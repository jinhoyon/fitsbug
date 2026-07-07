# Conventions

Coding standards for Fitsbug. **Trainer** and **admin** modules are the reference implementation. New code and refactored code in member/gym should converge toward these patterns.

## Package structure

One package tree per domain layer:

```
controller.{domain}.*   → HTTP entry (@WebServlet)
service.{domain}.*      → business logic
dao.{domain}.*          → database access
dto.{domain}.*          → data transfer objects
mapper/{domain}/*.xml   → MyBatis SQL mappings
```

Domains: `member`, `trainer`, `gym`, `admin`.

Shared cross-domain types (planned): `dto.common.*`, `dao.common.*`, `service.common.*`.

## Naming

### Classes

| Layer | Pattern | Example |
|-------|---------|---------|
| Controller | Feature name; `*Controller` optional | `LoginController`, `Dashboard`, `ReportList` |
| Service | `XxxService` + `XxxServiceImpl` | `ClientService`, `ClientServiceImpl` |
| DAO | `XxxDAO` + `XxxDAOImpl` | `TrainerDAO`, `TrainerDAOImpl` |
| DTO | `XxxDTO` suffix (admin/gym read-models may omit) | `TrainerDTO`, `AdminMainDTO` |
| Mapper XML | lowercase or snake_case per domain | `trainer/trainer.xml`, `admin/report.xml` |

**Target:** gym `Dao`/`DaoImpl` → `DAO`/`DAOImpl` to match trainer/admin.

### URLs

| Domain | Prefix | Example |
|--------|--------|---------|
| Member | `/member/` | `/member/login`, `/member/post` |
| Trainer | `/trainer/` | `/trainer/dashboard`, `/trainer/signup/step2` |
| Gym | `/gym/` | `/gym/dashboard`, `/gym/notice` |
| Admin | `/admin/` | `/admin/main`, `/admin/reportList` |
| Trainer payments | `/payment/` | `/payment/checkout`, `/payment/confirm` |

### MyBatis namespaces

| Domain | Namespace pattern | Example |
|--------|-------------------|---------|
| Admin | `mapper.admin.{feature}` | `mapper.admin.report` |
| Trainer | mixed (normalize over time) | `trainer`, `mapper.client`, `mapper.trainer.settlement` |
| Member | `mapper.{Name}Mapper` or `mapper.member.*` | `mapper.UserMapper` |
| Gym | `mapper.{feature}` | `mapper.gymMain` |

Admin namespaces are the cleanest model — prefer `mapper.{domain}.{feature}` for new mappers.

## Layering rules

### Request flow

```
Controller  →  Service  →  DAO  →  Mapper XML
```

- Controllers: parse request, check auth, call service, forward/redirect/write JSON.
- Services: business rules, open/close `SqlSession`, commit/rollback writes.
- DAOs: MyBatis calls only; receive `SqlSession` as first parameter.

### SqlSession ownership (reference: trainer `ClientServiceImpl`)

```java
SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
try {
    return clientDAO.selectClients(session, offset, limit, filter, search, trainerId);
} finally {
    session.close();
}
```

Writes:

```java
SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(false);
try {
    dao.insert(session, dto);
    session.commit();
} catch (Exception e) {
    session.rollback();
    throw e;
} finally {
    session.close();
}
```

**Avoid:**

- Controllers opening `SqlSession` directly (exists in trainer earnings — migrate to service)
- DAOs opening their own session (exists in `MealDAOImpl`, `NotificationDAOImpl` — migrate)
- Raw JDBC via `DBUtil` (exists in `GymDAOImpl` — migrate to mapper)

### Instantiation

No DI container. Use `new XxxServiceImpl()` / `new XxxDAOImpl()` in controllers or services.

## Authentication

### Trainer (reference)

On login, set both session keys:

```java
session.setAttribute("loginUser", result.getUser());      // dto.common.UserDTO
session.setAttribute("loginTrainer", result.getTrainer()); // dto.trainer.TrainerDTO
```

Protected trainer endpoints:

```java
HttpSession session = request.getSession(false);
if (session == null || session.getAttribute("loginTrainer") == null) {
    response.sendRedirect(request.getContextPath() + "/trainer/login");
    return;
}
```

Redirect failures to the **domain's own login page** (`/trainer/login`, not `/member/login`).

### Gym

```java
if (session == null || session.getAttribute("gymId") == null
        || session.getAttribute("loginUser") == null) {
    response.sendRedirect(request.getContextPath() + "/member/login");
    return;
}
```

### Admin (target — not yet implemented)

All `/admin/*` servlets should verify `loginUser.getRole().equals("ADMIN")` before processing. Planned as a servlet filter — see [CLEANUP_PLAN.md](CLEANUP_PLAN.md) Phase 6.

### Member

Check `loginUser != null` on protected endpoints. Guest-accessible pages (community browse, trainer list) may omit checks.

## Passwords

Trainer module is the reference:

| Operation | Where | How |
|-----------|-------|-----|
| Signup hash | Controller or service | `BCrypt.withDefaults().hashToString(12, password.toCharArray())` |
| Login verify | Service | `BCrypt.verifyer().verify(plain, hash)` |

Member/gym/admin must adopt the same pattern (cleanup Phase 6). Do not store or compare plaintext passwords in SQL.

## DTO guidelines

### One DTO per DB table (target state)

Each table gets a single Java type, ideally in `dto.common`:

| Table | Target DTO | Current duplicates |
|-------|------------|-------------------|
| USER | `dto.common.UserDTO` | Consolidated (was member + trainer copies) |
| TRAINER | `dto.common.TrainerDTO` | member + trainer copies |
| GYM | `dto.common.GymDTO` | `dto.member.GymDTO`, `dto.gym.Gym` |

### Keep domain-specific view DTOs

Do not merge these into entity DTOs:

- `dto.admin.MemberDTO` — admin list-view aggregate (not the MEMBER table row)
- `dto.admin.AdminMainDTO` — dashboard statistics
- `dto.gym.Dashboard`, `SalesChart`, etc. — gym-scoped read models
- `service.trainer.DashboardData` — trainer dashboard aggregate

### Date types

Inconsistent today (`String` in member, `Timestamp` in admin). New shared DTOs should use `java.time` or `Timestamp` consistently — pick one when consolidating.

## Controllers

### Servlet mapping

Every HTTP handler must have `@WebServlet`. Unmapped classes (e.g. `LessonInfo`, `NotificationApiServlet`) are dead code.

### JSON responses

Admin pattern: manual `StringBuilder` / `String.format` in servlet. Acceptable for admin AJAX endpoints. Prefer `org.json.JSONObject` for new code if not introducing a new library.

### File upload

```java
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 1024 * 1024 * 5,
    maxRequestSize = 1024 * 1024 * 5 * 5
)
```

- Require authentication before accepting uploads.
- Generate server-side filenames (`System.currentTimeMillis() + "_" + sanitizedName`).
- Validate extension/MIME before write (hardening planned).

### JSP output

Escape user-generated content:

```jsp
<c:out value="${post.title}" />
<c:out value="${post.body}" />
```

Do not use `${post.body}` for community posts or notices.

## Error handling

Current codebase uses `e.printStackTrace()` widely. Acceptable for student/project code; when touching a file, prefer logging to stderr with context or a shared logger if one is introduced later. Do not expose stack traces in HTTP responses.

## Configuration (target)

Secrets and environment-specific values should live in `config.properties` (gitignored), loaded at startup. Template: `config.properties.example`.

**Do not commit:** DB passwords, Gmail app passwords, Toss secret keys, Kakao client secrets.

## What not to introduce

- Spring / Spring Boot
- Maven / Gradle (unless explicitly decided later)
- New frontend framework (React, Vue, etc.)
- DI containers

Keep the Eclipse WTP + Tomcat + JSP stack consistent.

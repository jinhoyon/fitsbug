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
filter.*                → servlet auth filters
```

Domains: `member`, `trainer`, `gym`, `admin`.

Shared cross-domain types: `dto.common.*`, `dao.common.*`, `service.common.*`.

## Naming

### Classes

| Layer | Pattern | Example |
|-------|---------|---------|
| Controller | Feature name; `*Controller` optional | `LoginController`, `Dashboard`, `ReportList` |
| Service | `XxxService` + `XxxServiceImpl` | `ClientService`, `ClientServiceImpl` |
| DAO | `XxxDAO` + `XxxDAOImpl` | `TrainerDAO`, `TrainerDAOImpl` |
| DTO | `XxxDTO` suffix (admin/gym read-models may omit) | `TrainerDTO`, `AdminMainDTO` |
| Mapper XML | lowercase or snake_case per domain | `trainer/trainer.xml`, `admin/report.xml` |
| Filter | `XxxAuthFilter` | `AdminAuthFilter`, `TrainerAuthFilter` |

Admin exercise guides use `ExerciseGuideDAO` (not `ExerciseDAO`) to avoid collision with member `ExerciseDAO`.

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
- DAOs: MyBatis calls only; receive `SqlSession` as first parameter when session is service-owned.

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

- Controllers opening `SqlSession` directly (exists in a few legacy paths — migrate to service)
- Controllers calling DAOs directly when a service exists (use `UserService`, `MyPageService`, etc.)

### Instantiation

No DI container. Use `new XxxServiceImpl()` / `new XxxDAOImpl()` in controllers or services.

## Authentication

Servlet filters in `WEB-INF/web.xml` enforce domain-level protection:

| Filter | Pattern | Check |
|--------|---------|-------|
| `AdminAuthFilter` | `/admin/*` | `loginUser.role == ADMIN` |
| `TrainerAuthFilter` | `/trainer/*` | `loginTrainer` or TRAINER `loginUser`; excludes login/signup/gymLookup |
| `GymAuthFilter` | `/gym/*` | GYM `loginUser` + `gymId` |

### Trainer (reference)

On login, set both session keys:

```java
session.setAttribute("loginUser", result.getUser());       // dto.common.UserDTO
session.setAttribute("loginTrainer", result.getTrainer()); // dto.common.TrainerDTO
```

Per-controller checks are still used in some trainer servlets; the filter is the primary gate.

Redirect failures to the **domain's own login page** (`/trainer/login`, not `/member/login`) for trainer routes.

### Gym

Filter checks `loginUser` with role GYM and a non-null `gymId` (set on login).

### Admin

`AdminAuthFilter` redirects unauthenticated or non-admin users to `/member/login`.

### Member

Check `loginUser != null` on protected endpoints. Guest-accessible pages (community browse, trainer list) may omit checks.

## Passwords

Use `util.PasswordUtil` for all roles:

| Operation | How |
|-----------|-----|
| Hash on signup/update | `PasswordUtil.hash(plain)` |
| Verify on login | `PasswordUtil.verify(plain, stored)` |
| Legacy migration | Re-hash with `PasswordUtil.hash(plain)` after successful plaintext verify |

Do not store or compare plaintext passwords in SQL.

## DTO guidelines

### Shared entity DTOs (`dto.common`)

| Table | DTO |
|-------|-----|
| USER | `UserDTO` |
| TRAINER | `TrainerDTO` |
| GYM | `Gym` |
| PAYMENT / TOSS | `Payment`, `TossDTO` |
| LESSON, NOTIFICATION, … | `LessonDTO`, `NotificationDTO`, etc. |

### Keep domain-specific view DTOs

Do not merge these into entity DTOs:

- `dto.admin.MemberDTO` — admin list-view aggregate (not the MEMBER table row)
- `dto.admin.AdminMainDTO` — dashboard statistics
- `dto.gym.Dashboard`, `SalesChart`, etc. — gym-scoped read models
- `service.trainer.DashboardData` — trainer dashboard aggregate

## Controllers

### Servlet mapping

Every HTTP handler must have `@WebServlet`.

### JSON responses

Admin pattern: manual `StringBuilder` / `String.format` in servlet. Acceptable for admin AJAX endpoints.

### File upload

```java
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 1024 * 1024 * 5,
    maxRequestSize = 1024 * 1024 * 5 * 5
)
```

- Require authentication before accepting uploads (`UploadController` pattern).
- Generate server-side filenames (`System.currentTimeMillis() + "_" + sanitizedName`).
- Route persistence through a service (`MyPageService.updateProfile_image`).

### JSP output

Escape user-generated content:

```jsp
<c:out value="${post.title}" />
<c:out value="${post.body}" />
```

Use `fn:escapeXml()` for attribute values in edit forms. Do not use raw `${post.body}` or `${notice.content}` for user-authored text.

## Error handling

Current codebase uses `e.printStackTrace()` widely. Acceptable for student/project code; when touching a file, prefer logging to stderr with context. Do not expose stack traces in HTTP responses.

## Configuration

Secrets and environment-specific values live in `config.properties` (gitignored), loaded at startup:

| Utility | Keys |
|---------|------|
| `DatabaseConfig` | `db.driver`, `db.url`, `db.username`, `db.password` |
| `TossPaymentsConfig` | `toss.client.key`, `toss.secret.key` |

Template: `config.properties.example`. Copy to `config.properties` before running locally.

**Do not commit:** DB passwords, Gmail app passwords, Toss secret keys, Kakao client secrets.

## What not to introduce

- Spring / Spring Boot
- Maven / Gradle (unless explicitly decided later)
- New frontend framework (React, Vue, etc.)
- DI containers

Keep the Eclipse WTP + Tomcat + JSP stack consistent.

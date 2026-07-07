# Architecture

Agent-agnostic overview of the Fitsbug application structure, data flow, and known technical debt.

## System context

Fitsbug is a monolithic Java web application (WAR-style Eclipse project). All HTTP handling goes through annotated servlets (`@WebServlet`); there is no Spring or other DI framework.

```
Browser (JSP + fetch/AJAX)
        │
        ▼
@WebServlet Controllers  ──session──►  HttpSession (loginUser, loginTrainer, gymId, …)
        │
        ▼
Service (*Service / *ServiceImpl)     ← business rules, transaction boundaries
        │
        ▼
DAO (*DAO / *DAOImpl)                 ← MyBatis statement calls
        │
        ▼
Mapper XML (mapper/{domain}/*.xml)
        │
        ▼
MariaDB (database: fitsbug)
```

## Deployment

| Setting | Value |
|---------|-------|
| Deploy name | `Fitsbug` |
| Context root | `/Fitsbug` |
| Web root | `src/main/webapp/` |
| Compiled classes | `src/main/java/` → `WEB-INF/classes/` |
| Canonical `web.xml` | `src/main/webapp/WEB-INF/web.xml` |

> **Note:** A stale empty `web/WEB-INF/web.xml` may exist at repo root — it is not the deployable config. See [CLEANUP_PLAN.md](CLEANUP_PLAN.md) Phase 1.

## Module map

Four vertical domains share one database and one MyBatis `SqlSessionFactory` (`util.MybatisSqlSessionFactory`).

### Member (`member`)

End-user features: registration (3-step join), community posts, workouts/meals/inbody logs, trainer discovery, PT booking, chat, payments, mypage.

- URL prefix: `/member/*`
- ~80+ controllers, largest module by file count
- Session key: `loginUser` (`dto.member.UserDTO`)

### Trainer (`trainer`)

Reference module for cleanup. Trainer signup (5 steps), client management, calendar, earnings/settlements, meal/workout log views, Toss checkout.

- URL prefix: `/trainer/*` (payment callbacks at `/payment/*`)
- Session keys: `loginUser` (`dto.trainer.UserDTO`) + `loginTrainer` (`dto.trainer.TrainerDTO`)
- Passwords: BCrypt (cost 12)

### Gym (`gym`)

Gym-owner dashboard: member/trainer management, schedules, notices, reviews, sales, Toss payments.

- URL prefix: `/gym/*`
- Session keys: `loginUser` + `gymId`
- DAO naming uses `Dao`/`DaoImpl` (inconsistent with trainer/admin — being normalized)

### Admin (`admin`)

Platform oversight: certification approvals, member/gym/trainer lists, exercise guides, reports, inquiries, sales settlements.

- URL prefix: `/admin/*`
- Symmetric 6-domain stack (dashboard, members, exercises, reports, inquiries, sales)
- Mapper namespace: `mapper.admin.*`
- **No servlet-level auth checks today** (planned fix in cleanup Phase 6)

## Cross-module dependencies

Some modules intentionally reach across package boundaries:

| Consumer | Uses from | Example |
|----------|-----------|---------|
| Trainer controllers | member DAOs/DTOs | `InbodyLogDTO`, `WorkoutLogDTO` for client detail pages |
| Trainer earnings | member mappers | `mapper/member/PaymentMapper.xml` for settlement queries |
| Member controllers | trainer DTOs | `AvailabilityDTO` in trainer listing |
| Admin | — | Self-contained; no cross-domain service calls |

This cross-usage is a major source of duplicate DTOs/DAOs documented in [CLEANUP_PLAN.md](CLEANUP_PLAN.md).

## Data layer

### Schema

Canonical DDL: `finaldb.sql` (~30 tables).

Core entities: `USER`, `MEMBER`, `TRAINER`, `GYM`, `POST`, `PAYMENT`, `LESSON`, `MEMBERSHIP`, `SETTLEMENT`, …

### MyBatis

- Config: `src/main/java/resource/mybatis-config.xml`
- Global setting: `mapUnderscoreToCamelCase=true`
- Type aliases: per-module short names (some collide across admin/member — cleanup planned)
- Connection pool: POOLED, max 500 active (high for local dev)

### JDBC legacy

`util.DBUtil` was removed in cleanup Phase 3. All database access goes through MyBatis.

## Authentication & sessions

| Role | Login entry | Session attributes | Protected check (target) |
|------|-------------|-------------------|------------------------|
| MEMBER | `/member/login` | `loginUser` | Per-controller `loginUser != null` |
| TRAINER | `/trainer/login` | `loginUser`, `loginTrainer` | `loginTrainer != null` |
| GYM | `/member/login` (role GYM) | `loginUser`, `gymId` | `loginUser` + `gymId` |
| ADMIN | `/member/login` (role ADMIN) | `loginUser` | `role == ADMIN` (not enforced yet) |

Password handling is **inconsistent**:

- Trainer: BCrypt hash on signup, verify on login
- Member/Gym: plaintext compare in SQL (`UserMapper.findByEmailAndPassword`)

## Payments (Toss)

Three parallel implementations exist today:

| Domain | Controllers | Persistence |
|--------|-------------|-------------|
| Member | `PaymentController`, `PaymentSuccessController`, … | `mapper/member/PaymentMapper.xml`, `TossMapper.xml` |
| Gym | `GymPayment`, `GymTossPayment`, `GymPaymentCancel` | `mapper/gym/payment.xml`, `tossPayment.xml` |
| Trainer | `PaymentCheckout`, `PaymentConfirmationController`, `PaymentCancelController` | `mapper/trainer/payment.xml` |

Unification is planned in [CLEANUP_PLAN.md](CLEANUP_PLAN.md) Phase 5.

## File uploads

Multipart via `@MultipartConfig` on servlets. Files saved under `src/main/webapp/` subdirs (`/member/upload/`, `/uploads/`, etc.) using `getRealPath()`. Extension/MIME validation is minimal — hardening planned.

## External integrations

| Service | Location | Status |
|---------|----------|--------|
| Toss Payments | `controller/trainer/Payment*Controller`, gym/member equivalents | Test secret keys hardcoded |
| Kakao OAuth | `service/member/KakaoServiceImpl` | `REST_API_KEY` placeholder |
| Gmail SMTP | `controller/member/SendEmailController` | App password hardcoded — rotate |

## Known issues (summary)

Full remediation plan: [CLEANUP_PLAN.md](CLEANUP_PLAN.md).

| Severity | Issue |
|----------|-------|
| Critical | Hardcoded secrets (DB, Gmail, Toss) in source |
| Critical | Member/gym plaintext passwords |
| Critical | Admin endpoints unauthenticated |
| High | Duplicate DTOs/DAOs for same DB tables across modules |
| High | Three parallel payment stacks |
| High | XSS in community JSPs (`${post.body}` unescaped) |
| Medium | Inconsistent SqlSession ownership (service vs DAO vs controller) |
| Medium | Dead code: `LoginCheck`, `DBUtil`, orphan JSPs, unmapped servlets |
| Low | `web.xml` display-name still says `BankProj` |

## Dependency JARs

Located in `src/main/webapp/WEB-INF/lib/` (~3.6 MB):

- mybatis-3.4.6, mariadb-java-client-3.1.1
- taglibs-standard-* (JSTL)
- bcrypt-0.7.0, json-20231013, json-simple-1.1.1
- javax.mail-1.6.2, cos.jar (multipart), activation, bytes

Versions are pinned by committed JARs — do not upgrade without regression testing.

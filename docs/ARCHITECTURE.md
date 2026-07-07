# Architecture

Agent-agnostic overview of the Fitsbug application structure, data flow, and remaining technical debt.

## System context

Fitsbug is a monolithic Java web application (WAR-style Eclipse project). All HTTP handling goes through annotated servlets (`@WebServlet`); there is no Spring or other DI framework.

```
Browser (JSP + fetch/AJAX)
        │
        ▼
Servlet filters (encoding, AdminAuth, TrainerAuth, GymAuth)
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

## Module map

Four vertical domains share one database and one MyBatis `SqlSessionFactory` (`util.MybatisSqlSessionFactory`), with DB credentials loaded from `config.properties` via `util.DatabaseConfig`.

### Member (`member`)

End-user features: registration (3-step join), community posts, workouts/meals/inbody logs, trainer discovery, PT booking, chat, payments, mypage.

- URL prefix: `/member/*`
- Session key: `loginUser` (`dto.common.UserDTO`)

### Trainer (`trainer`)

Trainer signup (5 steps), client management, calendar, earnings/settlements, meal/workout log views, Toss checkout.

- URL prefix: `/trainer/*` (payment callbacks at `/payment/*`)
- Session keys: `loginUser` + `loginTrainer` (`dto.common.TrainerDTO`)
- Protected by `TrainerAuthFilter` (public: login, logout, signup*, gymLookup)

### Gym (`gym`)

Gym-owner dashboard: member/trainer management, schedules, notices, reviews, sales, Toss payments.

- URL prefix: `/gym/*`
- Session keys: `loginUser` + `gymId`
- Protected by `GymAuthFilter`

### Admin (`admin`)

Platform oversight: certification approvals, member/gym/trainer lists, exercise guides, reports, inquiries, sales settlements.

- URL prefix: `/admin/*`
- Protected by `AdminAuthFilter` (`loginUser.role == ADMIN`)

## Cross-module dependencies

Some modules intentionally reach across package boundaries:

| Consumer | Uses from | Example |
|----------|-----------|---------|
| Trainer controllers | member DAOs/DTOs | `InbodyLogDTO`, `WorkoutLogDTO` for client detail pages |
| Member controllers | trainer DTOs | `AvailabilityDTO` in trainer listing |
| `service.common` | member mappers | Unified `TossPaymentService`, `PaymentService` |
| Admin | — | Self-contained; no cross-domain service calls |

Shared entity types live in `dto.common` (User, Trainer, Gym, Payment, Toss, Lesson, Notification, PayoutAccount, Certification, Pricing, Availability).

## Data layer

### Schema

Canonical DDL: `finaldb.sql` (~30 tables).

Core entities: `USER`, `MEMBER`, `TRAINER`, `GYM`, `POST`, `PAYMENT`, `LESSON`, `MEMBERSHIP`, `SETTLEMENT`, …

### MyBatis

- Config: `src/main/java/resource/mybatis-config.xml`
- Global setting: `mapUnderscoreToCamelCase=true`
- Datasource: `${db.driver}`, `${db.url}`, `${db.username}`, `${db.password}` from `DatabaseConfig`
- Connection pool: POOLED, max 500 active (high for local dev)

All database access goes through MyBatis (raw JDBC `DBUtil` was removed in Phase 3).

## Authentication & sessions

| Role | Login entry | Session attributes | Protection |
|------|-------------|-------------------|------------|
| MEMBER | `/member/login` | `loginUser` | Per-controller checks |
| TRAINER | `/trainer/login` or `/member/login` | `loginUser`, `loginTrainer` | `TrainerAuthFilter` |
| GYM | `/member/login` (role GYM) | `loginUser`, `gymId` | `GymAuthFilter` |
| ADMIN | `/member/login` (role ADMIN) | `loginUser` | `AdminAuthFilter` |

Password handling uses `util.PasswordUtil` (BCrypt cost 12). Legacy plaintext passwords are verified once and re-hashed on successful login.

## Payments (Toss)

Member and trainer Toss flows are unified under `service.common`:

| Component | Role |
|-----------|------|
| `TossPaymentsConfig` | Loads client/secret keys from `config.properties` |
| `TossPaymentService` | Toss API confirm/cancel |
| `PaymentService` | Payment row persistence |
| `mapper/member/TossMapper.xml` | Single TOSS mapper for all domains |

Gym PortOne/Iamport cancel (`GymTossCancelService`) and gym registration payment logic remain gym-specific.

## File uploads

Multipart via `@MultipartConfig` on servlets. Files saved under `src/main/webapp/` subdirs (`/member/upload/`, `/uploads/`, etc.) using `getRealPath()`. `UploadController` requires an authenticated `loginUser` and routes through `MyPageService`.

## External integrations

| Service | Location | Config |
|---------|----------|--------|
| Toss Payments | `service.common.TossPaymentService` | `TossPaymentsConfig` |
| MariaDB | `util.DatabaseConfig` | `db.*` |
| Kakao OAuth | `util.KakaoUtil` → `KakaoLoginController` | `KakaoConfig` |
| Gmail SMTP | `SendEmailController` | `MailConfig` |

All loaders share `util.ConfigLoader`. Copy `config.properties.example` → `config.properties` for local values.

## Remaining technical debt

Tracked as post-v1 deferred work in [CLEANUP_PLAN.md](CLEANUP_PLAN.md#post-v1-deferred-work):

| ID | Issue |
|----|-------|
| D2 | Duplicate `TrainerDAO` name across member/trainer packages | Complete — member uses `TrainerListDAO` |
| D3 | Gym `Dao`/`DaoImpl` naming vs trainer/admin `DAO`/`DAOImpl` | Complete — all 16 gym DAO pairs renamed |
| D4 | Trainer signup spread across 5 servlets |
| — | Some controllers still open DAOs directly (step3 join, earnings, etc.) |
| — | Inconsistent SqlSession ownership in a few legacy DAOs |

## Dependency JARs

Located in `src/main/webapp/WEB-INF/lib/` (~3.6 MB):

- mybatis-3.4.6, mariadb-java-client-3.1.1
- taglibs-standard-* (JSTL)
- bcrypt-0.7.0, json-20231013, json-simple-1.1.1
- javax.mail-1.6.2, cos.jar (multipart), activation, bytes

Versions are pinned by committed JARs — do not upgrade without regression testing.

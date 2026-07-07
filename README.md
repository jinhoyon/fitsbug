# Fitsbug

핏츠버그 — a Korean fitness platform connecting members, personal trainers, gyms, and platform admins.

This repository is the **active cleanup fork**. The original course repo (`jun795/Final-Fitsbug`) is left unchanged.

## Stack

| Layer | Technology |
|-------|------------|
| Runtime | Java Servlet 4.0, JSP, JSTL |
| Persistence | MyBatis 3.4.6, MariaDB |
| Server | Apache Tomcat (Eclipse WTP deploy) |
| Payments | Toss Payments via `TossPaymentsConfig` |
| Auth | Session-based; BCrypt passwords; servlet filters for admin/trainer/gym; Kakao OAuth (member) |
| UI | JSP + Tailwind CSS (CDN) |

No Maven/Gradle — dependencies live in `src/main/webapp/WEB-INF/lib/`.

## Quick start

1. **Database** — create schema from `finaldb.sql` on MariaDB (`fitsbug` database).
2. **Config** — copy `config.properties.example` → `config.properties` and set DB credentials, Toss keys, and optional Kakao/Gmail values. `config.properties` is gitignored.
3. **Build** — Eclipse Dynamic Web Project: deploy name `Fitsbug`, context root `/Fitsbug`.
4. **Run** — deploy to Tomcat; member login at `/Fitsbug/member/login`.

## User roles

| Role | Entry URL | Package prefix |
|------|-----------|----------------|
| MEMBER | `/member/main` | `controller.member`, `service.member`, … |
| TRAINER | `/trainer/dashboard` | `controller.trainer`, `service.trainer`, … |
| GYM | `/gym/dashboard` | `controller.gym`, `service.gym`, … |
| ADMIN | `/admin/main` | `controller.admin`, `service.admin`, … |

Login is unified through `/member/login`; role determines redirect destination. Trainer-specific login is also available at `/trainer/login`.

Protected routes are enforced by servlet filters registered in `WEB-INF/web.xml` (`AdminAuthFilter`, `TrainerAuthFilter`, `GymAuthFilter`).

## Project layout

```
src/main/java/
  controller/{member,trainer,gym,admin}/   # @WebServlet entry points
  service/{member,trainer,gym,admin,common}/  # business logic (interface + *Impl)
  dao/{member,trainer,gym,admin,common}/      # MyBatis access (interface + *Impl)
  dto/{member,trainer,gym,admin,common}/      # data transfer objects
  filter/                                    # auth servlet filters
  mapper/{member,trainer,gym,admin}/         # MyBatis XML (on classpath)
  resource/mybatis-config.xml                # MyBatis config (${db.*} placeholders)
  util/                                      # ConfigLoader, PasswordUtil, DatabaseConfig, TossPaymentsConfig, KakaoConfig, MailConfig, …

src/main/webapp/
  member/ trainer/ gym/ admin/               # JSP views per role
  WEB-INF/web.xml                            # encoding + auth filters
  WEB-INF/lib/                               # vendored JARs

config.properties.example                    # template for local secrets (copy → config.properties)
```

## Documentation

| Doc | Purpose |
|-----|---------|
| [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) | System design, modules, data flow |
| [docs/CONVENTIONS.md](docs/CONVENTIONS.md) | Coding standards (trainer + admin as reference) |
| [docs/CLEANUP_PLAN.md](docs/CLEANUP_PLAN.md) | Phased refactor plan — **all phases complete** |
| [docs/SMOKE_TEST.md](docs/SMOKE_TEST.md) | Manual smoke test checklist |

## Cleanup status

Phases 0–8 and post-v1 deferred work (D1–D5) are complete (2026-07-07). See [docs/CLEANUP_PLAN.md](docs/CLEANUP_PLAN.md#post-v1-deferred-work) and [docs/SMOKE_TEST.md](docs/SMOKE_TEST.md).

Highlights from phases 0–8:

- Dead code removed; trainer auth unified; DAO pattern normalized
- Shared entity DTOs in `dto.common`
- Unified Toss payment services; secrets externalized to `config.properties`
- Auth filters, BCrypt passwords, XSS hardening on community/gym/admin views
- Admin `ExerciseGuideDAO` rename; upload/profile flows routed through services

## Post-v1 deferred work

| ID | Item | Status |
|----|------|--------|
| D1 | Kakao/Gmail config externalization | Complete |
| D2 | `TrainerListDAO` rename (member discovery vs trainer CRUD) | Complete |
| D3 | Gym `Dao` → `DAO` naming (16 pairs) | Complete |
| D4 | Trainer signup servlet consolidation | Complete |
| D5 | Legacy controller → service routing | Complete |

## Remote

`origin` → [https://github.com/jinhoyon/fitsbug](https://github.com/jinhoyon/fitsbug) (branch: `main`)

The original course repo (`jun795/Final-Fitsbug`) is intentionally unchanged.

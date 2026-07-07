# Fitsbug (Final-Fitsbug)

핏츠버그 — a Korean fitness platform connecting members, personal trainers, gyms, and platform admins.

## Stack

| Layer | Technology |
|-------|------------|
| Runtime | Java Servlet 4.0, JSP, JSTL |
| Persistence | MyBatis 3.4.6, MariaDB |
| Server | Apache Tomcat (Eclipse WTP deploy) |
| Payments | Toss Payments (test keys in source — migrate to config) |
| Auth | Session-based; Kakao OAuth (member) |
| UI | JSP + Tailwind CSS (CDN) |

No Maven/Gradle — dependencies live in `src/main/webapp/WEB-INF/lib/`.

## Quick start

1. **Database** — create schema from `finaldb.sql` on MariaDB (`fitsbug` database).
2. **Config** — copy `config.properties.example` → `config.properties` and set DB credentials (planned; credentials are currently hardcoded in `mybatis-config.xml`).
3. **Build** — Eclipse Dynamic Web Project: deploy name `Fitsbug`, context root `/Fitsbug`.
4. **Run** — deploy to Tomcat; member login at `/Fitsbug/member/login`.

## User roles

| Role | Entry URL | Package prefix |
|------|-----------|----------------|
| MEMBER | `/member/main` | `controller.member`, `service.member`, … |
| TRAINER | `/trainer/dashboard` | `controller.trainer`, `service.trainer`, … |
| GYM | `/gym/dashboard` | `controller.gym`, `service.gym`, … |
| ADMIN | `/admin/main` | `controller.admin`, `service.admin`, … |

Login is unified through `/member/login`; role determines redirect destination.

## Project layout

```
src/main/java/
  controller/{member,trainer,gym,admin}/   # @WebServlet entry points
  service/{member,trainer,gym,admin}/      # business logic (interface + *Impl)
  dao/{member,trainer,gym,admin}/          # MyBatis access (interface + *Impl)
  dto/{member,trainer,gym,admin}/          # data transfer objects
  mapper/{member,trainer,gym,admin}/       # MyBatis XML (on classpath)
  resource/mybatis-config.xml              # MyBatis + datasource config
  util/                                    # shared utilities

src/main/webapp/
  member/ trainer/ gym/ admin/             # JSP views per role
  WEB-INF/web.xml                          # servlet config (encoding filter)
  WEB-INF/lib/                             # vendored JARs
```

## Documentation

| Doc | Purpose |
|-----|---------|
| [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) | System design, modules, data flow, known issues |
| [docs/CONVENTIONS.md](docs/CONVENTIONS.md) | Coding standards (trainer + admin as reference) |
| [docs/CLEANUP_PLAN.md](docs/CLEANUP_PLAN.md) | Phased refactor plan to remove duplication and dead code |

## Status

The codebase is under active cleanup. See [docs/CLEANUP_PLAN.md](docs/CLEANUP_PLAN.md) for the roadmap. Trainer and admin modules are the reference implementation style; member and gym modules are being aligned.

## Remote

`origin` → `https://github.com/jun795/Final-Fitsbug.git` (branch: `main`)

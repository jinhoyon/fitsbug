# Cleanup Plan

Phased roadmap to streamline Fitsbug: remove dead code, eliminate duplicate implementations, and align member/gym modules with the **trainer** and **admin** reference patterns.

**Stack is frozen** — Servlet/JSP, MyBatis 3.4.6, MariaDB, vendored JARs, Eclipse WTP deploy. No Maven/Gradle or framework migration in this plan.

## Reference standard

| Source | What to replicate |
|--------|-------------------|
| **Trainer** | Package layout, interface+Impl services/DAOs, service-owned SqlSession, BCrypt passwords, dual session keys (`loginUser` + `loginTrainer`) |
| **Admin** | Symmetric feature stacks, `mapper.admin.*` namespaces, feature-named servlets |

See [CONVENTIONS.md](CONVENTIONS.md) for full coding rules.

## Principles

1. **Delete before refactor** — remove orphans first; smaller diffs, less risk.
2. **One owner per DB table** — one DTO + one DAO per entity; view-specific read models stay in their domain.
3. **Domain packages stay** — `member`, `trainer`, `gym`, `admin` remain; add `dto.common` / `dao.common` only for truly shared entities.
4. **Incremental phases** — each phase should leave the app deployable.
5. **Smoke-test after every phase** — rerun the checklist in Phase 0.

---

## Phase 0 — Baseline

**Effort:** ~½ day | **Risk:** none

| Task | Detail |
|------|--------|
| Smoke-test checklist | Member login/join, trainer login/signup, gym dashboard, admin main, Toss checkout |
| Work branch | e.g. `cleanup/phase-1-dead-code` |
| Deploy path | Confirm Tomcat uses `src/main/webapp/` only |

### Smoke-test checklist

- [ ] `/member/login` — member login
- [ ] `/member/join` → step1/2/3 — registration
- [ ] `/trainer/login` — trainer login
- [ ] `/trainer/signup` — trainer registration step 1
- [ ] `/gym/dashboard` — gym owner dashboard (after gym login)
- [ ] `/admin/main` — admin dashboard
- [ ] Toss payment checkout → confirm flow (any role)

---

## Phase 1 — Dead weight removal

**Effort:** ~1 day | **Risk:** low | **PR:** recommended first PR

Remove files and code with no live references. No intended behavior change.

### Delete files

| Path | Reason |
|------|--------|
| `web/WEB-INF/web.xml` (and `web/` if empty) | Stale duplicate; real config is `src/main/webapp/WEB-INF/web.xml` |
| `InitialTable.sql` | Empty; `finaldb.sql` is canonical |
| `src/main/java/util/LoginCheck.java` | Zero references |
| `src/main/java/util/DBUtil.java` | JDBC legacy; migrate `GymDAOImpl` first or in Phase 3 |
| `src/main/java/service/member/CompleteService.java` | Never referenced |
| `src/main/java/service/member/CompleteServiceImpl.java` | Never referenced |
| `src/main/webapp/trainer/payment1/` | Orphan; real checkout is `trainer/payment/` |
| `src/main/webapp/member/profileCard.jsp` | Unreferenced |
| `src/main/webapp/member/guideFragment.jsp` | Superseded by `exerciseCardFragment.jsp` |
| `src/main/webapp/trainer/calendarDetail.jsp` | Unreferenced |
| `src/main/java/controller/member/FeedbackController.java` | Stub; live path is `PtFeedback*` |
| `src/main/java/controller/member/MyPostController.java` | Hardcoded test data |

### Wire or delete unmapped servlets

| File | Issue |
|------|-------|
| `controller/trainer/LessonInfo.java` | No `@WebServlet` |
| `controller/trainer/NotificationApiServlet.java` | No `@WebServlet`; wrong session key |

### Remove commented dead code

| File | What to remove |
|------|----------------|
| `controller/member/JoinController.java` | Lines 1–31 (old controller) |
| `controller/admin/MemberGym.java` | Commented `adminMember` path (lines ~113–122) |
| `controller/trainer/SignupController.java` | Commented `profileImg` blocks |

### Admin dead service methods

Remove unused methods and their mapper statements:

- `MemberService.getGymlist()`, `getTrainerlist()`, `getClientlist()`
- `MemberDAO.selectAllGym/Trainer/Client`
- Corresponding SQL in `mapper/admin/member.xml`

### MyBatis config fixes (`resource/mybatis-config.xml`)

| Fix | Detail |
|-----|--------|
| Dedupe | `PtFeedbackMapper.xml` registered twice (lines ~116 and ~123) |
| Dedupe | `dto.trainer.MealDTO` aliased as both `meal` and `MealDTO` |
| Register or delete | `mapper/member/PayoutAccountMapper.xml`, `SettlementMapper.xml` (on disk, not registered) |
| Note | `mapper/member/GymMapper.xml` registered but unused — `GymDAOImpl` uses JDBC |

### Exit criteria

- App builds and deploys on Tomcat
- Smoke-test checklist passes
- ~15–20 files removed

---

## Phase 2 — Naming and trainer auth consistency

**Effort:** ~1 day | **Risk:** low–medium

| Area | Current | Target |
|------|---------|--------|
| `web.xml` display-name | `BankProj` | `Fitsbug` |
| Gym DAO naming | `GymMainDao` / `DaoImpl` | `GymMainDAO` / `DAOImpl` |
| Trainer `ClientDetail*` redirect | `/member/login` | `/trainer/login` |
| Trainer logout redirect | `/member/login` | `/trainer/login` |

### Trainer auth — single pattern

**Protected pages:** check `loginTrainer != null`, redirect to `/trainer/login`.

Apply to controllers currently checking only `loginUser`:

- `CalendarController`, `ProfileController`, `ProfileEditController`
- `Messages`, `ClientWorkoutLogController`, `ClientInbodyLogController`
- `MealApiServlet` (add auth)
- `ClientDetail`, `ClientDetailCommon` (restore ownership checks — currently commented out)

### Exit criteria

- Trainer module uses consistent auth checks and redirect targets
- `web.xml` display-name updated

---

## Phase 3 — DAO/Service pattern alignment

**Effort:** ~2–3 days | **Risk:** medium

Migrate to trainer reference pattern: **service opens SqlSession, DAO receives session**.

### Migrations

| Component | Current problem | Action |
|-----------|-----------------|--------|
| `dao/member/GymDAOImpl` | Raw JDBC via `DBUtil` | Switch to `mapper/member/GymMapper.xml` |
| `dao/trainer/MealDAOImpl` | Self-managed session | Service owns session |
| `dao/trainer/NotificationDAOImpl` | Self-managed session | Service owns session |
| `dao/trainer/PaymentDAOImpl` | Doesn't implement `PaymentDAO` | Implement interface or remove interface |
| `EarningsController` | Controller opens session | Move to service |
| `EarningsSettlementController` | Controller opens session | Move to service |
| `EarningsTransactionsController` | Controller opens session | Move to service |
| `Messages.java` | Controller opens session | Move to service |

### Exit criteria

- No `DBUtil` usage
- No controller-level `SqlSession`
- Gym member queries go through MyBatis mapper

---

## Phase 4 — Shared entity layer

**Effort:** ~3–5 days | **Risk:** high — **one entity per PR**

Create `dto.common` (and matching `dao.common`) with one Java type per DB table. Domain packages keep view/query DTOs only.

### Consolidation targets

| Entity (table) | Current duplicates | Canonical mapper owner |
|----------------|-------------------|------------------------|
| USER | `dto.member.UserDTO`, `dto.trainer.UserDTO` | `mapper/member/UserMapper.xml` |
| TRAINER | member + trainer `TrainerDTO` | `mapper/trainer/trainer.xml` |
| GYM | `dto.member.GymDTO`, `dto.gym.Gym` | `mapper/member/GymMapper.xml` |
| PAYMENT | `dto.member.PaymentDTO`, `dto.gym.Payment` | `mapper/member/PaymentMapper.xml` |
| TOSS | `dto.member.TossDTO`, `dto.gym.TossPayment`, trainer `PaymentDTO` (misnamed) | unified toss mapper |
| LESSON | member + trainer `LessonDTO` | `mapper/trainer/lesson.xml` |
| NOTIFICATION | member + trainer `NotificationDTO` | per-domain or common |
| PAYOUT_ACCOUNT | member + trainer | common |
| CERTIFICATION | `TrainerCertificationDTO`, `CertificationDTO` | common |
| PRICING / AVAILABILITY | member + trainer pairs | common |

### Do NOT merge

| DTO | Reason |
|-----|--------|
| `dto.admin.MemberDTO` | Admin list-view aggregate |
| `dto.admin.AdminMainDTO` | Dashboard stats |
| `dto.gym.Dashboard`, `SalesChart`, … | Gym read models |
| `service.trainer.DashboardData` | Trainer dashboard aggregate |

### Migration steps (per entity)

1. Create `dto.common.X`
2. Update one mapper + DAO (start with trainer)
3. Fix compile errors in dependents
4. Delete old duplicate DTO
5. Run smoke tests

### MyBatis alias cleanup

Replace short aliases that collide (`member`, `inquiry`, `report`) with fully qualified type names in admin mappers.

### Exit criteria

- No duplicate entity DTOs for USER, TRAINER, GYM, PAYMENT, TOSS
- All modules import shared types from `dto.common`

---

## Phase 5 — Payment unification

**Effort:** ~2–3 days | **Risk:** high

Collapse three Toss payment stacks into shared services.

### Target structure

```
controller.{domain}.*Payment*     ← thin; role-specific URLs only
        ↓
service.common.TossPaymentService ← confirm, cancel, refund
service.common.PaymentService     ← create order, persist PAYMENT row
        ↓
dao.common.PaymentDAO
        ↓
mapper (canonical payment + toss XML)
```

### Bugs to fix in this phase

| Bug | Fix |
|-----|-----|
| `PaymentController` returns empty JSON | Restore response via unified service |
| `paymentFail.jsp` unreachable | Add servlet mapping or fix URL in `trainerDetail.jsp` |
| Mixed Toss secret keys (`test_sk_` vs `test_gsk_`) | Single config source |
| Trainer `dto.trainer.PaymentDTO` misnamed | Rename to `TossDTO` or merge into common |

### URL layout (unchanged)

| Domain | URLs |
|--------|------|
| Member | `/member/payment*` |
| Gym | `/gym/payment*`, `/gym/tossPayment*` |
| Trainer | `/payment/checkout`, `/payment/confirm`, `/payment/cancel` |

### Exit criteria

- One payment service layer; domain controllers are thin wrappers
- Toss checkout smoke test passes for at least one role

---

## Phase 6 — Auth and security

**Effort:** ~2 days | **Risk:** medium

### Servlet filters (register in `WEB-INF/web.xml`)

| Filter | URL pattern | Check |
|--------|-------------|-------|
| `AdminAuthFilter` | `/admin/*` | `loginUser.role == "ADMIN"` |
| `TrainerAuthFilter` | `/trainer/*` | `loginTrainer != null`; exclude `/trainer/login`, `/trainer/signup*` |
| `GymAuthFilter` | `/gym/*` | `loginUser` + `gymId` |

### BCrypt for all roles

| Flow | Action |
|------|--------|
| Member join (`Step3Controller`) | Hash before insert |
| Member login (`UserServiceImpl`) | BCrypt verify (replace SQL plaintext compare) |
| Gym password change | Hash in `GymChangePassword` |
| Profile password update | Hash in `UpdateProfileController` |

### Password migration note

Existing member/gym plaintext passwords in DB cannot be verified with BCrypt without a migration strategy (force reset, or re-hash on next successful plaintext login during transition).

### Other security fixes

| Issue | Fix |
|-------|-----|
| XSS in community | `<c:out>` for `${post.title}`, `${post.body}` |
| SQL injection via sort | Whitelist `sortOrder` to `ASC`/`DESC` in admin controllers |
| Hardcoded secrets | Move to `config.properties` (gitignored) |

### Exit criteria

- Admin endpoints reject unauthenticated/non-admin users
- New member registrations store BCrypt hashes
- Secrets externalized to config template

---

## Phase 7 — Member/gym polish

**Effort:** ~3–4 days | **Risk:** low–medium

| Area | Action |
|------|--------|
| `UploadController` | Add auth check; route through service |
| Controllers calling DAO directly | Route through service layer |
| `ExerciseDAO` name collision | Rename admin `ExerciseDAO` → `ExerciseGuideDAO` |
| Remaining XSS surfaces | Gym notices, admin reports |
| Signup sprawl | Optional later: consolidate trainer 5 servlets into step-routed controller |

---

## Phase 8 — Documentation and repo hygiene

**Effort:** ~½ day | **Risk:** none

| Item | Action |
|------|--------|
| `README.md` | Keep current; update as phases complete |
| `config.properties.example` | DB URL, Toss test key, Gmail placeholders |
| `.gitignore` | Add `config.properties` |
| This file | Mark phases complete with dates as they land |

---

## Execution order

```
Phase 0 (baseline)
    → Phase 1 (dead code)        ← start here
    → Phase 2 (naming/auth)
    → Phase 3 (DAO pattern)
    → Phase 4 (shared DTOs)      ← highest structural value
    → Phase 5 (payments)
    → Phase 6 (security)
    → Phase 7 (polish)
    → Phase 8 (docs)
```

Phases 4 and 5 can be parallelized by different contributors if entity boundaries are respected (one entity per PR).

## PR breakdown

| PR | Phase | Est. scope |
|----|-------|------------|
| PR1 | 1 | ~25 deletes, ~5 edits |
| PR2 | 2 | ~15 files |
| PR3 | 3 | ~20 files |
| PR4 | 4a | User + UserDAO (~40 files) |
| PR5 | 4b | Trainer, Gym, Payment DTOs (~60 files) |
| PR6 | 5 | Payment unification (~30 files) |
| PR7 | 6 | Filters + BCrypt (~25 files) |
| PR8 | 7–8 | XSS, secrets, config template (~20 files) |

## Explicitly out of scope (v1)

- Maven/Gradle build migration
- Spring or other DI framework
- UI redesign
- Bulk rename of all 68 mapper files
- Automated test suite (unless separately requested)
- Merging admin view DTOs into entity DTOs

## Progress tracker

| Phase | Status | Completed |
|-------|--------|-----------|
| 0 — Baseline | Complete | 2026-07-07 — branch `cleanup/phase-1-dead-code` |
| 1 — Dead weight | Complete | 2026-07-07 — 16 files deleted, admin dead methods removed, mybatis deduped |
| 2 — Naming/auth | Complete | 2026-07-07 — web.xml display-name, trainer auth unified; gym DAO rename deferred |
| 3 — DAO pattern | Complete | 2026-07-07 — GymDAO→MyBatis, service-owned SqlSession, DBUtil removed |
| 4 — Shared DTOs | In progress | 2026-07-07 — UserDTO, TrainerDTO, Gym, Payment, TossDTO → `dto.common` |
| 5 — Payments | Not started | |
| 6 — Security | Not started | |
| 7 — Polish | Not started | |
| 8 — Docs | In progress | README, ARCHITECTURE, CONVENTIONS, this file |

_Update the progress tracker as phases complete._

# Smoke test checklist

Manual verification after cleanup. Deploy to Tomcat as `Fitsbug` (`/Fitsbug` context). Ensure `config.properties` is configured.

## Prerequisites

- [ ] MariaDB running with `fitsbug` schema from `finaldb.sql`
- [ ] `config.properties` copied from `config.properties.example` (DB, Toss keys; optional Kakao/Gmail)
- [ ] Tomcat deploy succeeds without startup errors

## Auth & sessions

| Flow | URL | Expected |
|------|-----|----------|
| Member login | `/Fitsbug/member/login` | Valid credentials → `/member/main` |
| Member join step 3 | `/Fitsbug/member/step3` | Completes 3-step signup; BCrypt password stored |
| Trainer login | `/Fitsbug/trainer/login` | Sets `loginTrainer` → `/trainer/dashboard` |
| Trainer via unified login | `/Fitsbug/member/login` (TRAINER role) | Sets `loginTrainer` → `/trainer/dashboard` |
| Gym login | `/Fitsbug/member/login` (GYM role) | Sets `gymId` → `/gym/dashboard` |
| Admin login | `/Fitsbug/member/login` (ADMIN role) | → `/admin/main` |
| Admin filter | `/Fitsbug/admin/main` (logged out) | Redirect to `/member/login` |
| Trainer filter | `/Fitsbug/trainer/dashboard` (logged out) | Redirect to `/trainer/login` |
| Gym filter | `/Fitsbug/gym/dashboard` (logged out) | Redirect to `/member/login` |

## Trainer signup (consolidated controller)

Complete all 5 steps with a new email:

1. [ ] `/trainer/signup` — account created, `pendingTrainerUserId` in session
2. [ ] `/trainer/signup/step2` — profile image + tags saved
3. [ ] `/trainer/signup/step3` — payout / trainer type saved
4. [ ] `/trainer/signup/step4` — certifications (optional skip)
5. [ ] `/trainer/signup/step5` — pricing + availability → redirect `/trainer/login`

## Member features

| Feature | URL | Check |
|---------|-----|-------|
| Community | `/member/community` | Posts render; title/body escaped |
| Notifications | `/member/notification` | JSON list when logged in |
| Workout log | `/member/workout` (GET/POST) | Today's exercises return/save |
| Profile upload | `/member/uploadProfile` | Requires login; updates image |
| Email code | `/member/sendEmailCode` | Returns `success:true` when Gmail configured |

## Payments (Toss test mode)

| Flow | Notes |
|------|-------|
| Member PT checkout | Trainer detail → payment; uses `tossClientKey` from config |
| Trainer payment confirm | `/payment/confirm` completes without 500 |

## Kakao (optional)

Requires `kakao.client.id` and redirect URI `http://localhost:8080/Fitsbug/member/kakaoLogin` in Kakao developer console.

- [ ] OAuth callback creates or logs in member → `/member/main`

## Regression spot-checks

- [ ] Gym notice list/detail shows escaped user content
- [ ] Admin report list loads; detail panel uses `textContent` (no script injection)
- [ ] Legacy plaintext password still works once, then migrates to BCrypt on login

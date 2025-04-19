1. Programs
GET /api/v1/programs

GET /api/v1/programs/:id

2. Days
GET /api/v1/programs/:program_id/days

GET /api/v1/days/:id (includes all activities)

3. Daily Activities
GET /api/v1/days/:day_id/activities?user_id=X

Returns daily activities with user-specific completion status

4. Completions
POST /api/v1/completions

DELETE /api/v1/completions/:id

GET /api/v1/users/:user_id/completions

5. User
GET /api/v1/users/1/progress
(optional query parameter ?program_id=1)
### Project 15 — Jobs, CronJobs, and Init Containers

**Complexity: ★★★★☆ | Pure K8s**

#### Design Brief

Not every workload runs forever. `Job` runs a task to completion and is perfect for database migrations, report generation, or data processing. `CronJob` wraps a Job in a schedule. `InitContainer` solves the problem of ensuring dependencies are ready before your main app starts. This project ties all three together in a realistic scenario.

#### What to Build

Using the Voting App from Project 13 as your base:

- Add an **InitContainer** to the worker deployment that uses `pg_isready` to wait for PostgreSQL to be accepting connections before the worker starts.
- Create a **Job** that runs a database seed/migration script via `psql`.
- Create a **CronJob** that runs every 5 minutes, curls the results API, and logs the current vote tally — simulating a scheduled report.

Observe Job history and configure `successfulJobsHistoryLimit` and `failedJobsHistoryLimit`.

#### Docker Images

- `postgres:15-alpine` — for the InitContainer (`pg_isready`) and the seed Job (`psql`).
- `curlimages/curl:8.4.0` — for the CronJob report task.
- `busybox:1.36` — for any additional scripting needs.

#### Deliverables

Job, CronJob, and a Deployment with InitContainers. Write about the ordering guarantees InitContainers provide.
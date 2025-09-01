# pgTAP POC

> https://pgtap.org/

pgTAP is a unit testing framework for PostgreSQL that allows you to write automated tests for your database objects (tables, columns, functions, triggers, constraints, etc.) using SQL. It follows the TAP (Test Anything Protocol), making it easy to integrate with CI/CD pipelines.

Key Features

- Test tables, columns, indexes, constraints, and default values.
- Test functions, stored procedures, triggers, and views.
- Provides more than 100 built-in testing functions (e.g., has_table, col_not_null, func_returns, ok).
- Integrates with pg_prove for running tests from the command line.
- Compatible with CI/CD tools like GitHub Actions, GitLab CI, Jenkins, etc.

### Usage

* Run DB
```bash
./run.sh
```

* Run tests
```bash
./tests.sh
```

* Clean Everything
```bash
./clean.sh
```

### Manual Usage

```bash
docker compose up --build
```

```bash
docker exec -it pgdb pg_prove -d testdb -U testuser /tests/*.sql
```

### Results
```
/tests/accounts.sql .. ok
/tests/users.sql ..... ok
All tests successful.
Files=2, Tests=9,  0 wallclock secs ( 0.02 usr  0.01 sys +  0.06 cusr  0.01 csys =  0.10 CPU)
Result: PASS
```
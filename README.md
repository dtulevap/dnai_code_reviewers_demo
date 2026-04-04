# dnai_code_reviewers_demo

A sample **dbt-like repository** used to explore [GitHub Copilot CLI](https://docs.github.com/en/copilot/using-github-copilot/using-github-copilot-in-the-command-line) in GitHub Actions before rolling the workflow out to a production repository.

---

## Purpose

This repo lets you safely experiment with:

- **GitHub Copilot CLI code review** triggered automatically on every pull request via GitHub Actions.

Once the workflows are validated here they can be copied into a production dbt project with confidence.

---

## Project structure

```
.
├── analyses/                   # Ad-hoc SQL analyses (not materialized)
│   └── monthly_revenue.sql
├── macros/                     # Reusable Jinja/SQL macros
│   ├── cents_to_dollars.sql
│   └── generate_schema_name.sql
├── models/
│   ├── staging/                # 1-to-1 mappings of raw source tables
│   │   ├── stg_customers.sql
│   │   ├── stg_orders.sql
│   │   ├── stg_payments.sql
│   │   └── _staging__sources.yml
│   ├── intermediate/           # Business logic / joins
│   │   ├── int_orders_with_payments.sql
│   │   └── _intermediate__models.yml
│   └── marts/                  # Final analytics-ready tables
│       ├── dim_customers.sql
│       ├── fct_orders.sql
│       └── _marts__models.yml
├── seeds/                      # Static CSV data for development/testing
│   ├── raw_customers.csv
│   ├── raw_orders.csv
│   └── raw_payments.csv
├── .github/
│   └── workflows/
│       └── copilot-review.yml  # GitHub Copilot CLI PR review
├── dbt_project.yml
├── packages.yml
└── profiles.yml
```

---

## Data model

```
raw_customers  raw_orders  raw_payments
      │               │           │
      ▼               ▼           ▼
stg_customers   stg_orders   stg_payments
                      │           │
                      └─────┬─────┘
                            ▼
                 int_orders_with_payments
                      │           │
                      ▼           ▼
               fct_orders   dim_customers
```

---

## GitHub Actions workflows

### `copilot-review.yml`

Triggered on every **non-draft pull request** that modifies dbt SQL or YAML files.

Uses the `github/copilot-public-api-actions/review` action to post an AI-powered code review comment covering:

- SQL quality & performance
- dbt best practices
- Test coverage
- Documentation completeness
- Security & data quality

---

## Local development

### Prerequisites

- Python 3.11+
- [dbt-duckdb](https://github.com/duckdb/dbt-duckdb)

### Setup

```bash
pip install dbt-duckdb dbt-core
dbt deps --profiles-dir .
dbt seed --profiles-dir .
dbt run --profiles-dir .
dbt test --profiles-dir .
```

### Generate & serve documentation

```bash
dbt docs generate --profiles-dir .
dbt docs serve --profiles-dir .
```

---

## License

Apache License 2.0 – see [LICENSE](LICENSE).

# List the available commands
help:
    @just --list --justfile {{justfile()}}

# Prepare the environment for development and setup pre-commit hooks.
setup:
    uv sync
    [[ -n "${HUGR_JUST_INHIBIT_GIT_HOOKS:-}" ]] || uv run pre-commit install -t pre-commit
    _check_nextest_installed

# Run the pre-commit checks.
check:
    HUGR_TEST_SCHEMA=1 uv run pre-commit run --all-files

# Run all the tests.
test: test-rust test-python
# Run the rust tests.
test-rust *TEST_ARGS: _check_nextest_installed
    cargo nextest r \
        --workspace \
        --exclude 'python' \
        --all-features \
        {{TEST_ARGS}}
# Run the python tests.
test-python *TEST_ARGS:
    uv run maturin develop --uv
    uv run pytest {{TEST_ARGS}}

# Run all the benchmarks.
bench: bench-rust
# Run the rust benchmarks
bench-rust *TEST_ARGS:
    cargo bench {{TEST_ARGS}}

# Auto-fix all lints and warnings.
fix: fix-rust fix-python
# Fix the rust code
fix-rust:
    cargo clippy --all-targets --all-features --workspace --fix --allow-staged --allow-dirty
# Fix the python code
fix-python:
    uv run ruff check --fix

# Format the code.
format: format-rust format-python
# Format the rust code
format-rust:
    cargo fmt --all
# Format the python code
format-python:
    uv run ruff format

# Generate a test coverage report.
coverage: coverage-rust coverage-python
# Generate the rust coverage report
coverage-rust:
    cargo llvm-cov --lcov > lcov.info
# Generate the python coverage report
coverage-python:
    uv run pytest -n auto --cov=./ --cov-report=html

_check_nextest_installed:
    #!/usr/bin/env bash
    cargo nextest --version >/dev/null 2>&1 || { echo "❌ cargo-nextest not found. Install binary from https://nexte.st/docs/installation/pre-built-binaries/"; exit 1; }

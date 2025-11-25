# Template instructions

This is a template repository for creating TKET extensions implemented using the
Rust hugr/tket API, and exporting a Python package that can be used with
guppy-generated hugrs.

The template is a work in progress, so be sure to add an issue if you find any
problems with it.

## Setting up a new repository

0. Create a new Github repository for your extension using this one as a template.

1. Replace all occurrences of `tket-extension-template` or `tket_extension_template` with your project's name.

2. Ask someone on the Hugrverse team to create a @hugrbot token and add it as a `HUGRBOT_TOKEN` secret to the repository.

3. Update the `README.md` files in the `rust` and `python` directories to reflect the details of your extension.

### Github Repository Configuration

These options ensure that the repository is configured correctly for the CI to run smoothly.

- In General Settings > Pull Request, only allow "Squash and merge" for pull requests.
    - Set the default commit message to the PR title and description.

- In Rules > Ruleset create a new "Branch ruleset".
    - Set enforcement status to "Active"
    - Set target branch to the default branch of the repository.
    - Select "Require linear history"
    - Select "Require merge queue"
    - Select "Require a pull request before merging"
    - Select "Require status checks to pass" and enable the following checks (you may need to push a commit for the selector to populate):
        - Required checks 🐍
        - Required checks 🦀
        - check-title / Validate Conventional Commit PR title

### Optional steps

After the previous steps, the repository should be ready for development.

If your project is in a public repository, consider adding benchmarking and test coverage tracking to the repository.

#### Coverage

Setup a [codecov.io](https://codecov.io) project and add a `CODECOV_TOKEN` secret to the repository.
The CI should take care of uploading the coverage report to codecov.io.

#### Benchmarking

Setup a [codspeed.io](https://codspeed.io) project and add a `CODSPEED_TOKEN` secret to the repository.
The CI should take care of uploading the benchmark results to codspeed.io.

#### Release automation

You can let automation handle the CHANGELOG generation, version bumping, and package publishing for you (for both Rust and Python libraries).

Re-enable the triggers in [`release-plz.yml`](.github/workflows/release-plz.yml)
and [`release-please.yml`](.github/workflows/release-please.yml) if you want to
use it. You'll need to create the library in crates.io or PyPI initially before
the automation can push to them.

## Structure of the repository

The repository is a workspace with two members:

- `rust`: The Rust library containing the extension.
- `python`: The Python package containing the bindings.

The `rust` library is a standard Rust library that can be optionally published to crates.io.
This is where most of the core functionality of your extension should be implemented.
As it does not require a Python runtime, it can be published to crates.io and shared with other Rust projects.

The `python` package contains both a small Rust library that exposes bindings to the Python side, and a Python package that can be published to PyPI, using those bindings.
The CI is already setup to build the Python wheels with all the native code compiled to a shared library.

## Implementing an extension

There's three steps to implementing a new feature in your extension:

1. Add new functions/methods/types to the main Rust library.

    This should go in `rust/src/*.rs`.

2. Add bindings for the new definitions.

    Wrap the rust definitions in classes using `pyo3` macros.
    This should go in `python/rust-bindings/*.rs`.
    There's some basic examples in the file, but you can refer to the
    [`pyo3` user guide](https://pyo3.rs/) for more details.

    Be sure to add type stubs to the `python/src/tket_extension_template/_bindings/__init__.pyi` file.

3. Use the new definitions in the Python package.

    This should go in `python/src/tket_extension_template/*.py`.

    Tests can be added in the `python/tests/` directory.

The repository is setup with a justfile to run the tests, benchmarks, and other
checks. Install [just](https://just.systems/) and run `just setup` to initialize
the python environment and setup the pre-commit hooks.

You can check that your extension is working at each step by running `just
test`.

Check [DEVELOPMENT.md](https://github.com/CQCL/tket-extension-template/blob/main/DEVELOPMENT.md) for more details on working with the repository.

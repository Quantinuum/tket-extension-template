//! Supporting Rust library for the Python bindings.

mod hugr;

use pyo3::exceptions::PyException;
use pyo3::{create_exception, pymodule};

/// Python module containing the Rust bindings.
///
/// The definitions here should be reflected in the
/// `python/src/tket_extension_template/_bindings/__init__.pyi` type stubs.
#[pymodule]
mod _bindings {
    use pyo3::prelude::*;

    #[pymodule_export]
    use crate::ExampleError;
    #[pymodule_export]
    use crate::hugr::RsHugr;

    /// Remove all contents from the Hugr.
    ///
    /// This function is provided only as an example.
    //
    // Inline definition of a pyfunction, also made available to Python
    #[pyfunction]
    fn example_remove_contents(rs_hugr: &mut RsHugr) -> PyResult<()> {
        let hugr = &mut rs_hugr.hugr;

        // Call the function from the rust crate.
        tket_extension_template::example_remove_contents(hugr)
            .map_err(|e| ExampleError::new_err(e.to_string()))?;

        Ok(())
    }
}

// Define custom exceptions
create_exception!(
    _bindings,
    ExampleError,
    PyException,
    "Example python-side exception."
);

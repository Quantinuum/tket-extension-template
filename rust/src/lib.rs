//! TKET extension crate.
//
// TODO: These docs appear in the landing page of the crate documentation on docs.rs.
// Make sure to update them to reflect the details of your extension.

use tket::Hugr;
use tket::hugr::HugrView;
use tket::hugr::hugr::hugrmut::HugrMut;

/// Example function.
///
/// Takes a Hugr and removes every node from it, except the module root.
pub fn example_remove_contents(hugr: &mut Hugr) -> Result<(), ExampleError> {
    if hugr.num_nodes() == 1 {
        return Err(ExampleError {
            message: "Hugr is already empty".to_string(),
        });
    }
    hugr.set_entrypoint(hugr.module_root());

    while let Some(node) = hugr.first_child(hugr.module_root()) {
        hugr.remove_subtree(node);
    }

    hugr.validate().unwrap_or_else(|e| panic!("{e}"));

    Ok(())
}

/// Example error.
#[derive(Debug, derive_more::Display, derive_more::Error)]
#[display("Example error: {message}")]
pub struct ExampleError {
    message: String,
}

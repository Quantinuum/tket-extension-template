"""An example TKET extension."""

from ._bindings import ExampleError
from ._bindings import RsHugr
from ._bindings import example_remove_contents

from hugr import Hugr


def remove_contents(hugr: Hugr) -> Hugr:
    """Remove all contents from the Hugr.

    This function is provided only as an example.

    :raises ExampleError: If the hugr is empty.
    """
    rs_hugr = RsHugr.from_str(hugr.to_str())
    example_remove_contents(rs_hugr)
    return Hugr.from_str(rs_hugr.to_str())


__all__ = [
    "ExampleError",
    "remove_contents",
]

# This is updated by the release-please workflow, triggered by this
# annotation: x-release-please-version
__version__ = "0.0.0"

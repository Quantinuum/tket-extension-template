from hugr import Hugr, ops
from tket_extension_template import remove_contents, ExampleError
import pytest


def test_it_works() -> None:
    assert str(2 + 2) != "🐟"


def test_remove_contents() -> None:
    hugr = Hugr(ops.DFG([], []))

    hugr = remove_contents(hugr)
    assert hugr.num_nodes() == 1

    with pytest.raises(ExampleError):
        hugr = remove_contents(hugr)

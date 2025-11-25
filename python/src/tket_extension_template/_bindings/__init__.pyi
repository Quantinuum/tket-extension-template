"""Typing stubs for the bindings defined in the `rust-bindings` crate."""

from hugr.envelope import EnvelopeConfig

class RsHugr:
    """Rust-backed Hugr."""
    def to_bytes(self, config: EnvelopeConfig | None = None) -> bytes:
        """Encode the Hugr as a bytes object."""
        pass

    def to_str(self, config: EnvelopeConfig | None = None) -> str:
        """Encode the Hugr as a string."""
        pass

    @classmethod
    def from_bytes(cls, bytes: bytes, config: EnvelopeConfig | None = None) -> RsHugr:
        """Decode the Hugr from a bytes object."""
        pass

    @classmethod
    def from_str(cls, str: str, config: EnvelopeConfig | None = None) -> RsHugr:
        """Decode the Hugr from a string."""
        pass

    def mermaid_string(self) -> str:
        """Render the Hugr as a Mermaid string."""
        pass

class ExampleError(Exception):
    """Example python-side exception."""

def example_remove_contents(rs_hugr: RsHugr) -> None:
    """Remove all contents from the Hugr.

    This function is provided only as an example.

    :raises ExampleError: If the hugr is empty.
    """

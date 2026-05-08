return {
    cmd = { "rust-analyzer" },
    filetypes = { "rust", },
    root_markers = {
        "Cargo.toml",
        "Cargo.lock",
        ".git",
    },
    settings = {
      cargo = {
        targetDir = "target/rust-analyzer",
      },
    },
}

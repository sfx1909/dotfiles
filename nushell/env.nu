# --- Environment ---
$env.GOPATH = $"($env.HOME)/go"
$env.BUN_INSTALL = $"($env.HOME)/.bun"

# --- Path ---
$env.PATH = (
    $env.PATH
    | split row (char esep)
    | prepend [
        $"($env.GOPATH)/bin"
        $"($env.BUN_INSTALL)/bin"
        $"($env.HOME)/.pub-cache/bin"
        $"($env.HOME)/.local/bin"
        $"($env.HOME)/bin"
    ]
    | where { |p| ($p | path exists) }
    | uniq
)
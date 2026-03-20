# --- Environment ---
$env.GOPATH = $"($env.HOME)/go"
$env.BUN_INSTALL = $"($env.HOME)/.bun"

# --- Path ---
$env.PATH = (
    $env.PATH
    | split row (char esep)
    | prepend [
        $"($env.GOPATH)/bin"          # Go globals
        $"($env.BUN_INSTALL)/bin"     # Bun globals
        $"($env.HOME)/.pub-cache/bin" # Dart globals
        $"($env.HOME)/.local/bin"     # Local bins
        $"($env.HOME)/bin"            # User bins
    ]
    | filter { |p| ($p | path exists) } # Only add if exists
    | uniq                              # No duplicates
)
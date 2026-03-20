# --- Prompt ---
if (which starship | is-not-empty) {
    $env.STARSHIP_SHELL = "nu"
    let starship_cache = $"($env.HOME)/.cache/starship"
    if not ($starship_cache | path exists) { mkdir $starship_cache }
    starship init nu | save -f $starship_cache/init.nu
    use $starship_cache/init.nu
}

# --- Completions ---
if (which carapace | is-not-empty) {
    $env.CARAPACE_BRIDGES = 'nushell'
    carapace _carapace nushell | save -f /tmp/carapace.nu
    use /tmp/carapace.nu
}

# --- Aliases ---
alias neofetch = fastfetch
alias cat = bat
alias v = nvim
alias vi = nvim
alias vim = nvim
alias n = nvim
alias ls = eza --icons
alias ll = eza --icons -la
alias c = clear
alias clr = clear

# --- Misc ---
$env.config = {
    show_banner: false
}
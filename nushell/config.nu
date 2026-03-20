# --- Prompt ---
use ~/.cache/starship/init.nu

# --- Completions ---
source ~/.cache/carapace.nu

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
# --- CLI Tools Aliases ---
command -q fastfetch && alias neofetch='fastfetch'
command -q bat && alias cat='bat'
command -q nvim && alias v='nvim' && alias vi='nvim' && alias vim='nvim' && alias n='nvim'
command -q zeditor && alias zed='zeditor'
command -q eza && function ls
    eza --icons $argv
end
command -q eza && function ll
    eza --icons -la $argv
end

# --- General Aliases ---
alias c='clear'
alias clr='clear'

# --- Environment ---

set -gx GOPATH $HOME/go
set -gx BUN_INSTALL $HOME/.bun

# --- Path ---

fish_add_path $GOPATH/bin # Go Global
fish_add_path $BUN_INSTALL/bin # Bun Global
fish_add_path $HOME/.pub-cache/bin # Dart Global
fish_add_path $HOME/.tools/flutter/bin # Flutter and Dart

## --- Local Bin Auto Discovery ---
for dir in $HOME/.local/bin $HOME/bin
    if test -d $dir
        fish_add_path $dir
    end
end

# --- Tools ---
if command -q zoxide
    zoxide init fish --cmd cd | source
end

if command -q direnv
    direnv hook fish | source
end

if command -q carapace
    set -Ux CARAPACE_BRIDGES 'zsh,fish,bash,inshellisense'
    carapace _carapace | source
end

if command -q starship
    if set -q VSCODE_PID; or test "$TERM_PROGRAM" = vscode; or set -q ZED_TERM
        set -gx STARSHIP_CONFIG ~/.config/starship/minimal.toml
    end

    function starship_transient_rprompt_func
        starship module time
    end
    function starship_transient_prompt_func
        starship module character
    end
    starship init fish | source
    enable_transience
end

# --- Misc ---
set -U fish_greeting

# --- SSH Agent ---
if test -z "$SSH_AUTH_SOCK"
    set -gx SSH_AUTH_SOCK /run/user/1000/ssh-agent
end

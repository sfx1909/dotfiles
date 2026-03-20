# --- Environment ---

set -gx GOPATH $HOME/go
set -gx BUN_INSTALL $HOME/.bun

# --- Path ---

fish_add_path $GOPATH/bin # Go Global
fish_add_path $BUN_INSTALL/bin # Bun Global
fish_add_path $HOME/.pub-cache/bin # Dart Global

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
    starship init fish | source
end

# --- Misc ---
set -U fish_greeting

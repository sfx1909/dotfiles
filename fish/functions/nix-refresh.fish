function nix-refresh --description "Update and rebuild NixOS"
    set -l config_dir ~/nixos-config
    set -l use_gum (command -q gum; and echo true; or echo false)
    set -l verbose false
    set -l tmp (mktemp)

    # Parse flags
    for arg in $argv
        if test $arg = --verbose -o $arg = -v
            set verbose true
        end
    end

    # Grab sudo upfront
    sudo -v
    if test $status -ne 0
        test $use_gum = true && gum style --foreground 196 "✗ sudo authentication failed"
        rm $tmp
        return 1
    end

    cd $config_dir

    # Update
    if test $use_gum = true && test $verbose = false
        gum spin --spinner dot --title "Updating..." -- sudo nix flake update --flake .
        if test $status -ne 0
            gum style --foreground 196 "✗ Failed to update"
            rm $tmp
            sudo -k
            cd -
            return 1
        end
    else
        test $use_gum = true && gum style --foreground 212 "Updating..."
        sudo nix flake update --flake . 2>&1 | tee $tmp
        if test $pipestatus[1] -ne 0
            test $use_gum = true && gum style --foreground 196 "✗ Failed to update"
            rm $tmp
            sudo -k
            cd -
            return 1
        end
    end

    test $use_gum = true && gum style --foreground 48 "✓ Updated"

    # Rebuild NixOS
    if test $use_gum = true && test $verbose = false
        gum spin --spinner dot --title "Rebuilding NixOS..." -- sh -c "sudo nixos-rebuild switch --flake '.#desktop' > $tmp 2>&1"
        if test $status -ne 0
            gum style --foreground 196 "✗ Failed to rebuild NixOS"
            cat $tmp
            rm $tmp
            sudo -k
            cd -
            return 1
        end
    else
        test $use_gum = true && gum style --foreground 212 "Rebuilding NixOS..."
        sudo nixos-rebuild switch --flake ".#desktop" 2>&1 | tee $tmp
        if test $pipestatus[1] -ne 0
            test $use_gum = true && gum style --foreground 196 "✗ Failed to rebuild NixOS"
            rm $tmp
            sudo -k
            cd -
            return 1
        end
    end

    rm $tmp

    if test $use_gum = true
        gum style --foreground 48 "✓ NixOS refresh complete!"
    else
        echo "Done!"
    end

    sudo -k
    cd -
end

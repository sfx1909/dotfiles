# --- SSH Agent via keychain ---
if command -q keychain
    keychain --eval --quiet id_ed25519 | source
end

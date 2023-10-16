# Check if pkg-config is installed
if command -v pkg-config >/dev/null 2>&1; then
    completions_dir=$(pkg-config --variable=completionsdir bash-completion)
else
    # If pkg-config is not installed, assume default directory
    completions_dir="/usr/share/bash-completion/completions"
fi

# Check if pass-otp completion file exists
if [ -f "$completions_dir/pass-otp" ]; then
    # Check if 'otp' is already in PASSWORD_STORE_EXTENSION_COMMANDS
    if [[ ! " ${PASSWORD_STORE_EXTENSION_COMMANDS[*]} " =~ " otp " ]]; then
        source "$completions_dir/pass-otp"
    fi
fi


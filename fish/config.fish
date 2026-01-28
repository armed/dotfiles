# Environment variables (run in all sessions, interactive or not)
set -gx PATH "/usr/local/bin" $PATH
set -gx PATH "$HOME/.local/bin" $PATH
set -gx PATH "/opt/homebrew/bin" "/opt/homebrew/sbin" $PATH
set -gx PATH "$HOME/Developer/myself/dotfiles/scripts" $PATH
set -gx PATH "/Users/armed/bin" $PATH
set -gx PATH "/usr/local/sbin" $PATH
set -gx PATH "$HOME/Developer/tools/ldc2/bin" $PATH
set -gx PATH "$VCPKG_ROOT" $PATH

set -gx XDG_CONFIG_HOME "/Users/armed/.config"
set -gx PNPM_HOME "/Users/armed/Library/pnpm"
set -gx GRAALVM_HOME "$JAVA_HOME"
set -gx LANG "en_US.UTF-8"
set -gx LC_ALL "en_US.UTF-8"
set -gx LIBRARY_PATH "$LIBRARY_PATH" "/opt/homebrew/lib"
set -gx VCPKG_ROOT "$HOME/Developer/vcpkg"
set -gx EDITOR "nvim"

set -gx JJ_CONFIG "$HOME/.config/jj/config.toml"

if not string match -q "*$PNPM_HOME*" "$PATH"
    set -gx PATH "$PNPM_HOME" $PATH
end

# Interactive session settings
if status is-interactive
    alias ll "ls -la"
    alias nv "nvim"
    alias wifi "networksetup -setairportpower en0 off; and sleep 1; and networksetup -setairportpower en0 on"
    alias nvd "$HOME/Applications/neovide.app/Contents/MacOS/neovide --frame transparent"
    alias clojure "clojure -J-Dapple.awt.UIElement=true"
    alias ljj "lazyjj"
    alias p "pnpm"
    alias pu "pulumi"

    alias lust "just --justfile .justfile.local"

    # Console account
    alias claude-console='CLAUDE_CODE_USE_BEDROCK=1 \
      ANTHROPIC_MODEL="global.anthropic.claude-opus-4-5-20251101-v1:0" \
      ANTHROPIC_SMALL_FAST_MODEL="us.anthropic.claude-haiku-4-5-20251001-v1:0" \
      ANTHROPIC_DEFAULT_OPUS_MODEL="global.anthropic.claude-opus-4-5-20251101-v1:0" \
      ANTHROPIC_DEFAULT_SONNET_MODEL="global.anthropic.claude-sonnet-4-5-20250929-v1:0" \
      ANTHROPIC_DEFAULT_HAIKU_MODEL="global.anthropic.claude-haiku-4-5-20251001-v1:0" \
      CLAUDE_CODE_MAX_OUTPUT_TOKENS=8129 \
      MAX_THINKING_TOKENS=1024 \
      AWS_REGION=us-east-1 \
      CLAUDE_CONFIG_DIR="$HOME/.config/claude-code/profiles/console" \
      claude'

    # Personal account  
    alias claude-personal='CLAUDE_CONFIG_DIR="$HOME/.config/claude-code/profiles/personal" claude'

    mise activate fish | source

    starship init fish | source
    fzf --fish | source

    atuin init fish | source

    COMPLETE=fish jj | source
end

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/armed/Downloads/google-cloud-sdk/path.fish.inc' ]; . '/Users/armed/Downloads/google-cloud-sdk/path.fish.inc'; end


function fish_greeting
end

fish_vi_key_bindings

# Emulates vim's cursor shape behavior
# Set the normal and visual mode cursors to a block
set fish_cursor_default block blink
# Set the insert mode cursor to a line
set fish_cursor_insert line blink
# Set the replace mode cursors to an underscore
set fish_cursor_replace_one underscore
set fish_cursor_replace underscore

set fish_vi_force_cursor

function fish_prompt
    set -l last_status $status

    set -l stat
    if test $last_status -ne 0
        set stat (set_color -o brred)"[$last_status]"(set_color normal)
    end

    string join '' -- (set_color -o 87FF00) (whoami) (set_color -o C3CBE9) ':' \
        (set_color -o AFFFFF) (prompt_pwd --full-length-dirs 2) (set_color C3CBE9) \
        '$' $stat (set_color normal) ' '
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end

function from_bash
    sed -e 's/\(.*\)=\(.*\); \(.*\)/set -x \1 \'\2\'; \3/' $argv
end

eval $(ssh-agent | from_bash) > /dev/null

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME
set -gx PATH $HOME/.cabal/bin $PATH /home/nick/.ghcup/bin # ghcup-env

source "/home/nick/.jabba/jabba.fish"

fish_add_path ~/utils/
fish_add_path ~/go/bin/
fish_add_path ~/zig/compiler/
fish_add_path ~/.local/share/flatpak/exports/share/

bind -M insert \cF accept-autosuggestion

source ~/.cargo/env.fish
source ~/.config/fish/completions/*
alias hx helix

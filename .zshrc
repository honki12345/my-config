# Created by newuser for 5.8.1

USB_DIR="/media/hookim/myusb"
NIX_PORTABLE="$HOME/goinfre/nix-portable"
DROPBOX_DIR="$HOME/dev/dropbox"

# prompt
autoload -U colors && colors
if [[ "$ENV" == "nix" ]]; then
    source $DROPBOX_DIR/install/git-prompt-nix.zsh
else
    source $DROPBOX_DIR/install/git-prompt.zsh
fi

#NEWLINE=$'\n %# '
#PS1="%{$fg[red]%}%n@%m %~ %{$reset_color%}${NEWLINE}"


# set environment
export MAIL=hookim@student.42gyeongsan.kr
export PATH="$DROPBOX_DIR/install/node-v22.11.0-linux-x64/bin:$DROPBOX_DIR/install/lua-5.4.7/src:$DROPBOX_DIR/install:$HOME/.local/bin:$PATH"
export NP_LOCATION=~/goinfre
export NP_RUNTIME=bwrap
export NIXPKGS_ALLOW_UNFREE=1
export CPATH="$DROPBOX_DIR/install/include:$CPATH"
export LIBRARY_PATH="$DROPBOX_DIR/install/lib:$LIBRARY_PATH"
export LD_LIBRARY_PATH="$DROPBOX_DIR/install/lib:$LD_LIBRARY_PATH"
export RUSTUP_HOME=/media/hookim/myusb/rust/rustup
export CARGO_HOME=/media/hookim/myusb/rust/cargo


# alias
alias nsh="$NIX_PORTABLE nix-shell $DROPBOX_DIR/install/shell.nix"
alias mynorm='norminette -R CheckForbiddenSourceHeader'
alias normh='norminette -R CheckDefine'
alias mycc='cc -Wall -Wextra -Werror -g'
alias ll='eza -1 --long -a'
alias l='eza -1'
alias c='clear'
alias zshrc='vi ~/.zshrc'
alias paste='xclip -selection clipboard'
alias start='~/nix-script.sh'
alias nvim="$DROPBOX_DIR/dropbox/nvim-linux64/bin/nvim"
alias lgit='lazygit'
#alias py="$DROPBOX_DIR/install/python313.sh"
alias ff='nohup /goinfre/hookim/firefox/firefox "$@" > /dev/null 2>&1 &
		disown'

clion() {
        nohup $USB_DIR/jetbrains/cli*/bin/clion "$@" > /dev/null 2>&1 &
		disown
}
pycharm() {
        nohup $USB_DIR/jetbrains/pyc*/bin/pycharm "$@" > /dev/null 2>&1 &
		disown
}
rustrover() {
        nohup $USB_DIR/jetbrains/Rus*/bin/rustrover "$@" > /dev/null 2>&1 &
		disown
}
webstorm() {
        nohup $USB_DIR/jetbrains/Web*/bin/webstorm "$@" > /dev/null 2>&1 &
		disown
}
rubymine() {
        nohup $USB_DIR/jetbrains/RubyMine*/bin/rubymine "$@" > /dev/null 2>&1 &
		disown
}
tldr() {
        ~/goinfre/nix-portable nix run nixpkgs#tldr -- "$@"
}
tree() {
        ~/goinfre/nix-portable nix run nixpkgs#tree -- "$@"
}
duf() {
        ~/goinfre/nix-portable nix run nixpkgs#duf -- "$@"
}
dust() {
        ~/goinfre/nix-portable nix run nixpkgs#dust -- "$@"
}
bear() {
    $NIX_PORTABLE nix-shell -p bear --run "bear -- make"
    make fclean
}

eval "$(zoxide init zsh)"

. "$HOME/.atuin/bin/env"

eval "$(atuin init zsh)"
rip() {
        ~/goinfre/nix-portable nix run nixpkgs#rm-improved -- "$@"
}
wmctrl() {
        ~/goinfre/nix-portable nix run nixpkgs#wmctrl -- "$@"
}
zsh-git-prompt() {
        ~/goinfre/nix-portable nix run nixpkgs#zsh-git-prompt -- "$@"
}
dropbox() {
        ~/goinfre/nix-portable nix run nixpkgs#maestral -- "$@"
}
code() {
    /media/hookim/myusb/dropbox/install/VSCode/bin/code -- "$@"
}

function rr() {
    if [ $# -eq 0 ]; then
        echo "Usage: rustrun <filename>"
        return 1
    fi

    local filename=$(basename "$1" .rs)
    
    if [ ! -f "${filename}.rs" ]; then
        echo "Error: ${filename}.rs does not exist."
        return 1
    fi

    rustc "${filename}.rs" && ./"${filename}"
}


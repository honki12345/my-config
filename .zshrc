# Created by newuser for 5.8.1

# prompt
autoload -U colors && colors
source /home/hookim/dev/install/git-prompt.zsh
#NEWLINE=$'\n %# '
#PS1="%{$fg[red]%}%n@%m %~ %{$reset_color%}${NEWLINE}"


# set environment
export MAIL=hookim@student.42gyeongsan.kr
export PATH="$HOME/dev/install:$HOME/.local/bin:$PATH"
export NP_LOCATION=~/goinfre
export NP_RUNTIME=bwrap
export NIXPKGS_ALLOW_UNFREE=1


# alias
alias mynorm='norminette -R CheckForbiddenSourceHeader'
alias normh='norminette -R CheckDefine'
alias mycc='cc -Wall -Wextra -Werror -g'
alias ll='eza -1 --long -a'
alias l='eza -1'
alias c='clear'
alias cfdf='cd /home/hookim/dev/inner-circle/fdf'
alias cfzf='cd $(find ~ -type d | fzf)'
alias zshrc='vi ~/.zshrc'
alias paste='xclip -selection clipboard'


clion() {
        nohup ~/goinfre/nix-portable nix run --impure nixpkgs#jetbrains.clion "$@" > /dev/null 2>&1 & 
		disown
}
tldr() {
        ~/goinfre/nix-portable nix run nixpkgs#tldr -- "$@"
}
broot() {
        ~/goinfre/nix-portable nix run nixpkgs#broot -- "$@"
}
fzf() {
        ~/goinfre/nix-portable nix run nixpkgs#fzf -- "$@"
}
fd() {
        ~/goinfre/nix-portable nix run nixpkgs#fd -- "$@"
}
duf() {
        ~/goinfre/nix-portable nix run nixpkgs#duf -- "$@"
}
dust() {
        ~/goinfre/nix-portable nix run nixpkgs#dust -- "$@"
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

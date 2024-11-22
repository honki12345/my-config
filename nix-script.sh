#!/bin/bash

# 체크할 실행 파일 경로
nix_portable="$HOME/goinfre/nix-portable"
TLDR="nixpkgs#tldr"
ZOXIDE_PATH="$HOME/.local/bin/zoxide"
FZF_NAME="fzf"
FZF_PKGS="nixpkgs#fzf"
FD_NAME="fd"
FD_PKGS="nixpkgs#fd"
DUF_NAME="duf"
DUF_PKGS="nixpkgs#duf"
DUST_NAME="dust"
DUST_PKGS="nixpkgs#dust"
RIP_NAME="rip"
RIP_PKGS="nixpkgs#rm-improved"
WMCTRL_NAME="wmctrl"
WMCTRL_PKGS="nixpkgs#wmctrl"

# nix-portable install
if [ ! -f "$nix_portable" ]; then
	echo "$nix_portable does not exist. Downloading and setting up nix-portable..."
	curl -L https://github.com/DavHau/nix-portable/releases/latest/download/nix-portable-$(uname -m) > ~/goinfre/nix-portable

	chmod +x ~/goinfre/nix-portable
else
  echo "$nix_portable exists. No need to run the script."
fi

export NIXPKGS_ALLOW_UNFREE=1

$nix_portable nix build --impure --no-link nixpkgs#jetbrains.clion
$nix_portable nix build --impure --no-link nixpkgs#maestral
$nix_portable nix build --impure --no-link $TLDR
$nix_portable nix build --impure --no-link $FZF_PKGS
$nix_portable nix build --impure --no-link $FD_PKGS
$nix_portable nix build --impure --no-link $DUF_PKGS
$nix_portable nix build --impure --no-link $DUST_PKGS
$nix_portable nix build --impure --no-link $RIP_PKGS
$nix_portable nix build --impure --no-link $WMCTRL_PKGS

# .zshrc 파일 경로
ZSHRC_PATH="$HOME/.zshrc"

# zoxide install
if [ ! -f "$ZOXIDE_PATH" ]; then
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
else
    echo "zoxide가 이미 설치되어 있습니다."
fi


zsh -c "source $ZSHRC_PATH"

#./nix-portable nix-store --gc


wmctrl() {
    ~/goinfre/nix-portable nix run nixpkgs#wmctrl -- "$@"
}

clion() {
    nohup ~/goinfre/nix-portable nix run --impure nixpkgs#jetbrains.clion "$@" > /dev/null 2>&1 &
    disown
}

firefox() {
    nohup /usr/bin/flatpak run --branch=stable --arch=x86_64 --command=firefox org.mozilla.firefox "$@" > /dev/null 2>&1 &
    disown
}

discord() {
    nohup /usr/bin/flatpak run --branch=stable --arch=x86_64 --command=com.discordapp.Discord com.discordapp.Discord "$@" > /dev/null 2>&1 &
    disown
}

slack() {
    nohup /usr/bin/flatpak run --branch=stable --arch=x86_64 --command=com.slack.Slack --file-forwarding com.slack.Slack @@u %U @@ "$@" > /dev/null 2>&1 &
    disown
}

dropbox() {
        ~/goinfre/nix-portable nix run nixpkgs#maestral -- "$@"
}


# 프로그램을 먼저 다 실행합니다.
clion
firefox
slack
discord

# 각 프로그램의 창이 열리기까지 대기 후, 창 ID를 찾아 최대화하고 작업공간으로 이동
wait_for_window_and_move() {
    local window_name=$1
    local workspace=$2

    while true; do
	while [ $(wmctrl -l | grep "$window_name" | wc -l) -ne 1 ]; do
	    echo "창이 아직 열리지 않았습니다. 다시 확인 중..."
	    sleep 1  # 1초 대기
	done
        window_id=$(wmctrl -l | grep "$window_name" | awk '{print $1}')
        echo "Searched $window_name. Window ID: $window_id"

        if [ ! -z "$window_id" ]; then
            # 창 최대화
            wmctrl -i -r $window_id -b add,maximized_vert,maximized_horz

            # 작업공간으로 이동
            wmctrl -i -r $window_id -t $workspace
            echo "$window_name maximized and moved to workspace $workspace"
            break
        fi

        echo "$window_name not found. Waiting..."
        sleep 0.5
    done
}

# 각 프로그램에 대해 창이 열릴 때까지 기다리고 최대화한 후 작업공간으로 이동
wait_for_window_and_move "CLion" 1
wait_for_window_and_move "Firefox" 2
wait_for_window_and_move "Slack" 3
wait_for_window_and_move "Discord" 3

dropbox start


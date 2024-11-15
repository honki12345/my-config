#!/bin/zsh

wmctrl() {
    ~/goinfre/nix-portable nix run nixpkgs#wmctrl -- "$@"
}

clion() {
    nohup ~/goinfre/nix-portable nix run --impure nixpkgs#jetbrains.clion "$@" > /dev/null 2>&1 &
    disown
}

terminator() {
    /usr/bin/terminator
}

firefox() {
    nohup ~/goinfre/nix-portable nix run --impure nixpkgs#firefox "$@" > /dev/null 2>&1 &
    disown
}

discord() {
    nohup ~/goinfre/nix-portable nix run --impure nixpkgs#discord "$@" > /dev/null 2>&1 &
    disown
}

slack() {
    nohup ~/goinfre/nix-portable nix run --impure nixpkgs#slack "$@" > /dev/null 2>&1 &
    disown
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
        window_id=$(wmctrl -l | grep "$window_name" | awk '{print $1}')
        echo "Searching for $window_name. Window ID: $window_id"

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


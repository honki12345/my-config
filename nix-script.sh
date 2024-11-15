#!/bin/bash

# 체크할 실행 파일 경로
nix_portable="$HOME/goinfre/nix-portable"
TLDR="nixpkgs#tldr"
ZOXIDE_PATH="$HOME/.local/bin/zoxide"
BROOT_NAME="broot"
BROOT_PKGS="nixpkgs#broot"
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
$nix_portable nix build --impure --no-link $TLDR

# .zshrc 파일 경로
ZSHRC_PATH="$HOME/.zshrc"

# clion install
if ! grep -q "clion()" "$ZSHRC_PATH"; then
    # clion 함수가 없다면 .zshrc에 추가
    echo 'clion() {
        nohup ~/goinfre/nix-portable nix run --impure nixpkgs#jetbrains.clion "$@" > /dev/null 2>&1 & 
		disown
}' >> "$ZSHRC_PATH"
    echo "clion 함수가 .zshrc에 추가되었습니다."
else
    echo "clion 함수가 이미 .zshrc에 존재합니다."
fi

# tldr install
if ! grep -q "tldr()" "$ZSHRC_PATH"; then
    echo "tldr() {
        ~/goinfre/nix-portable nix run $TLDR -- \"\$@\"
}" >> "$ZSHRC_PATH"
    echo "$TLDR 함수가 .zshrc에 추가되었습니다."
else
    echo "$TLDR 함수가 이미 .zshrc에 존재합니다."
fi


# broot install
if ! grep -q "$BROOT_NAME()" "$ZSHRC_PATH"; then
    echo "$BROOT_NAME() {
        ~/goinfre/nix-portable nix run $BROOT_PKGS -- \"\$@\"
}" >> "$ZSHRC_PATH"
    echo "$BROOT_NAME 함수가 .zshrc에 추가되었습니다."
else
    echo "$BROOT_NAME 함수가 이미 .zshrc에 존재합니다."
fi

# fzf install
if ! grep -q "$FZF_NAME()" "$ZSHRC_PATH"; then
    echo "$FZF_NAME() {
        ~/goinfre/nix-portable nix run $FZF_PKGS -- \"\$@\"
}" >> "$ZSHRC_PATH"
    echo "$FZF_NAME 함수가 .zshrc에 추가되었습니다."
else
    echo "$FZF_NAME 함수가 이미 .zshrc에 존재합니다."
fi

# fd install
if ! grep -q "$FD_NAME()" "$ZSHRC_PATH"; then
    echo "$FD_NAME() {
        ~/goinfre/nix-portable nix run $FD_PKGS -- \"\$@\"
}" >> "$ZSHRC_PATH"
    echo "$FD_NAME 함수가 .zshrc에 추가되었습니다."
else
    echo "$FD_NAME 함수가 이미 .zshrc에 존재합니다."
fi

# duf install
if ! grep -q "$DUF_NAME()" "$ZSHRC_PATH"; then
    echo "$DUF_NAME() {
        ~/goinfre/nix-portable nix run $DUF_PKGS -- \"\$@\"
}" >> "$ZSHRC_PATH"
    echo "$DUF_NAME 함수가 .zshrc에 추가되었습니다."
else
    echo "$DUF_NAME 함수가 이미 .zshrc에 존재합니다."
fi

# dust install
if ! grep -q "$DUST_NAME()" "$ZSHRC_PATH"; then
    echo "$DUST_NAME() {
        ~/goinfre/nix-portable nix run $DUST_PKGS -- \"\$@\"
}" >> "$ZSHRC_PATH"
    echo "$DUST_NAME 함수가 .zshrc에 추가되었습니다."
else
    echo "$DUST_NAME 함수가 이미 .zshrc에 존재합니다."
fi

# rip install
if ! grep -q "$RIP_NAME()" "$ZSHRC_PATH"; then
    echo "$RIP_NAME() {
        ~/goinfre/nix-portable nix run $RIP_PKGS -- \"\$@\"
}" >> "$ZSHRC_PATH"
    echo "$RIP_NAME 함수가 .zshrc에 추가되었습니다."
else
    echo "$RIP_NAME 함수가 이미 .zshrc에 존재합니다."
fi

# wmctrl install
if ! grep -q "$WMCTRL_NAME()" "$ZSHRC_PATH"; then
    echo "$WMCTRL_NAME() {
        ~/goinfre/nix-portable nix run $WMCTRL_PKGS -- \"\$@\"
}" >> "$ZSHRC_PATH"
    echo "$WMCTRL_NAME 함수가 .zshrc에 추가되었습니다."
else
    echo "$WMCTRL_NAME 함수가 이미 .zshrc에 존재합니다."
fi

# zoxide install
if [ ! -f "$ZOXIDE_PATH" ]; then
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
else
    echo "zoxide가 이미 설치되어 있습니다."
fi


# .zshrc를 재로드하여 변경 사항을 반영
zsh -c "source $ZSHRC_PATH"

#./nix-portable nix-store --gc

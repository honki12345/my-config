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

#!/bin/zsh

DROPBOX_DIR="$HOME/dev/dropbox"
NVIM_DIR="/goinfre/hookim/cache/nvim"
FIREFOX_DIR="/goinfre/hookim/firefox"
GOINFRE="/goinfre/hookim"
TAR_FILE="$DROPBOX_DIR/install/firefox-133.0.tar.bz2"
nix_portable="$HOME/goinfre/nix-portable"

xmodmap -e "clear mod1"
xmodmap -e "add mod1 = Alt_L Meta_L"
xmodmap -e "keycode 108 = Katakana"

# nix-portable install
if [ ! -f "$nix_portable" ]; then
	echo "$nix_portable does not exist. Downloading and setting up nix-portable..."
	curl -L https://github.com/DavHau/nix-portable/releases/latest/download/nix-portable-$(uname -m) > ~/goinfre/nix-portable

	chmod +x ~/goinfre/nix-portable
else
  echo "$nix_portable exists. No need to run the script."
fi

export NIXPKGS_ALLOW_UNFREE=1

dropbox() {
        ~/goinfre/nix-portable nix run nixpkgs#maestral -- "$@"
}

dropbox start

if [ ! -d "$FIREFOX_DIR" ]; then
    echo "creating firefox directory"
    tar -xf $TAR_FILE -C $GOINFRE
    while [ ! -d "$FIREFOX_DIR" ]; do
        sleep 1
    done
    echo "Firefox extraction completed"
fi

/home/hookim/goinfre/nix-portable nix-shell $DROPBOX_DIR/install/shell.nix


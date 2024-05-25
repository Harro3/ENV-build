#!/bin/sh

install() {
    package=$1

    read -p "Install $package ? [Y|n] " answer
    case "$answer" in
        [nN]|[nN][oO])
            return;;
    esac

    $INSTALL_COMMAND $package
}


echo "The packages in this step will be installed with the following command:"
echo "> $INSTALL_COMMAND"

for pck in $PACKAGES; do
    install "$pck"
done
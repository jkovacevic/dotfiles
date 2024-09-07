#!/usr/bin/zsh
vl() {
    VAULT_NAME=vault.zip
    if [ -f $VAULT_NAME ]; then
        echo "vault.zip already exists, exiting..."
        return
    fi;

    zip $VAULT_NAME *
    rm $(ls -I $VAULT_NAME* )
}

vo() {
    VAULT_NAME="vault.zip"
    extract $VAULT_NAME*
    rm $VAULT_NAME*
}
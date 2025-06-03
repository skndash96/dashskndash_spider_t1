#!/bin/bash

# cronjob - runs weekly
# * * * * 0 root /root/vault_sweeper.sh /root/coding

if [[ $(whoami) != 'root' ]]; then
        echo "please use sudo"
        exit 1
fi

START_DIR=$1
if [[ -z "$START_DIR" ]]; then START_DIR=$(pwd); fi

LOGS_DIR="$START_DIR"/.vault/logs
LOGS_FILE="$LOGS_DIR"/$(date +%s)".log"

echo "Creating $LOGS_FILE"
mkdir -p "$LOGS_DIR"
touch "$LOGS_FILE"

if id manager &> /dev/null; then
        echo "User manager exists"
else
        echo "Creating manager user"
        useradd -M -s /bin/bash manager
fi

chown "manager:manager" "$LOGS_DIR"

function is_line_invalid() {
        local key value

        key=$(echo -n "$1" | grep -oP "^\w+=")
        [[ -z "$key" ]] && return 0

        value=${1#"$key"}

        if [[ -z $(echo -n "$value" | grep -oP "^(\w+|\"\w+\s[\w\s]*\")$") ]]; then
                return 0
        fi

        return 1
}

function scan_dir() {
        while read -r item; do
                tmp=$(mktemp)
                cp "$item" "$tmp"

                c=0
                okc=0
                invalid=""

                while read -r line; do
                        if is_line_invalid "$line"; then
                                ((c=c+1))
                                invalid="$invalid"$(echo "$line")
                                sed -i "\|^$line\$|d" "$tmp"
                        else
                                ((okc=okc+1))
                        fi
                done < <(cat "$item")

                if [[ $c > 0 ]]; then
                        SANITIZED_PATH="$item".sanitized
                        mv "$tmp" "$SANITIZED_PATH"
                        echo "Sanitized $item at $SANITIZED_PATH"
                        read -rp "Do you want to lock this file? (y/n): " res
                        if [[ "y" == "$res" ]]; then
                                setfacl -b "$SANITIZED_PATH";
                                chown "manager:manager" "$SANITIZED_PATH";
                                echo "Locked $SANITIZED_PATH"
                        fi
                fi

                acl_output=$(getfacl -pc "$item" | sed 's/^/    /')

                stat "$item" -c "
File: %n
Owner: %u-%U %g-%G
Perms:
    %A
$acl_output
Total Valid: $okc
Total Invalid: $c
$invalid" >> $LOGS_FILE
        done < <(find "$START_DIR" -type f -iname *.env -o -iname *.env.*)
}

scan_dir

echo "$LOGS_FILE"


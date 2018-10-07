#!/bin/sh

cat /src/emoji_db.json |jq --raw-output --arg tag "$1" ' .[] | select(select([.aliases[] == $tag] | any)) | .emoji'


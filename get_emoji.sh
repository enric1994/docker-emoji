#!/bin/sh

response=$(cat /src/emoji_db.json |jq --raw-output --arg tag "$1" ' .[] | select(select([.aliases[] == $tag] | any)) | .emoji')

if [ -z $response ]
then
    echo -e 'Emoji not found🤦‍\nMaybe you where looking for...\n'
    cat /src/emoji_db.json |jq --raw-output --arg tag "$1" '.[] | select(.tags[] | contains($tag)) | "\(.emoji) \(.aliases[0])"'
    cat /src/emoji_db.json |jq --raw-output --arg tag "$1" '.[] | select(.aliases[] | contains($tag)) | "\(.emoji) \(.aliases[0])"'
else
    echo $response
fi
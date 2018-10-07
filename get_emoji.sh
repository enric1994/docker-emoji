#!/bin/sh

response=$(cat /src//emoji_db.json |jq --raw-output --arg tag "$1" ' .[] | select(select([.aliases[] == $tag] | any)) | .emoji')

if [ -z $response ]
then
    tag_suggestions=$(cat /src/emoji_db.json |jq --raw-output --arg tag "$1" '.[] | select(.tags[] | contains($tag)) | "\(.emoji) \(.aliases[0])"')
    aliases_suggestions=$(cat /src/emoji_db.json |jq --raw-output --arg tag "$1" '.[] | select(.aliases[] | contains($tag)) | "\(.emoji) \(.aliases[0])"')
    
    if [ -z "${tag_suggestions}" ] && [ -z "${aliases_suggestions}" ]
    then
        echo -e 'No emojis found related with: ' $1
    else
        echo -e 'Emoji not found🤦‍\nMaybe you where looking for...\n'
        echo $tag_suggestions $aliases_suggestions
    fi
else
    echo $response
fi
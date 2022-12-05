#!/usr/bin/env bash

# make sure wenhook and messages are defined
if [[ ${webhook:-none} == "none" || ${message:-none} == "none" ]]; then
    echo "::error::Webhook or Message not defined! Exiting..."
    exit -1
fi

# format embed
json=$(cat <<EOF
{
  "content": "",
  "embeds": [
    {
      "title": "[${repo#*/}:${ref_name}] Action Notif",
      "description": "$message",
      "url": "https://github.com/$repo/actions/runs/$run_id",
      "color": 16777215,
      "author": {
        "name": "$owner",
        "icon_url": "https://github.com/${owner}.png"
      },
      "footer": {
        "text": "Run #${run_number}"
      },
      "timestamp": "$(date +"%Y-%m-%dT%H:%M:%S%z")"
    }
  ],
  "attachments": []
}
EOF
)

# minify and validate
minified=$(jq -r tostring <<< $json)
if [[ $? -ne 0 ]]; then
    echo "::error::Failed parsing JSON! Make sure your message is escaped properly?"
    exit 1
fi

# send it off
curl -X POST \
  $webhook?wait=true \
  -H 'Content-Type: application/json' \
  -d "$minified"
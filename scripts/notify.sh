#!/bin/bash

# Default values for variables
REPOSITORY_NAME="icvs_pirv"
SLACK_WEBHOOK_URL=""
TICKET_ID=""
DEPLOYMENT_STATUS=""
DEPLOYMENT_LOCATION=""
BRANCH_NAME=""

# Parse command-line arguments
while getopts "s:w:t:b:d:" opt; do
  case $opt in
    s)
      DEPLOYMENT_STATUS="$OPTARG"
      ;;
    w)
      SLACK_WEBHOOK_URL="$OPTARG"
      ;;
    t)
      TICKET_ID="$OPTARG"
      ;;
    b)
      BRANCH_NAME="$OPTARG"
      ;;
    d)
      DEPLOYMENT_LOCATION="$OPTARG"
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

# Validate required arguments
if [ -z "$SLACK_WEBHOOK_URL" ]; then
  echo "SLACK_WEBHOOK_URL is required. Use the -w flag to specify it."
  exit 1
fi

# Set the default icon to exclamation
ICON_EMOJI=":bell:"

# If the status is not failure, set the icon to bell
if [ "${DEPLOYMENT_STATUS}" == "failure" ]; then
    ICON_EMOJI=":exclamation:"
fi

echo $ICON_EMOJI

if [ "${DEPLOYMENT_STATUS}" = "failure" ]; then
  SLACK_MESSAGE="Repository Name :- ${REPOSITORY_NAME} \n Ticket ID :- ${TICKET_ID} \n Branch:- ${BRANCH_NAME} \n Deployment Status :- ${DEPLOYMENT_STATUS}:bangbang:"
else
  SLACK_MESSAGE="Repository Name :- ${REPOSITORY_NAME} \n Ticket ID :- ${TICKET_ID} \n Branch:- ${BRANCH_NAME} \n Deployment Status :- ${DEPLOYMENT_STATUS} \n Deployment Location :- ${DEPLOYMENT_LOCATION}"
fi

# Create Slack payload
PAYLOAD='{
  "channel": "slack-alerts-for-cd",
  "icon_emoji": "'"${ICON_EMOJI}"'",
  "username": "deployment-bot",
  "attachments": [
    {
      "color": "'"${DEPLOYMENT_STATUS}"'",
      "title": "Deployment alert",
      "text": "'"${SLACK_MESSAGE}"'"
    }
  ]
}'

# Send the notification to Slack using curl
curl -X POST -H 'Content-type: application/json' --data "${PAYLOAD}" "${SLACK_WEBHOOK_URL}"
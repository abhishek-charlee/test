#!/bin/bash

sudo su - test3
cd /home2/test3/UI
ticket_id=${{ steps.extract-ticket-id.outputs.ticket_id }}
echo "Ticket ID: $ticket_id"
mkdir $ticket_id
cd $ticket_id
ls
start_port=3000
end_port=9000

for ((port=start_port; port<=end_port; port++))
do
    if ! lsof -i :$port &> /dev/null; then
    echo "Port $port is available."
    export AVAILABLE_PORT=$port
    break  # Exit the loop after finding an available port
    fi
done
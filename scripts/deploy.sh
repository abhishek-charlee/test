#!/bin/bash

sudo su - test3 -c id
sudo su - test3 -c pwd
echo "Ticket ID: $ticket_id"
sudo su - test3 -c "mkdir UI/$ticket_id"
sudo su - test3 -c "cd UI/$ticket_id"
sudo su - test3 -c "ls UI/"

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
#     ./start_server.sh $AVAILABLE_PORT
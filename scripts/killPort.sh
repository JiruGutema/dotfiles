#!/bin/bash

# This script kills any process using the specified port.
# Usage: ./kill_port.sh <port_number>
# Example: ./kill_port.sh 33333

# What Happens:
# - Checks if a port number is provided.
# - Looks for any process using that port and attempts to kill it.
# - Outputs a confirmation message if a process is killed, or notifies if none is found.

# Important Notes:
# - Ensure you have the necessary permissions to kill processes.
# - Use this script with caution, as it forcefully kills any process using the specified port.
# - Do NOT use this to kill system processes unless you know what you are doing.

if [ -z "$1" ]; then
  echo "Usage: $0 <port_number>"
  exit 1
fi

PORT=$1
PID=$(lsof -ti tcp:$PORT)

if [ -n "$PID" ]; then
  kill -9 $PID
  echo "Killed process $PID using port $PORT."
else
  echo "No process found using port $PORT."
fi

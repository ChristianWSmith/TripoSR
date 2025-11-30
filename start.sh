#!/usr/bin/env bash
# hacky start script for TripoSR with server readiness check

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Start Python backend in background
pushd "${SCRIPT_DIR}" > /dev/null
ls
pipenv run "${SCRIPT_DIR}/gradio_app.py" &
BACKEND_PID=$!

# Wait until server responds
echo "Waiting for Gradio server to start..."
until curl -s http://127.0.0.1:7860 >/dev/null; do
    sleep 0.5
done

echo "Server is up! Opening browser..."
xdg-open "http://127.0.0.1:7860"
# Wait for backend to exit
wait $BACKEND_PID
popd > /dev/null

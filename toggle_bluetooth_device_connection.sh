#!/usr/bin/env zsh

if [ -f .env ]; then
  set -a
  source .env
  set +a
else
  echo "Error: .env file not found. Please create an .env file by copying the .env.example file."
  exit 1
fi

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Function to pair or unpair a device based on its connection status
toggle_bluetooth_device_connection() {
  local device_id="$1"
  local device_name="$2"

  if ! command_exists "$BLUEUTIL"; then
    echo "Error: blueutil command not found at $BLUEUTIL"
    exit 1
  fi

  echo "Processing $device_name ($device_id)..."

  if [ "$("$BLUEUTIL" --is-connected "$device_id")" = "1" ]; then
    echo "Unpairing $device_name..."
    "$BLUEUTIL" --unpair "$device_id"
  else
    echo "Pairing and connecting $device_name..."
    "$BLUEUTIL" --pair "$device_id"
    sleep 1
    "$BLUEUTIL" --connect "$device_id"
  fi

  echo "Finished processing $device_name"
}

typeset -A devices
devices=(
  "$MK_ID" "Magic Keyboard"
  "$MT_ID" "Magic Trackpad"
)

for device_id device_name in "${(@kv)devices}"; do
  toggle_bluetooth_device_connection "$device_id" "$device_name"
done

echo "All devices processed."

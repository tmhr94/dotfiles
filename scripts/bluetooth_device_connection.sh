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

manage_bluetooth_device() {
  local action="$1"
  local device_id="$2"
  local device_name="$3"

  if ! command_exists "$BLUEUTIL"; then
    echo "Error: blueutil command not found"
    exit 1
  fi

  echo "Processing $device_name ($device_id)..."

  case "$action" in
    pair)
      echo "Pairing and connecting $device_name..."
      "$BLUEUTIL" --pair "$device_id"
      sleep 1
      "$BLUEUTIL" --connect "$device_id"
      ;;
    unpair)
      echo "Unpairing $device_name..."
      "$BLUEUTIL" --unpair "$device_id"
      ;;
    *)
      echo "Error: Invalid action. Use 'pair' or 'unpair'."
      exit 1
      ;;
  esac

  echo "Finished processing $device_name"
}

if [ $# -ne 1 ]; then
  echo "Usage: $0 [pair|unpair]"
  exit 1
fi

# Get the action from command line argument
ACTION="$1"

typeset -A devices
devices=(
  "$MK_ID" "Magic Keyboard"
  "$MT_ID" "Magic Trackpad"
)

for device_id device_name in "${(@kv)devices}"; do
  manage_bluetooth_device "$ACTION" "$device_id" "$device_name"
done

echo "All devices processed."
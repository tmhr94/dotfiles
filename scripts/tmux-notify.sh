#!/bin/bash
session="${1:-tmux}"
window="${2:-}"
osascript -e "display notification \"${window:+$window: }タスク完了\" with title \"tmux ($session)\" sound name \"Glass\""

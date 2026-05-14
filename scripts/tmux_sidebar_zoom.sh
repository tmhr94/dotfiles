#!/bin/sh

set -eu

focus_pane="${1:-$(tmux display-message -p '#{pane_id}')}"
window_id="$(tmux display-message -p -t "$focus_pane" '#{window_id}')"

zoomed="$(tmux show-option -wqv -t "$window_id" @sidebar_zoom)"

restore_pane_order() {
  position=1

  for desired_pane in "$@"; do
    current_pane="$(tmux list-panes -t "$window_id" -F '#{pane_id}' | sed -n "${position}p")"

    if [ -n "$current_pane" ] && [ "$current_pane" != "$desired_pane" ]; then
      tmux swap-pane -d -s "$desired_pane" -t "$current_pane" 2>/dev/null || true
    fi

    position=$((position + 1))
  done
}

if [ "$zoomed" = "1" ]; then
  focus_pane="$(tmux show-option -wqv -t "$window_id" @sidebar_zoom_focus_pane)"
  previous_layout="$(tmux show-option -wqv -t "$window_id" @sidebar_zoom_previous_layout)"
  pane_order="$(tmux show-option -wqv -t "$window_id" @sidebar_zoom_pane_order)"

  if [ -n "$pane_order" ]; then
    # shellcheck disable=SC2086
    restore_pane_order $pane_order
  fi

  if [ -n "$previous_layout" ]; then
    tmux select-layout -t "$window_id" "$previous_layout" 2>/dev/null || tmux select-layout -t "$window_id" tiled
  else
    tmux select-layout -t "$window_id" tiled
  fi

  [ -n "$focus_pane" ] && tmux select-pane -t "$focus_pane" 2>/dev/null || true

  tmux set-option -wqu -t "$window_id" @sidebar_zoom
  tmux set-option -wqu -t "$window_id" @sidebar_zoom_focus_pane
  tmux set-option -wqu -t "$window_id" @sidebar_zoom_previous_layout
  tmux set-option -wqu -t "$window_id" @sidebar_zoom_pane_order
  exit 0
fi

main_pane="$(tmux list-panes -t "$window_id" -F '#{pane_id}' | sed -n '1p')"
previous_layout="$(tmux display-message -p -t "$window_id" '#{window_layout}')"
pane_order="$(tmux list-panes -t "$window_id" -F '#{pane_id}' | tr '\n' ' ' | sed 's/ $//')"

tmux set-option -wq -t "$window_id" @sidebar_zoom 1
tmux set-option -wq -t "$window_id" @sidebar_zoom_focus_pane "$focus_pane"
tmux set-option -wq -t "$window_id" @sidebar_zoom_previous_layout "$previous_layout"
tmux set-option -wq -t "$window_id" @sidebar_zoom_pane_order "$pane_order"

if [ "$focus_pane" != "$main_pane" ]; then
  tmux swap-pane -d -s "$focus_pane" -t "$main_pane"
fi

tmux set-option -wq -t "$window_id" main-pane-width 67%
tmux select-layout -t "$window_id" main-vertical
tmux select-pane -t "$focus_pane"

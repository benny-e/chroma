#!/usr/bin/env bash
set -euo pipefail

LAUNCHER_THEME="$HOME/.config/rofi/leftlauncher.rasi"
FOOTER_SCRIPT="$HOME/.config/scripts/power-footer"

PID_LAUNCHER="/run/user/$UID/rofi-launcher.pid"
PID_FOOTER="/run/user/$UID/rofi-footer.pid"

kill_pair() {
  #kill rofi instances by pid
  for p in "$PID_LAUNCHER" "$PID_FOOTER"; do
    if [[ -f "$p" ]]; then
      pid="$(cat "$p" 2>/dev/null || true)"
      [[ -n "${pid:-}" ]] && kill "$pid" 2>/dev/null || true
      rm -f "$p" 2>/dev/null || true
    fi
  done
}

trap 'kill_pair' EXIT INT TERM

#kill any instances first
kill_pair

#start rofi launcher
rofi -show drun \
  -theme "$LAUNCHER_THEME" \
  -hover-select \
  -pid "$PID_LAUNCHER" \
  -on-cancel "~/.config/scripts/killrofis.sh" &
launcher_pid=$!

#footer script for secondary rofi power window
"$FOOTER_SCRIPT" &
footer_script_pid=$!

#wait for either rofi instance to exit
wait -n "$launcher_pid" "$footer_script_pid" 2>/dev/null || true

#kill other instance
kill_pair


wait "$launcher_pid" 2>/dev/null || true
wait "$footer_script_pid" 2>/dev/null || true


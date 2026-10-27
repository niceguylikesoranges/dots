#!/usr/bin/env bash
# Power profile module for waybar.
#   (no args) -> print JSON for waybar
#   cycle     -> switch to the next profile, then refresh the module

ORDER=(power-saver balanced performance)

# Profiles this machine actually supports, in low -> high order
available() {
  local have p
  have=$(powerprofilesctl list 2>/dev/null | sed -nE 's/^[* ]+([a-z-]+):$/\1/p')
  for p in "${ORDER[@]}"; do
    grep -qx "$p" <<<"$have" && echo "$p"
  done
}

if [ "${1:-}" = "cycle" ]; then
  mapfile -t AV < <(available)
  [ "${#AV[@]}" -eq 0 ] && exit 1
  CUR=$(powerprofilesctl get 2>/dev/null)
  NEXT="${AV[0]}"
  for i in "${!AV[@]}"; do
    [ "${AV[$i]}" = "$CUR" ] && NEXT="${AV[(i + 1) % ${#AV[@]}]}"
  done
  powerprofilesctl set "$NEXT"
  pkill -RTMIN+9 waybar
  exit 0
fi

CUR=$(powerprofilesctl get 2>/dev/null)
case "$CUR" in
power-saver)
  ICON=$'\U000f032a'
  NAME="Power Saver"
  ;; # nf-md-leaf
balanced)
  ICON=$'\U000f0f85'
  NAME="Balanced"
  ;; # nf-md-speedometer_medium
performance)
  ICON=$'\U000f04c5'
  NAME="Performance"
  ;; # nf-md-speedometer
*)
  ICON="?"
  NAME="Unknown"
  ;;
esac

jq -nc --arg text "MODE $ICON" --arg tooltip "$NAME" --arg class "$CUR" \
  '{text: $text, tooltip: $tooltip, class: $class}'

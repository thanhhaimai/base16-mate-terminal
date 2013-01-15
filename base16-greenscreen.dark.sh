#!/usr/bin/env bash
# Base16 Chalk - Mate Terminal color scheme install script
# Thanh Hai Mai (https://github.com/thanhhaimai)

[[ -z "$PROFILE_NAME" ]] && PROFILE_NAME="Base 16 Green Screen"
[[ -z "$PROFILE_SLUG" ]] && PROFILE_SLUG="base-16-greenscreen"
[[ -z "$GCONFTOOL" ]] && GCONFTOOL="mateconftool-2"
[[ -z "$BASE_KEY" ]] && BASE_KEY=/apps/mate-terminal/profiles

PROFILE_KEY="$BASE_KEY/$PROFILE_SLUG"

gset() {
  local type="$1"; shift
  local key="$1"; shift
  local val="$1"; shift

  "$GCONFTOOL" --set --type "$type" "$PROFILE_KEY/$key" -- "$val"
}

# Because gconftool doesn't have "append"
glist_append() {
  local type="$1"; shift
  local key="$1"; shift
  local val="$1"; shift

  local entries="$(
    {
      "$GCONFTOOL" --get "$key" | tr -d '[]' | tr , "\n" | fgrep -v "$val"
      echo "$val"
    } | head -c-1 | tr "\n" ,
  )"

  "$GCONFTOOL" --set --type list --list-type $type "$key" "[$entries]"
}

# Append the Base16 profile to the profile list
glist_append string /apps/mate-terminal/global/profile_list "$PROFILE_SLUG"

gset string visible_name "$PROFILE_NAME"
gset string palette "#000011110000:#000033330000:#000055550000:#000077770000:#000099990000:#0000bbbb0000:#0000dddd0000:#0000ffff0000:#000077770000:#000099990000:#000077770000:#0000bbbb0000:#000055550000:#000099990000:#0000bbbb0000:#000055550000"
gset string background_color "#000011110000"
gset string foreground_color "#0000bbbb0000"
gset string bold_color "#0000bbbb0000"
gset bool   bold_color_same_as_fg "true"
gset bool   use_theme_colors "false"
gset bool   use_theme_background "false"
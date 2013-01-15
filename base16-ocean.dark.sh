#!/usr/bin/env bash
# Base16 Chalk - Mate Terminal color scheme install script
# Thanh Hai Mai (https://github.com/thanhhaimai)

[[ -z "$PROFILE_NAME" ]] && PROFILE_NAME="Base 16 Ocean"
[[ -z "$PROFILE_SLUG" ]] && PROFILE_SLUG="base-16-ocean"
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
gset string palette "#22bb330033bb:#334433dd4466:#44ff55bb6666:#6655773377ee:#aa77aaddbbaa:#cc00cc55ccee:#ddffee11ee88:#eeffff11ff55:#bbff661166aa:#dd0088777700:#eebbccbb88bb:#aa33bbee88cc:#9966bb55bb44:#88ffaa11bb33:#bb4488eeaadd:#aabb77996677"
gset string background_color "#22bb330033bb"
gset string foreground_color "#cc00cc55ccee"
gset string bold_color "#cc00cc55ccee"
gset bool   bold_color_same_as_fg "true"
gset bool   use_theme_colors "false"
gset bool   use_theme_background "false"
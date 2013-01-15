#!/usr/bin/env bash
# Base16 Chalk - Mate Terminal color scheme install script
# Thanh Hai Mai (https://github.com/thanhhaimai)

[[ -z "$PROFILE_NAME" ]] && PROFILE_NAME="Base 16 Chalk"
[[ -z "$PROFILE_SLUG" ]] && PROFILE_SLUG="base-16-chalk"
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
gset string palette "#115511551155:#220022002200:#330033003300:#550055005500:#bb00bb00bb00:#dd00dd00dd00:#ee00ee00ee00:#ff55ff55ff55:#ffbb99ffbb11:#eeddaa998877:#ddddbb2266ff:#aacccc226677:#1122ccffcc00:#66ffcc22eeff:#ee11aa33eeee:#ddeeaaff88ff"
gset string background_color "#115511551155"
gset string foreground_color "#dd00dd00dd00"
gset string bold_color "#dd00dd00dd00"
gset bool   bold_color_same_as_fg "true"
gset bool   use_theme_colors "false"
gset bool   use_theme_background "false"


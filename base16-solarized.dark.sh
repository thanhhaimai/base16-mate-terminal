#!/usr/bin/env bash
# Base16 Chalk - Mate Terminal color scheme install script
# Thanh Hai Mai (https://github.com/thanhhaimai)

[[ -z "$PROFILE_NAME" ]] && PROFILE_NAME="Base 16 Solarized"
[[ -z "$PROFILE_SLUG" ]] && PROFILE_SLUG="base-16-solarized"
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
gset string palette "#000022bb3366:#007733664422:#558866ee7755:#665577bb8833:#883399449966:#9933aa11aa11:#eeeeee88dd55:#ffddff66ee33:#ddcc332222ff:#ccbb44bb1166:#bb5588990000:#885599990000:#22aaaa119988:#226688bbdd22:#66cc7711cc44:#dd3333668822"
gset string background_color "#000022bb3366"
gset string foreground_color "#9933aa11aa11"
gset string bold_color "#9933aa11aa11"
gset bool   bold_color_same_as_fg "true"
gset bool   use_theme_colors "false"
gset bool   use_theme_background "false"
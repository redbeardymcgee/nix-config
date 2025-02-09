#!/usr/bin/env bash
# FIXME: Doesn't work with `nurl`
# "https://gitee.com/DreamMaoMao/searchjump.yazi"

links=(
  ## FIXME: needs special case
  "https://github.com/yazi-rs/plugins"
  "https://github.com/hankertrix/augment-command.yazi"
  "https://github.com/sonico98/allmytoes.yazi"
  "https://github.com/sonico98/exifaudio.yazi"
  "https://github.com/reledia/glow.yazi"
  "https://github.com/reledia/hexyl.yazi"
  "https://github.com/reledia/miller.yazi"
  "https://github.com/ndtoan96/ouch.yazi"
  "https://github.com/kirasok/torrent-preview.yazi"
  "https://github.com/h-hg/yamb.yazi"
  "https://github.com/Lil-Dank/lazygit.yazi"
)

for link in "${links[@]}"; do
  expr=$(, nurl "$link")
  name=${link##*/}
  name=${name%\.yazi}
  printf '%s = %s;\n' "$name" "$expr"
done

#!/usr/bin/env bash

links=(
	"https://github.com/yazi-rs/plugins"
	"https://github.com/hankertrix/augment-command.yazi"
	"https://gitee.com/DreamMaoMao/searchjump.yazi"
	"https://github.com/sonico98/allmytoes.yazi"
	"https://github.com/sonico98/exifaudio.yazi"
	"https://github.com/reledia/glow.yazi"
	"https://github.com/reledia/hexyl.yazi"
	"https://github.com/reledia/miller.yazi"
	"https://github.com/ndotan96/ouch.yazi"
	"https://github.com/kirasok/torrent-preview.yazi"
	"https://github.com/h-hg/yamb.yazi"
	"https://github.com/Lil-Dank/lazygit.yazi"
)

for link in "${links[@]}"; do
	nurl "$link"
done

#!/bin/bash
# Credit to https://github.com/FrictionalGames/AmnesiaTheDarkDescent/pull/2#issuecomment-697648592 for providing this snippet
for f in `file * | grep ASCII | cut -d: -f1`; do ln -fs `cut -d' ' -f2 $f` $f; done

#!/usr/bin/env bash
rm -rf docs
mkdir -p docs/images/ docs/picture/
cp -r source/css/images/ docs/images
cp -r source/css/picture/ docs/picture
asciidoctor ./source/cn/index.adoc -o ./docs/index.html
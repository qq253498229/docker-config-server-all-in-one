#!/usr/bin/env bash
rm -rf docs
mkdir -p docs/images/
cp -r source/css/images/ docs/images
asciidoctor ./source/cn/index.adoc -o ./docs/index.html
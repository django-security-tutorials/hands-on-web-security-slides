#!/bin/bash

# Like 'use strict'; but for bash!
set -euo pipefail

# This script will import slides from the Hacker Slides instance that
# Asheesh has been using into a directory structure that can live in
# this repo.

mkdir -p student-handout
pushd student-handout

# First, nab the slides.
wget --header "Cookie: $2" "https://$1/slides.md"

# Then, nab the static directory, and all that it references.
mkdir -p static
pushd static
wget -nH --cut-dirs=1 --mirror --no-parent --header "Cookie: $2" "https://$1/static/slides.html" || true  # OK if this fails.

# Grab these extra dependencies.
for thing in "plugin/markdown/markdown.js" "plugin/markdown/marked.js" "css/print/paper.css" "plugin/zoom-js/zoom.js" "plugin/notes/notes.js" "plugin/notes/notes.html"
do
wget -nH --cut-dirs=1 --mirror --no-parent --header "Cookie: $2" "https://$1/static/$thing" || true  # OK if this fails.
done

# Prepare this for git commit, but let the user be the one to actually
# commit it.
popd; popd
git add .

#!/usr/bin/env bash
# rebuild.sh: run periodically to make Quay rebuild the prebake image.
set -ex
git fetch git@github.com:vgteam/vg_ci_prebake.git master
git checkout FETCH_HEAD
git branch -D quay-rebuild || true
git checkout -b quay-rebuild
date > prebake-build-timestamp.txt
git add prebake-build-timestamp.txt
git commit -m "Update build timestamp to $(cat build-timestamp.txt)"
git push git@github.com:vgteam/vg_ci_prebake.git quay-rebuild:master



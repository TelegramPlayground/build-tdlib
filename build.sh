#!/bin/sh
sudo apt-get update
sudo apt-get install zlib1g-dev libssl-dev gperf
rm -rf td
git clone --depth 1 --recursive https://github.com/tdlib/td.git tdlib
cd tdlib
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=../../td ..
cmake --build . --target install -j 4
cd ..
cd ..
rm -rf tdlib
TDV=$(ls -1 td/lib/libtdjson.so* | tail -n1 | cut -d. -f 2)
git add -A td
git config user.name "github-actions[bot]"
git config user.email "41898282+github-actions[bot]@users.noreply.github.com"
git commit -m "Build TDLib ${TDV}" || exit 0
git pull --rebase
git push

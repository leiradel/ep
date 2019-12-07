#!/bin/bash

cp -R eplays/distributions/eplays LibreELEC.tv/distributions
cp -R eplays/packages/eplays LibreELEC.tv/packages
cp -R eplays/projects/RPi2 LibreELEC.tv/projects

cd LibreELEC.tv

rm -rf target/

export IGNORE_VERSION=1

>&2 echo "RPi2.arm + noobs"
PROJECT=RPi2 ARCH=arm make noobs

rm target/*.kernel
rm target/*.system

for f in target/*; do
  md5sum $f > $f.md5
  sha256sum $f > $f.sha256
done

for f in target/*; do
  dir=`echo $f | sed -e 's/target\/eplays-\(.*\)-\(.*\)-devel-\(.*\)/\1/'`
  #dir=`echo $f | sed -e 's/target\/eplays-\(.*\)-2.3\(.*\)/\1/'`
  mkdir -p target/$dir
  mv $f target/$dir/
done

cd ..

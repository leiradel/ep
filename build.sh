#!/bin/bash

rm -rf LibreELEC.tv/distributions/eplays && cp -R eplays/distributions/eplays LibreELEC.tv/distributions
rm -rf LibreELEC.tv/packages/eplays && cp -R eplays/packages/eplays LibreELEC.tv/packages
rm -rf LibreELEC.tv/projects/RPi2 && cp -R eplays/projects/RPi2 LibreELEC.tv/projects

cd LibreELEC.tv

rm -rf target/

export IGNORE_VERSION=1
export DISTRO=eplays
export THREADCOUNT=8

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

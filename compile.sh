#!/bin/bash
#

B2QT_PATH="/opt/b2qt/2.2.4/environment-setup-cortexa9hf-neon-poky-linux-gnueabi"
QMAKE_PATH="/opt/b2qt/2.2.4/sysroots/x86_64-pokysdk-linux/usr/bin/qmake"
repo=$1
out=$2
mount=$3

usage()
{
    echo "Compiles Minibank project"
    echo "Usage: compile  [<repository-path>] [<building-dir-path>]"
    echo "                [<mount-dir-path>]"
    echo "Options:"
    echo "    <repository-path>:   specifies the repository path. Default: CIM-GUI"
    echo "    <building-dir-path>: specifies the output directory of building. Default: build"
    echo "    <mount-dir-path>:    specifies the container's mount directory. Default: /output"
}

if [ -z "$mount" ]; then
	mount="/output"
	if [ ! -d $mount ]; then
		echo "Error: Container mount directory $mount is not found"
		usage
		exit 1
	fi
elif [ ! -d $mount ]; then
	echo "Error: Container mount directory $mount is not found"
	usage
	exit 1
fi
cd $mount
if [ -z "$repo" ]; then
	repo="CIM-GUI"
	if [ ! -d $repo ]; then
		echo "Error: Repository $repo is not found"
		usage
		exit 1
	fi
elif [ ! -d $repo ]; then
	echo "Error: Repository $repo is not found"
	usage
	exit 1
fi
if [ -z "$out" ]; then
	out="build"
	if [ ! -d $out ]; then
		echo "Error: Building directory $out is not found"
		usage
		exit 1
	fi
elif [ ! -d $out ]; then
	echo "Error: Building directory $out is not found"
	usage
	exit 1
fi
cd $out
echo "Compiling Minibank project from $repo directory"
echo "Building output directory: $out"
echo "Container mount directory: $mount"
source $B2QT_PATH
$QMAKE_PATH -o ./Makefile $mount/$repo/Minibank.pro -spec devices/linux-oe-generic-g++ && /usr/bin/make qmake_all
make clean
make

exit 0

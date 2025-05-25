#!/bin/bash
chmod +x
if test -f s1built.bin; then
	mv -f s1built.bin s1built.prev.bin
fi
./tool/linux/asl -xx -q -A -L -U -E -i . main.asm
./tool/linux/p2bin main.p s1built.bin
rm -f main.p
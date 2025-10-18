#!/bin/bash
if test -f s1built.bin; then
	mv -f s1built.bin s1built.prev.bin
fi
./tool/linux/asl -xx -q -A -L -U -E -i . main.asm
./tool/linux/p2bin -p=FF -z=0,uncompressed,Size_of_DAC_driver_guess,after main.p s1built.bin
rm -f main.p
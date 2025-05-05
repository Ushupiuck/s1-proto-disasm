@echo off
IF EXIST s1built.bin move /Y s1built.bin s1built.prev.bin >NUL
build_tools\asw -xx -q -A -L -U -E -i . main.asm
build_tools\p2bin main.p -p=FF s1built.bin
del main.p
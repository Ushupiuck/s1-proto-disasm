@echo off
IF EXIST s1built.bin move /Y s1built.bin s1built.prev.bin >NUL
tool\asw -xx -q -A -L -U -E -i . main.asm
tool\p2bin main.p -p=FF s1built.bin
del main.p
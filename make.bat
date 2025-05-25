@echo off
IF EXIST s1built.bin move /Y s1built.bin s1built.prev.bin >NUL
tool\windows\asw -xx -q -A -L -U -E -i . main.asm
tool\windows\p2bin main.p s1built.bin
del main.p
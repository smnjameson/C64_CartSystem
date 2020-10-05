# C64_CartSystem

Change the makefile to suit your project and environment, replacing the paths as necessary and changing the cart type on the cartify line:

```
echo off

rem Kick assembling
java -cp *c:\C64\Tools\KickAssembler\kickass-cruncher-plugins-2.0.jar;c:\C64\Tools\KickAssembler\KickAss.jar cml.kickass.KickAssembler cart.asm -vicesymbols -showmem -odir ./bin

rem Cart building
node ./cartloader/cartify.js ./bin/cart.crt MAGICDESK

rem Launch vice
C:\C64\Tools\Vice\x64.exe -logfile ./bin/vicelog.txt -moncommands ./bin/cart.vs ./bin/cart.crt
```

In the setup at the top of cart.asm change the #define MAGICDESK to match the cart type seelcted in the make file

Please note some functionality is not avaialbe in D64 mode, such as static banking. Demo provided should work for all cart types MAGICDESK, EASYFLASH and GMOD2. D64 demo to follow at a later date.

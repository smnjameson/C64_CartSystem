# C64_CartSystem

Change the makefile to suit your project and environment, replacing the paths as necessary and changing the cart type on the cartify line:

```
echo off

rem Kick assembling
java -cp c:\C64\Tools\KickAssembler\KickAss.jar cml.kickass.KickAssembler cart.asm -vicesymbols -showmem -odir ./bin

rem Cart building and breakpoint generation from the DBG file
node ./cartloader/cartify.js ./bin/cart.crt MAGICDESK
node ./cartloader/cartbreak.js ./bin/cart.dbg

rem Launch vice
C:\C64\Tools\Vice\x64.exe -logfile ./bin/vicelog.txt -moncommands ./bin/cart.vs ./bin/cart.crt
```

In the setup at the top of cart.asm change the #define MAGICDESK to match the cart type seelcted in the make file

Please note some functionality is not avaialbe in D64 mode, such as static banking. Demo provided should work for all cart types MAGICDESK, EASYFLASH and GMOD2. D64 demo to follow at a later date.

Also note NODEJS is required in order to run the cartify.js step of the makefile

echo off

rem Kick assembling
java -cp c:\C64\Tools\KickAssembler\KickAss.jar cml.kickass.KickAssembler cart.asm -vicesymbols -showmem -odir ./bin

rem Cart building
node ./cartloader/cartify.js ./bin/cart.crt MAGICDESK

rem Launch vice
C:\C64\Tools\Vice\x64.exe -logfile ./bin/vicelog.txt -moncommands ./bin/cart.vs ./bin/cart.crt


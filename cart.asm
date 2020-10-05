.segment Code [outBin="cart.crt", allowOverlap]



//Initialise cart
#define MAGICDESK	//Valid values D64, MAGICDESK, GMOD2, EASYFLASH
.var CART_ZP_START = $f0 //10 bytes min
.var CART_COPY_BASE = $0340	//$e0 bytes
.var CART_MAX_FILES = 256 	//256 maximum
.var KRILL_INSTALL_METHOD = $10dd //D64 only, Found in loadersymbols-c64.inc
#import "cartloader/cartLoader.asm"


LOADER_AddFile("BOOT", BOOT, __BOOT, $0800)   //First entry will AUTO run  (FAT Index 0)

LOADER_AddFile("DEMO", DEMO, __DEMO, $c000)   //(FAT Index 1)

.const MyFatIndexHere = FAT_INDEX

LOADER_AddFile("SOMEDATA", SOMEDATA, __SOMEDATA, $1000)

BOOT:	
	.pseudopc $0800 {
		sei
		lda #$7f
		sta $dc0d
		sta $dd0d

		lda #$35
		sta $01
		cli

		//Load by name
		LOADER_LoadFile("DEMO") 

		//Load by fat index (useful for level loading)
		lda #MyFatIndexHere
		LOADER_LoadFileByFATIndex() 
		
		jmp MAIN.Start
	}
__BOOT:


DEMO:
	.pseudopc $c000 {
		MAIN: {
			Start: {

					ldx #$0a
				!:
					lda $1000, x
					sta $0400, x
					lda #$01
					sta $d800, x
					dex
					bpl !-

				loop:
					//Bank in a static ROM bank at $8000
					lda #$37
					sta $01
					LOADER_LoadStaticBank(63)

				TEST_SMOD:
					lda $8000
					sta $d020

					//Remove cartridge banking at $8000
					lda #$35
					sta $01
					inc TEST_SMOD + 1

					jmp loop
			}
		}
	}
__DEMO:


SOMEDATA:
	.encoding "screencode_upper"
	.text "HELLO WORLD"
__SOMEDATA:


//STATIC BANKS
:LOADER_DefineStaticBank(63)
	.fill 8192, floor(random() * 255)
:LOADER_EndDefineStaticBank()









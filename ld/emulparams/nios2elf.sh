SCRIPT_NAME=elf
TEMPLATE_NAME=elf32
EXTRA_EM_FILE=
OUTPUT_FORMAT="elf32-littlenios2"
LITTLE_OUTPUT_FORMAT="elf32-littlenios2"
BIG_OUTPUT_FORMAT="elf32-bignios2"
TEXT_START_ADDR=0x1000
OTHER_GOT_SYMBOLS='
  _gp = ALIGN(16) + 0x7ff0;
  PROVIDE(gp = _gp);
'
ARCH=nios2
MACHINE=
MAXPAGESIZE="CONSTANT (MAXPAGESIZE)"
COMMONPAGESIZE="CONSTANT (COMMONPAGESIZE)"
ENTRY=_start
NOP=0x0001883a

GENERATE_SHLIB_SCRIPT=yes
GENERATE_PIE_SCRIPT=yes

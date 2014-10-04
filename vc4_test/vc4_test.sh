AS=$(which vc4-as)
OBJDUMP=$(which vc4-objdump)
LD=$(which vc4-ld)

if [ "$AS" == "" ] || [ "$OBJDUMP" == "" ] || [ "$LD" == "" ]; then
  echo "Put the VC4 binutils in your PATH"
  exit 1
fi

#make -j12
#VAL="valgrind --leak-check=full --log-fd=1"
#VAL=time
VAL=
${VAL} $AS -o test1.o test1.s
${VAL} $AS -o test2.o test2.s
${VAL} $AS -o test5.o test5.s
${VAL} $AS -o uart01.o uart01.s
${VAL} $AS -o uart02.o uart02.s
$LD uart02.o -o uart02_out.o
echo ===== DUMP =====
${VAL} $OBJDUMP -S test1.o
${VAL} $OBJDUMP -r test1.o
${VAL} $OBJDUMP -S test2.o
${VAL} $OBJDUMP -r test2.o
${VAL} $OBJDUMP -S test5.o
${VAL} $OBJDUMP -r test5.o
${VAL} $OBJDUMP -S uart01.o
${VAL} $OBJDUMP -r uart01.o
${VAL} $OBJDUMP -S uart02.o
${VAL} $OBJDUMP -r uart02.o
${VAL} $OBJDUMP -S uart02_out.o
${VAL} $OBJDUMP -r uart02_out.o
echo ===== LD =====
${VAL} .$LD -o testx test1.o test2.o
${VAL} $OBJDUMP -S testx

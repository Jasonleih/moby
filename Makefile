all:Image
.PHONY=clean
run-qumu:
	@qemu-system-i386 -boot a -fda bootsect.o
bootsect.o:
	@as --32 bootsect.s -o bootsect.o
bootsect:bootsect.o ld-bootsect.ld
	@ld -T ld-bootsect.ld bootsect.o -o bootsect
	@objcopy -O binary -j .text bootsect.o
clean:
	@rm -f *.o
	@rm bootsect

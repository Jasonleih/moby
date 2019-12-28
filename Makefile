all:Image
	bochs
.PHONY=clean run-qumu

run-qumu:bootsect
	@qemu-system-i386 -boot a -fda bootsect

bootsect.o:bootsect.s
	@as --32 bootsect.s -o bootsect.o

bootsect:bootsect.o ld-bootsect.ld
	@ld -T ld-bootsect.ld bootsect.o -o bootsect
	@objcopy -O binary -j .text bootsect
Image: bootsect demo
	@dd if=bootsect of=Image bs=512 count=1
	@dd if=demo of=Image bs=512 count=4 seek=1
demo: demo.o ld-bootsect.ld
	@ld -T ld-bootsect.ld demo.o -o demo
	@objcopy -O binary -j .text demo
demo.o: demo.s
	-@as --32 demo.s -o demo.o
	 
clean:
	-@rm -f *.o
	-@rm bootsect
	-@rm Image demo

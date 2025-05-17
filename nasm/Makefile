to_roman: to_roman.o
	ld to_roman.o -o to_roman

to_roman.o:
	nasm -f elf64 to_roman.asm

.PHONY: clean
clean:
	rm -f to_roman.o to_roman

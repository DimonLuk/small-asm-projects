nasm -f elf64 $1.nasm && ld -m elf_x86_64 -s -o $1.bin $1.o

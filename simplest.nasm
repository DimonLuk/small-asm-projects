section .data
  SYS_EXIT equ 1
  SYS_WRITE equ 4
  SYS_CALL equ 0x80
  STDOUT equ 1
  HELLO_WORLD_MSG db "Hello world!", 0xA
  HELLO_WORLD_LEN equ $ - HELLO_WORLD_MSG
section .text
  global _start
  _start:
  print_msg:
    xor eax, eax
    or eax, SYS_WRITE
    xor ebx, ebx
    or ebx, STDOUT
    xor ecx, ecx
    or ecx, HELLO_WORLD_MSG
    xor edx, edx
    or edx, HELLO_WORLD_LEN
    int SYS_CALL
  exit:
    xor eax, eax
    or eax, SYS_EXIT
    xor ebx, ebx
    int SYS_CALL

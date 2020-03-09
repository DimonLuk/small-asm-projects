#include <sys/syscall.h>
#include "functions/malloc.S"

.section .data
  MESSAGE:
    .ascii "Hello world!\n"
  MESSAGE_LEN:
    .quad . - MESSAGE
  STDOUT:
    .quad 1
  NORMAL_EXIT_STATUS:
    .quad 0

.globl _start

.section .text

  _start:
  pushq %rbp
  movq %rsp, %rbp 
  pushq 8
  call allocate_memory
  mov %rbp, %rsp
  popq %rbp
  print_message:
    movq $SYS_write, %rax
    movq STDOUT, %rdi
    movq $MESSAGE, %rsi
    movq MESSAGE_LEN, %rdx
    syscall

  exit:
    movq $SYS_exit, %rax
    movq NORMAL_EXIT_STATUS, %rdi
    syscall

#include <sys/syscall.h>


.globl _start


.section .rodata
  NUMBER:
    .quad 5

  ZERO_ASCII_CODE:
    .quad 48

  STDOUT:
    .quad 1

  SUCCESS_CODE:
    .quad 0

  BRK:
    .quad 12


.section .text
  _start:
  pushq %rbp
  movq %rsp, %rbp
  pushq NUMBER
  call convert_number_to_char
  movq %rbp, %rsp
  pop %rbp
  pushq %rax


  print_char:
    movq $SYS_write, %rax
    movq STDOUT, %rdi
    movq %rsp, %rsi
    movq $1, %rdx
    syscall

  exit:
    movq $SYS_exit, %rax
    movq SUCCESS_CODE, %rdi
    syscall

  .type convert_number_to_char, @function
  convert_number_to_char:
    movq -8(%rbp), %rbx
    cmp $9, %rbx
    jle _call_convert_digit_to_char

    _call_convert_digit_to_char:
      pushq %rbp
      movq %rsp, %rbp
      pushq %rbx
      call convert_digit_to_char
      movq %rbp, %rsp
      popq %rbp

    # allocate 2 bytes of memory
    pushq %rax
    movq BRK, %rax
    movq $2, %rdi
    syscall


    subq $2, %rdi
    pop (%rdi, 1, 1)
    movq %rdi, %rax
    ret

  # arguments: digit: quad
  # returns: digit: char
  # converts single digit to char by adding decima 48 (ASCII code of zero) to digit
  .type convert_digit_to_char, @function
  convert_digit_to_char:
    movq -8(%rbp), %rax
    addq ZERO_ASCII_CODE, %rax
    ret

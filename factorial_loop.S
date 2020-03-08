#include <sys/syscall.h>


.globl _start


.section .data
  STDOUT:
    .quad 1

  NUMBER:
    .quad 5


.section .text
  _start:
  calculate_factorial:
    # gcc calling convention
    pushq %rbp
    movq %rsp, %rbp
    pushq NUMBER
    call factorial_fuction
    movq %rbp, %rsp
    popq %rbp

  return_result:
    movq %rax, %rdi
    movq $SYS_exit, %rax
    syscall

  .type factorial_fuction, @function
  factorial_fuction:
    movq -8(%rbp), %rax
    movq -8(%rbp), %rbx

    _loop:
      cmpq $1, %rbx
      je _loop_end
      decq %rbx
      mulq %rbx
      jmp _loop

    _loop_end:
      ret

# include <sys/syscall.h>


.globl _start


.section .data
  NUMBER:
    .quad 5

  STDOUT:
    .quad 1


.section .text
  _start:
  calculate_factorial:
    pushq %rbp # save current base pointer
    movq %rsp, %rbp # prepare stack frame
    pushq NUMBER # pass argument to function
    call factorial_function
    movq %rbp, %rsp # restore stack frame, so stack points to rbp value in stack
    popq %rbp # restore base pointer

  return_result:
    movq %rax, %rdi # save result as return code
    movq $SYS_exit, %rax
    syscall

  factorial_function:    
    movq -8(%rbp), %rax # store passed value

    cmpq $1, %rax
    je factorial_function_end

    decq %rax # prepare value for recurrent call

    # call factorial_fuction again
    pushq %rbp
    movq %rsp, %rbp
    pushq %rax
    call factorial_function
    movq %rbp, %rsp
    popq %rbp

    mulq -8(%rbp)

    factorial_function_end:
      ret

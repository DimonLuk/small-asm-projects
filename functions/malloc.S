.globl allocate_memory


.section .data
  BRK:
    .quad 12


.section .bss
  initial_break:
    .quad

  current_break:
    .quad


.section .text
  # gcc calling convention
  # parameters: quad: number of bytes to allocate
  # returns: pointer to the begining of allocated memory 
  .type allocate_memory, @function
  allocate_memory:
    cmp $0, initial_break
    je _get_initial_break
    jne _allocate_memory

    _get_initial_break:
      movq BRK, %rax
      movq initial_break, %rdi
      syscall
      movq %rax, initial_break
      movq %rax, current_break

    _allocate_memory:
      pushq current_break
      movq BRK, %rax
      movq current_break, %rdi
      addq -8(%ebp), %rdi
      syscall
      movq %rax, current_break

    popq %rax

    ret

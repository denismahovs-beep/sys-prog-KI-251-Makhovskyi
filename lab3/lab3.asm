default rel

global main
extern printf
extern scanf

section .rodata
    msg_prompt db "Enter the Fibonacci number you want to calculate (0-93): ", 0
    msg_err    db "Please enter a number between 0 and 93.", 10, 0
    msg_res    db "The %dth Fibonacci number is %llu", 10, 0
    fmt_in     db "%d", 0

section .text

fibonacci:
    cmp edi, 0
    je .ret_zero
    cmp edi, 1
    je .ret_one

    push rbx
    push r12

    mov ebx, edi

    lea edi, [ebx - 1]
    call fibonacci
    mov r12, rax

    lea edi, [ebx - 2]
    call fibonacci

    add rax, r12

    pop r12
    pop rbx
    ret

.ret_zero:
    xor eax, eax
    ret

.ret_one:
    mov eax, 1
    ret

main:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    lea rdi, [msg_prompt]
    xor eax, eax
    call printf

    lea rdi, [fmt_in]
    lea rsi, [rbp - 4]
    xor eax, eax
    call scanf

    mov eax, dword [rbp - 4]
    cmp eax, 0
    jl .input_error
    cmp eax, 93
    jg .input_error

    mov edi, eax
    call fibonacci

    lea rdi, [msg_res]
    mov esi, dword [rbp - 4]
    mov rdx, rax
    xor eax, eax
    call printf

    xor eax, eax
    jmp .exit

.input_error:
    lea rdi, [msg_err]
    xor eax, eax
    call printf
    mov eax, 1

.exit:
    leave
    ret
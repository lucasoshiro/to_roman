global _start

section .data
STDOUT: equ 0
STDIN: equ 1

PROMPT: db "Enter a number: ", 0x0A
SIZE_PROMPT: equ $ - PROMPT

ROMAN_DIGITS: db "    i   ii  iii iv  v   vi  vii viiiix  x   "

ROMAN_DEC: db "IVXLCDM "

section .bss

buf: resb 64
size_buf: equ $ - buf

roman_buf: resb 64
size_roman_buf: equ $ - roman_buf

section .text
_start:
        mov rax, 1
        mov rdi, STDOUT
        mov rsi, PROMPT
        mov rdx, SIZE_PROMPT
        syscall

        mov rax, 0
        mov rdi, STDIN
        mov rsi, buf
        mov rdx, size_buf
        syscall

        mov r9, rax
        lea rcx, [buf + r9 - 2]
        lea rdx, [roman_buf]

for_1:
        xor rax, rax
        mov al, [rcx]
        sub rax, '0'

        xor ebx, ebx
        mov ebx, [ROMAN_DIGITS + 4 * rax]

        mov dword [rdx], ebx

        cmp rcx, buf
        jl for_1_exit

        dec rcx
        mov r9, 4

        add rdx, r9
        jmp for_1

for_1_exit:
        
        mov r9, roman_buf
        mov r8, ROMAN_DEC
for_2:  
        cmp r9, rdx
        je for_2_exit

        xor rax, rax
        mov eax, [r8]

        mov rbx, rax
        shr rbx, 8
        and rbx, 0xFF

        mov rcx, rax
        shr rcx, 16
        and rcx, 0xFF

        and rax, 0xFF

        mov r10, r9
        mov r11, 4
        add r11, r10

for_2_1:
        cmp r10, r11
        je for_2_1_exit

        cmp byte [r10], 'i'
        je i_substitution

        cmp byte [r10], 'v'
        je v_substitution

        cmp byte [r10], 'x'
        je x_substitution

        jmp for_2_1_end

i_substitution: 
        mov byte [r10], al
        jmp for_2_1_end
v_substitution: 
        mov byte [r10], bl
        jmp for_2_1_end
x_substitution: 
        mov byte [r10], cl
        jmp for_2_1_end

for_2_1_end:    

        inc r10
        jmp for_2_1

for_2_1_exit:   

        mov rax, 4
        add r9, rax

        mov rax, 2
        add r8, rax

        jmp for_2
for_2_exit:     

        lea rcx, buf
for_3:
        cmp r9, roman_buf
        jl for_3_exit

        mov r14, 4
        mov r10, r9
        sub r10, r14
for_3_1:        
        cmp r10, r9
        je for_3_1_exit

        mov al, [r10]
        cmp al, ' '

        je for_3_1_end

        mov byte [rcx], al
        inc rcx
for_3_1_end:    
        inc r10
        jmp for_3_1
for_3_1_exit:    

for_3_end:      
        sub r9, r14
        jmp for_3
for_3_exit:     

end:
        mov byte [rcx], 0x0A
        inc rcx
        sub rcx, buf
        
        mov rax, 1
        mov rdi, STDOUT
        mov rsi, buf
        mov rdx, rcx
        syscall

        mov rax, 60
        xor rdi, rdi
        syscall

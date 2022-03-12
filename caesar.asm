%include "io.mac"

section .text
    global caesar
    extern printf

caesar:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length
    
    ;; DO NOT MODIFY

    ;; TODO: Implement the caesar cipher
    mov ebx, edi

modulo:
    cmp ebx, 26
    jl caesar1

    sub ebx, 26
    mov edi, ebx
    jmp modulo

caesar1:

    xor eax, eax
    xor ebx, ebx
    mov ebx, edi

task:
    cmp ecx, 0
    je exit

;;compare to determine position of char on ASCII table
compare:
    mov al, byte[esi + ecx -1] ;rightmost byte   

    cmp al, 'z'
    jg next_char
    
    cmp al, 'A'
    jl next_char

    cmp al, 'a'      
    jl intermediate 
   
    cmp al, 'a'              
    jge found_letter 
     
intermediate:
    cmp al, 'Z'  
    jg next_char 
    cmp al, 'Z'               
    jle found_letter 

;; see in what situation we are after we would supposedly add key  
found_letter:
    xor edi, edi 
    mov edi, eax
    add edi, ebx
    cmp edi, 0x7A
    jg recalculate_small

    cmp edi, 0x5A
    jle add_output

    cmp edi, 0x7A
    jl recalculate_small

;;recalculate to start alphabet from beginning
recalculate_small:
    cmp edi, 0x61
    jl recalculate_capital

    cmp edi, 0x7A
    jle add_output

    sub eax, 0x7A
    add eax, 0x61
    sub eax, 1
    jmp add_output

;;recalculate to start alphabet from beginning
recalculate_capital:
    cmp edi, 0x5A
    jle add_output
    sub eax, 0x5A
    add eax, 0x41
    sub eax, 1
    jmp add_output

;;shift with key and place into edx registry
add_output:
    add eax, ebx
    mov [edx + ecx -1], al
    jmp done

;;situation for special chars that dont need shifting
next_char:  
    mov [edx + ecx -1], al
    jmp done

done:
    dec ecx
    jmp task

exit:
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
%include "io.mac"

section .text
    global vigenere
    extern printf
section .data
    key_length dd 0
    text_length dd 0

vigenere:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     ecx, [ebp + 16]     ; plaintext_len
    mov     edi, [ebp + 20]     ; key
    mov     ebx, [ebp + 24]     ; key_len
    ;; DO NOT MODIFY

    ;; TODO: Implement the Vigenere cipher

    mov [key_length], ebx 
    mov [text_length], ecx
    xor ecx, ecx
    xor ebx, ebx
;;restart key when pointer gets to last letter
restart_key:
    mov ebx, 0
    jmp main 

main:   
    cmp ecx, [text_length]
    jg exit

    cmp ebx, [key_length]
    je restart_key

    mov al, byte[esi + ecx] ;leftmost byte plaintext 

    ;;compare to determine position of char on ASCII table
    cmp al, 'z'
    jg add_output
    
    cmp al, 'A'
    jl add_output

    cmp al, 'a'      
    jl intermediate 
   
    cmp al, 'a'              
    jge found_letter 
     
intermediate:
    cmp al, 'Z'  
    jg add_output 
    cmp al, 'Z'               
    jle found_letter 
                 
;; see in what situation we are after we would supposedly add key  
found_letter:
;;we push to stack ecx so we can use him for this computation
    push ecx
    mov cl, al
    mov ah, byte[edi + ebx] ; leftmost byte key
    sub ah, 'A'
    
    add cl, ah

    cmp cl, 'z' ;122
    jg recalculate_small

    cmp cl, 'Z' ;90
    jle compute

    cmp cl, 'a' ;97
    jl recalculate_capital

    cmp cl, 'z' ; 122
    jle compute

;;recalculate to start alphabet from beginning
recalculate_small:
    sub al, 'z'
    add al, 'a'
    sub al, 1
    jmp compute

;;recalculate to start alphabet from beginning
recalculate_capital:
    sub al, 'Z'
    add al, 'A'
    sub al, 1
    jmp compute

;;actually shift bytes by key and place result in edx registry
compute:
    pop ecx
    add al, ah 
    mov [edx + ecx], al
    inc ebx
    jmp done

;;situation for special chars that dont need shifting
add_output:
    mov [edx + ecx], al
    jmp done

 done:
    inc ecx
    jmp main

exit:
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
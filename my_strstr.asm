%include "io.mac"

section .text
    global my_strstr
    extern printf

section .data
    key_length dd 0
    text_length dd 0
    
my_strstr:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edi, [ebp + 8]      ; substr_index
    mov     esi, [ebp + 12]     ; haystack
    mov     ebx, [ebp + 16]     ; needle
    mov     ecx, [ebp + 20]     ; haystack_len
    mov     edx, [ebp + 24]     ; needle_len
    ;; DO NOT MODIFY

    ;; TO DO: Implement my_strstr
    mov [text_length], ecx
    mov [key_length], edx 
    xor eax, eax
    xor ecx, ecx
    xor edx, edx
    
;;compare first char of key with every char of text until match happens
compare_first_byte:
    cmp ecx, [text_length]
    jg finish_not_ok1

    mov al, byte[esi + ecx] ;;leftmost byte of plaintext
    mov ah, byte[ebx + edx] ;;leftmost byte of key
    cmp al, ah ;; compare to see if bytes match
    je save_value
    inc ecx
    jmp compare_first_byte

save_value:
    mov eax, ecx
    push eax ;; push to stack the value at which chars matched
    jmp compare_key

compare_key:
    inc edx
    inc ecx

    ;;check to see if we found the key in text
    cmp edx, [key_length]
    je finish_ok

    ;;check to see if we finished the text
    cmp ecx, [text_length]
    je finish_not_ok

    ;; compare at the same time each byte from key and plaintext
    xor eax, eax
    mov al, [esi + ecx]
    mov ah, [ebx + edx]
    cmp al, ah
    je compare_key ;; continue while still equal
    jmp restart_key ;; in case of mismatch, move to next set of chars

;;retrieve value from stack and place in edx, if key was found
finish_ok:
    xor eax, eax
    pop eax
    mov [edi], eax
    jmp exit

;; place in edx text length + 1 if key was not found
finish_not_ok:
    xor eax, eax
    pop eax
    inc eax
    mov [edi], eax
    jmp exit

;; place in edx text length + 1 if key was not found, after restarting loop
finish_not_ok1:
    mov [edi], ecx
    jmp exit

;;clear registries and try again from beginning
restart_key:
    pop eax
    xor eax, eax
    xor edx, edx
    jmp compare_first_byte

exit:
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY

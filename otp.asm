%include "io.mac"

section .text
    global otp
    extern printf

otp:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length
   jmp task
    ;; DO NOT MODIFY
    ;; TODO: Implement the One Time Pad cipher
task:
    cmp ecx, 0
    je exit
    ;;make sure registry is 0
    xor eax, eax
    ;;move byte from last - 1 position of plaintext into Al
    mov al, byte[esi + ecx - 1]
    ;;move byte from last - 1 position of key into Al
    mov ah, byte[edi + ecx - 1]
    ;;xor between bytes
    xor al,ah
    ;; place result into edx
    mov [edx + ecx - 1], al

    dec ecx
    jmp task


exit:
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
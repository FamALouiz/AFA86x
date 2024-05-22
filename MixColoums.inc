mulTwo Macro inp

    pushf
    pusha

    mov ax,2
    MUL inp
    CMP ah,0
    ;if ZF
    JZ end1
    XOR ax,0x1Bh
    end1: MOV inp,al
    
    popa
    popf
    
endm

mulThree Macro inp
    
    pushf
    pusha

    MOV DL,inp
    mov ax,2
    MUL inp
    CMP ah,0
    ;if ZF
    JZ end2
    XOR ax,0x1Bh
    end2: MOV inp,al
    XOR inp,Dl
    
    popa
    popf

endm







diad MACRO one four 
    pushf
    push ax
    MOV ax,4
    MUL four
    add al,one
    MOV ah,00
    mov di,ax
    push ax
    pushf
endm

clone MAcro 

    pushf
    pusha
    MOV cx,0
    loop1:
        MOV di,cx
        mOv dl,keyMatrix[di]
        MOv unchangedMatrix[di],dl
        inc cx
       cmp cx,16
       jnz loop1
    pusha
    pushf
endm

macro mixColoums
    clone
    pushf
    pusha
    ii:
        jj:
            MOV ans,00
            mov an ,00
            mov tmp,00
            mov at,00
            xx:
                
                ; di = i+x*4
                diad i x
                push ax
                ;AT = key[di]
                MOV al,unchangedMatrix[di]
                MOV at,al
                ;tmp = di
                MOV tmp, di
                pop ax

                pusha
                diad x j              
                cmp MDS[di],1
                JNZ if2
                MOV dl, at
                XOR an,dl
                if2: cmp MDS[di],2
                jnz if3
                ;at = at*2
                MulTwo at
                ;an = an  ¤ at
                MOV dl, at
                XOR an,dl
                if3:cmp MDS[di],3 
                JNZ endif
                ;at = at*3
                MulTHree at
                ;an = an  ¤ at
                MOV dl,at
                XOR an,dl
                endif: 
                popa
                ;ans = an
                mov dl, an
                mov ans,dl

                inc x
                cmp x,4
                jnz xx
            
            push ax
            
            diad i, j ; di i+(4*j)
            ; key[di] = an
            mov ah ,an
            MOV keyMatrix[di], ah
            pop ax

            MOV x,0
            inc j
            cmp j,4
            jnz jj
        MOV j,0
        inc i
        cmp i,4
        jnz ii
    popa
    popf
endm

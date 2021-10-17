.data
argument: .word 7
str1:     .string "Factorial value of "
str2:     .string " is "

.text
main:
    lw a0,argument
    jal ra,fact
    jal ra,printResult
    #exit program
    li a7,10
    ecall
fact:
    addi sp,sp,-16
    sw ra,8(sp)
    sw a0,0(sp)
    addi t0,a0,-1
    bge t0,zero,nfact
    addi a0,zero,1
    addi sp,sp,16
    jr ra
    
nfact:
    addi a0,a0,-1
    jal ra,fact
    addi t1,a0,0
    lw ra,8(sp)
    lw a0,0(sp)
    addi sp,sp,16  
    mul a0,a0,t1
    ret
printResult:
    mv t0,a0
    la a0,str1
    li a7,4
    ecall
    la a0,str2
    li a7,4
    ecall
    mv a0,t0
    li a7,1
    ecall
    ret
    

    
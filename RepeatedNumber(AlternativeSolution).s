.data
nums: .word 5,1,5,2,5,3,5,4
numsSize: .word 8
str1: .string "["
str2: .string "]\n"
str3: .string " "
str4: .string "Repeated number is "

.text
main:
    la a1,nums
    lw a2,numsSize
    jal Check
    mv a4,a0

    jal ra,Print #Print Array
    la a0,str4
    li a7,4
    ecall
    mv a0,a4    #print Answer
    li a7,1
    ecall
    li a7,10
    ecall

Print: # a1:array a2: numSize
    li t0,0
    la a0,str1 #print started
    li a7,4
    ecall
    mv a3,a1
PrintFor:
    lw a0,(0)a3 # print number
    li a7,1
    ecall
    la a0,str3 # print space
    li a7,4
    ecall
    addi a3,a3,4
    addi t0,t0,1
    bne t0,a2,PrintFor
PrintEnd:
    la a0,str2  #print ended
    li a7,4
    ecall
    jr ra

Check: 
    # return a0 by answer  
    # t0   i
    # t3 t4 t5 number of Ai Ai+1 Ai+2
    # a3 pointer to current number
#------Start--------------------------------
    mv t4,a2      #t4= numsSize
    addi t4,t4,-1 #t4=numsSize-1
    slli t4,t4,2  #t4= (numsSize-1) pointer offset
    addi t3,zero,3 # 3
    blt a2,t3,SkipCompare
    # if(nums[0]==nums[numsSize-1] || nums[0]==nums[numsSize-2])
    lw t3,(0)a1 # t0=A[0]
    add a3,a1,t4
    lw t4,(0)a3
    lw t5,(-4)a3
    beq t3,t4,ReturnAns
    beq t3,t5,ReturnAns
    # if(nums[1]==nums[numsSize-1] || nums[1]==nums[0])
    lw t3,(4)a1
    lw t5,(0)a1
    beq t3,t4,ReturnAns
    beq t3,t5,ReturnAns
#---------loop Start------
    li t0,2 #Start From 2
CheckFor:
#-------getNumber-------------------------------
    slli t3,t0,2 # t3 = t0*4   t3 :i
    add a3,a1,t3 # a3= a1+t0  pointer calculation
    lw t3,(0)a3  # t3= A[i]
    lw t4,(-4)a3
    lw t5,(-8)a3
#----check A==A[i+1] or A==A[i+2]----------------
    beq t3,t4,ReturnAns
    beq t3,t5,ReturnAns
    addi t0,t0,1 #endFor i++
    blt t0,a3,CheckFor #Check i<numsSize
ReturnAns:
    add a0,t3,zero
    jr ra
SkipCompare:
    lw t3,(0)a1
    jr ra
     
    
    
 
    
    
    
  
    
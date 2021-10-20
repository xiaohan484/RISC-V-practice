# RISC-V-practice
This is homework for Computer Architecture. 
# Assignment1: RISC-V Assembly and Instruction Pipeline

## Problem Description: N-Repated Element in Size 2N Array

Given one interger array called **nums**:
 - It has N+1 uniques number
 - The length of array: 2N
 - There has **exactly one** element is repeat **N** times.
 
 Return the repeated element.
 
 Ex. Array: [1,2,4,4,4,4]
 - The length of array: 6
 - N = 3
 - Repeated element is repeat 3 times
 Ans: 4
 
## Problem Analysis
Only one element can be repeated.Consider 3 cases, i is the index of current element:
  - Case 1: abcddd, d are all continuous repeated.(or dddabc,abdddc)
  > 1. We can compare two adjacent number to find the repeated elements.(compare i and i+1 elements)
  - Case 2: dadbdc, d are all discontinuous repeated.(or adbdcd)
  > 2. We can compare the element after one (compare i and i+2 element) to find the
  - Case 3: other
  > 3. Case 3 must combined in case 1 and case 2,some of repeated elements are continuous repeat,some of repeated elements are discontinuous repeat.(ddadbc -> dda|dbc)

## C code
Check all element in the array **a**, if the element **a**~i~ is repeated element, following event are true:
> **a**~i~=**a**~i+1~ or **a**~i~=**a**~i+2~ 
```c
#include <stdio.h>
int repeatedNTimes(int* nums,int numsSize)
{
    for(int i=0;i<numsSize;i++)
    {
        if(nums[i]==nums[(i+1)%numsSize] || nums[i]==nums[(i+2)%numsSize])
            return nums[i];
    }
    return -1;
}

int main()
{
    int a[]={5,1,5,2,5,3,5,4};
    int numsSize=8;
    printf("[");
    for(int i=0;i<numsSize;i++)
        printf("%d ",a[i]);
    printf("]\n");
    int repeatedNum=repeatedNTimes(a,numsSize);
    printf("%d ",repeatedNum);
    return 0;
}
```

## Assembly Code
```assembly
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

Check: # return a0 by answer  
    # t0 t1 t2   i ,i+1 ,i+2
    # t3 t4 t5 number of Ai Ai+1 Ai+2
    # t6 :4
    # a3 pointer to current number
#------ForStart--------------------------------
    li t0,0
    li t6,4
CheckFor:
    addi t1,t0,1
    addi t2,t0,2
#-------getNumberi-------------------------------
    mul t3,t0,t6 # t3 = t0*4   t3 :i
    add a3,a1,t3 # a3= a1+t0  pointer calculateion
    lw t3,(0)a3  # t3= A[i]
#-------getNumberi+1------------------------------  
    rem t2,t2,a2
    mul t4,t2,t6 # t4 = t1*4   t3 :i
    add a3,a1,t4 # a3= a1+t1  pointer calculateion
    lw t4,(0)a3  # t4= A[i+1]
#-------getNumberi+2------------------------------
    rem t3,t3,a2
    mul t5,t3,t6 # t5 = t0*4   t3 :i
    add a3,a1,t5 # a3= a1+t0  pointer calculation
    lw  t5,(0)a3  # t5= A[i+2]
#----check A==A[i+1] or A==A[i+2]----------------
    beq t3,t4,ReturnAns
    beq t4,t5,ReturnAns
    addi t0,t0,1 #endFor i++
    blt t0,a3,ReturnAns #Check i<numsSize
    j CheckFor
ReturnAns:
    add a0,t3,zero
    jr ra
```
  
 

     

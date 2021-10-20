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

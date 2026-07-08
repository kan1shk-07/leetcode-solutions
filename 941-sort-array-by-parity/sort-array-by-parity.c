/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* sortArrayByParity(int* nums, int numsSize, int* returnSize) {
    *returnSize=numsSize;
    int *arr = malloc(numsSize * sizeof(int));
    int k=0;
    int x=numsSize;
    for(int i=0;i<numsSize;i++){
        if(nums[i]%2==0){
            arr[k]=nums[i];
            k++;
        }
        else{
            
            arr[x-1]=nums[i];
            x--;

        }
    }
    return arr;
    
  

    
}
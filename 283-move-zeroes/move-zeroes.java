class Solution {
    public void moveZeroes(int[] nums) {
        int [] arr=new int [nums.length];
        int r=nums.length-1;
        int l=0;
        for(int i=0;i<nums.length;i++){
            if(nums[i]==0){
                arr[r]=nums[i];
                r--;
            }
            else{
            arr[l]=nums[i];
            l++;
            }
            
        }
        for(int i=0;i<nums.length;i++){
            nums[i]=arr[i];
        }
        
    }
}
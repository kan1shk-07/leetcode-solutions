class Solution {
    public int findMaxConsecutiveOnes(int[] nums) {
        int a=0;
        int z=0;
        int msize=0;
        for(int i=0;i<nums.length;i++){
            if(nums[i]==1){
                z++;
            }
            if(msize<z-a){
                msize=z-a;
            }
            
            if (nums[i]==0){
                a=i+1;
                z=i+1;
                


            }

        }
        return msize;
        
        
    }
}
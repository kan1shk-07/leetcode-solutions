class Solution {
    public int minSubArrayLen(int target, int[] nums) {
        int l=0;
        int r=0;
        int sum=0;
        int mlen=Integer.MAX_VALUE;
        int length=0;
        for(r=0;r<nums.length;r++){
            sum+=nums[r];
            
            


            while(sum>=target){
                length=r-l+1;
                
                sum-=nums[l];
                l++;
                if((length)<mlen){
                    mlen=length;
                }
                
                
            }
        }
        if(mlen==Integer.MAX_VALUE)
        return 0;
        else
        return mlen;

    }
}    
       
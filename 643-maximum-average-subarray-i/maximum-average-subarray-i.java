class Solution {
    public double findMaxAverage(int[] nums, int k) {
        
        int l=0;
        int r=nums.length;
        int avg=0;


        for(int i=0;i<k;i++){
            avg+=nums[i];

        }
        int mavg=avg;
        for(int i=k;i<nums.length;i++){
            avg+=nums[i];
            avg-=nums[i-k];
            if(avg>mavg)
            mavg=avg;
        }
        return (double) mavg/k;
    }
}
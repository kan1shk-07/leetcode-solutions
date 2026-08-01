class Solution {
    public int missingNumber(int[] nums) {
        HashSet<Integer> set=new HashSet<>();
        int n=0;
        for(int i=0;i<nums.length;i++){
            set.add(nums[i]);

        }
        for( int i=0;i<nums.length+1;i++){
            if(!set.contains(i))
            n=i;
            
        }
        return n;

        
        
    }
}
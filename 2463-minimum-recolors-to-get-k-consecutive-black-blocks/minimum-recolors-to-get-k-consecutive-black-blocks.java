class Solution {
    public int minimumRecolors(String blocks, int k) {
        char[] arr=blocks.toCharArray();
        int whiteocc=0;

        for(int i=0;i<k;i++){
            if(arr[i]=='W'){
                whiteocc++;
            }
        }
        int minrecolor=whiteocc;
        for(int i=k;i<arr.length;i++){
            if(arr[i]=='W'){
                whiteocc++;
            }
            if(arr[i-k]=='W'){
                whiteocc--;
            }
            if(minrecolor>whiteocc)
            minrecolor=whiteocc;

        }
        return minrecolor;
        
    }
}
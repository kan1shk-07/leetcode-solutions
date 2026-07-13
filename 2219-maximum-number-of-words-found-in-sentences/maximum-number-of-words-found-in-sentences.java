class Solution {
    public int mostWordsFound(String[] sentences) {
        int maxword=0;
        for(int i=0;i<sentences.length;i++){
            String[] words = sentences[i].trim().split("\\s+");
            if(maxword<words.length){
                maxword=words.length;
            }


        }
        return maxword;
        
    }
}
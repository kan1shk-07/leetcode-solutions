class Solution {
    public void merge(int[] nums1, int m, int[] nums2, int n) {
        // Set pointers for the end of valid elements in both arrays
        int p1 = m - 1;
        int p2 = n - 1;
        // Set pointer for the end of the total space in nums1
        int p = m + n - 1;

        // Merge from the back while elements remain in both arrays
        while (p1 >= 0 && p2 >= 0) {
            if (nums1[p1] > nums2[p2]) {
                nums1[p] = nums1[p1];
                p1--;
            } else {
                nums1[p] = nums2[p2];
                p2--;
            }
            p--;
        }

        // If elements remain in nums2, copy them over
        while (p2 >= 0) {
            nums1[p] = nums2[p2];
            p2--;
            p--;
        }
    }
}

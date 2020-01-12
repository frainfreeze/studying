#include <iostream>
#include <algorithm>
#include <unordered_map>

/*
Find Pair with given Sum in the Array
Given an unsorted array of integers, find a pair with given sum in it.
For example,
Input :
arr = [8,7,2,5,3,1]
sum = 10
Output :
Pair found at index 0 and 2 (8 + 2)
Pair found at index 1 and 4 (7 + 3)

ref: [1] http://www.techiedelight.com/find-pair-with-given-sum-array/
*/

void naive_find_pair(int field[], int fieldSize, int sum){
    // "The time complexity of solution is O(n^2) and auxiliary space used is O(1)"[1]

    std::cout << "Naive pair search:\n";

    for (unsigned int i = 0; i<fieldSize; i++){
        for (unsigned int j = fieldSize; j>0; j--){
            if(field[i]+field[j]==sum){
                std::cout << "Pair found at index " << i << " and " << j << " ("
                     << field[i] << " + " << field[j] << ").\n";
            }
        }
    }
}

void sorting_find_pair(int field[], int fieldSize, int sum){
    /*
    "2. O(nlog(n)) solution using Sorting -
    The idea is to sort the given array in ascending order and maintain search
    space by maintaining two indices (low and high) that initially points to two
    end-points of the array. Then we loop till low is less than high index and
    reduce search space arr[low.. high] at each iteration of the loop. We compare
    sum of elements present at index low and high with desired sum and increment
    low if sum is less than the desired sum else we decrement high is sum is more
    than the desired sum. Finally, we return if pair found in the array."[1]
    */
    std::cout << "\nSorting pair search:\n";

    std::sort(field,field+fieldSize); // sort array in ascending order

    // two indices pointing to end-points of array
    int low = 0;
    int high = fieldSize-1;

    // reduce search space arr[low..high] at each iteration of the loop
    // loop till low is less than high
    while (low < high){
        if (field[low] + field[high] == sum){  // sum found
            std::cout << "Pair found at index " << low << " and " << high << " ("
                     << field[low] << " + " << field[high] << ").\n";
            return;
        }
        // increment low index if total is less than the desired sum
        // decrement high index is total is more than the sum
        (field[low] + field[high] < sum)? low++: high--;
    }
    // No pair with given sum exists in the array
    std::cout << "Pair not found\n";
}

void hashing_find_pair(int field[], int fieldSize, int sum){
    /*
    "3. O(n) solution using Hashing -
    We can use map to easily solve this problem in linear time. The idea is to insert
    each element of the array field[i] in a map. We also checks if difference (field[i],
    sum field[i]) already exists in the map or not. If the difference is seen before, we
    print the pair and return."[1]
    */
    std::cout << "\n\nHashing pair search:\n";

    // create an empty map
    std::unordered_map<int, int> map;

    // do for each element
    for (int i = 0; i < fieldSize; i++){
        // check if pair (field[i], sum-field[i]) exists
        // if difference is seen before, print the pair
        if (map.find(sum - field[i]) != map.end()){
            std::cout << "Pair found at index " << map[sum - field[i]] << " and " << i;
            return;
        }
        // store index of current element in the map
        map[field[i]] = i;
    }
    // we reach here if pair is not found
    std::cout << "Pair not found\n";
}

int main() {

    int field[] = {8,7,2,5,3,1};
    int fieldSize = sizeof(field)/sizeof(field[0]);
    int sum = 10;

	naive_find_pair(field,fieldSize,sum);
    sorting_find_pair(field,fieldSize,sum);
    hashing_find_pair(field,fieldSize,sum);

	return 0;
}

#include <iostream>
#include <algorithm>
#include <array>

using namespace std;

void init_array(array<int, 100> &arr)
{
	for (unsigned i = 0; i < arr.size(); i++) {
		arr[i] = i + 1;
	}
}

bool prime(const int n) 
{
	for (int i = 2; i < n; i++) {
		if (n % i == 0) {
			return false;
		}
	}
	return n != 1;
}

void print_if_prime(const int n) 
{
	if (prime(n))  {
		cout << n << endl;
	}
}

int main() 
{
	array<int, 100> arr;
	init_array(arr);
	for_each(arr.begin(), arr.end(), print_if_prime);
	
	//print backwards
	//1st way
	//for_each(arr.rbegin(), arr.rend(), print_if_prime);
	//2nd way
	//reverse(arr.begin(), arr.end());
	//for_each(arr.begin(), arr.end(), print_if_prime);

}
#include <iostream>
using namespace std;

//auto test() -> int { return <int>;}

template<class T, class S>
auto test(T value1, S value2) -> decltype(value1 + value2) {
	return value1 + value2;
}

int get()
{
	return 999;
}

auto test2() -> decltype(get())
{
	return get();
}

int main() {
	auto value = 7;
	auto text = "Hello";

	cout << test(5, 6) << endl;
    cout << test(value, text) << endl;
	cout << test2() << endl;
	cout << test(get(), test2()) << endl;

	return 0;
}
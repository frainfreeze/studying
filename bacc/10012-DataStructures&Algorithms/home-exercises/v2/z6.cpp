#include <iostream>
#include <algorithm>
#include <fstream>
#include <string>
#include <array>

using namespace std;

// int count_words(ifstream &in)
// {
// 	int counter = 0;
// 	string word;
// 	while (in >> word) 
// 	{
// 		counter++;
// 	}
// 	return counter;
// }

void fill_array(ifstream &in, array<string, 250> &words)
{
	int pos = 0;
	string word;
	while (in >> word)
	{
		words[pos++] = word;
	}
}

int main()
{
	ifstream in("NekiTekst.txt");
	if (!in)
	{
		cout << "nije moguce pristupiti datoteci" << endl;
		return -1;
	}
	//first we need to count the words and then create array
	//int nr_words = count_words(in); 
	//cout << nr_words << endl; //250
	array<string, 250> words;
	fill_array(in, words);

	in.close();

	string what = "the";
	int counter = count(words.begin(), words.end(), what);
	cout << "rijec " << what << " se pojavljuje " << counter << " puta" << endl;

	return 0;
}
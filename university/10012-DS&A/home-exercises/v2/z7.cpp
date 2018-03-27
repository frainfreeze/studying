#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <algorithm>

using namespace std;

void fill_vector(ifstream &in, vector<string> &words)
{
	int pos = 0;
	string word;
	while (in >> word) {
		words.push_back(word);
	}
}

int main()
{
	ifstream in("NekiTekst.txt");
	if (!in) {
		cout << "nije moguce pristupiti datoteci" << endl;
		return -1;
	}

	vector<string> words;
	fill_vector(in, words);

	in.close();

	string what = "the";
	//int counter = count(words.begin(), words.end(), what);
	
	int counter = 0;
	auto pos = find(words.begin(), words.end(), what);
	while (pos != words.end()) {
		counter++;
		pos = find(pos + 1, words.end(), what);
	}

	cout << "rijec " << what << " se pojavljuje " << counter << " puta" << endl;

	return 0;
}
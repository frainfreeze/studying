//     stringstream      //
#include <sstream>
stringstream ss;
ss << "P(" << 10 << ", " << 20 << ") = " << 10*20;
cout << ss.str();

//     random string     //
#include <ctime>
#include <string>
using namespace std;
int generate_random(int min, int max) {
	return rand() % (max - min + 1) + min;
}
string randstr(int size){
    srand(time(0));
    string temp;
    static const char alphanum[] =
        "0123456789"
        "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        "abcdefghijklmnopqrstuvwxyz";
    for (int i = 0; i < size; ++i) 
        temp.push_back(alphanum[rand() % (sizeof(alphanum) - 1)]);
	return temp;
}

//     stopwatch     //
#include <iostream>
#include <chrono>
using namespace std::chrono;

auto t1 = high_resolution_clock::now();
//zadatak
auto t2 = high_resolution_clock::now();

nanoseconds ns = duration_cast<nanoseconds>(t2 - t1); 
long long trajanje = ns.count();
cout << "trajanje: " << trajanje << " ns" << endl;

//     converter     //
#include <sstream>
using namespace std;

template<typename T>
T convert(string &s) {
	T result;
	stringstream converter(s);
	converter >> result;
	return result;
}

double level = convert<double>(string);

//     stopwatch 2     //
//Stoperica.h
#pragma once 
#include <chrono>
class Stoperica { 
private: 
	std::chrono::time_point<std::chrono::high_resolution_clock> t1; 	
	std::chrono::time_point<std::chrono::high_resolution_clock> t2;
public: 
	void start(); 
	void stop(); 
	long long get_elapsed_milliseconds(); 
};
//stoperica.cpp
#include "Stoperica.h"
void Stoperica::start() { 
	t1 = std::chrono::high_resolution_clock::now(); 
}
void Stoperica::stop() { 
	t2 = std::chrono::high_resolution_clock::now(); 
}
long long Stoperica::get_elapsed_milliseconds() { 
	return std::chrono::duration_cast<std::chrono::milliseconds>(t2-t1) .count(); 
}
//Source.cpp
#include <iostream> 
#include "Stoperica.h" 
using namespace std;
int main() { 
	Stoperica sw; 
	sw.start();
	//zadatak
	sw.stop(); 
	long long trajanje = sw.get_elapsed_milliseconds();
	cout << "Trajanje " << trajanje << " ms" << endl; return 0;
}

//     error catching    //
try{
	cout << a << " / " << b << " = " << divide(a, b) << endl;
} catch (const exception& e) {
	cout << "error: " << e.what() << endl;
}
if (sirina <= 0 || visina <= 0) {
	throw std::exception("Pravokutnik mora imati stranice vece od 0");
}

//      read file   //
void read_file(const string &fname) {
	ifstream in(fname);
	if (!in)
		throw exception("Nije moguce pristupiti datoteci");
	...
    try{
		read_file(fname);
	} catch (const exception &e) {
		cout << "Pogreska:" << e.what() << endl;
		return 1;
	}

// other //
#include <array>
    array<int, 100> arr; //...
    //print backwards
    for_each(arr.rbegin(), arr.rend(), print_if_prime);

    //count whats
    //int counter = count(words.begin(), words.end(), what);
    auto pos = find(words.begin(), words.end(), what);
    while (pos != words.end()) {
        counter++;
        pos = find(pos + 1, words.end(), what);
    }

    //delete till year
    levels.remove_if([&](Water_level wl) {return wl.get_year() <= year; });
    //or
    for (auto it = levels.begin(); it != levels.end();) {
		if (it->get_year() <= year)
			it = levels.erase(it);
		else 
			++it;
	}

#include <stack>
	stack<int, vector<int>> s; // push, pop, top
#include <queue>
	queue<string> q; // push, pop, front

#include "btree.h"
	btree tree("a");
	tree.insert_left(tree.root(), "b");
	tree.insert_right(tree.root(), "c");

	node* c = tree.get_right_child(tree.root());
	tree.insert_right(c, "d");

void btree::inorder(node* current) {
	if (current == nullptr)	return;
	inorder(current->left_child);
	cout << current->element << endl;
	inorder(current->right_child);
}

void btree::preorder(node* current) {
	if (current == nullptr) return;
	cout << current->element << endl;
	preorder(current->left_child);
	preorder(current->right_child);
}

void btree::postorder(node* current) {
	if (current == nullptr) return;
	postorder(current->left_child);
	postorder(current->right_child);
	cout << current->element << endl;
}

void btree::bfs(node * current) { //public
	queue<node*> q;
	q.push(current);
	bfs(q);
}

void btree::bfs(queue<node*>& q) { //private
	if (q.empty()) return;
	node* current = q.front();
	q.pop();

	cout << current->element << endl;
	if (current->left_child != nullptr) 
		q.push(current->left_child);
	if (current->right_child != nullptr)
		q.push(current->right_child);
	bfs(q);
}

void btree::print(node * current, int level) {
	if (current == nullptr) return;
	if (level > 0) {
		for (unsigned i = 0; i < (level - 1) * 4; i++)
			cout << " ";
		cout << "|";
		for (unsigned i = 0; i < 3; i++) 
			cout << "-";
	}
	cout << current->element << endl;
	print(current->left_child, level + 1);
	print(current->right_child, level + 1);
}
   
//binary files
void write_string(string line, ofstream &out) {
    short length = line.length();
    out.write((char*)&length, sizeof(length));
    out.write(line.c_str(), length);
}

	ofstream os("nazivi_drzava.dat", ios_base::binary);
	if (!is || !os) ...
    write_string(naziv, os);

    //read
    ifstream bin("nazivi_drzava.dat", ios_base::binary);
    if (!bin) ...
    while (true) {
        short length;
        if (!bin.read((char*)&length, sizeof(length)))
            break;
        string naziv = read_string(length, bin);
        cout << naziv << endl;
    }
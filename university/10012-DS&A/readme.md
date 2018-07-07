A priori analiza
- Vrijeme izvršavanja (engl. running time) je vrijeme potrebno da izvođenje algoritma dođe do kraja
- Izražavat ćemo ga u broju operacija, a ne sekundi
- T(1000) = 2981 znači da trajanje algoritma na 1000 ulaznih podataka iznosi 2981 operaciju
- Da bismo mogli prebrojati operacije, moramo odlučiti koji tip analize želimo raditi:
    - best case scenario
    - worst case scenario
    - average case scenario

A posteori analiza
- predstavlja analizu izvođenja programa na nekom stvarnom računalu
- umjesto logičkih operacija mjerimo duljinu izvođenja programa
- Što je kraće vrijeme izvođenja, program smatramo boljim

Mjerenje brzine koda
```cpp
// Stoperica.h
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
```
```cpp
// Stoperica.cpp
#include "Stoperica.h"
void Stoperica::start() {
    t1 = std::chrono::high_resolution_clock::now();
}
void Stoperica::stop() {
    t2 = std::chrono::high_resolution_clock::now();
}
long long Stoperica::get_elapsed_milliseconds() {
    return std::chrono::duration_cast<std::chrono::milliseconds>(t2-t1).count();
}
```

```cpp
// Source.cpp
#include <iostream>
#include "Stoperica.h"
using namespace std;
int main() {
    Stoperica sw;
    sw.start();
    long long s = 0;
    for (int i = 0; i < 2100000000; i++) {
        s += i;
    }
    sw.stop();
    long long trajanje = sw.get_elapsed_milliseconds();
    cout << "Trajanje " << trajanje << " ms" << endl;
    return 0;
}


## ogledni 
- [I3 b](#i3b)
```
(Bodova: 7) Kreirajte kontejner od 10 slučajnih brojeva između 1 i 100. 
Pitajte korisnika da odabere smjer kojim želi ispisati brojeve (ASC ili DESC). 
Koristeći hrpu ili prioritetni red (prema želji), ispišite brojeve u zadanom smjeru.
```

## V9
- [V9 Z1-2](#v9z1-2)
```
1., 2. Napravite 2 vektora od 10 slučajnih brojeva između 1 i 100 i onda:
- Ispišite sve brojeve iz prvog vektora.
- Uredite vektor tako da ima svojstva hrpe (funkcija make_heap) pa ispišite sve brojeve.
- Uklonite sve brojeve iz hrpe koristeći funkciju pop_heap (i ostalo što vam treba). 
Nakon svakog uklonjenog broja ispišite sadržaj hrpe

- Napravite prioritetni red i u njega ubacite sve brojeve iz drugog vektora.
- Učitavajte od korisnika brojeve dok on to želi i dodajte ih u prioritetni red.
- Ispišite sve brojeve iz prioritetnog reda.
```
- [V9 Z3-4](#v9z3-4)
```
3., 4. vektora od 10 slučajnih brojeva između 1 i 100
- ispisite brojeve iz pqa od manjih prema vecima(minheap) ugradenim komparatorom
- ispisite brojeve iz pqa od manjih prema vecima vlastitim komparatorom
```

- [V9 Z5](#v9z5)
```
5. Napravite program koji koristi prioritetni red za obradu zaprimljenih poruka 
prema prioritetima (1 = minimalni, 2 = normalni, 3 = visoki prioritet). Zaprimite 
nekoliko poruka pa ih obradite ispisivanjem na ekran.
```
- [V9 Z7](#v9z7)
```
program koji koristi prioritetni red ili hrpu i ispisuje sve osobe iz item csv 
od visih idneksa tjelesne mase prema manje. prva i zadnja dva stupca su useless
```

## V11
- [V11 Z1](#v11z1)
```
Implementirajte varijantu bogosorta kojom rastuće sortiranje radite tako da prolazite sve permutacije.
```
- [V11 Z2](#v11z2)
```
Učitajte prvih 20.000 slučajnih brojeva iz datoteke puno_brojeva1.txt u program. 
Primijenite bubble, insertion, selection, shell i merge iz priloga na brojeve iz 
datoteke i ispišite za svaki koliko je trajao.
```
- [V11 Z5](#v11z5)
```
Promijenite selectionsorttako da sortira pravokutnike (širina, visina) prema površini. 
Učitajte svih 1000 pravokutnika iz pravokutnici.txt (u svakom retku su širina i visina 
jednog pravokutnika odvojeni razmakom) i prepišite ih u drugu datoteku, ali sortirano.
```


## V12
- [V12 Z2](#v12z2)
```
Generirajte vektor od razbacanih brojeva od 1 do 100. Sortirajte ga na tri načina te 
rezultate sortiranja zapišite u datoteke:
a)Rastuće
b)Padajuće
c)Tako da prvo dođu parni onda neparni (rjeseno sortiranjem trebalo bi particioniranjem)
```
- [V12 Z3](#v12z3)
```
program koji sortira riječi iz datoteke osobe.txt na način da prvo dođu kraće, a onda 
dulje riječi. Riječi jednake duljine ostavite u jednakom redoslijed u kakvom su u zadanoj
datoteci.
```
- [V12 Z](#v12z4)
```
Napišite program koji ispisuje sva svemirska tijela iz datoteke SolarSystem.csv tako da 
za svako od njih ispiše naziv, tip te koliko zemaljskih godina treba dok obiđe oko sunca.
Planete ispišite redoslijedom od najbliže Suncu do najudaljenije.
```
- [V12 Z10](#v12z10)
```
Napišite program koji omogućuje pretraživanje datoteke puno_malih_brojeva1.txt na način 
da pitate korisnika koji broj želi tražiti, a onda mu vi ispišete ima li tog broja ili 
nema. Optimizirajte rješenje u svrhu pretraživanja.
```

## V13
- [V13 Z1](#v13z1)
```
Uzmite sve brojeve od 1 do milijun, promiješajte ih i smjestite u vlastitu minimalnu 
implementaciju tablice s direktnim adresiranjem. Ključ neka bude broj, a vrijednost njegov 
kvadrat. Omogućite korisniku da upiše broj pa izračunajte i ispišite koliko treba vremena za 
pronalazak.
```
- [V13 Z](#v13z3)
```
Promijenite prethodni zadatak tako da koristite hashfunkciju h(key) = key mod 100003 (prosti 
broj otprilike 10 puta manji od broja ključeva) i optimizirate veličinu polja. Konflikte 
nemojte razrješavati već samo pregazite staru vrijednost. Na kraju ispišite koliko konflikata 
se dogodilo.
```
- [V13 Z](#v13z4)
```
Promijenite prethodni zadatak tako da konflikte razrješavate ulančavanjem. Ispišite u posebnu
datoteku stanje hashtablice (redni broj bucketate broj ključeva koji se nalaze u njemu).
```
- [V13 Z](#v13z5)
```
za predhodni zadatak omogućite korisniku da upiše broj pa izračunajte i ispišite 
koliko treba vremena za pronalazak
```


## V14
- [V14 Z1](#v14z1)
```
a.Napravite unordered_maps cjelobrojnim ključem koja može čuvati stringove.
b.Ubacite proizvoljne vrijednosti za ključeve 1, 2, 3, 4 i 5.
c.Učitajte od korisnika ključ pa ili ispišite vrijednost pod tim ključem 
     ili napišite da ključ ne postoji.
d.Prepišite sve neparne ključeve i injihove vrijednosti u unordered_multimap.
e.Ispišite sve iz multimape.
f.Prepišite sve vrijednosti s više od 3 znaka u unordered_set.
g.Uklonite prvu vrijednost iz seta.
h.Prepišite sve vrijednosti u unordered_multisetiispišiteih
i.Pobrišite sve iz multiseta.
```
- [V14 Z3](#v14z3)
```
Napišite program koji kreira unordered_setcijelih brojeva. 
Sve dok korisnik to želi, ubacujte u set 20 brojeva, počevši od 1. 
Nakon svakog ubacivanja ispišite sve bucketei pokraj svakog u 
zagradi broj elemenata hashiranihu  njega.

```
- [V14 Z4](#v14z4)
```
Napišite program koji u unordered_setubacuje 1000 slučajnih 
stringova duljine 5 znakova i sastavljenih od slova ‘a’, ‘b’, ‘c’, ‘d’ i ‘e’. 
Ispišite svaki put kad se ubacivanje ne napravi jer vrijednost već postoji.
```
- [V14 Z5](#v14z5)
```
Uzmite sve brojeve od 1 do milijun, promiješajte ih i smjestite u 
set i unordered_set. Ispišite koliko je trajalo umetanje u svaki kontejner. 
Nakon toga pitajte korisnika koji broj traži pa ispišite trajanje 
traženja u svakom od kontejnera.
```

- [V14 Z6](#v14z6)
```
Koristeći prikladnu hashtablicu, ispišite u novu datoteku koliko je kojeg 
imena ukupno bilo u 1901. i 2001. Primjer ispisa: Mary, 18936
```

- [V14 Z7](#v14z7)
```
Koristeći prikladnu hashtablicu, ispišite sva imena iz 1901. kojih nije 
više bilo 2001.

```

------------------------

i3b
-----
```cpp
#include <iostream>
#include <ctime>
#include <queue>
using namespace std;

int main(){
	srand(time(nullptr));
    priority_queue<int, vector<int>, greater<int>> pqAsc;
    priority_queue<int> pqDesc;
    
	char choice; cout << "smjer (a/d)? "; cin>>choice;
	switch (choice){
	case 'a':
		for (unsigned i = 0; i<10; ++i) pqAsc.push((rand()%100)+1);
        while(!pqAsc.empty()){
            std::cout << pqAsc.top() << " ";
            pqAsc.pop();
		}
		break;
	case 'd':
		for (unsigned i = 0; i<10; ++i) pqDesc.push((rand()%100)+1);
        while(!pqDesc.empty()){
            std::cout << pqDesc.top() << " ";
            pqDesc.pop();
		}
		break;
	default:
		cout << "bad choice";
		break;
	}
}
```

v9z1-2
--------------

```cpp

#include <iostream>
#include <ctime>
#include <vector>
#include <algorithm>
using namespace std;

int generate_random(int min, int max) {
    return rand() % (max - min + 1) + min;
}

vector<int> seed(unsigned n, int min, int max) {
    srand(time(nullptr));
    vector<int> v;
    for (unsigned i = 0; i < n; i++)
        v.push_back(generate_random(min, max));
    return v;
}

void print(vector<int> &v){
    for (int n : v)
        cout << n << " ";
    cout << endl;
}

void insert(vector<int> &v) {
    bool dalje; int n;
    do {
        cout << "Unesite broj: ";
        cin >> n;
        v.push_back(n);
        push_heap(v.begin(), v.end());
        cout << "Dalje (1=da, 0=ne): ";
        cin >> dalje;
    } while (dalje);
}

int main(){
    vector<int> numbers = seed(10, 1, 100);
    vector<int> numbers2 = seed(10, 1, 100);

    print(numbers); //before heap
    make_heap(numbers.begin(), numbers.end()); //heap properties
    print(numbers); //after heap
    while (numbers.size() > 0) {
        cout << numbers.front() << " - ";
        pop_heap(numbers.begin(), numbers.end());
        numbers.pop_back();
        print(numbers);
    }

    priority_queue<int> pq(numbers2.begin(), numbers2.end());
    insert(pq);
    while (!pq.empty()){
        cout << pq.top() << " ";
        pq.pop();
    }
}
```



v9z3-4
--------------
```cpp
#include <iostream>
#include <ctime>
#include <queue>
#include <functional>
using namespace std;

int generate_random(int min, int max);

struct int_comparer {
    bool operator()(const int &i1, const int &i2) const{
        return i1 > i2;
    }
};

// za vlastiti comparator ...t>, int_comparer> seed(...
priority_queue<int, vector<int>, greater<int>> seed(unsigned n, int min, int max){
    srand(time(nullptr));
    // za vlastiti comparator ...t>, int_comparer> pq;
    priority_queue<int, vector<int>, greater<int>> pq;
    for (unsigned i = 0; i < n; i++)
        pq.push(generate_random(min, max));
    return pq;
}

int main()
{
    // za vlastiti comparator ...t>, int_comparer> pq = ...
    priority_queue<int, vector<int>, greater<int>> pq = seed(10, 1, 100);
    while (!pq.empty()){
        cout << pq.top() << " ";
        pq.pop();
    }
}
```

v9z5
--------------
```cpp
#include <iostream>
#include <ctime>
#include <queue>
#include <string>
using namespace std;

struct message {
	string text;
	int priority;
	message(string text, int priority) {
		this->text = text;
		this->priority = priority;
	}
};

struct message_comparer_asc {
	bool operator() (const message &m1, message const &m2) const {
		return m1.priority > m2.priority;
	}
};

int main(){
	priority_queue<message, vector<message>, message_comparer_asc> pq;

	pq.push(message("Kupi kruh", 2));
	pq.push(message("Pokupi punicu", 3));
	pq.push(message("Nauci raditi s hrpom", 1));

	while (!pq.empty()) {
		cout << pq.top().text << "(" << pq.top().priority << ")" << endl;
		pq.pop();
	}
}
```

v9z7
--------------
```cpp
#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <cmath>
#include <queue>
using namespace std;
template <typename T> T convert(string &s) { stringstream c(s); T t; c >> t; return t;}

/*itemcsv
,sex,weight,height,repwt,repht
1,M,77,182,77,180
2,F,58,161,51,159
3,F,53,161,54,158 */

class Person{
	std::string gender;
	int weight, height;
public:
	Person(std::string gender, int weight, int height):gender(gender),weight(weight),height(height){};
	std::string to_string() const{
		std::stringstream ss;
		ss << "ibm: " << ibm() << ", gender: " << gender << ", weight: " << weight << ", height: " << height;
		return ss.str();
	}
	double ibm() const{
		return weight / pow(height/100.0, 2);
	}
};

struct person_ibmcomparer_desc{
	bool operator() (const Person &p1, const Person &p2) const{
		return p1.ibm() < p2.ibm();
	}
};

void load(ifstream &in, priority_queue<Person, vector<Person>, person_ibmcomparer_desc> &pq){
	string line; getline(in, line); //skip header
	while (getline(in, line)){
		stringstream ss(line);
		string temp; getline(ss, temp, ','); //skip column;
		string gender; getline(ss, gender, ',');
		getline(ss, temp, ',');
		int weight = convert<int>(temp);
		getline(ss, temp, ',');
		int height = convert<int>(temp);
		pq.emplace(gender, weight, height);
	}
}
int main(){
	ifstream in("itm.csv");
	if (!in) return 1;

	priority_queue<Person, vector<Person>, person_ibmcomparer_desc> pq;
	load(in, pq);
	in.close();

	while (!pq.empty()){
		cout << pq.top().to_string() << endl;
		pq.pop();
	}
}
```

v11z1
--------------
```cpp
#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;

bool is_sorted_ascending(vector<int>& v){
	for (unsigned i = 0; i < v.size() - 1; i++) 
		if (v[i] > v[i + 1]) return false;
	return true;
}

void print(vector<int> &v){for (int n : v) cout << n << " "; cout << endl;}

int main(){
	vector<int> v{ 9, 8, 1, 3, 6, 2, 4, 10, 5, 7};

	//1. nacin - vlastita funkcija za provjeru je li vektor sortiran rastuce
	//while (!is_sorted_ascending(v)) {next_permutation(v.begin(), v.end());}

	//2. nacin - ugradjena funkcija za provjeru je li vektor sortiran rastuce
	//while (!is_sorted(v.begin(), v.end())) {next_permutation(v.begin(), v.end());}

	//3.nacin - next_permutation:
	// - vraca true ako moze presloziti elemente u vecu leksikografsku permutaciju (desc)
	// - vraca false ako trenutna permutacija nije veca od prethodne, vec je namanja moguca (asc)
	//funkciju za provjeru niti ne trebamo	
	while (next_permutation(v.begin(), v.end()));
	print(v);

	//dodatak - prev_permutation - inverzna logika
	while (prev_permutation(v.begin(), v.end()));
	print(v);
}
```

v11z2
--------------
```cpp
#include <iostream>
#include <string>
#include <fstream>
#include <chrono>
#include <functional>
#include "bubble_sort.h"
#include "selection_sort.h"
#include "insertion_sort.h"
#include "shell_sort.h"
#include "merge_sort.h"
using namespace std;

void load(ifstream &in, int *originalni_brojevi, int *radno_polje, const int BROJ_ELEMENATA){
	for (int i = 0; i < BROJ_ELEMENATA; i++){
		in >> originalni_brojevi[i];
		radno_polje[i] = originalni_brojevi[i];
	}
}

void copy_array(int* originalni_brojevi, int* radno_polje, const int BROJ_ELEMENATA)
	for (int i = 0; i < BROJ_ELEMENATA; i++) radno_polje[i] = originalni_brojevi[i];
}

void sort(int *radno_polje, const int BROJ_ELEMENATA, string tekst, function<void(int*, int)> funkcija){
	auto begin = chrono::high_resolution_clock::now();
	funkcija(radno_polje, BROJ_ELEMENATA);
	auto end = chrono::high_resolution_clock::now();
	cout << tekst << chrono::duration_cast<chrono::milliseconds>(end - begin).count() << " ms" << endl;
}

int main(){
	ifstream in("puno_brojeva3.txt"); if (!in) return 1;

	const int BROJ_ELEMENATA = 20000;
	int* originalni_brojevi = new int[BROJ_ELEMENATA];
	int* radno_polje = new  int[BROJ_ELEMENATA];

	load(in, originalni_brojevi, radno_polje, BROJ_ELEMENATA);
	in.close();

	// Bubble sort.
	sort(radno_polje, BROJ_ELEMENATA, "Bubble sort:", bubble_sort);

	// Selection sort.
	copy_array(originalni_brojevi, radno_polje, BROJ_ELEMENATA);
	sort(radno_polje, BROJ_ELEMENATA, "Selection sort:", selection_sort);

	// Insertion sort.
	copy_array(originalni_brojevi, radno_polje, BROJ_ELEMENATA);
	sort(radno_polje, BROJ_ELEMENATA, "Insertion sort:", insertion_sort);

	// Shell sort.
	copy_array(originalni_brojevi, radno_polje, BROJ_ELEMENATA);
	sort(radno_polje, BROJ_ELEMENATA, "Shell sort:", shell_sort);

	//Merge sort.
	copy_array(originalni_brojevi, radno_polje, BROJ_ELEMENATA);
	sort(radno_polje, BROJ_ELEMENATA, "Merge sort:", merge_sort);

	delete[] originalni_brojevi;
	delete[] radno_polje;
}
```

v11z5
--------------
```cpp
#include <iostream>
#include <fstream>
using namespace std;

struct pravokutnik { int a,b;};

void selection_sort(pravokutnik data[], int n) {
	for (int i = 0; i < n - 1; i++) {
		int min_index = i;
		for (int j = i + 1; j < n; j++)
			if (data[j].a * data[j].b < data[min_index].a * data[min_index].b)
				min_index = j;
		swap(data[min_index], data[i]);
	}
}

void load(ifstream &in, pravokutnik *pravokutnici, const int BROJ_ELEMENATA) {
	for (int i = 0; i < BROJ_ELEMENATA; i++) {
		in >> pravokutnici[i].a; in >> pravokutnici[i].b;
	}
}

int main() {
	ifstream in("pravokutnici.txt");
	ofstream out("pravokutnici_sortirano.txt");
	if (!in || !out) return 1;
	const int BROJ_ELEMENATA = 1000;

	pravokutnik* pravokutnici = new pravokutnik[BROJ_ELEMENATA];
	load(in, pravokutnici, BROJ_ELEMENATA);
	in.close();

	selection_sort(pravokutnici, BROJ_ELEMENATA);
	for (int i = 0; i < BROJ_ELEMENATA; i++) 
		out << pravokutnici[i].a << " " << pravokutnici[i].b << endl;

	out.close();
	delete[] pravokutnici;
}
```

v12z2
--------------
```cpp
#include <iostream>
#include <fstream>
#include <string>
#include <ctime>
#include <vector>
#include <algorithm>
using namespace std;

void prepare_vector(vector<int> &v, int n) {
	for (int i = 1; i <= n; i++) v.push_back(i);
	random_shuffle(v.begin(), v.end());
}

void write(ofstream &out, vector<int> v) {
	for (int n : v) out << n << endl;
}

bool sort_desc(int a, int b) {
	return a > b;
}

bool sort_even_first(int a, int b) {
	return a % 2 == 0 && b % 2 == 1;
}

int main() {
	ofstream out1("rastuci.txt");
	ofstream out2("padajuci.txt");
	ofstream out3("parni_neparni.txt");
	if (!out1 || !out2 || !out3) return 1;

	srand(unsigned(time(nullptr)));
	vector<int> original;
	prepare_vector(original, 100);

	// a)
	vector<int> v(original);
	sort(v.begin(), v.end());
	write(out1, v);

	// b)
	v.assign(original.begin(), original.end());
	sort(v.begin(), v.end(), sort_desc);
	write(out2, v);

	// c) primjer sa stable sortom - ostaviti sortirani vektor padajuce	
	stable_sort(v.begin(), v.end(), sort_even_first);
	write(out3, v);

	out1.close();out2.close();out3.close();return 0;
}
```

v12z3
--------------
```cpp
#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include <fstream>
using namespace std;

void load(ifstream &in, vector<string> &v) {
	string ime;
	while (getline(in, ime)) v.push_back(ime);
}

void print(vector<string> &v) {for (string s : v)cout << s << endl;}

bool sort_by_length(string a, string b) {return a.length() < b.length();}

int main() {	
	ifstream in("osobe.txt"); if (!in) return -1;

	vector<string> osobe; load(in, osobe); in.close();
	stable_sort(osobe.begin(), osobe.end(), sort_by_length);
	print(osobe);
}
```

v12z4
--------------
```cpp
#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <vector>
#include <algorithm>
using namespace std;

struct celestial_body {
	string name,type;
	double mean_distance_from_sun_au,orbital_period_years,rotation_period_days,mean_temperature_c;
};

template<typename T> T convert(string &s) {
	stringstream c(s);T t;c >> t;return t;
}

void load(ifstream &in, vector<celestial_body> &v){
    //parsing
	v.push_back(body);
}

void print(celestial_body &body){
	cout << "(d=" << body.mean_distance_from_sun_au << ") " << body.name << ", " << body.type << ", godina traje: " << body.orbital_period_years << endl;
}

bool sort_by_distance(celestial_body &a, celestial_body &b) {
	return a.mean_distance_from_sun_au < b.mean_distance_from_sun_au;
}

int main() {
	ifstream in("Solar System.csv");
	if (!in) return -1;

	vector<celestial_body> bodies;
	load(in, bodies);in.close();

	sort(bodies.begin(), bodies.end(), sort_by_distance);
	for_each(bodies.begin(), bodies.end(), print);
}
```

v12z10
--------------
```cpp
#include <iostream>
#include <fstream>
#include <vector>
#include <algorithm>
using namespace std;

void load(ifstream& in, vector<int> &v){int n; while (in >> n) v.push_back(n);}

void search(vector<int> &v){
	bool dalje; int upit;
	do {
		cout << "Upisite broj koji zelite traziti: ";
		cin >> upit;

		if (binary_search(v.begin(), v.end(), upit)) 
			cout << "Broj " << upit << " postoji" << endl;
		else 
			cout << "Broj " << upit << " ne postoji" << endl;
		
		cout << "Dalje (1=da, 0=ne): ";
		cin >> dalje;
	} while (dalje);
}

int main() {
	ifstream in("puno_malih_brojeva1.txt"); if (!in) return 1;
	vector<int> brojevi;

	load(in, brojevi);in.close();

	sort(brojevi.begin(), brojevi.end());
	search(brojevi);
}
```

v13z1
--------------
```cpp
#include <iostream>
#include <fstream>
#include <vector>
#include <ctime>
#include <algorithm>
#include <chrono>
using namespace std;

class direct_addressing_table {
unsigned long long* array;
public:
	direct_addressing_table(unsigned n) {array = new unsigned long long[n];}
	void insert(int key, unsigned long long value) {array[key] = value;}
	unsigned long long search(int key) {return array[key];}
	~direct_addressing_table() {delete[] array;}
};

void prepare_vector(vector<int> &v, int n){
	for (int i = 1; i <= n; i++)v.push_back(i);
	random_shuffle(v.begin(), v.end());
}

void load_table(direct_addressing_table &table, int n, vector<int> &v){
	for (int i = 0; i < n; i++) table.insert(v[i], v[i] * v[i]);
}

void search(direct_addressing_table &table, int n){
	auto begin = chrono::high_resolution_clock::now();
	unsigned long long rez = table.search(n);
	auto end = chrono::high_resolution_clock::now();
	cout << rez << endl;
	cout << "Vrijeme: " << chrono::duration_cast<chrono::nanoseconds>(end - begin).count() << " ns" << endl;
}

int main() {
	srand(unsigned(time(nullptr)));
	vector<int> v;
	const unsigned BROJ_ELEMENATA = 1000000;
	prepare_vector(v, BROJ_ELEMENATA);	

	direct_addressing_table table(BROJ_ELEMENATA + 1);
	load_table(table, BROJ_ELEMENATA, v);

	int n; cout << "Upisite broj: "; cin >> n;
	search(table, n);
}
```

v13z3
--------------
```cpp
class hash_table {
private:
	const int M = 100003;
	unsigned long long* array;
	int h(int key);
	int nr_conflicts = 0;
public:
	hash_table();
	void insert(int key, unsigned long long value);
	unsigned long long search(int key);
	int get_nr_conflicts();
	~hash_table();
};

int hash_table::h(int key) {
	return key % M;
}

hash_table::hash_table() {
	array = new unsigned long long[M] {0};
}

void hash_table::insert(int key, unsigned long long value) {
	int slot = h(key);
	if (array[slot] != 0) nr_conflicts++;
	array[slot] = value;
}

unsigned long long hash_table::search(int key) {
	return array[h(key)];
}

int hash_table::get_nr_conflicts() {
	return nr_conflicts;
}

hash_table::~hash_table() {
	delete[] array;
}
```

v13z4
--------------
```cpp
#include <list>
using namespace std;

struct entry 
{
	int key;
	unsigned long long value;
	entry(int key, unsigned long long value) 
	{
		this->key = key;
		this->value = value;
	}
};

class hash_table 
{
private:
	const int M = 100003;
	list<entry>* array;
	int h(int key);
public:
	hash_table();
	void insert(int key, unsigned long long value);
	unsigned long long search(int key);
	int get_buckets();
	int get_elements_in_bucket(int n);
	~hash_table();
};

int hash_table::h(int key) {
	return key % M;
}

hash_table::hash_table() {
	array = new list<entry>[M];
}

void hash_table::insert(int key, unsigned long long value) {
	int slot = h(key);
	array[slot].push_back(entry(key, value));
}

unsigned long long hash_table::search(int key) {
	int slot = h(key);
	for (auto it = array[slot].begin(); it != array[slot].end(); ++it) 
		if (it->key == key) return it->value;
	return 0;
}

int hash_table::get_buckets() {
	return M;
}

int hash_table::get_elements_in_bucket(int n) {
	return array[n].size();
}

hash_table::~hash_table() {
	delete[] array;
}
//main
void write(ofstream &out, hash_table &table){
	for (int i = 0; i < table.get_buckets(); i++) 
		out << "Bucket " << i << ": " << table.get_elements_in_bucket(i) << " elements" << endl;
}
```

v13z5
--------------
```cpp
#include <chrono>
void search(hash_table &table, int n){
	auto start = chrono::high_resolution_clock::now();
	unsigned long long rez = table.search(n);
	auto end = chrono::high_resolution_clock::now();
	cout << rez << endl;
	cout << "Vrijeme: "<< chrono::duration_cast<chrono::nanoseconds>(end - start).count()<< " ns" << endl;
}
int n;cout << "Upisite broj: ";cin >> n;
search(table, n);
```

v14z1
--------------
```cpp
#include <iostream>
#include <string>
#include <unordered_map>
#include <unordered_set>

using namespace std;

void fill_map(unordered_map<int, string> &m) {
	m.insert(pair<int, string>(1, "Zec"));
	m.insert({ 2, "Zaba" });
	m.insert({ { 3, "Tramvaj" }, { 4, "Slon" }, { 5, "Avion" } });
}

void search_map(unordered_map<int, string> &m){
	int key; cout << "Unesite kljuc:"; cin >> key;
	auto it = m.find(key);
	(it != m.end()) ? cout << "Nadjen je kljuc:"  << it->first << ": " << it->second << endl : cout << "Nema trazenog kljuca" << endl;
}

void fill_multimap(unordered_map<int, string> &m, unordered_multimap<int, string> &mm){
	for (auto it = m.begin(); it != m.end(); ++it)
		if (it->first % 2 != 0)
			mm.insert(*it);//mm.insert({ it->first, it->second });
}

void print_multimap(unordered_multimap<int, string> &mm){
	cout << "multimap:" << endl;
	for (auto it = mm.begin(); it != mm.end(); ++it)
		cout << it->first << ": " << it->second << endl;
}

void fill_set(unordered_multimap<int, string> &mm, unordered_set<string> &s){
	for (auto it = mm.begin(); it != mm.end(); ++it)
		if (it->second.length() > 3) s.insert(it->second);
}

void fill_multiset(unordered_set<string> &s, unordered_multiset<string> &ms){
	//for (auto it = s.begin(); it != s.end(); ++it) ms.insert(*it);
	ms.insert(s.begin(), s.end());
}

void print_multiset(unordered_multiset<string> &ms){
	cout << "multiset:" << endl;
	for (auto it = ms.begin(); it != ms.end(); ++it) cout << *it << endl;
}

int main() {
	unordered_map<int, string> m;//a.
	fill_map(m);  //b.
	search_map(m);//c.
	unordered_multimap<int, string> mm; //d.
	fill_multimap(m, mm);
	print_multimap(mm);//e.
	unordered_set<string> s;//f.
	fill_set(mm, s);
	s.erase(s.begin());//g.
	unordered_multiset<string> ms;//h.
	fill_multiset(s, ms);
	print_multiset(ms);
	ms.clear();//i.
}
```

v14z3
--------------
```cpp
#include <iostream>
#include <unordered_set>
using namespace std;

int main(){
	unordered_set<int> set;
	int current = 1, limit = 20; bool dalje;
	do{
		while (current <= limit) set.insert(current++);
		limit += 20;
		for (unsigned i = 0; i < set.bucket_count(); i++)
			cout << "Bucket: " << i << ": " << set.bucket_size(i) << " elemenata" << endl;

		cout << "Dalje (1=da, 0=ne): ";cin >> dalje;system("cls");
	} while (dalje);
}
```

v14z4
--------------
```cpp
	srand(time(nullptr));
	unordered_set<string> set;
	string s = "abcde";
	int coll = 0;
	for (int i = 0; i < 1000; i++){
		random_shuffle(s.begin(), s.end());
		//pair<unordered_set<string>::iterator, bool> retval = set.insert(s);
		auto retval = set.insert(s);
		if (!retval.second)
			cout << "iteracija: "<< i << ",  broj kolizija: " << ++coll << endl;
	}
```

v14z5
--------------
```cpp
#include <iostream>
#include <vector>
#include <algorithm>
#include <set>
#include <unordered_set>
#include <chrono>
#include <ctime>
using namespace std; using namespace std::chrono;

void prepare_vector(vector<int> &v, const int N) {
	for (int i = 0; i < N; i++) v.push_back(i);
}

template<typename T>
void measure_insert(vector<int> &v, T t) {
	auto begin = high_resolution_clock::now();
	for (int n : v) t.insert(n);
	auto end = high_resolution_clock::now();
	cout << "Vrijeme: " << duration_cast<chrono::milliseconds>(end - begin).count() << " ms" << endl;
}

template<typename T>
void measure_search(T t, int query){
	auto begin = high_resolution_clock::now();
	t.find(query);
	auto end = high_resolution_clock::now();
	cout << "Vrijeme: " << duration_cast<chrono::microseconds>(end - begin).count() << " us" << endl;
}

int main(){
	srand(time(nullptr));
	const int N = 1000000;
	vector<int> v;
	prepare_vector(v, N);

	set<int> set; cout << "Umetanje u set:" << endl; measure_insert(v, set);
	unordered_set<int> uset; cout << "Umetanje u unordered set:" << endl; measure_insert(v, uset);

	int query; cout << "Koji broj zelite pronaci: "; cin >> query;
	cout << "Pretraga u setu:" << endl; measure_search(set, query);
	cout << "Pretraga u unordered setu:" << endl; measure_search(uset, query);
}
```

v14z6
--------------
```cpp
#include <iostream>
#include <string>
#include <fstream>
#include <sstream>
#include <unordered_map>
using namespace std;
template<typename T>T convert(string &s){stringstream c(s);T t;c >> t;return t;}

void load(ifstream &in, unordered_map<string, int> &m){
	string line;
	while (getline(in, line)) {
		stringstream ss(line); string key; getline(ss, key, ',');

		string temp;getline(ss, temp, ',');

		getline(ss, temp);
		int value = convert<int>(temp);
		m[key] += value;
	}
}

void write(ofstream &out, unordered_map<string, int> &m){
	for (auto it = m.begin(); it != m.end(); ++it) out << it->first << ", " << it->second << endl;
}


int main()
{
	ifstream in1("yob1901.txt");ifstream in2("yob2001.txt");
	ofstream out("yobSuma.txt");
	if (!in1 || !in2 || !out) cout << "Nije moguce pristupiti datotekama" << endl;

	unordered_map<string, int> m;
	load(in1, m);load(in2, m);
	in1.close();in2.close();

	write(out, m);out.close();
}
```

v14z7
--------------
```cpp
void print_nonexistent(ifstream &in, unordered_set<string> &s){
	int n = 1;
	string line;
	while (getline(in, line)){
		stringstream ss(line);
		string key;
		getline(ss, key, ',');
		if (s.find(key) == s.end()) cout << n++ << ": " << key << endl;
	}
}
int main(){
	...
	unordered_set<string> s;
	load(in1, s); in1.close();
	print_nonexistent(in2, s);
	in2.close();
```

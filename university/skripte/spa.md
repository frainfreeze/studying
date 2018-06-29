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
- [V11 Z](#v11z)
- [V11 Z](#v11z)
- [V11 Z](#v11z)
- [V11 Z](#v11z)

```
```

## V12
- [V12 Z](#v12z)
- [V12 Z](#v12z)
- [V12 Z](#v12z)
- [V12 Z](#v12z)

```
```

## V13
- [V13 Z](#v13z)
- [V13 Z](#v13z)
- [V13 Z](#v13z)
- [V13 Z](#v13z)

```
```

## V14
- [V14 Z](#v14z)
- [V14 Z](#v14z)
- [V14 Z](#v14z)
- [V14 Z](#v14z)

```
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

vz
--------------
```cpp

```

vz
--------------
```cpp

```

vz
--------------
```cpp

```

vz
--------------
```cpp

```

vz
--------------
```cpp

```

vz
--------------
```cpp

```

vz
--------------
```cpp

```

vz
--------------
```cpp

```

vz
--------------
```cpp

```

vz
--------------
```cpp

```

vz
--------------
```cpp

```

vz
--------------
```cpp

```

vz
--------------
```cpp

```

vz
--------------
```cpp

```

vz
--------------
```cpp

```

vz
--------------
```cpp

```

vz
--------------
```cpp

```

vz
--------------
```cpp

```

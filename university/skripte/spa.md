## V9

- [V9 Z1-2](#v9z1-2)
- [V9 Z3-4](#v9z3-4)
- [V9 Z5](#v9z5)
- [V9 Z](#)

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



```
3., 4. vektora od 10 slučajnih brojeva između 1 i 100
- ispisite brojeve iz pqa od manjih prema vecima(minheap) ugradenim komparatorom
- ispisite brojeve iz pqa od manjih prema vecima vlastitim komparatorom
```

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
```
5. Napravite program koji koristi prioritetni red za obradu zaprimljenih poruka 
prema prioritetima (1 = minimalni, 2 = normalni, 3 = visoki prioritet). Zaprimite 
nekoliko poruka pa ih obradite ispisivanjem na ekran.
```

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

## V10

```

```

```cpp

```

```

```

```cpp

```

```

```

```cpp

```

```

```

```cpp

```

```

```

```cpp

```

```

```

```cpp

```

```

```

```cpp

```

```

```

```cpp

```

```

```

```cpp

```

```

```

```cpp

```

```

```

```cpp

```

```

```

```cpp

```

```

```

```cpp

```

```

```

```cpp

```

```

```

```cpp

```

```

```

```cpp

```


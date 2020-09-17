#include <iostream>
using namespace std;

//

int main()
{		
	cout << "Program racuna srednju ocjenu uspjeha ucenika." << endl;
	cout << "Nakon posljednje ocjene unosi se 0." << endl;

    float ocjena,zbrojOcjena,brojUnesenihOcjena;
	zbrojOcjena = 0;
	brojUnesenihOcjena = 0;

    do
	{
        cout << "Unesi ocjenu: ";
		cin >> ocjena;

		if(ocjena == 1)
		{
			cout << "Negativan uspjeh!" << endl;
			return 0;
		}
		else if(ocjena < 0 || ocjena > 5)
		{
			cout << "Pogresan unos." << endl;
			return 0;
		}
		else      
		{
			zbrojOcjena += ocjena;
			if(ocjena != 0)
				brojUnesenihOcjena++;
		}
	}

	while(ocjena > 0);
    cout << "Srednja ocjena uspjeha je " << zbrojOcjena / brojUnesenihOcjena << endl;

	return 0;
}
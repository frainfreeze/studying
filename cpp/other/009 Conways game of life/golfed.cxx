%:include <iostream>
%:include <bitset>
%:include <ctime>
%:include <chrono>
%:include <thread>
std::bitset<800> field;
int main() <%
	srand(static_cast<unsigned int>(time(nullptr)));
	for (unsigned int i = 0; i < field.size(); ++i) if (!(rand() % 4)) field[i] = true;
	loop:
		std::this_thread::sleep_for(std::chrono::milliseconds(250));
		std::bitset<800> nxtField;
		for (struct {int i, neighbours;} a={0,0}; a.i <  field.size(); ++a.i) <% 
			!(a.i % 40) ? std::cout << "\n" : field[a.i] ? std::cout << "#" : std::cout << " ";
			a.neighbours += (a.i > 40  && field[a.i - 41]);
			a.neighbours += (a.i > 39  && field[a.i - 40]);
			a.neighbours += (a.i > 38  && field[a.i - 39]);
			a.neighbours += (a.i > 0   && field[a.i - 1]);
			a.neighbours += (a.i < 799 && field[a.i + 1]);
			a.neighbours += (a.i < 761 && field[a.i + 39]);
			a.neighbours += (a.i < 760 && field[a.i + 40]);
			a.neighbours += (a.i < 759 && field[a.i + 41]);
			a.neighbours < 2 || a.neighbours > 3 ? nxtField[a.i] = false : (a.neighbours == 3) || (field[a.i] == 1 && a.neighbours == 2) ?  nxtField[a.i] = true : true;
			a.neighbours=0;
		%>  field = nxtField;
	goto loop;
%>
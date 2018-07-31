#ifndef COMPLEXNUMBER_H_
#define COMPLEXNUMBER_H_

#include <string>
#include <sstream>

class ComplexNumber {
public:
	ComplexNumber();
	ComplexNumber(int real, int imaginary);
	ComplexNumber(ComplexNumber k1, ComplexNumber k2);

	void set_real(int real);
	void set_imaginary(int imaginary);

    int get_real();
    int get_imaginary();
	std::string get();

private:
	int real;
	int imaginary;
};

#endif // COMPLEXNUMBER_H_

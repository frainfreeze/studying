#include "ComplexNumber.h"

ComplexNumber::ComplexNumber(){}

ComplexNumber::ComplexNumber(int real, int imaginary):
	real(real),
	imaginary(imaginary)
	{}

ComplexNumber::ComplexNumber(ComplexNumber k1, ComplexNumber k2):
    real(k1.get_real() + k2.get_real()),
	imaginary(k1.get_imaginary() + k2.get_imaginary())
	{}


void ComplexNumber::set_real(int real) {this->real=real;}

void ComplexNumber::set_imaginary(int imaginary) {this->imaginary=imaginary;}


int ComplexNumber::get_real(){ return real;}

int ComplexNumber::get_imaginary(){ return imaginary;}

std::string ComplexNumber::get(){
	std::stringstream ss;
	if (imaginary < 0)
        ss <<"Rez = " << real << " - " << 0 <<"i";
	else
		ss <<"Rez = " << real << " + " << imaginary << "i";

	return ss.str();
}


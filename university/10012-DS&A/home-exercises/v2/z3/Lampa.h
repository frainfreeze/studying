#ifndef LAMPA_H_
#define LAMPA_H_
#include <string>

class Lampa {
public:
	Lampa();
	Lampa(const std::string model);
	std::string get_model() const;
	void set_model(const std::string model);
	std::string get_proizvodac() const;
	void set_proizvodac(const std::string proizvodac);
	int get_broj_sijalica() const;
	void set_broj_sijalica(const int broj_sijalica);
	double get_snaga() const;
	void set_snaga(const double snaga);
	std::string to_string() const;

private:
	std::string model;
	std::string proizvodac;
	int broj_sijalica;
	double snaga;
};

#endif //LAMPA_H_
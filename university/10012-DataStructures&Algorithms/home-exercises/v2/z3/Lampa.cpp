#include "Lampa.h"

#include <sstream>

Lampa::Lampa()
{
}

Lampa::Lampa(const std::string model)
{
	set_model(model);
}

std::string Lampa::get_model() const
{
	return model;
}

void Lampa::set_model(const std::string model)
{
	this->model = model;
}

std::string Lampa::get_proizvodac() const
{
	return proizvodac;
}

void Lampa::set_proizvodac(const std::string proizvodac)
{
	this->proizvodac = proizvodac;
}

int Lampa::get_broj_sijalica() const
{
	return broj_sijalica;
}

void Lampa::set_broj_sijalica(const int broj_sijalica)
{
	this->broj_sijalica = broj_sijalica;
}

double Lampa::get_snaga() const
{
	return snaga;
}

void Lampa::set_snaga(const double snaga)
{
	this->snaga = snaga;
}

std::string Lampa::to_string() const
{
	std::stringstream ss;
	ss
		<< "model: " << model
		<< ", proizvodac:" << proizvodac
		<< ", broj sijalica: " << broj_sijalica
		<< ", snaga: " << snaga << "W";
	return ss.str();
}



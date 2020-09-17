#ifndef PRAVOKUTNIK_H
#define PRAVOKUTNIK_H

class Pravokutnik {
private:
    int sirina;
    int visina;

public:
    void inicijaliziraj(int s, int v);

    void mnozi_skalarom(int skalar);

    int povrsina();

    int opseg();

    double dijagonala();

    void iscrtaj();
};

#endif // PRAVOKUTNIK_H

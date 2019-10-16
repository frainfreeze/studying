class Upitnik():
    """Skulja odgovore na upitnik"""
    def __init__(self, pitanje):
        """Pospremi pitanje i napravi pripremu za pospremanje odgovora"""
        self.pitanje = pitanje
        self.odgovori = []
        
    def prikazi_pitanje(self):
        """Prikazuje pitanje"""
        print(self.pitanje)
        
    def pohrani_odgovor(self, novi_odgovor):
        """Pospremi odgovor"""
        self.odgovori.append(novi_odgovor)
        
    def prikazi_rezultate(self):
        """Prikaži odgovore"""
        print("Rezultati:")
        for odgovor in self.odgovori:
            print('- ' + odgovor)
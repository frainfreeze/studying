def ime_prezime(ime, prezime, srednje=''):
    """Formatira ime i prezime."""
    if srednje:
        puno_ime = ime + ' ' + srednje + ' ' + prezime
    else:
        puno_ime = ime + ' ' + prezime
    return puno_ime.title()
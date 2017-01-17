# Upute za samostalni zadatak

Originalne datoteke nalaze se u mapama ```hrwac```, ```srwac.cyr``` te ```srwac.lat```. (to be added)

Jezičnu obradu tih datoteka radimo pomoću skripte ```tag_all.py``` koja poziva ReLDI servise i obrađuje sve datoteke s ekstenzijom ```.txt``` u danim mapama.

```
$ python tag_all.py hr hrwac
$ python tag_all.py sr srwac.cyr
$ python tag_all.py sr srwac.lat
```

Po jezičnoj obradi datoteka možemo crpiti željene varijable iz njih. To činimo pomoću skripte ```extract.py``` koja kao argumente prima mapu u kojoj se nalaze jezično obrađene datoteke te ime referentnog korpusa.

```
$ python extract.py hrwac hrwac
$ python extract.py srwac.cyr srwac
$ python extract.py srwac.lat srwac
```

Izlaz ovih skripti nalazi se u datotekama ```hrwac.out```, ```srwac.cyr.out``` te ```srwac.lat.out```. Potrebno je da sadržaj tih datoteka združite kopipejstanjem (other ideas?).

What follows is... RRRR!

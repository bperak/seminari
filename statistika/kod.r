################# 
# 1. DEO - UVOD #
#################

### Jednostavne operacije

4+5+6
sum(4,5,6)

### Vektori i drugi objekti. Uporedite:

o1 = 4+5+6
v1 = c(4,5,6)

o1*2
v1*2

## Unos naziva objekta daje njegovu vrednost

o1
v1

### Matematički i logički operatori

+ - * /
== > < >= <=

& 	# i
| 	# ili
! 	# negacija (!= znači 'nije jednako')

### Učitavanje eksternih dokumenata

## Provera radnog direktorijuma 

getwd()

## Na računarima u učionici trebalo bi da dobijete jedan od ovih foldera:
## "C:/Documents and Settings/Administrator/My Documents"
## "C:/Documents and Settings/Korisnik/My Documents"

## Napomena za Windows: putanje u Windows Explorer-u sadrže \ (npr. C:\Documents and Settings\Administrator),
## ali u R se mora uneti / ili \\

## Eventualna promena postiže se komandom setwd("putanja/direktorijum")
## Dodatni način promene radnog direktorijuma je putem menija File (Windows) ili Misc (Mac) > Change dir... / Change Working Directory

### Učitavanje podataka (iz radnog direktorijuma)

reldi1 = read.delim("reldi1.tsv")
refl = read.csv("reflexives.csv")

## Možete koristiti i opciju koja otvara iskačući prozor za izbor dokumenta:

reldi1 = read.delim(file.choose())
refl = read.csv(file.choose())

## Pregled podataka i njihovih osobina:

head(reldi1)
tail(reldi1)
head(refl,n=20)	# podešavanje prikaza prvih n redova tabele

summary(reldi1)  # osnovne statističke mere za svaku varijablu

str(reldi1)	# prikaz vrste varijable i početka niza njenih vrednosti

reldi1$duzina.recenica.2=as.factor(duzina.recenica.2)   # pretvaranje varijable iz broja u faktor

## Operacije sa pojedinačnim varijablama

sum(refl$Cloze)		
sum(refl$Cloze[refl$Group=="Control-I"]) 

## Ponavljanje operacija na više podskupova podataka

tapply(refl$Cloze, refl$Group, sum) 	# ponavljanje operacije sabiranja za svaku grupu posebno

### Dodavanje, brisanje i kopiranje podataka

## Dodavanje nove kolone u podatke

reldi1$tipovi = reldi1$tokeni*reldi1$ttr  	# računanje broja tipova
head(reldi1)

## Brisanje kolone iz podataka

reldi1$tipovi = NULL
head(reldi1)

## Izdvajanje varijabli ili redova

reldi1a = subset(reldi1, select="tokeni") # formiranje novog objekta sa jednom kolonom
reldi1b = subset(reldi1, select=c("tokeni","ttr")) # formiranje novog objekta sa dve kolone

reldi1c = subset(reldi1, tokeni>500) # formiranje novog objekta sa redovima u kojima je vrednost varijable tokeni>500

## Izdvajanje slučajnog manjeg uzorka

reldi1mini = reldi1[sample(1:nrow(reldi1), 100, replace=FALSE),]


###############################
# 2a. DEO - DESKRIPTIVNE MERE #
###############################

### Deskriptivne mere

## Mere učestalosti

table(reldi1$korpus)	# daje učestalost vrednosti kategoričke varijable, ovde broj tekstova prema korpusima
table(refl$Group)	

table(reldi1$korpus=="srwac.lat")

table(reldi1$korpus=="srwac.lat" & reldi1$duzina.recenica.2==1) # obratite pažnju na navodnike - potrebni su za kategorije, za numeričke vrednosti se ne navode
table(reldi1$korpus=="srwac.lat" & reldi1$duzina.recenica.2!=1)

# Crosstabs (kontingencijske ili tabele unakrsne klasifikacije)

duzina.recenica.2.po.korpusima=table(reldi1$korpus,reldi1$duzina.recenica.2)
leks.gust.2.po.korpusima=xtabs(~reldi1$korpus+reldi1$leks.gust.2)

# "Ručno" formiranje tabele (primer sa slajda)

infinitivi = matrix(c(24484790, 199792951, 4608002, 79296848), ncol=2, byrow=TRUE) 
colnames(infinitivi) = c("Infinitivi", "Ostalo") 
rownames(infinitivi) = c("hrWaC", "srWaC")
infinitivi = as.table(infinitivi)

# Relativne frekvencije

leks.gust.2.po.korpusima.prop = prop.table(leks.gust.2.po.korpusima,1) 	# 1 označava računanje procenata prema redovima (2 je prema kolonama)

## Mere centralne tendencije, pozicione mere i mere disperzije

mean(reldi1$tokeni)  
sd(reldi1$tokeni)  
var(reldi1$tokeni) 

median(refl$Cloze)  
IQR(refl$Cloze)  
quantile(refl$Cloze)

min(refl$Cloze)
max(refl$Cloze)

# R nema predefinisanu funkciju za mod

summary(reldi1$tokeni)

library(pastecs)
stat.desc(refl$Cloze)

### Deskriptivne mere izračunate na podskupovima podataka i ponovljene na više podskupova

mean(reldi1$tokeni[reldi1$korpus == "hrwac"])	
median(refl$Refl3p[refl$Group == "Control-I"])

tapply(reldi1$tokeni, reldi1$korpus, mean) 
tapply(refl$Refl3p, refl$Group, median) 


#############################
# 2b. DEO - GRAFIČKI PRIKAZ #
#############################

### Osnovni tipovi grafikona

## Scatterplot

plot(reldi1$tokeni,reldi1$recenice)
plot(reldi1$leks.gust,reldi1$ceste.reci)
plot(reldi1$ceste.reci,reldi1$ttr)

## Histogram

hist(reldi1$recenice)
hist(reldi1$recenice[reldi1$korpus=="hrwac"])
hist(reldi1$ttr)

histogram1=hist(refl$Cloze[refl$Group=="Control-I"])
histogram1	# pored grafikona dobijaju se i dodatne informacije

## Boxplot

boxplot(reldi1$recenice~reldi1$korpus)
boxplot(reldi1$leks.gust~reldi1$korpus)

boxplot(refl$Cloze~refl$Group)

## Mosaic plot

mosaicplot(duzina.recenica.2.po.korpusima)
mosaicplot(leks.gust.2.po.korpusima)

mosaicplot(infinitivi)

## Bar plot 

barplot(duzina.recenica.2.po.korpusima, beside=TRUE) # predefinisana opcija je "beside=F", tada su potkategorije jedne iznad drugih (stacked columns)

refl.Cloze = tapply(refl$Cloze, refl$Group, mean)	# računanje prosečnog broja bodova za svaku grupu i čuvanje rezultata u novom objektu "refl.Cloze"
barplot(refl.Cloze)

### Podešavanje opcija za grafikone 

## Pregled trenutnih podešavanja

par()

## Primer: promena boje naziva osa grafikona; globalna promena predefinisane vrednosti (biće primenjena do kraja sesije ili do sledeće promene)

par(col.lab="red")

## Ista promena može se primeniti i na pojedinačne grafikone unutar funkcije za crtanje

hist(reldi1$tokeni, col.lab="red") 

## Drugi parametri koji se mogu podesiti iz funkcije za crtanje 

main="Naslov" 	# naslov celog grafikona

xlab="Naziv X ose" 	
ylab="Naziv y ose" 	

xlim=c(xmin, xmax) 	# min i max vrednosti prikazane na X osi
ylim=c(ymin, ymax) 	# min i max vrednosti prikazane na Y osi

## Definisanje boja centralnog dela grafikona (stubića, linija...); potrebno je navesti onoliko boja koliko ima stubića (i sl.), 
## inače će boje početi da se ponavljaju; detaljan pregled boja i njihovih naziva: http://research.stowers-institute.org/efg/R/Color/Chart/ColorChart.pdf

col=c("orchid","turquoise")

## Izbor simbola za skater i linijske dijagrame, npr. 0=kvadrat, 1=krug (predefinisana opcija); više vrednosti može se videti na:
## http://www.statmethods.net/advgraphs/parameters.html

pch=0,1,2,3...

## Izbor vrste linije, 0=bez linije, 1=puna linija (predefinisana opcija), 2=crtice, 3=tačke, 4=tačke i crtice, 5=duže crtice, 6=dve crtice

lty=0,1,2,3...

### Spajanje više grafikona u jedan veći

par() 

## Funkcija par() pruža mogućnost da se definišu brojevi redova i kolona u matrici koju će popunjavati grafikoni 

mfrow=c(nrows, ncols) 	# popunjavanje matrice po redovima
mfcol=c(nrows, ncols) 	# popunjavanje matrice po kolonama

### Primena gornjih parametara (plus neke dodatne opcije)

## Scatterplot

plot(reldi1$tokeni, reldi1$recenice, col="turquoise", main="Broj tokena i broj rečenica", pch=4)
abline(lm(reldi1$recenice ~ reldi1$tokeni))	# trendline (linija koja najbolje opisuje podatke)

## Histogrami

hist(reldi1$recenice, col="lightblue", xlab="Broj rečenica", main="Raspodela broja rečenica u tekstu")

## Preklapanje više histograma (u svrhu poređenja više distribucija)

hist(reldi1$leks.gust[reldi1$korpus=="srwac.cyr"], col=rgb(0,0,1,0.5))	# definisanje boja pomoću rgb sistema
hist(reldi1$leks.gust[reldi1$korpus=="srwac.lat"], col=rgb(1,0,0,0.5), add=T)

## Mosaic plots

mosaicplot(duzina.recenica.2.po.korpusima, col=c("tomato3", "gold1", "olivedrab3", "plum3", "turquoise"),
           main="Dužina rečenica po korpusima", xlab="Korpus", ylab="Dužina rečenica")	

## Box plots

boxplot(reldi1$ceste.reci[reldi1$korpus=="hrwac"], col=c("purple"))
boxplot(reldi1$ceste.reci[reldi1$korpus=="hrwac"]~reldi1$ceste.reci.2[reldi1$korpus=="hrwac"], col=c("red","blue","green","yellow"))
boxplot(reldi1$ceste.reci~reldi1$korpus, col=c("mediumvioletred","royalblue3","limegreen"), notch=TRUE) # "notch" označava 95% interval pouzdanosti medijane; ako se "notches" za različite kategorije ne preklapaju, vrlo verovatno postoji značajna razlika

boxplot(refl$Cloze~refl$Group, notch=TRUE) 

boxplot(refl$Cloze~refl$Group, col=c(rainbow(5)), notch=TRUE)
grid()

## Kombinovanje više grafikona u jedan

par(mfrow=c(1,2))
boxplot(refl$Cloze~refl$Group)
grid()
boxplot(refl$Cloze~refl$Group, col=c(rainbow(5)))
grid()		
par(mfrow=c(1,1))	# povratak na crtanje pojedinačnih grafikona


####################
# 3. DEO - TESTOVI #
####################

### Chi-square test (hi-kvadrat)

chisq.test(duzina.recenica.2.po.korpusima) 
summary(duzina.recenica.2.po.korpusima)

## Za tabele u kojima je neka od frekvencija <5 treba koristiti Fisher's exact test - fisher.test()  

### Test normalnosti raspodele: Shapiro-Wilk test

shapiro.test(reldi1$tokeni) # ako je rezultat statistički značajan, raspodela NIJE normalna

tapply(reldi1$tokeni,reldi1$korpus,shapiro.test) 
tapply(refl$Cloze,refl$Group,shapiro.test)

### Provera jednakosti varijanse: Ansari-Bradley test

ansari.test(refl$Cloze[refl$Group=="SerLI-I"],refl$Cloze[refl$Group=="SerUI-I"]) # ako je rezultat statistički značajan, varijanse NISU jednake

### Korelacija

cor.test(reldi1$tokeni, reldi1$recenice, method="spearman")

### T-testovi i Wilcoxon testovi

t.test(refl$Cloze[refl$Group=="SerLI-I"],refl$Cloze[refl$Group=="SerUI-I"], var.equal=TRUE) 
t.test(refl$Cloze[refl$Group=="SerLI-I"|refl$Group=="SerUI-I"]~refl$Group[refl$Group=="SerLI-I"|refl$Group=="SerUI-I"], var.equal=TRUE) 	
# predefinisana opcija podrazumeva nejednake varijanse; predefinisana opcija je dvosmerni test

wilcox.test(reldi1$tokeni[reldi1$korpus=="srwac.cyr"],reldi1$tokeni[reldi1$korpus=="srwac.lat"]) 
wilcox.test(reldi1$tokeni[reldi1$korpus=="srwac.cyr"|reldi1$korpus=="srwac.lat"]~reldi1$korpus[reldi1$korpus=="srwac.cyr"|reldi1$korpus=="srwac.lat"])

wilcox.test(refl$Refl1c[refl$Group=="SerLI-I"],refl$Refl3c[refl$Group=="SerLI-I"], paired=TRUE)

### Jednofaktorska (nezavisna) ANOVA, Kruskal-Wallis test i Friedman test

oneway.test(refl$Cloze[refl$Group!="Control-I"]~refl$Group[refl$Group!="Control-I"])

anova1=aov(refl$Cloze[refl$Group!="Control-I"]~refl$Group[refl$Group!="Control-I"])
TukeyHSD(anova1)

kruskal.test(refl$Cloze~refl$Group)
kruskal.test(reldi1$tokeni~reldi1$korpus)
	
# Podatke za Fridmanov test potrebno je uneti u drugačijem formatu od formata za ponovljenu jednofaktorsku analizu varijanse

refl1 = subset(refl, Group=="Control-I")
refl2 = subset(refl1, select=c("Refl1c", "Refl2c", "Refl3c"))
friedman.test(as.matrix(refl2))
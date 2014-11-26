# Analiza podatkov s programom R, 2014/15

## Voda iz javnega vodovod

Avtor: Špela Povrženič

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2014/15.

## Tematika

V projektu, bom analizirala podatke, ki se navezujejo na vodo iz javnega vodovoda. 

Uporabila bom pet tabel. 
Najprej bom predstavila porečja Slovenije, iz kjer pride voda v vodovode. Analizirala bom tudi kakšna je preskrba poslovnih subjektov z vodo po področjih dejavnosti v Sloveniji. Nato pa še porabo vode, dobljene iz javnega vodovoda, v gospodinjstvih na prebivalca, torej bom primerjala regije. Uvozila jih bom v CSV obliki.

1. http://pxweb.stat.si/pxweb/Dialog/varval.asp?ma=2750104S&ti=&path=../Database/Okolje/27_okolje/03_27193_voda/01_27501_javni_vodovod/&lang=2

2. http://pxweb.stat.si/pxweb/Dialog/varval.asp?ma=2750301S&ti=&path=../Database/Okolje/27_okolje/03_27193_voda/03_27503_industrija/&lang=2

3. http://pxweb.stat.si/pxweb/Dialog/varval.asp?ma=3268904S&ti=&path=../Database/Okolje/32_trajnostni_razvoj/10_ravnovesje_skromnost/05_32689_naravni_viri/&lang=2

Četrto tabelo sem dobila iz eurostat-a, ki jo bom uvozila v xlsx obliki (v Excel tabelo), nato pa jo pretvorila v csv. Govori o preskrbi z vodo po področjih dejavnosti v evropskih državah.

4.http://epp.eurostat.ec.europa.eu/tgm/table.do?tab=table&init=1&language=en&pcode=ten00006&plugin=1

Peta tabela pa je iz neke spletne strani, uvozila pa sem jo kot html. Izbrala pa sem jo zato, ker vsebuje urejenostne spremenljivke. Podatki pa so o tem, kolikšna raven arzenika je vsebovana v vodovodnih sistemih v 25 državah.

5.http://www.nrdc.org/water/drinking/arsenic/chap1.asp

Moj cilj projekta je, da analiziram iz kje največ dobimo vodo, katero je tisto leto in  dejavnosti, ki porabijo največ vode ter katere statistične regije porabijo največ vode v gospodinjstvih na prebivalca. 

## Program

Glavni program se nahaja v datoteki `projekt.r`. Ko ga poženemo, se izvedejo
programi, ki ustrezajo drugi, tretji in četrti fazi projekta:

* obdelava, uvoz in čiščenje podatkov: `uvoz/uvoz.r`
* analiza in vizualizacija podatkov: `vizualizacija/vizualizacija.r`
* napredna analiza podatkov: `analiza/analiza.r`

Vnaprej pripravljene funkcije se nahajajo v datotekah v mapi `lib/`. Podatkovni
viri so v mapi `podatki/`. Slike, ki jih program naredi, se shranijo v mapo
`slike/`. Zemljevidi v obliki SHP, ki jih program pobere, se shranijo v mapo
`zemljevid/`.

## Poročilo

Poročilo se nahaja v mapi `porocilo/`. Za izdelavo poročila v obliki PDF je
potrebno datoteko `porocilo/porocilo.tex` prevesti z LaTeXom. Pred tem je
potrebno pognati program, saj so v poročilu vključene slike iz mape `slike/`.

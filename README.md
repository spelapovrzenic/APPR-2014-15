# Analiza podatkov s programom R, 2014/15

## Voda iz javnega vodovod

Avtor: Špela Povrženič

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2014/15.

## Tematika

V projektu, bom analizirala podatke, ki se navezujejo na vodo iz javnega vodovoda. Najprej bom analizirala porečja Slovenije, iz kjer pride voda v vodovode. Predstavila bom tudi kakšna je preskrba poslovnih subjektov z vodo po področjih dejavnosti v Sloveniji. Nato pa še porabo vode, dobljene iz javnega vodovoda, v gospodinjstvih na prebivalca.


Podatke za moj projekt sem dobila na spletni strani Statističnega urada Republike Slovenije, Ker lahko na statističnem uradu sam izbiraš v kakšni obliki bi imel podatke in tabele (izbiram lahko med datotekami oblike .html, .csv, .txt, .xls. ... ), sem se odločila, da bom za vsako od mojih 3 tabel uporabila drugačno metodo uvoza le-te v R, torej html., csv. in xls. oblike, na tak način pa bom spoznala  vse tehnike in načine, kako jih uvoziti v R.
Povezave do podatkovnih tabel:
1. http://pxweb.stat.si/pxweb/Dialog/varval.asp?ma=2750104S&ti=&path=../Database/Okolje/27_okolje/03_27193_voda/01_27501_javni_vodovod/&lang=2 
2. http://pxweb.stat.si/pxweb/Dialog/varval.asp?ma=2750301S&ti=&path=../Database/Okolje/27_okolje/03_27193_voda/03_27503_industrija/&lang=2
3. http://pxweb.stat.si/pxweb/Dialog/varval.asp?ma=3268904S&ti=&path=../Database/Okolje/32_trajnostni_razvoj/10_ravnovesje_skromnost/05_32689_naravni_viri/&lang=2

Moj cilj projekta je, da analiziram iz kje največ dobimo vodo, katere so tiste dejavnosti, ki porabijo največ vode ter katere statistične regije porabijo največ vode v gospodinjstvih na prebivalca. 

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

# Analiza podatkov s programom R, 2014/15

## Voda - vodovod, kanalizacija, izkoriščanje v industriji

Avtor: Špela Povrženič

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2014/15.

## Tematika

#(Izbrali si boste temo, s katero se bo vaš projekt ukvarjal. Tukaj boste napisali, kje ste dobili podatke, ter kakšen je vaš cilj.)
Naslov mojega projekta je Voda - vodovod, kanalizacija, izkoriščanje v industriji. Že sam naslov pove, da se bom ukvarjala z analizo podatkov, ki so povezani z javnim vodovodom (načrpana voda po vodnih virih, analiza dobavljene vode iz javnega vodovoda), javno kanalizacijo (analizirala bom odpadne vode po povodjih in porečjih, po viru onesnaženja ter po mestu izpusta ) ter analizirala bom kako izkoriščamo vodo v industriji.

Podatke za moj projekt sem dobila na spletni strani Statističnega urada Republike Slovenjie (http://www.stat.si/).

MOj cilj projekta je, da analiziram uporabo in porabo vode v Sloveniji in v regijah v  javnem vodovodu, kanalizaciji ter njeno uporabo v industriji.

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

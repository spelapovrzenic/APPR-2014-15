# Poročilo
## 1.FAZA: Izbira teme

Za naslov mojega projekta sem izbrala Voda iz javnega vodovoda.
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

## 2.FAZA: Obdelava, uvoz in čiščenje podatkov

Uporabila sem 5 tabel.
Prve tri sem dobila iz statističnega urada in jih uvozila v CSV obliki.
Četrto tabelo sem dobila iz eurostat-a, ki sem jo uvozila v xlsx obliki (v Excel tabelo), nato pa sem jo pretvorila v CSV. Peta tabela pa je iz neke spletne strani, uvozila pa sem jo kot html.

Najprej sem tabele, ki sem jih uvozila v CSV obliki, uredila, se pravi odstranila sem vse odvečne podatke, vrstice. Nato pa sem te tabele uvozila, v mapi uvoz, v uvoz.r. Pri uvozu sem uporabila tudi na.strings, torej tisti podatki, ki niso bili na voljo, sem jih pretvorila v NA(not available). Enako sem naredila tudi četrto tabelo, o evropskih državah.

Pri peti tabeli o arzeniku, ki sem jo dobila na spletni strani, pa sem jo najprej uvozila v mapi lib, v xml.r. Najprej sem poiskala koliko tabel je v tej spletni strani, nato izbrala tisto, ki sem jo želela uvoziti, potem pa iz nje naredila matriko, nato pa še tabelo. Tudi to tabelo sem nato uvozila v mapi uvozi, v uvozi.r.

Ko sem uvozila vse tabele, sem se lotila risanja grafov. Najprej sem v mapi slike, ustvarila novo R-skripto. Najprej sem napisala v prvi in zadnji vrstici ukaze, ki mi uvozijo grafe v pdf obliko. Nato pa sem začela z grafi. 

Za prvo tabelo, ki govori o porečjih, sem se odločila da bom uporabila stolpični graf(barplot), saj sem želela, da bi iz grafa videli, koliko je porečij, ki so zelo veliki. Izbrala sem si samo podatke za porečja za leto 2013, saj neke bistvene razlike med leti drugače ni. 

Za drugo tabelo, ki govori o preskrba poslovnih subjektov z vodo, sem izbrala točkast in črtast graf (plot, tipa b), saj sem želela pokazati oskrbo po vseh področjih skupaj, v različnih letih. 

Za tretjo tabelo, ki govori o poraba vodovodne vode v gospodinjstvih na prebivalca, sem tudi uporabila stolpični graf (barplot), saj sem želela primerjati porabo vode v slovenskih regijah v letu 2012. 

Tudi za četrti graf, ki govori o preskrbi z vodo v evropskih državah, sem izbrala stolpičnega, saj me zanima, katere so tiste države, ki letno največ porabijo vode. Izbrala sem samo leto 2005, saj je v tej/četrti tabeli zelo veliko neznanih podatkov, zaradi česar je težko analizirati stvari, zaradi pomanjkanja podatkov, zato sem namenoma izbrala leto 2005, saj je le-to vsebovalo najmanj neznanih podatkov.

Prav tako za peti graf, ki govori o kolicina arzenika v vodovodnih sistemih, sem ibrala stolpični graf, saj vsebuje urejenostne spremenljivke in je zato najbolj primeren za prikaz podatkov.

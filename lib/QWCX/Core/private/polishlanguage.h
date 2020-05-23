#pragma once

#include <QWCX/Core/private/abstractlanguage.h>

QWCX_CORE_BEGIN_NAMESPACE

class PolishLanguage : public AbstractLanguage
{
public:
    explicit PolishLanguage() = default;
    ~PolishLanguage() override = default;

    std::string locale() const override
    {
        return "pl";
    }

    std::vector<std::string> words() const override
    {
        return {
            "abażur",
            "aborcja",
            "absurd",
            "adopcja",
            "adresat",
            "adwent",
            "adwokat",
            "agencja",
            "agonia",
            "agresja",
            "akademia",
            "akcent",
            "akordeon",
            "aktualny",
            "aktywny",
            "akurat",
            "alchemia",
            "alergia",
            "alfabet",
            "algebra",
            "alkohol",
            "aluzja",
            "amator",
            "ambasada",
            "amnestia",
            "amoniak",
            "amulet",
            "analiza",
            "ananas",
            "anarchia",
            "anatomia",
            "anioł",
            "ankieta",
            "antena",
            "antylopa",
            "aparat",
            "apetyt",
            "apostoł",
            "aprobata",
            "apteka",
            "archiwum",
            "areszt",
            "argument",
            "arkusz",
            "artykuł",
            "asfalt",
            "aspekt",
            "aspiryna",
            "astronom",
            "ateizm",
            "atomowy",
            "atrament",
            "atrybut",
            "audycja",
            "awantura",
            "awaria",
            "awokado",
            "babcia",
            "badanie",
            "bagaż",
            "bakteria",
            "balkon",
            "bandyta",
            "banknot",
            "baranina",
            "bardziej",
            "barwnik",
            "bateria",
            "bawełna",
            "bawić",
            "bawół",
            "bałagan",
            "bałwan",
            "bańka",
            "beczka",
            "benzyna",
            "bezdomny",
            "bezsilny",
            "biały",
            "biblijny",
            "biedny",
            "biegunka",
            "bielizna",
            "bilans",
            "biolog",
            "biskup",
            "biurko",
            "bizmut",
            "biznes",
            "bliski",
            "blizna",
            "bluzka",
            "bocian",
            "boczny",
            "bodziec",
            "bogaty",
            "bogini",
            "bohater",
            "boisko",
            "bojowy",
            "bolesny",
            "borsuk",
            "bowiem",
            "bożek",
            "bramka",
            "brokuł",
            "bronić",
            "brudny",
            "brutalny",
            "brydż",
            "brzoza",
            "brzuch",
            "brzydki",
            "brązowy",
            "buddyzm",
            "budowa",
            "budynek",
            "budzić",
            "budżet",
            "bukiet",
            "burdel",
            "burzyć",
            "butelka",
            "bydło",
            "bystry",
            "bywać",
            "bzdura",
            "bóstwo",
            "bądź",
            "bęben",
            "błazen",
            "błoto",
            "błysk",
            "błędny",
            "całkiem",
            "cebula",
            "cegła",
            "cement",
            "cenić",
            "centrum",
            "cesarz",
            "chamski",
            "chałupa",
            "chciwy",
            "chemia",
            "chirurg",
            "chmiel",
            "chmura",
            "chociaż",
            "chodzić",
            "choinka",
            "cholera",
            "choroba",
            "choćby",
            "chrapać",
            "chronić",
            "chrzcić",
            "chusta",
            "chwast",
            "chwilowy",
            "chwytać",
            "chętny",
            "chłodny",
            "ciasny",
            "ciało",
            "ciekawy",
            "cielesny",
            "ciemny",
            "ciepło",
            "cierpki",
            "cieszyć",
            "ciotka",
            "ciskać",
            "ciągły",
            "ciężko",
            "cmentarz",
            "cudowny",
            "cukier",
            "cukrzyca",
            "cyfrowy",
            "cygaro",
            "cyklon",
            "cylinder",
            "cyrkiel",
            "cytować",
            "cywilny",
            "czajnik",
            "czapka",
            "czarny",
            "czasem",
            "czcić",
            "czekać",
            "czerwiec",
            "czeski",
            "cześć",
            "czkawka",
            "czosnek",
            "czoło",
            "cztery",
            "czujny",
            "czuwać",
            "czuły",
            "czwartek",
            "czyjś",
            "czynnik",
            "czysty",
            "czytanie",
            "cząstka",
            "często",
            "córka",
            "daleko",
            "dalszy",
            "darmowy",
            "darować",
            "darzyć",
            "dawać",
            "dekada",
            "dentysta",
            "depresja",
            "deszcz",
            "detektyw",
            "diabeł",
            "diagnoza",
            "dialekt",
            "diament",
            "dlatego",
            "dmuchać",
            "dobrze",
            "dochód",
            "dodawać",
            "dojść",
            "dokonać",
            "doktryna",
            "dokądś",
            "dolina",
            "domena",
            "domowy",
            "donosić",
            "dookoła",
            "dopiero",
            "dopóki",
            "dopływ",
            "doradca",
            "dorosły",
            "dostać",
            "dosyć",
            "dotykać",
            "dowcip",
            "dowolny",
            "dowód",
            "doznać",
            "dozorca",
            "dość",
            "drabina",
            "dramat",
            "drapać",
            "drewno",
            "drgać",
            "drobny",
            "drogowy",
            "drukarka",
            "drużyna",
            "drzewko",
            "drżeć",
            "duchowny",
            "dureń",
            "dusić",
            "dworzec",
            "dwunasty",
            "dwójka",
            "dynastia",
            "dyplom",
            "dyrekcja",
            "dyskusja",
            "dysproz",
            "dzbanek",
            "dział",
            "dzielić",
            "dzisiaj",
            "dziurka",
            "dziwka",
            "dziób",
            "dzięki",
            "dzwonić",
            "dążyć",
            "dłoń",
            "długo",
            "dźwig",
            "dżdża",
            "edukacja",
            "egoizm",
            "egzamin",
            "ekologia",
            "ekspert",
            "elektron",
            "element",
            "emigrant",
            "emisja",
            "emocja",
            "energia",
            "estetyka",
            "etniczny",
            "etyczny",
            "ewolucja",
            "fabryka",
            "fantazja",
            "fasola",
            "faworyt",
            "festiwal",
            "figura",
            "filmowy",
            "filozof",
            "fizyka",
            "finał",
            "formalny",
            "forteca",
            "fosfor",
            "fragment",
            "frakcja",
            "fryzjer",
            "fundusz",
            "futerał",
            "gabinet",
            "galeria",
            "gadać",
            "ganić",
            "gardło",
            "garnek",
            "garść",
            "gasić",
            "gatunek",
            "gazeta",
            "gałąź",
            "gdzieś",
            "generał",
            "geniusz",
            "geograf",
            "geologia",
            "ginąć",
            "gitara",
            "giętki",
            "gniazdo",
            "godło",
            "godzina",
            "goleń",
            "goniec",
            "gorliwy",
            "gorzki",
            "gorący",
            "gotówka",
            "gołąb",
            "gość",
            "goździk",
            "grabież",
            "gramofon",
            "granica",
            "gromada",
            "grozić",
            "groźba",
            "gruczoł",
            "grupowy",
            "grusza",
            "gryzoń",
            "gryźć",
            "grzbiet",
            "grzeczny",
            "grzmieć",
            "grzywna",
            "gumowy",
            "gwałt",
            "gwiazda",
            "górnik",
            "gówno",
            "gąbka",
            "gęsty",
            "gładki",
            "głodny",
            "głupi",
            "główka",
            "haczyk",
            "hamować",
            "hamulec",
            "handlowy",
            "harcerz",
            "harmonia",
            "hasło",
            "hałas",
            "hańba",
            "herbata",
            "herezja",
            "hetman",
            "higiena",
            "hinduizm",
            "hipoteza",
            "historia",
            "hodowca",
            "honorowy",
            "hormon",
            "horoskop",
            "horyzont",
            "hrabstwo",
            "ideał",
            "idiota",
            "iloczyn",
            "ilość",
            "imieniny",
            "imitacja",
            "imperium",
            "impreza",
            "inaczej",
            "indyjski",
            "infekcja",
            "instynkt",
            "interes",
            "inwestor",
            "ironia",
            "istota",
            "jabłko",
            "jadalny",
            "jagnię",
            "jagoda",
            "jakiś",
            "jakość",
            "jarmark",
            "jarzyna",
            "jaskinia",
            "jaśmin",
            "jednak",
            "jedwabny",
            "jedynka",
            "jedzenie",
            "jeleń",
            "jelito",
            "jeniec",
            "jesień",
            "jeszcze",
            "jezdnia",
            "jezioro",
            "jeśli",
            "jeżeli",
            "jodła",
            "jądro",
            "język",
            "kabina",
            "kaczka",
            "kadłub",
            "kalafior",
            "kaloria",
            "kameleon",
            "kamienny",
            "kanapka",
            "kandydat",
            "kangur",
            "kanibal",
            "kapeć",
            "kapitał",
            "kaprys",
            "kapłan",
            "karabin",
            "karetka",
            "kariera",
            "kartka",
            "kasztan",
            "katedra",
            "kawał",
            "kazanie",
            "każdy",
            "kelner",
            "kiedyś",
            "kielich",
            "kierowca",
            "kilometr",
            "klarnet",
            "klasztor",
            "klatka",
            "klawisz",
            "klejnot",
            "klient",
            "klimat",
            "kluczowy",
            "klątwa",
            "klęska",
            "kobalt",
            "kobieta",
            "kochanek",
            "kocioł",
            "kodeks",
            "kolacja",
            "kolczyk",
            "kolejny",
            "kolizja",
            "kolorowy",
            "kolumna",
            "kometa",
            "komiks",
            "komora",
            "komputer",
            "komórka",
            "koncert",
            "kondycja",
            "konflikt",
            "kongres",
            "koniec",
            "konkurs",
            "kontekst",
            "kopalnia",
            "korona",
            "korzeń",
            "kosmos",
            "kostka",
            "koszyk",
            "kotwica",
            "kozioł",
            "kołyska",
            "końcowy",
            "kość",
            "kraina",
            "krajowy",
            "kraniec",
            "krawat",
            "kraść",
            "kredyt",
            "kreska",
            "kretyn",
            "krewny",
            "kroić",
            "krokodyl",
            "kropla",
            "krosta",
            "krtań",
            "kruchy",
            "krwawić",
            "krytyk",
            "kryzys",
            "krzesło",
            "krzyżyk",
            "krótki",
            "krążek",
            "kręcić",
            "ksiądz",
            "księga",
            "kształt",
            "kuchnia",
            "kukułka",
            "kulisty",
            "kultura",
            "kumpel",
            "kupić",
            "kupować",
            "kurczak",
            "kurtka",
            "kwadrat",
            "kwantowy",
            "kwartał",
            "kwaśny",
            "kwestia",
            "kwiatowy",
            "kółko",
            "kąpiel",
            "kłaść",
            "kłopot",
            "kłódka",
            "labirynt",
            "lampka",
            "laska",
            "latarnia",
            "lawina",
            "lecieć",
            "leczyć",
            "ledwie",
            "legenda",
            "lekcja",
            "lenistwo",
            "lepiej",
            "lepszy",
            "leśny",
            "leżeć",
            "liceum",
            "liczenie",
            "likier",
            "lipiec",
            "listopad",
            "litera",
            "litość",
            "liturgia",
            "liść",
            "lodowiec",
            "lodówka",
            "logarytm",
            "lokalny",
            "lornetka",
            "losowy",
            "loteria",
            "lotnisko",
            "ludowy",
            "ludzie",
            "luksus",
            "lustro",
            "luźny",
            "lądowy",
            "lśnić",
            "macica",
            "magazyn",
            "magiczny",
            "magnez",
            "majątek",
            "makaron",
            "makijaż",
            "malarz",
            "maleć",
            "malina",
            "malować",
            "mamusia",
            "mandat",
            "mangan",
            "marchew",
            "marzec",
            "masakra",
            "masowy",
            "maszyna",
            "masło",
            "materac",
            "matura",
            "małpa",
            "mechanik",
            "medyczny",
            "melodia",
            "metalowy",
            "meteoryt",
            "metoda",
            "miasto",
            "miedź",
            "miejsce",
            "mienie",
            "mierzyć",
            "mieszać",
            "migdał",
            "mikrofon",
            "milczeć",
            "milion",
            "minerał",
            "miniony",
            "minuta",
            "minąć",
            "miotła",
            "mistrz",
            "miękki",
            "miłosny",
            "mleczny",
            "mnóstwo",
            "molibden",
            "moment",
            "monarcha",
            "moneta",
            "moralny",
            "morela",
            "morski",
            "motocykl",
            "można",
            "mrowisko",
            "mruczeć",
            "mrówka",
            "mundur",
            "musieć",
            "muzeum",
            "muzyczny",
            "mydło",
            "myśliwy",
            "mówić",
            "mądry",
            "męczyć",
            "mędrzec",
            "męski",
            "mężny",
            "młode",
            "nabrać",
            "nabyć",
            "nacisk",
            "naczynie",
            "nadawać",
            "nadmiar",
            "nadzieja",
            "nagroda",
            "nagły",
            "naiwny",
            "najpierw",
            "nakrycie",
            "nakład",
            "nalewać",
            "namiot",
            "napadać",
            "napęd",
            "napisać",
            "naprzód",
            "napój",
            "napływ",
            "narciarz",
            "narodowy",
            "narząd",
            "naród",
            "nasiono",
            "nastrój",
            "natura",
            "nawias",
            "naukowy",
            "nazwisko",
            "nazywać",
            "niejasny",
            "niekiedy",
            "niemiły",
            "niepewny",
            "niestety",
            "niewinny",
            "niezgoda",
            "nieść",
            "nigdzie",
            "nijaki",
            "nonsens",
            "nóżka",
            "nosić",
            "nożyce",
            "notatka",
            "notować",
            "nowina",
            "nośnik",
            "nędzny",
            "obalić",
            "obecny",
            "obfity",
            "obiecać",
            "objąć",
            "oblicze",
            "obracać",
            "obrońca",
            "obrzęd",
            "obrót",
            "obręb",
            "obszar",
            "obsługa",
            "obuwie",
            "obwód",
            "obyczaj",
            "obywatel",
            "obłęd",
            "obłok",
            "oceniać",
            "ochota",
            "ochronny",
            "odbiór",
            "odbywać",
            "odchody",
            "odcień",
            "oddać",
            "oddech",
            "oddział",
            "odkryć",
            "odkąd",
            "odległy",
            "odmiana",
            "odnosić",
            "odraza",
            "odrębny",
            "odstęp",
            "odwaga",
            "odzież",
            "ofiara",
            "ogień",
            "ogromny",
            "ogród",
            "ogół",
            "ohydny",
            "ojciec",
            "ojczyzna",
            "okazja",
            "okienko",
            "około",
            "okresowy",
            "okropnie",
            "okrutny",
            "okrywać",
            "okręt",
            "okulary",
            "okupacja",
            "olbrzymi",
            "oliwka",
            "opactwo",
            "oparcie",
            "operacja",
            "opiekun",
            "opinia",
            "opisać",
            "opozycja",
            "oprócz",
            "optyczny",
            "opłata",
            "orbita",
            "organy",
            "orzeł",
            "osadzić",
            "osiemset",
            "osioł",
            "osnowa",
            "osobnik",
            "ospały",
            "ostatnio",
            "ostrzyć",
            "oszustwo",
            "osłona",
            "otaczać",
            "otoczyć",
            "otwarty",
            "otwór",
            "owalny",
            "owocowy",
            "ozdobić",
            "ołówek",
            "ośrodek",
            "pacjent",
            "pacyfizm",
            "paczka",
            "padać",
            "padlina",
            "pagórek",
            "pająk",
            "palenie",
            "paliwo",
            "pamięć",
            "panorama",
            "papieros",
            "paplać",
            "papuga",
            "parasol",
            "parking",
            "parowy",
            "partia",
            "parzyć",
            "pasażer",
            "pasierb",
            "pasterz",
            "paszport",
            "patelnia",
            "patrzeć",
            "pawian",
            "pałac",
            "pański",
            "paść",
            "pchać",
            "pchła",
            "pedał",
            "pejzaż",
            "pensja",
            "perfumy",
            "perski",
            "perła",
            "pestka",
            "pewien",
            "pewnie",
            "pełny",
            "piasek",
            "pieczywo",
            "piekło",
            "pieprz",
            "pierś",
            "pieszo",
            "pieśń",
            "pijany",
            "pikantny",
            "pilnik",
            "pionowy",
            "piorun",
            "piosenka",
            "piramida",
            "pisanie",
            "pisemny",
            "pisownia",
            "pistolet",
            "piwnica",
            "pióro",
            "piątek",
            "piękny",
            "piłka",
            "planeta",
            "plaster",
            "platyna",
            "plaża",
            "plecak",
            "pleść",
            "plotka",
            "pobożny",
            "pochyły",
            "pociąg",
            "poczta",
            "podatek",
            "poddasze",
            "podkowa",
            "podmiot",
            "podobny",
            "podpis",
            "podróż",
            "podstęp",
            "poduszka",
            "podziw",
            "podłoga",
            "poetycki",
            "poezja",
            "poganin",
            "pogląd",
            "pogoda",
            "pogrzeb",
            "pojazd",
            "pojemnik",
            "pojęcie",
            "pokarm",
            "pokonać",
            "pokroić",
            "pokój",
            "pokład",
            "polegać",
            "polityk",
            "polować",
            "polski",
            "pomagać",
            "pomimo",
            "pomnik",
            "pomocny",
            "pomysł",
            "pomóc",
            "poniżej",
            "ponowny",
            "ponury",
            "poparcie",
            "popiół",
            "poprawny",
            "poranek",
            "porcja",
            "portret",
            "porwanie",
            "poród",
            "poseł",
            "posiłek",
            "postać",
            "posępny",
            "posłać",
            "potomek",
            "potrawa",
            "potwór",
            "potęga",
            "poufały",
            "powaga",
            "powinien",
            "powolny",
            "powrót",
            "powstać",
            "powód",
            "powłoka",
            "poziomka",
            "poznanie",
            "pozorny",
            "pozycja",
            "pozór",
            "połysk",
            "pożar",
            "praktyka",
            "pralka",
            "pranie",
            "prawie",
            "preparat",
            "prezent",
            "procent",
            "produkt",
            "profesor",
            "program",
            "projekt",
            "promień",
            "proszek",
            "proton",
            "prośba",
            "prysznic",
            "prywatny",
            "przemoc",
            "przyroda",
            "przód",
            "próbny",
            "prącie",
            "prędki",
            "pszenny",
            "ptaszek",
            "puchar",
            "pudełko",
            "pustynia",
            "puszka",
            "pułapka",
            "puścić",
            "pyszny",
            "pytać",
            "pyłek",
            "pójść",
            "późno",
            "pączek",
            "pęcherz",
            "pędzić",
            "pępek",
            "pętla",
            "płacz",
            "płeć",
            "płuco",
            "płynny",
            "płód",
            "płótno",
            "rabunek",
            "rachunek",
            "raczej",
            "radiowy",
            "radość",
            "radzić",
            "rakieta",
            "ramię",
            "ranić",
            "raport",
            "rasizm",
            "ratować",
            "ratusz",
            "rdzeń",
            "reakcja",
            "realny",
            "reforma",
            "region",
            "reguła",
            "rejestr",
            "reklama",
            "relacja",
            "religia",
            "remont",
            "renifer",
            "reszta",
            "rezerwa",
            "rezultat",
            "reżim",
            "robić",
            "robota",
            "rocznica",
            "rodzina",
            "rolnik",
            "ropucha",
            "rosnąć",
            "rosół",
            "rower",
            "rozbić",
            "rozgłos",
            "rozkład",
            "rozmiar",
            "rozpacz",
            "rozrywka",
            "roztwór",
            "rozwój",
            "roślina",
            "rtęć",
            "ruchomy",
            "ruszyć",
            "ryba",
            "rycerz",
            "ryczeć",
            "rysować",
            "rysunek",
            "rytuał",
            "ryzyko",
            "rzadki",
            "rzekomy",
            "rzeźba",
            "rzucać",
            "rzymski",
            "rzęsa",
            "równy",
            "róża",
            "ręcznie",
            "rękaw",
            "rżnąć",
            "sadzić",
            "samica",
            "samolot",
            "sandał",
            "satelita",
            "sałatka",
            "schemat",
            "schowek",
            "schron",
            "sekcja",
            "sekret",
            "sektor",
            "sekunda",
            "senator",
            "sensowny",
            "serial",
            "serwis",
            "siadać",
            "siarka",
            "siatka",
            "siebie",
            "siedem",
            "siekiera",
            "sierota",
            "silnik",
            "siodło",
            "siostra",
            "siódmy",
            "sięgać",
            "skakać",
            "skalisty",
            "skandal",
            "skarga",
            "skazać",
            "skała",
            "skoczek",
            "skorupa",
            "skośny",
            "skrajny",
            "skroń",
            "skręt",
            "skrucha",
            "skrzypce",
            "skupiać",
            "skutek",
            "skórka",
            "skąpiec",
            "skład",
            "smaczny",
            "smoczek",
            "smoła",
            "smród",
            "smukły",
            "smutek",
            "sobota",
            "sobór",
            "soczewka",
            "solidny",
            "sosnowy",
            "spacer",
            "spadek",
            "spaść",
            "spektakl",
            "spisać",
            "spodnie",
            "spokojny",
            "sportowy",
            "sposób",
            "spotkać",
            "sprawić",
            "sprzeciw",
            "spójny",
            "srebrny",
            "stabilny",
            "stacja",
            "stadium",
            "stajnia",
            "standard",
            "starzec",
            "statek",
            "stawać",
            "stały",
            "sterta",
            "stolica",
            "stopień",
            "stosowny",
            "straszny",
            "strefa",
            "strona",
            "struś",
            "strzelba",
            "stróż",
            "student",
            "stulecie",
            "styczeń",
            "stół",
            "subtelny",
            "sukces",
            "sukienka",
            "sumienie",
            "surowy",
            "suszyć",
            "sweter",
            "swobodny",
            "sygnał",
            "sylaba",
            "sylwetka",
            "symbol",
            "sympatia",
            "synagoga",
            "synonim",
            "syrena",
            "system",
            "sytuacja",
            "szacunek",
            "szafran",
            "szakal",
            "szalony",
            "szansa",
            "szatan",
            "szczęka",
            "szeptać",
            "szeroko",
            "sześć",
            "szkielet",
            "szklanka",
            "szkoda",
            "szkło",
            "szlachta",
            "szmaragd",
            "szminka",
            "sznurek",
            "szorstki",
            "szpital",
            "sztuczny",
            "sztywny",
            "szuflada",
            "szwagier",
            "szybki",
            "szynka",
            "szyszka",
            "szósty",
            "sądzić",
            "sąsiad",
            "sędzia",
            "słaby",
            "słony",
            "słupek",
            "słynny",
            "tabela",
            "tabletka",
            "tajski",
            "także",
            "talerz",
            "tamilski",
            "tamten",
            "taneczny",
            "taniec",
            "tarcza",
            "tatarski",
            "tatuaż",
            "taśma",
            "tchórz",
            "technika",
            "teczka",
            "telegram",
            "tellur",
            "teoria",
            "terapia",
            "termin",
            "teść",
            "tkanka",
            "tlenek",
            "toaleta",
            "toczyć",
            "tonacja",
            "topór",
            "torebka",
            "towarowy",
            "tracić",
            "tradycja",
            "trafić",
            "tramwaj",
            "trawić",
            "trener",
            "trochę",
            "troska",
            "trucizna",
            "trudny",
            "trujący",
            "trumna",
            "trwały",
            "trzcina",
            "trzeba",
            "trzonek",
            "trzymać",
            "trójka",
            "trąbka",
            "turecki",
            "turysta",
            "tułów",
            "tuńczyk",
            "twardy",
            "twierdza",
            "tworzyć",
            "twórca",
            "tydzień",
            "tygrys",
            "typowy",
            "tysiąc",
            "tytuł",
            "tyłek",
            "tęcza",
            "tętnica",
            "tłuszcz",
            "ubierać",
            "ubiór",
            "ubranie",
            "uchwyt",
            "uciekać",
            "uczelnia",
            "uczony",
            "uczucie",
            "uczynek",
            "uderzyć",
            "udział",
            "ujście",
            "ukochany",
            "ukraść",
            "ukrywać",
            "układ",
            "uległy",
            "uliczka",
            "ulotka",
            "umierać",
            "umrzeć",
            "umysł",
            "unikać",
            "upadek",
            "uparty",
            "upaść",
            "uprawny",
            "uprzejmy",
            "urodziny",
            "urząd",
            "ustalać",
            "usterka",
            "ustrój",
            "usunąć",
            "usuwać",
            "usługa",
            "utrata",
            "utwór",
            "uważać",
            "uwolnić",
            "uznać",
            "uzyskać",
            "ułamek",
            "użyć",
            "wahanie",
            "wakacje",
            "walczyć",
            "walizka",
            "wampir",
            "wariat",
            "warkocz",
            "warsztat",
            "warunek",
            "warzywo",
            "wawrzyn",
            "ważny",
            "wciąż",
            "wczesny",
            "wczoraj",
            "wdowiec",
            "wdzięk",
            "weekend",
            "wektor",
            "wejście",
            "wersja",
            "wesele",
            "wesoły",
            "wezwanie",
            "wełna",
            "whisky",
            "wiadro",
            "widelec",
            "widnieć",
            "widoczny",
            "widzenie",
            "wiecznie",
            "wiedza",
            "wiejski",
            "wielki",
            "wieniec",
            "wierny",
            "wieszak",
            "wilgotny",
            "wiosło",
            "wisieć",
            "witamina",
            "wizyta",
            "wiązać",
            "większy",
            "wiśnia",
            "wkrótce",
            "wniosek",
            "wnosić",
            "wnuczka",
            "wnętrze",
            "wojenny",
            "wojownik",
            "wojskowy",
            "wokół",
            "woleć",
            "wolfram",
            "wołowy",
            "woźnica",
            "wpaść",
            "wprawa",
            "wprost",
            "wpół",
            "wracać",
            "wreszcie",
            "wrodzony",
            "wrzask",
            "wrzeć",
            "wrzucić",
            "wrócić",
            "wschód",
            "wsiadać",
            "wskazać",
            "wskutek",
            "wsparcie",
            "wspólny",
            "wstawać",
            "wstręt",
            "wstępny",
            "wszelki",
            "wszystek",
            "wtorek",
            "wulgarny",
            "wulkan",
            "wybieg",
            "wybory",
            "wybrać",
            "wybuch",
            "wybór",
            "wycofać",
            "wydawca",
            "wygląd",
            "wygodny",
            "wygrać",
            "wyjazd",
            "wyjątek",
            "wykonać",
            "wykład",
            "wylać",
            "wymagać",
            "wymię",
            "wymowa",
            "wymówka",
            "wynikać",
            "wynosić",
            "wypadek",
            "wyprawa",
            "wypukły",
            "wypłata",
            "wyraźny",
            "wyrostek",
            "wyrwać",
            "wyrób",
            "wysoko",
            "wystawa",
            "wysłać",
            "wytworny",
            "wywiad",
            "wyznanie",
            "wyścig",
            "wyższy",
            "wzajemny",
            "wzdłuż",
            "wzgląd",
            "wzgórze",
            "wziąć",
            "wzrost",
            "wzywać",
            "wódka",
            "wówczas",
            "wózek",
            "wąchać",
            "wąski",
            "wątroba",
            "węgiel",
            "węzeł",
            "władca",
            "włoski",
            "zabawny",
            "zabić",
            "zabrać",
            "zabytek",
            "zabójca",
            "zachęta",
            "zacząć",
            "zadanie",
            "zagadka",
            "zagrać",
            "zaimek",
            "zając",
            "zakonny",
            "zakręt",
            "zakupy",
            "zakład",
            "zależny",
            "zamach",
            "zamiast",
            "zamykać",
            "zapał",
            "zapewne",
            "zapytać",
            "zapłata",
            "zaraza",
            "zarośla",
            "zarząd",
            "zarówno",
            "zasada",
            "zasięg",
            "zasnąć",
            "zasób",
            "zatoka",
            "zatrucie",
            "zatykać",
            "zaufanie",
            "zawistny",
            "zawodowy",
            "zawrzeć",
            "zawód",
            "załoga",
            "zbierać",
            "zbiornik",
            "zbiór",
            "zboże",
            "zbrojny",
            "zbędny",
            "zdanie",
            "zdawać",
            "zdjąć",
            "zdobycie",
            "zdolny",
            "zdołać",
            "zdrada",
            "zdrowie",
            "zebranie",
            "zegarek",
            "zejść",
            "zemsta",
            "zepsuć",
            "zerwać",
            "zespół",
            "zestaw",
            "zeszły",
            "zgiełk",
            "zginąć",
            "zgodny",
            "zgraja",
            "zgubić",
            "ziarno",
            "zielony",
            "ziemniak",
            "ziewać",
            "zioło",
            "zięć",
            "zjawisko",
            "zjeść",
            "zmarły",
            "zmiana",
            "zmierzch",
            "zmuszać",
            "zmysł",
            "znacznie",
            "znajomy",
            "znosić",
            "zoolog",
            "zostać",
            "zresztą",
            "zrobić",
            "zrywać",
            "zrzucić",
            "zręczny",
            "zupełny",
            "zużycie",
            "zwiastun",
            "zwierzę",
            "zwinny",
            "związek",
            "zwolnić",
            "zwracać",
            "zwyczaj",
            "zwykły",
            "zwłoki",
            "zyskać",
            "złapać",
            "złoty",
            "ósemka",
            "ładny",
            "łagodny",
            "łapać",
            "łaska",
            "łatwy",
            "łobuz",
            "łopatka",
            "łosoś",
            "łotwa",
            "łoże",
            "łucznik",
            "łukasz",
            "łódź",
            "łąka",
            "ścisły",
            "ślepy",
            "ślimak",
            "ślubny",
            "śląsk",
            "śmiech",
            "śnieg",
            "śpiewak",
            "średnia",
            "środek",
            "śruba",
            "świerk",
            "źrenica",
            "żaden",
            "żaglowy",
            "żarłok",
            "żebro",
            "żeglarz",
            "żelazny",
            "żeński",
            "żmija",
            "żonaty",
            "żuraw",
            "życzyć",
            "żyrafa",
            "żywić",
            "żyzny",
            "żyła",
            "żółty",
            "żółw",
            "żądny"
        };
    }
};

QWCX_CORE_END_NAMESPACE

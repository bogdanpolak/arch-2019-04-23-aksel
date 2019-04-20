# Dobre praktyki programowania

### Praca zespołowa

* Zostawiajcie ślad po tym co zrobiliście
    * Wspólne repozytorium
    * Przy całodziennym kodowaniu - min. 10 rewizji (commit-ów)
* Planuj pracę
	* Wewnetrzny system działu programistycznego
	* GitHub, GitLab, etc.
* Przeglądy kodu źródłowego
    * Na początek "na żywo" - spotkanie w jednej sali
    * Docelowo off-line
* Sprawdź pracę parami przy trudniejszych tematach
    * Pair Programming - jedno z wymagań metodyki XP

### Zapachy kodu

* Kreatywność i poznawanie nowych technik
	* Nie programuj ciągle w ten sam sposób. Ucz się i eksperymentuj z nowymi sposobami kodowania.
* Zasady czystego kodu
	* Inspuruj się zasadami guru informatyki, ale ztwórz zasady odpowiednie dla zespołu w jakim pracujesz
	* Naucz się rozpoznawać zapachy kodu: kiedy śmierdzi, a kiedy ma miły zapach.

### DRY

DRY - Don't Repeat Yourself

* Unikaj kopiuj-wklej (kopy-pasteryzm)
* Uogólniaj rozwiązanie
    * uzywaj rekodrów, obiektów, tablic i list
    * odnajduj podobne wzorce i buduj reużywalne moduły
* W metodach używaj mało wyrażeń warunkowych IF / WHILE
    * szczególnie gdy niewiele się różnią zarówno pod kątem warunku, jak i tego co jest wykonywane jeśli warunek jest prawdziwy
* Separacja logiki
    * Wydzielaj logikę na zewnątrz (do klasy lub przynajmniej do autonomicznej funkcji)
    * Staraj się wstrzykiwać wszelkie zależności do klasy (Prawo Demeter)
    
### Czysty kod w Delphi

* Class helpers
  - metody operujace na klsach VCL-a i RTL-a
* Nazwy
	* Zwróć uwagę na nazwy zmiennych, funkcji i struktur
* Wielkość
	* Małe i czytelne metody / funkcje
* Programowanie obiektowe
  - Staraj się nie pisać samodzielnych funkcji i procedur 


### Zasady SOLID

![(c) Mohit Rajput - mohitrajput987 Apr 30 '17 https://dev.to/mohitrajput987/coding-best-practices-part-1-naming-conventions--class-designing-principles](https://res.cloudinary.com/practicaldev/image/fetch/s--VIyIhNNs--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://s11.postimg.org/r5n293c4z/SOLID.jpg)

1. SRP = Single Responsibility Principle
    * Klasa powinna być odpowidzialna za jedną rzecz
2. OCP = Open/Close Principle
    * Klasa musi być otwarta na rozbudowę, ale zamknięta na poprawę dobrego kodu
    * Podejrzane: wielopoziomowe if-ów / casów
    * Rozwiązania OOP: abstrakcja, polimorfizm, fabryki
    * Użycie wzorca Fabryki Abstrakcyjnej
3. LSP = Liskov Substition Principle
    * Poprawnie zbudowane drzewo dziedziczenia nie wymaga nadpisywania metod ojca, w celu poprawnego działania algorytmu
    * ```TKwadrat != class(TProstokąt)```
        * zobacz jak działa metoda WyliczPole
    * poprawnie: 
        ```
        TKwadrat = class(TFigure)
        TProstokąt = class(TFigure)
        ```
4. ISP = Interface Segreation Principle
    * Podziel interfejsy na mniejsze (spójne dziedzinowo)
5. DIP = Dependency Invertion Principle
    * Klasy z dwóch różnych warstw separuj interfejsami
    * Przykład: Klasy dziedzinowe (realizujące funkcjonalność) oraz klasy składujące dane (zbiory danych).
    * Jeśli klasa warstwy wyższej tworzy obiekty warstwy niższej to można zastosować: IoC = Inversion of Control
    * Trzech muszkieterów: DIP, IoC, DI (Dependency Injection)

### Prawo Demeter

* LoD = Law of Demeter
* Rozmawiaj tylko z przyjaciółmi, nidy z obcymi
* Klasa musi mieć dostęp lokalny do wszystkich zaleźności
	* Nie powinna odwoływać się do innych globanych struktur biznesowych

[Prezentacja na slideshare.net](https://www.slideshare.net/vladimirtsukur/law-of-demeter-objective-sense-of-style)

### Testowanie

* Testuj kod często
* Postaraj się, aby robiły to za Ciebie automaty
    * Testy jednostkowe
        * DUnitX
        * TestInsight (Stefan Glienke) [link](https://bitbucket.org/sglienke/testinsight/wiki/Home)
    * Testy integracyjne
        * DUnitX
    * Testy akceptacyjne
        * Nagrywanie i odtwarzanie
        * Ranorex Studio - [link](https://www.ranorex.com/windows-desktop-test-automation/)
        * Smartbear TestComplete - [link](https://smartbear.com/product/testcomplete/)
* Czasami warto popracować w TDD
    * Krótkie cykle:
        1. Piszę prosty test
        2. Piszę kod spełniający ten test
        3. Refaktoryzuję kod test i kod produkcyjny


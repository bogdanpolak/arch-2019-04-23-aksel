# Rozgrzewka

## Konfiguracja Git-a

1. Pobranie i instalacja Git dla Windows
    * https://git-scm.com/download/win
1. Stworzenie konfiguracji Git-a `plik .gitconfig`:
	* Dane użytkownika
	```sh
	git config --global user.email "you@example.com"
	git config --global user.name "Your Name"
	```
1. Dodanie aliasów do analizy historii  w formie drzewa
	* Modyfikacja pliku pliku konfiguracyjnego `.gitconfig` (lokalizacja: `C:\Users\{{użytkownik}}`)
	```
	[alias]
		graph1 = log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all
		graph2 = log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all
		lg = !"git graph1"
	```
1. Zmiana edytora
    * Klasyczny notatnik - Notepad
    ```sh
    git config --global core.editor C:\Windows\notepad.exe
    ```
    * Notepad++ (**zalecany**)
    ```sh
    git config --global core.editor "'C:/Program Files (x86)/Notepad++/notepad++.exe' -multiInst -notabbar -nosession -noPlugin"
    ```

1. Konto na GitHub
	* Założenie konta GitHub-ie
	* https://github.com/join

## Polecenia Git-a

| Polecenie | Opis |
| --- | --- |
| `git checkout master` | Przełączenie głowy `HEAD` na gałąź `master` |
| `git checkout -b trener` | Założenie gałęzi `trener` oraz przełączenie się na tą gałąź |
| `git add .` | Dodanie wszystkich zmienionych plików oraz wszystkich nowych plików do poczekalni |
| `git commit -m "Zmieniono plik XYZ"` | Stworzenie nowej rewizji (commit-a) na bazie poczekalni |
| `git commit -a` | Dodanie wszystkich zmienionych plików do poczekalni oraz stworzenie nowej rewizji (**Uwaga!** Nowe pliki nie zostaną dodane do poczekalni) |
| `git push` | Wysłanie wszystkich rewizji (commit-ów) do zdalnego repozytorium `origin` oraz aktualizacja wskaźnika bieżącej gałęzi na rewizję zgodną z lokalnym repozytorium. Uwaga na opcje `--set-upstream` oraz `--force`  |
| `git fetch` | Pobranie rewizji ze zdalnego repozytorium `origin`  |
| `git merge` | scalenie lokalnego wskaźnika bieżącej gałęzi ze wskaźnikiem zdalnym (*wyjasnić tryb: fast-forward*) |
| `git pull` | `git fetch` + `git merge` |
| `git checkout --track origin/osoba1` | Włączenie śledzenia wskaźnika zdalnego. Spowoduje "stworzenie" lokalnej gałęzi |


## Polecenia porządkowe Git-a

| Polecenie | Opis |
| --- | --- |
| `git reset -- {nazwa pliku}` | Usunięcie pliku z poczekalni |
| `git reset --hard` | Skasowanie wszystkich zmian w katalogu roboczym i przywrócenie plików roboczych do stanu wskazywanego aktualnie przez głowę `HEAD` |
| `git reset ver-01` | Przełączenie wskaźnika aktualnej gałęzi na tag o nazwie `ver-01`. Nie zmienia zawartości plików w katalogu roboczym |
| `git reset fde6048` | Przestawienie wskaźnika bieżącej gałęzi na rewizję (commit) o ID = `fde6048`. Nie zmienia plików roboczych. |
| `git reset --hard fde6048` | Jak wyżej, ale zmienia pliki robocze na zgodne z rewizją (kasuje zmiany w katalogu roboczym) |

## Git graficzny klient (GUI Git client)

* Fork - https://git-fork.com/
* wiele innych możliwości ... [artykuł](./GitGuiClients.md)

## Zadanie

> Dopisanie swoich danych ( imię i nazwisko oraz nick z GitHub-a )

---

* A: Rafał Pitlok / RafalPitlok
* B: Rafał Wodok / Extermi111
* C: Grzegorz Najduch / gery77n
* D: Nina Czaplicka / NinaCzaplicka
* E: Małgorzata Hetman / mhetman
* F: Marcin Kajtoch / marcinkajtoch
* G: Paweł Kantor / laki94
* Trener: Bogdan Polak

---

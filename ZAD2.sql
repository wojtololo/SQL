use D4012024Test

use TRPrzychodnia
--ZAD1
Select  P.Nazwisko, P.Imie, P.Pesel, COUNT(W.IdPacjenta) AS Liczba_Wizyt
 
	FROM Wizyty as W INNER JOIN Pacjenci as P on W.IdPacjenta = P.IdPacjenta
							
	WHERE W.DataWizyty BETWEEN '20210601' and '20211231'

	GROUP BY P.Nazwisko, P.Imie, P.Pesel
	HAVING COUNT(W.IdPacjenta) >= 3  	
	ORDER BY Liczba_Wizyt DESC
	
use TRUczelnia
--ZAD2
SELECT P.Nazwa, COUNT(O.Ocena)

	FROM Przedmioty as P INNER JOIN Oceny as O on P.IdPrzedmiotu = O.IdPrzedmiotu

	WHERE O.Ocena = 5

	GROUP BY P.Nazwa

	ORDER BY  COUNT(O.Ocena) DESC
--ZAD2*
SELECT S.Nazwisko, S.Imie, S.Pesel, AVG(O.Ocena) AS Œrednia

	FROM Studenci as S INNER JOIN Oceny as O on S.IdStudenta = O.IdStudenta

	WHERE YEAR(S.DataUrodzenia) > 1965 and YEAR(O.DataOceny) = 2020

	GROUP BY S.Nazwisko, S.Imie, S.Pesel
	HAVING COUNT(O.DataOceny) > 20
	ORDER BY Œrednia DESC
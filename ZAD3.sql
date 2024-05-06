use TRUczelnia;
-- zad1
Select S.Nazwisko, S.Imie, S.Pesel
FROM Studenci as S 
	INNER JOIN Oceny as O on O.IdStudenta = S.IdStudenta
WHERE YEAR(O.DataOceny) = 2021
GROUP BY S.Nazwisko, S.Imie, S.Pesel
HAVING (Count(O.Ocena) > 15) and (AVG(O.Ocena) > 4)

--zad2
use TRPrzychodnia;
SELECT P.Nazwisko, P.Imie, P.Pesel
FROM Pacjenci as P 
		INNER JOIN Wizyty as W on P.IdPacjenta = W.IdPacjenta
		INNER JOIN Lekarze as L on W.IdLekarza = L.IdLekarza
		INNER JOIN Specjalizacje as S on S.idspecjalizacji = L.Idspecjalizacji
WHERE (W.DataWizyty = '20200515')
	and (S.NazwaSpecjalizacji = 'Kardiolog' or S.NazwaSpecjalizacji = 'Diabetolog')
	and NOT(YEAR(W.DataWizyty) = 2020 and S.NazwaSpecjalizacji = 'Lekarz rodzinny')
GROUP BY P.Nazwisko, P.Imie, P.Pesel

--zad3
use TRUczelnia;
SELECT TOP 1 W.Nazwisko + ' ' + W.Imie as WYKLADOWCA,
	S.Nazwisko + ' ' + S.Imie as STUDENT 
FROM Wykladowcy as W
	INNER JOIN Oceny as O on O.IdWykladowcy = W.IdWykladowcy
	INNER JOIN Studenci as S on O.IdStudenta = S.IdStudenta
WHERE (YEAR(O.DataOceny) = 2019)
	and	(O.Ocena = 2)
	and not(O.Ocena = 5)
GROUP BY W.Nazwisko, W.Imie, S.Nazwisko, S.Imie
HAVING COUNT(O.Ocena) > 3
ORDER BY COUNT(O.Ocena)	DESC
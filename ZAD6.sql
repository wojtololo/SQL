use TRUczelnia;

WITH piatki as
(
	SELECT S.Nazwisko, S.Imie, S.Pesel, YEAR(O.DataOceny) as Rok,
		COUNT(O.Ocena) as ile5
	FROM Studenci as S
		INNER JOIN Oceny as O on S.IdStudenta = O.IdStudenta
	WHERE O.Ocena = 5
	GROUP BY S.Nazwisko, S.Imie, S.Pesel, YEAR(O.DataOceny)
	HAVING COUNT(O.Ocena) > 4

), dwojki as
(
	SELECT S.Nazwisko, S.Imie, S.Pesel, YEAR(O.DataOceny) as Rok,
		COUNT(O.Ocena) as ile2
	FROM Studenci as S
		INNER JOIN Oceny as O on S.IdStudenta = O.IdStudenta
	WHERE O.Ocena = 2
	GROUP BY S.Nazwisko, S.Imie, S.Pesel, YEAR(O.DataOceny)
)
	SELECT P.Nazwisko, P.Imie, P.Pesel, P.Rok, D.ile2, P.ile5
	FROM piatki as P
		JOIN dwojki as D on P.Pesel = D.Pesel
	WHERE D.ile2 > (P.ile5*2)
	GROUP BY P.Nazwisko, P.Imie, P.Pesel, P.Rok, D.ile2, P.ile5
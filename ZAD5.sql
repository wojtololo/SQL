use TRUczelnia;

WITH s2020 as 
(
	SELECT S.Nazwisko, S.Imie, S.Pesel,
		YEAR(O.DataOceny) as Rok,
		AVG(O.Ocena) as Sred2020		
	FROM Studenci as S
		INNER JOIN Oceny as O on S.IdStudenta = O.IdStudenta
	WHERE YEAR(O.DataOceny) = 2020
	GROUP BY S.Nazwisko, S.Imie, S.Pesel, YEAR(O.DataOceny)
	HAVING COUNT(O.Ocena) >= 10
), s2019 as
(
	SELECT S.Nazwisko, S.Imie, S.Pesel,
		AVG(O.Ocena) as Sred2019		
	FROM Studenci as S
		INNER JOIN Oceny as O on S.IdStudenta = O.IdStudenta
	WHERE YEAR(O.DataOceny) = 2019
	GROUP BY S.Nazwisko, S.Imie, S.Pesel, YEAR(O.DataOceny)
	HAVING COUNT(O.Ocena) >= 10
)
SELECT s2020.Nazwisko, s2020.Imie, s2020.Pesel,
	s2020.Rok, s2020.Sred2020, s2019.Sred2019 
FROM s2020
	JOIN s2019 on s2019.Pesel = s2020.Pesel
WHERE s2020.Sred2020 >= (s2019.Sred2019 + 0.6)
ORDER BY Pesel
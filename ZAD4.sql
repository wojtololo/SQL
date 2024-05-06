use TRPrzychodnia;

--zad1 

WITH Pierwsze_5 as
(
	SELECT L.Nazwisko, L.IdLekarza,  L.Imie, W.DataWizyty, S.NazwaSpecjalizacji, P.CzyKobieta,
		ROW_NUMBER() over (partition by L.Nazwisko ORDER BY W.DataWizyty) as NR,
		SUM(IIF(P.CzyKobieta = 1, 1, 0)) over (partition by L.IdLekarza
			ORDER BY W.DataWizyty rows between unbounded preceding and current row) as NARASTA
	FROM Lekarze as L
		INNER JOIN Wizyty as W on W.IdLekarza = L.IdLekarza
		INNER JOIN Pacjenci as P on P.IdPacjenta = W.IdPacjenta
		INNER JOIN Specjalizacje as S on L.Idspecjalizacji = S.idspecjalizacji
	WHERE YEAR(W.DataWizyty) = 2021
	GROUP BY L.Nazwisko, L.Imie, W.DataWizyty, S.NazwaSpecjalizacji, P.CzyKobieta, L.IdLekarza

), Co_5 as
(
	SELECT * 
	FROM Pierwsze_5
	WHERE NR = 5
		AND NARASTA = 0
	
)
	SELECT Nazwisko, Imie, NazwaSpecjalizacji
	FROM Co_5
	GROUP BY Nazwisko, Imie, NazwaSpecjalizacji;

--zad2
WITH Wszystkie_Wizyty as
(
	SELECT P.Nazwisko, P.Imie, P.Pesel, W.DataWizyty, S.NazwaSpecjalizacji,
		ROW_NUMBER() over (partition by P.Pesel ORDER BY W.DataWizyty) as NR,
		SUM(IIF(S.NazwaSpecjalizacji = 'Kardiolog', 1, 0)) over	(partition by P.Pesel
			ORDER BY W.DataWizyty rows between unbounded preceding and current row) as NARASTA
		
	FROM Pacjenci as P
		INNER JOIN Wizyty as W on W.IdPacjenta = P.IdPacjenta
		INNER JOIN Lekarze as L on W.IdLekarza = L.IdLekarza
		INNER JOIN Specjalizacje as S on L.Idspecjalizacji = S.idspecjalizacji
	WHERE YEAR(W.DataWizyty) = 2020
	GROUP BY P.Nazwisko, P.Imie, P.Pesel, W.DataWizyty, S.NazwaSpecjalizacji
), regula as
(
	SELECT Nazwisko, Imie, Pesel, DataWizyty, NazwaSpecjalizacji, NR, NARASTA,
		IIF((NARASTA > 0 AND NazwaSpecjalizacji != 'Kardiolog'), 1, 0) AS Byl_u_innego
	FROM Wszystkie_Wizyty
	GROUP BY Nazwisko, Imie, Pesel, DataWizyty, NazwaSpecjalizacji, NR, NARASTA
	HAVING NARASTA > 0
)
	SELECT Nazwisko, Imie, Pesel
	FROM regula
	WHERE NARASTA > 1
		AND Byl_u_innego = 0
	GROUP BY Nazwisko, Imie, Pesel;
use D4012024Test
use TRPrzychodnia
 
Select P.Nazwisko + ' ' + P.Imie AS Pacjent,
		L.NrEwid AS Nume_Ewidencji,
		W.Oplata
FROM Wizyty as W INNER JOIN Lekarze as L on W.IdLekarza = L.IdLekarza
						JOIN Pacjenci as P on W.IdPacjenta = P.IdPacjenta
 
WHERE  W.DataWizyty = '20130422' and
		YEAR(P.DataUrodzenia) > 1987 and
		L.CzyKobieta = 1
 
Select  P.Nazwisko, P.Imie, P.Pesel, COUNT 
 
FROM Wizyty as W INNER JOIN Pacjenci as P on W.IdPacjenta = P.IdPacjenta
						
 
WHERE W.DataWizyty BETWEEN '20130101' and '20130630'
	and S.NazwaSpecjalizacji = 'Diabetolog' OR S.NazwaSpecjalizacji = 'Chirurg'
 
SELECT L.Nazwisko + ' ' + L.Imie AS Lekarz,
		P.Nazwisko + ' ' + P.Imie AS Pacjent,
		W.DataWizyty, W.Oplata
FROM Wizyty as W INNER JOIN Lekarze as L on W.IdLekarza = L.IdLekarza
						JOIN Pacjenci as P on W.IdPacjenta = P.IdPacjenta

WHERE YEAR(W.DataWizyty) = '2013'
		and MONTH(W.DataWizyty) = '03'
ORDER BY W.DataWizyty ASC
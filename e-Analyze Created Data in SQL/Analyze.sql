--These descriptions are both Turkish and English

--Marmara Bolgesinde Tuketici kategorisinde en fazla satisin oldugu ay
--The month with the highest sales in the Personel category in the Marmara Region
 
SELECT TOP 1 DATENAME(MONTH,Date_) Date_,Category,Region,SUM(Sales) Sales
FROM Credits KD
INNER JOIN Branch S on S.Sube_ID=KD.Sube_ID
WHERE Category='Personal' AND Region='Marmara Bölgesi'
GROUP BY Date_,Category,Region
ORDER BY Sales DESC


--Marmara Bolgesinde En fazla Satisin Oldugu ay ve Kategori
--Month and Category with the Most Sales in the Marmara Region
SELECT TOP 1 DATENAME(MONTH,Date_) Date_,Category,Region,SUM(Sales) Sales
FROM Credits KD
INNER JOIN Branch S on S.Sube_ID=KD.Sube_ID
WHERE Region='Marmara Bölgesi'
GROUP BY Date_,Category,Region
ORDER BY Sales DESC

--Akdeniz Bolgesinde Tuketici kategorisinde her ayin toplam satislari
--Total sales of each month in the Personal category in the Akdeniz Region
SELECT  DATENAME(MONTH,Date_) Date_,Category,Region,SUM(Sales) Sales
FROM Credits KD
INNER JOIN Branch S on S.Sube_ID=KD.Sube_ID
WHERE Category='Personal' AND Region='Akdeniz Bölgesi'
GROUP BY Date_,Category,Region
ORDER BY Sales DESC


--Istanbul Subesinde Tuketici Kategorisinde En Fazla Satisin Yapildigi Ay
--The Month with the Most Sales in the Personal Category in the Istanbul Branch
SELECT TOP 1  Branch_Name, DATENAME(MONTH,Date_) Date_,Category,Region,SUM(Sales) Sales
FROM Credits KD
INNER JOIN Branch S on S.Sube_ID=KD.Sube_ID
WHERE Category='Personal' AND Branch_Name='Ýstanbul Branch'
GROUP BY Date_,Category,Region,Branch_Name
ORDER BY Sales DESC



--Istanbul Subesinde Tuketici Kategorisinde En Az Satis Yaptigi Ay
--Month with Least Sales in Personal Category in Istanbul Branch
SELECT TOP 1 DATENAME(MONTH,Date_) Date_,Branch_Name,Category,Region,SUM(Sales) Sales
FROM Credits KD
INNER JOIN Branch S on S.Sube_ID=KD.Sube_ID
WHERE Category='Personal' AND Branch_Name='Ýstanbul Branch'
GROUP BY Date_,Category,Region,Branch_Name
ORDER BY Sales ASC

--Marmara Bolgesinde Tasit Kategorisinde En Az Satisin Yapildigi Sube ve Ay
--Branch and Month with the Least Sales in the Auto Category in the Marmara Region
SELECT TOP 1 DATENAME(MONTH,Date_) Date_,Branch_Name,Category,Region,SUM(Sales) Sales
FROM Credits KD
INNER JOIN Branch S on S.Sube_ID=KD.Sube_ID
WHERE Category='Auto' AND Region='Marmara Bölgesi'
GROUP BY Date_,Category,Region,Branch_Name
ORDER BY Sales ASC

--Haziran Ayinda Dogu Anadolu Bolgesinde En Fazla Satis Yapan Sube
--The Branch with the Most Sales in the Doðu Anadolu Region in June
SELECT TOP 1 Branch_Name,Region,DATENAME(MONTH,Date_) AY,SUM(Sales) Sales

FROM Credits KD
JOIN Branch S ON S.Sube_ID=KD.Sube_ID
WHERE DATENAME(MONTH,Date_)='June' and Region='DOÐU ANADOLU BÖLGESÝ'
GROUP BY Branch_Name,Region,DATENAME(MONTH,Date_)
ORDER BY Sales DESC

--Guneydogu Anadolu Bolgesinde Her Ayin En Cok Satis Yapan Subesi
--The Most Sales Branch of Every Month in the Güneydoðu Anadolu Region
SELECT Branchs,Dates,Sales
FROM
( SELECT Branch_Name Branchs,Date_ Dates,SUM(Sales) as Sales,
RANK () over (partition by Date_ Order By SUM(Sales) DESC )rn
FROM Credits KD
JOIN Branch S on S.Sube_ID=KD.Sube_ID
WHERE MONTH(Date_) between 1 and 12 and Region='Güneydoðu Anadolu Bölgesi'
GROUP BY Branch_Name,Date_
)t
WHERE rn<=1






--Bolgelerin Satis Toplamlari
--Total Sales of Regions
SELECT Region,SUM(Sales) SumSales
FROM Credits KD
JOIN Branch S ON KD.Sube_ID=S.Sube_ID
GROUP BY Region
ORDER BY SumSales DESC


--Bolgelerin Ocak Ayindaki Satis Toplamlari
--Total Sales of the Regions in January
SELECT Region,SUM(Sales) SumSales

FROM Credits KD
JOIN Branch S ON KD.Sube_ID=S.Sube_ID
WHERE DATENAME(MONTH,Date_)='January'
GROUP BY Region
ORDER BY SumSales DESC


--Her Subenin tuketici, tasit, konut kredisi satislarinin aylik satis toplamlarinin 12 aylik ortalamasi
--The monthly average aggregated sales for the personal,auto,mortgage loans of each Branch over a 12 month period.
SELECT  Branch_Name,AVG(SumSales) AvgSumSales FROM
( SELECT Branch_Name,SUM(Sales) SumSales

FROM Credits KD
JOIN Branch S ON KD.Sube_ID=S.Sube_ID
GROUP BY Branch_Name,DATENAME(MONTH,Date_) 
) T
GROUP BY Branch_Name
ORDER BY  2 DESC

--Marmara Bolgesindeki Subelerin Aylik Satis Toplamlarinin 12 Aylik Ortalamasi
--The monthly average aggregated sales for the Marmara Region Branches over a 12 month period
SELECT  Branch_Name,Region,AVG(SumSales) AVGSumSales FROM
( SELECT Branch_Name,Region,SUM(Sales) SumSales

FROM Credits KD
JOIN Branch S ON KD.Sube_ID=S.Sube_ID
WHERE Region='Marmara Bölgesi'
GROUP BY Branch_Name,DATENAME(MONTH,Date_),Region
) T
GROUP BY Branch_Name,Region
ORDER BY  AVGSumSales DESC




--Bolge bazinda Subelerin tuketici, tasit, konut kredisi satislarinin aylik toplamlarýnýn 12 aylik ortalamasý
--The monthly average aggregated sales for the Regions over a 12 month period.
SELECT  Region,AVG(SumSales) AvgSumSales FROM
( SELECT Region,SUM(Sales) SumSales

FROM Credits KD
JOIN Branch S ON KD.Sube_ID=S.Sube_ID

GROUP BY Region,DATENAME(MONTH,Date_) 

) T
GROUP BY Region
ORDER BY  2 DESC

--GUNEYDOGU ANADOLU BOLGESI'ndeki Subelerin kategori satislarinin her ay ortalamasi
--Average of category sales of Branches in Güneydoðu Anadolu Region for each month

SELECT Branch_Name,Region,DATENAME(MONTH,Date_) AY,AVG(Sales) Ortalama

FROM Credits KD
JOIN Branch S ON KD.Sube_ID=S.Sube_ID
WHERE Region='GÜNEYDOÐU ANADOLU BÖLGESÝ'
GROUP BY Branch_Name,DATENAME(MONTH,Date_),Region
ORDER BY Branch_Name DESC



--Istanbul Subesinin tuketici, tasit, konut kategorisi satislarinin her ay icin ortalamasi
--Average of Istanbul Branch's consumer, vehicle and housing category sales for each month
SELECT Branch_Name,DATENAME(MONTH,Date_) AY,AVG(Sales) AvgSales

FROM Credits KD
JOIN Branch S ON KD.Sube_ID=S.Sube_ID
WHERE Branch_Name='Ýstanbul Branch'
GROUP BY Branch_Name,DATENAME(MONTH,Date_)
ORDER BY 3 DESC

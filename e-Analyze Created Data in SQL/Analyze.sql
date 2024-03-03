--These descriptions are both Turkish and English

--Marmara Bölgesinde Tüketici kategorisinde en fazla satýþýn olduðu ay
--The month with the highest sales in the Personel category in the Marmara Region
 
SELECT TOP 1 DATENAME(MONTH,Date_) Date_,Category,Region,SUM(Sales) Sales
FROM Credits KD
INNER JOIN Branch S on S.Sube_ID=KD.Sube_ID
WHERE Category='Personal' AND Region='Marmara Bölgesi'
GROUP BY Date_,Category,Region
ORDER BY Sales DESC


--Marmara Bölgesinde En fazla Satýþýn Olduðu ay ve Kategori
--Month and Category with the Most Sales in the Marmara Region
SELECT TOP 1 DATENAME(MONTH,Date_) Date_,Category,Region,SUM(Sales) Sales
FROM Credits KD
INNER JOIN Branch S on S.Sube_ID=KD.Sube_ID
WHERE Region='Marmara Bölgesi'
GROUP BY Date_,Category,Region
ORDER BY Sales DESC

--Akdeniz Bölgesinde Tüketici kategorisinde her ayýn toplam satýþlarý
--Total sales of each month in the Personal category in the Akdeniz Region
SELECT  DATENAME(MONTH,Date_) Date_,Category,Region,SUM(Sales) Sales
FROM Credits KD
INNER JOIN Branch S on S.Sube_ID=KD.Sube_ID
WHERE Category='Personal' AND Region='Akdeniz Bölgesi'
GROUP BY Date_,Category,Region
ORDER BY Sales DESC


--istanbul Þubesinde Tüketici Kategorisinde En Fazla Satýþýn Yapýldýðý Ay
--The Month with the Most Sales in the Personal Category in the Istanbul Branch
SELECT TOP 1  Branch_Name, DATENAME(MONTH,Date_) Date_,Category,Region,SUM(Sales) Sales
FROM Credits KD
INNER JOIN Branch S on S.Sube_ID=KD.Sube_ID
WHERE Category='Personal' AND Branch_Name='Ýstanbul Branch'
GROUP BY Date_,Category,Region,Branch_Name
ORDER BY Sales DESC



--Ýstanbul Þubesinde Tüketici Kategorisinde En Az Satýþ Yaptýðý Ay
--Month with Least Sales in Personal Category in Istanbul Branch
SELECT TOP 1 DATENAME(MONTH,Date_) Date_,Branch_Name,Category,Region,SUM(Sales) Sales
FROM Credits KD
INNER JOIN Branch S on S.Sube_ID=KD.Sube_ID
WHERE Category='Personal' AND Branch_Name='Ýstanbul Branch'
GROUP BY Date_,Category,Region,Branch_Name
ORDER BY Sales ASC

--Marmara Bölgesinde Taþýt Kategorisinde En Az Satýþýn Yapýldýðý Þube ve Ay
--Branch and Month with the Least Sales in the Auto Category in the Marmara Region
SELECT TOP 1 DATENAME(MONTH,Date_) Date_,Branch_Name,Category,Region,SUM(Sales) Sales
FROM Credits KD
INNER JOIN Branch S on S.Sube_ID=KD.Sube_ID
WHERE Category='Auto' AND Region='Marmara Bölgesi'
GROUP BY Date_,Category,Region,Branch_Name
ORDER BY Sales ASC

--Haziran Ayýnda Doðu Anadolu Bölgesinde En Fazla Satýþ Yapan Þube
--The Branch with the Most Sales in the Doðu Anadolu Region in June
SELECT TOP 1 Branch_Name,Region,DATENAME(MONTH,Date_) AY,SUM(Sales) Sales

FROM Credits KD
JOIN Branch S ON S.Sube_ID=KD.Sube_ID
WHERE DATENAME(MONTH,Date_)='June' and Region='DOÐU ANADOLU BÖLGESÝ'
GROUP BY Branch_Name,Region,DATENAME(MONTH,Date_)
ORDER BY Sales DESC

--Güneydoðu Anadolu Bölgesinde Her Ayýn En Çok Satýþ Yapan Þubesi
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






--Bölgelerin Satýþ Toplamlarý
--Total Sales of Regions
SELECT Region,SUM(Sales) SumSales
FROM Credits KD
JOIN Branch S ON KD.Sube_ID=S.Sube_ID
GROUP BY Region
ORDER BY SumSales DESC


--Bölgelerin Ocak Ayýndaki Satýþ Toplamlarý
--Total Sales of the Regions in January
SELECT Region,SUM(Sales) SumSales

FROM Credits KD
JOIN Branch S ON KD.Sube_ID=S.Sube_ID
WHERE DATENAME(MONTH,Date_)='January'
GROUP BY Region
ORDER BY SumSales DESC


--Her Þubenin tüketici, taþýt, konut kredisi satýþlarýnýn aylýk satýþ toplamlarýnýn 12 aylýk ortalamasý
--The monthly average aggregated sales for the personal,auto,mortgage loans of each Branch over a 12 month period.
SELECT  Branch_Name,AVG(SumSales) AvgSumSales FROM
( SELECT Branch_Name,SUM(Sales) SumSales

FROM Credits KD
JOIN Branch S ON KD.Sube_ID=S.Sube_ID
GROUP BY Branch_Name,DATENAME(MONTH,Date_) 
) T
GROUP BY Branch_Name
ORDER BY  2 DESC

--Marmara Bölgesindeki Þubelerin Aylýk Satýþ Toplamlarýnýn 12 Aylýk Ortalamasý
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




--Bölge bazýnda  Þubelerin tüketici, taþýt, konut kredisi satýþlarýnýn aylýk toplamlarýnýn 12 aylýk ortalamasý
--The monthly average aggregated sales for the Regions over a 12 month period.
SELECT  Region,AVG(SumSales) AvgSumSales FROM
( SELECT Region,SUM(Sales) SumSales

FROM Credits KD
JOIN Branch S ON KD.Sube_ID=S.Sube_ID

GROUP BY Region,DATENAME(MONTH,Date_) 

) T
GROUP BY Region
ORDER BY  2 DESC

--GÜNEYDOÐU ANADOLU BÖLGESÝ'ndeki Þubelerin kategori satýþlarýnýn her ay ortalamasý
--Average of category sales of Branches in Güneydoðu Anadolu Region for each month

SELECT Branch_Name,Region,DATENAME(MONTH,Date_) AY,AVG(Sales) Ortalama

FROM Credits KD
JOIN Branch S ON KD.Sube_ID=S.Sube_ID
WHERE Region='GÜNEYDOÐU ANADOLU BÖLGESÝ'
GROUP BY Branch_Name,DATENAME(MONTH,Date_),Region
ORDER BY Branch_Name DESC



--Ýstanbul Þubesinin tüketici, taþýt, konut kategorisi satýþlarýnýn her ay için ortalamasý
--Average of Istanbul Branch's consumer, vehicle and housing category sales for each month
SELECT Branch_Name,DATENAME(MONTH,Date_) AY,AVG(Sales) AvgSales

FROM Credits KD
JOIN Branch S ON KD.Sube_ID=S.Sube_ID
WHERE Branch_Name='Ýstanbul Branch'
GROUP BY Branch_Name,DATENAME(MONTH,Date_)
ORDER BY 3 DESC


--Using the data in our CityPopulation table, we will create our PopulationRange table in which we will determine the Minimum and Maximum values to create sales data based on population
--Firstly we create PopulationRange table 
CREATE TABLE PopulationRange(City varchar(100),SumPopulation Float,MinValue float,MaxValue Float)
--Then, we enter our first row into PopulationRange table manually and then we will create our script for PopulationRange table.
INSERT INTO PopulationRange(City,SumPopulation,MinValue,MaxValue)
VALUES('Ýstanbul',15519267,0,18.69)
--We write our script

DECLARE @SumPopulation as FLOAT
DECLARE @City as VARCHAR(100)
DECLARE @PopulationRatio as FLOAT
DECLARE @CalculatePop as FLOAT
DECLARE @MinValue as FLOAT
DECLARE @MaxValue as FLOAT
DECLARE @K AS INT=2

WHILE @K<82
BEGIN

SELECT @City=City FROM CityPopulation WHERE ID=@K
SELECT @SumPopulation=Sum_Population FROM CityPopulation WHERE ID=@K
SELECT @MinValue=MaxValue FROM PopulationRange WHERE ID=@K-1
SELECT @CalculatePop=Sum_Population FROM CityPopulation WHERE ID=@K
SET @PopulationRatio=(@CalculatePop/1000000)*1.70
SET @MaxValue=@MinValue+@PopulationRatio

INSERT INTO PopulationRange(City,SumPopulation,MinValue,MaxValue)
VALUES (@City,@SumPopulation,@MinValue,@MaxValue)

SET @K=@K+1


END



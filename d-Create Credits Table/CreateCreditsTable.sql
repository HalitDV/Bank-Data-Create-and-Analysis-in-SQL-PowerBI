--Finally we will create 'Credits Table' for each category which Personal,Mortgage,Auto using 'PopulationRange' table
--Firstly we create table
CREATE TABLE Credits(Sube_ID int, Category varchar(50),Date_ date,Sales int,Sales_Target int))
--And then we create our scripts for Credits Table

DECLARE @Sube_ID as int
DECLARE @Category as varchar(100)
DECLARE @DateID as int=1
DECLARE @Date_ as DATE='2023/01/25'
DECLARE @MaxValue as FLOAT	
DECLARE @MinValue as FLOAT
DECLARE @RAND as INT
DECLARE @RAND2 AS INT
DECLARE @Target as int
DECLARE @Sales int
--
WHILE @DateID<13
BEGIN

--



DECLARE @K AS INT=1
WHILE @K<82
BEGIN
SELECT @Sube_ID=ID FROM PopulationRange WHERE ID=@K
SET @Category='Personal'
SET @MinValue=(SELECT MinValue FROM PopulationRange WHERE ID=@K)
SET @MaxValue=(SELECT MaxValue FROM PopulationRange WHERE ID=@K)
SET @RAND=CONVERT(INT,RAND()*(3500-2000))+2000
SET @RAND2=CONVERT(INT,RAND()*(3500-2010))+2010
SET @Sales=CONVERT(INT,(@MaxValue-@MinValue)*@RAND)
SET @Target=CONVERT(INT,(@MaxValue-@MinValue)*@RAND2)


INSERT INTO Credits(Sube_ID,Category,Date_,Sales,Sales_Target)
VALUES(@Sube_ID,@Category,@Date_,@Sales,@Target)

SET @K=@K+1
END
--
DECLARE @B AS INT=1
WHILE @B<82
BEGIN
SELECT @Sube_ID=ID FROM PopulationRange WHERE ID=@B
SET @Category='Mortgage'
SET @MinValue=(SELECT MinValue FROM PopulationRange WHERE ID=@B)
SET @MaxValue=(SELECT MaxValue FROM PopulationRange WHERE ID=@B)
SET @RAND=CONVERT(INT,RAND()*(3500-2000))+2000
SET @RAND2=CONVERT(INT,RAND()*(3500-2010))+2010
SET @Sales=CONVERT(INT,(@MaxValue-@MinValue)*@RAND)
SET @Target=CONVERT(INT,(@MaxValue-@MinValue)*@RAND2)


INSERT INTO Credits(Sube_ID,Category,Date_,Sales,Sales_Target)
VALUES(@Sube_ID,@Category,@Date_,@Sales,@Target)


SET @B=@B+1

END
--
DECLARE @S AS INT=1
WHILE @S<82
BEGIN
SELECT @Sube_ID=ID FROM PopulationRange WHERE ID=@S
SET @Category='Auto'
SET @MinValue=(SELECT MinValue FROM PopulationRange WHERE ID=@S)
SET @MaxValue=(SELECT MaxValue FROM PopulationRange WHERE ID=@S)
SET @RAND=CONVERT(INT,RAND()*(3500-2000))+2000
SET @RAND2=CONVERT(INT,RAND()*(3500-2010))+2010
SET @Sales=CONVERT(INT,(@MaxValue-@MinValue)*@RAND)
SET @Target=CONVERT(INT,(@MaxValue-@MinValue)*@RAND2)


INSERT INTO Credits(Sube_ID,Category,Date_,Sales,Sales_Target)
VALUES(@Sube_ID,@Category,@Date_,@Sales,@Target)

SET @S=@S+1
END

SET @DateID=@DateID+1
SET @Date_=DATEADD(MONTH,1,@Date_)

END

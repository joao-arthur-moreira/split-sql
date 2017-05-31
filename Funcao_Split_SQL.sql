/*
   @Descritption: Função para quebrar uma string a partir de um delimitador
   @Version: 1.0
   @Date: 02/06/2016
   @Author: João Arthur
   @Ex.: select * from dbo.Split('98958;09766',';')
*/
CREATE FUNCTION Split (
  @InputString VARCHAR(8000),
  @Delimiter   VARCHAR(50)
)
RETURNS @Items TABLE (
  Item VARCHAR(8000)
)
AS
BEGIN
  IF @Delimiter = ' '
  BEGIN
    SET @Delimiter = ','
    SET @InputString = REPLACE(@InputString, ' ', @Delimiter)
  END
  -- se o delimitador for vazio seto um valor default 
  IF (@Delimiter IS NULL OR @Delimiter = '')
    SET @Delimiter = ','
  DECLARE @Item       VARCHAR(8000)
  DECLARE @ItemList   VARCHAR(8000)
  DECLARE @DelimIndex INT
  
  SET @ItemList = @InputString
  SET @DelimIndex = CHARINDEX(@Delimiter, @ItemList, 0)
  WHILE (@DelimIndex != 0)
  BEGIN
    SET @Item = SUBSTRING(@ItemList, 0, @DelimIndex)
    INSERT INTO @Items VALUES (@Item)            
    SET @ItemList = SUBSTRING(@ItemList, @DelimIndex+1, LEN(@ItemList)-@DelimIndex)
    SET @DelimIndex = CHARINDEX(@Delimiter, @ItemList, 0)
  END 
  IF @Item IS NOT NULL
  BEGIN
    SET @Item = @ItemList
    INSERT INTO @Items VALUES (@Item)
  END      
  ELSE 
    INSERT INTO @Items VALUES (@InputString)

  RETURN
END
GO
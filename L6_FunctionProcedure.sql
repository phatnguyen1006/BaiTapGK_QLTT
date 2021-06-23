USE QLDT

-------------------------------------------------------------------
-- Set Up Funciton

-- CREATE FUNCTION [schema_name.]function_name
-- ( [ @parameter [ AS ] [type_schema_name.] datatype
-- [ = default ] [ READONLY ]
-- , @parameter [ AS ] [type_schema_name.] datatype
-- [ = default ] [ READONLY ] ]
-- )

-- RETURNS return_datatype

-- [ WITH { ENCRYPTION
-- | SCHEMABINDING
-- | RETURNS NULL ON NULL INPUT
-- | CALLED ON NULL INPUT
-- | EXECUTE AS Clause ]

-- [ AS ]

-- BEGIN

-- [declaration_section]

-- executable_section

-- RETURN return_value

-- END;
-------------------------------------------------------------------


-- Bai 4
--- 4.1
GO
CREATE PROCEDURE ShowAVG_DT
@msdt char(6),
@avg float OUTPUT
AS
BEGIN
    -- DECLARE
    DECLARE @avg1 float;
    DECLARE @avg2 float;
    DECLARE @avg3 float;
    -- Check AVG from GV_HDDT
    SELECT @avg1 = avg(DIEM)
    FROM GV_HDDT
    WHERE MSDT=@msdt
    -- Check AVG from GV-PBDT
    SELECT @avg2 = avg(DIEM)
    FROM GV_PBDT
    WHERE MSDT=@msdt
    -- Check AVG from GV_UVDT
    SELECT @avg3 = avg(DIEM)
    FROM GV_UVDT
    WHERE MSDT=@msdt
    -- Result
    SET @avg = (@avg1+ @avg2 + @avg3)/3;
END;

GO
DECLARE @lastAvg float;
EXEC ShowAVG_DT @msdt='97001', @avg=@lastAvg OUTPUT;
SELECT @lastAvg AS B2;


--- 4.2
GO
CREATE FUNCTION ListAVG ( @msdt char(6) )
RETURNS FLOAT
AS
BEGIN
    -- define variables
    DECLARE @avg float;
    DECLARE @avg1 float;
    DECLARE @avg2 float;
    DECLARE @avg3 float;
    -- Check AVG from GV_HDDT
    SELECT @avg1 = avg(DIEM)
    FROM GV_HDDT
    WHERE MSDT = @msdt
    if (@avg1 IS NULL)
        SET @avg1 = 0
    -- Check AVG from GV_PBDT
    SELECT @avg2 = avg(DIEM)
    FROM GV_PBDT
    WHERE MSDT = @msdt
    if (@avg2 IS NULL)
        SET @avg2 = 0
    -- Check AVG from GV_UVDT
    SELECT @avg3 = avg(DIEM)
    FROM GV_UVDT
    WHERE MSDT = @msdt
    if (@avg3 IS NULL)
        SET @avg3 = 0
    -- Result
    SET @avg = (@avg1+@avg2+@avg3)/3;
    -- return
    RETURN @avg;
END;

GO
SELECT MSDT, TENDT, [dbo].[ListAVG](MSDT) as AV
FROM DETAI

--- 4.2 -- Giao Vien PB
GO
CREATE FUNCTION GV_PB ( @msgv int )
RETURNS nvarchar(30)
AS
BEGIN
    -- DECLARE
    DECLARE @tengv nvarchar(30);
    -- Query GIAOVIEN PB
    SELECT @tengv=TENGV
    FROM GIAOVIEN
    WHERE MSGV = @msgv
    -- return
    RETURN @tengv;
END;

GO
SELECT MSGV, [dbo].[GV_PB](MSGV) as TEN
FROM GV_PBDT

--- 4.3
GO
CREATE FUNCTION DT_HD ( @msdt char(6) )
RETURNS nvarchar(30)
AS
BEGIN
    -- DECLARE
    DECLARE @tendt nvarchar(30);
    -- Query TEN DT from DETAI
    SELECT @tendt= TENDT
    FROM DETAI
    WHERE MSDT =@msdt

    -- return
    RETURN @tendt;
END;

GO
SELECT MSDT, [dbo].[DT_HD](MSDT)
FROM HOIDONG_DT


-- CLEAR
GO
DROP PROCEDURE ShowAVG_DT; -- 4.1
-- DROP FUNCTION ListAVG; -- 4.2
DROP FUNCTION GV_PB; -- 4.2
DROP FUNCTION DT_HD; -- 4.3

use master
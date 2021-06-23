-- STORE PROCEDURE
USE QLDT
--- A.1
GO
CREATE PROCEDURE CheckHH_GV
@msgv int,
@tengv nvarchar(30),
@sodt nvarchar(50),
@diachi varchar(10),
@mshh int,
@namhh smalldatetime
AS
BEGIN
    IF NOT EXISTS (
        SELECT *
        FROM HOCHAM
        WHERE MSHH=@mshh)
        PRINT 0;
    ELSE
        INSERT INTO GIAOVIEN
        VALUES (@msgv, @tengv, @sodt, @diachi, @mshh, @namhh)
END;

GO
EXEC CheckHH_GV @msgv=00206,
@tengv='Chu Tiến',@sodt='46466646',
@diachi='Hà Nội',@mshh='3',@namhh='2005';

--- A.2
GO
CREATE PROCEDURE CheckGV_GV
@msgv int,
@tengv nvarchar(30),
@sodt nvarchar(50),
@diachi varchar(10),
@mshh int,
@namhh smalldatetime
AS
BEGIN
    IF EXISTS (
        SELECT *
        FROM GIAOVIEN
        WHERE MSGV=@msgv
    )
        PRINT 0;
    ELSE
        INSERT INTO GIAOVIEN
        VALUES (@msgv, @tengv, @sodt, @diachi, @mshh, @namhh)
END;

GO
EXEC CheckGV_GV @msgv=00205,
@tengv='Chu Tiến',@sodt='46466646',
@diachi='Hà Nội',@mshh='2',@namhh='2005';

--- A.3
GO
CREATE PROCEDURE CheckHHGV_GV
@msgv int,
@tengv nvarchar(30),
@sodt nvarchar(50),
@diachi varchar(10),
@mshh int,
@namhh smalldatetime
AS
BEGIN
    IF (EXISTS (
        SELECT *
        FROM GIAOVIEN
        WHERE MSGV=@msgv
    ))
        PRINT 0
    ELSE IF (NOT EXISTS (
        SELECT *
        FROM HOCHAM
        WHERE MSHH=@mshh
    ))
        PRINT 1
    ELSE
        INSERT INTO GIAOVIEN
        VALUES (@msgv, @tengv, @sodt, @diachi, @mshh, @namhh)
END;

GO
EXEC CheckHHGV_GV @msgv=00205,
@tengv='Chu Tiến',@sodt='46466646',
@diachi='Hà Nội',@mshh='2',@namhh='2005';

--- A.4
GO
CREATE PROCEDURE UpdateDT_DT
@msdt char(6),
@tendt nvarchar(30)
AS
BEGIN
    IF (NOT EXISTS (
        SELECT *
        FROM DETAI
        WHERE MSDT=@msdt
    ))
        PRINT 0
    ELSE
        UPDATE DETAI
        SET TENDT=@tendt
        WHERE MSDT=@msdt
        PRINT 1
END;

GO
EXEC UpdateDT_DT @msdt='97007', @tendt='Quản lý vé máy bay';
EXEC UpdateDT_DT @msdt='97001', @tendt='Quản lý vé máy bay';

--- A.5
GO
CREATE PROCEDURE UpdateSV_SV
@mssv char(8),
@tensv nvarchar(30),
@diachi nchar(50)
AS
BEGIN
    IF (NOT EXISTS (
        SELECT *
        FROM SINHVIEN
        WHERE MSSV=@mssv
    ))
        PRINT 0
    ELSE
    BEGIN
        UPDATE SINHVIEN
        SET TENSV=@tensv
        WHERE MSSV=@mssv
        PRINT 1
    END
END;

GO
EXEC UpdateSV_SV @mssv='13522007', @tensv='Nguyễn Phúc An', @diachi='QUẬN 5';

-- STORED PROCEDURES WITH OUTPUT
--- B.1
GO
CREATE PROCEDURE CountHV_GV
@tenhv nvarchar(20),
@countgv int OUTPUT
AS
BEGIN
    SELECT @countgv = COUNT(MSGV)
    FROM GV_HV_CN GV, HOCVI HV
    WHERE TENHV=@tenhv
    AND GV.MSHV=HV.MSHV
END;

GO
DECLARE @count int;
EXEC CountHV_GV @tenhv=N'Kỹ sư', @countgv=@count OUTPUT;
select @count AS B1;

--- B.2
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

-- B.4
GO
CREATE PROCEDURE ShowHD_HD
@mshd int,
@tenct nvarchar(30) OUTPUT,
@sdt varchar(10) OUTPUT
AS
BEGIN
    DECLARE @msgv int;
    
    IF (NOT EXISTS (
    -- Find President
        SELECT GV.TENGV, GV.SODT
        FROM HOIDONG HD, GIAOVIEN GV
        WHERE HD.MSHD=@mshd
        AND HD.MSGV=HD.MSGV
    ))
        PRINT 0
    ELSE
    BEGIN
        SELECT @tenct = GV.TENGV, @sdt = GV.SODT
        FROM HOIDONG HD, GIAOVIEN GV
        WHERE HD.MSHD=@mshd
        AND HD.MSGV=HD.MSGV
    END
END;

GO
DECLARE @ct nvarchar(30), @sdt varchar(10);
EXEC ShowHD_HD @mshd=2, @tenct=@ct OUTPUT, @sdt=@sdt OUTPUT;
SELECT @ct as B4_TENCT, @sdt as B4_SDT;

--- CLEAR
---- A
GO
DROP PROCEDURE CheckHH_GV; -- A.1
DROP PROCEDURE CheckGV_GV; -- A.2
DROP PROCEDURE CheckHHGV_GV; -- A.3
DROP PROCEDURE UpdateDT_DT; -- A.4
DROP PROCEDURE UpdateSV_SV -- A.5
---- B
GO
DROP PROCEDURE CountHV_GV -- B.1
DROP PROCEDURE ShowAVG_DT; -- B.2
DROP PROCEDURE ShowHD_HD; -- B.4

USE QLSACH
GO

-- PROCEDURE
--- Procedure to Report
--- Params : NXB{ min: 2019, max: 2021 }
GO
CREATE PROCEDURE REPORT
@min int, @max int
AS
BEGIN
    SELECT *
    FROM TG_SACH
    WHERE NAMXB BETWEEN @min AND @max
END

GO
DROP PROCEDURE REPORT

--- Q: Đưa vào MSSACH trả ra: tên sách, tác giả, năm xuất bản.

GO
CREATE PROCEDURE SHOW_SACH
@mssach char(3),
@tensach nvarchar(25) OUTPUT,
@tentg nvarchar(60) OUTPUT,
@namxb int OUTPUT
AS
BEGIN
    DECLARE @mstg char(4)
    -- Find out the Data
    IF (NOT EXISTS(
        SELECT S.TENSACH, TG.TENTG, TG_S.NAMXB
        FROM SACH S, TACGIA TG, TG_SACH TG_S
        WHERE S.MSSACH = @mssach
        AND S.MSSACH = TG_S.MSSACH
        AND TG_S.MSTG = TG.MSTG
    ))
        PRINT 0
    ELSE
        BEGIN
            SELECT @tensach= S.TENSACH,@tentg= TG.TENTG,@namxb= TG_S.NAMXB
            FROM SACH S, TACGIA TG, TG_SACH TG_S
            WHERE S.MSSACH = @mssach
            AND S.MSSACH = TG_S.MSSACH
            AND TG_S.MSTG = TG.MSTG
        END
END;

GO
DECLARE @tensach nvarchar(25), @tentg nvarchar(60), @namxb int;
-- Case Đúng
EXEC SHOW_SACH @mssach='S01', @tensach=@tensach OUTPUT, @tentg=@tentg OUTPUT, @namxb=@namxb OUTPUT;
SELECT @tensach as Ten_Sach, @tentg as Ten_TG, @namxb as NAM_XB;
-- Case Sai
EXEC SHOW_SACH @mssach='S05', @tensach=@tensach OUTPUT, @tentg=@tentg OUTPUT, @namxb=@namxb OUTPUT;
SELECT @tensach as Ten_Sach, @tentg as Ten_TG, @namxb as NAM_XB;

GO
DROP PROCEDURE SHOW_SACH;

-- TRIGGER
--- Q: Xóa một sách thì sẽ xóa tất cả các thông tin liên quan.

GO
CREATE TRIGGER DEL_SACH ON SACH
FOR DELETE
AS
BEGIN
    DECLARE @mssach char(3);
    -- Get the SACH Code
    SELECT @mssach= MSSACH
    FROM DELETED
    -- Delete In TG_SACH Table
    DELETE
    FROM TG_SACH
    WHERE TG_SACH.MSSACH = @mssach
    -- Last Checking
    IF (NOT EXISTS(
        SELECT *
        FROM SACH S, TG_SACH TG_S
        WHERE S.MSSACH=@mssach
        AND S.MSSACH=TG_S.MSSACH
    ))
        PRINT 'Xoa Thanh Cong'
    ELSE
        BEGIN
            PRINT 'Xoa That Bai'
            ROLLBACK TRANSACTION
        END
END

DELETE
FROM SACH
WHERE MSSACH = 'S04'

SELECT *
FROM SACH

GO
DROP TRIGGER DEL_SACH
---
GO
USE master

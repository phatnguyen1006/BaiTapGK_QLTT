
USE QLSACH
GO

-- PROCEDURE
--- Q: Đưa vào MSSACH trả ra: tên sách, tác giả, năm xuất bản.

GO
CREATE PROCEDURE SHOW_SACH
@mssach char(3),
@tensach varchar(25) OUTPUT,
@tentg varchar(20) OUTPUT,
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
DECLARE @tensach varchar(25), @tentg varchar(20), @namxb int;
EXEC SHOW_SACH @mssach='S01', @tensach=@tensach OUTPUT, @tentg=@tentg OUTPUT, @namxb=@namxb OUTPUT;
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

GO
DROP TRIGGER DEL_SACH
---
GO
USE master
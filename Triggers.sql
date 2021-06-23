-- Triggers QLDT
USE QLDT

--- C.1
GO
CREATE TRIGGER DeleteDT_DT ON DETAI
FOR DELETE
AS
BEGIN
    DECLARE @msdt char(6);
    -- Get the delete MSDT
    SELECT @msdt = MSDT
    FROM DELETED
    -- Delete msdt in SV_DETAI
    DELETE
    FROM SV_DETAI
    WHERE MSDT=@msdt
    -- Delete msdt in GV_HDDT
    DELETE
    FROM GV_HDDT
    WHERE MSDT=@msdt
    -- Delete msdt in GV_PBDT
    DELETE
    FROM GV_PBDT
    WHERE MSDT=@msdt
    -- Delete msdt in GV_UVDT
    DELETE
    FROM GV_UVDT
    WHERE MSDT=@msdt
    -- Last Check
    if (EXISTS (
        SELECT *
        FROM DETAI
        WHERE MSDT=@msdt
    ))
        BEGIN
            PRINT 'Xoa That Bai'
            ROLLBACK TRANSACTION
        END
    ELSE
        PRINT 'Xoa thanh cong!!'
END

GO
DELETE
FROM DETAI
WHERE MSDT='97006'

--- C.3
GO
CREATE TRIGGER Trigger_DT_HDDT ON HOIDONG_DT
FOR INSERT,UPDATE
AS
BEGIN
    DECLARE @mshd int, @dt int;
    -- Lay MSHD || MSDT neu duoc nhap
    SELECT @mshd=MSHD
    FROM INSERTED
    -- Count(de_tai)
    SELECT @dt= count(MSDT)
    FROM HOIDONG_DT
    WHERE MSHD=@mshd
    -- PROMISE.ALL
    IF (@dt > 2)
    BEGIN
        PRINT 'Da Qua So De Tai Cho Phep'
        ROLLBACK TRANSACTION
    END
    ELSE
        PRINT 'THEM THANH CONG'
END

GO
INSERT INTO HOIDONG_DT VALUES (2,'97002',N'Được')
GO
DELETE FROM HOIDONG_DT WHERE MSDT='97002'

--- GROUP BY
GO
CREATE TRIGGER MAX10 ON HOIDONG_DT
FOR INSERT, UPDATE
AS
BEGIN
	 IF EXISTS( 
        SELECT * 
        FROM (
            SELECT * 
            FROM HOIDONG_DT 
            UNION 
            SELECT * 
            FROM INSERTED
        ) TEMP, INSERTED 
        WHERE TEMP.MSHD = INSERTED.MSHD
		GROUP BY INSERTED.MSHD
		HAVING COUNT(DISTINCT TEMP.MSDT) > 3
    )
		BEGIN
			PRINT 'Da Qua So De Tai Cho Phep'
			ROLLBACK TRANSACTION
		END
	ELSE 
	   BEGIN
			PRINT 'THEM THANH CONG!'
			
	   END
END

--- C.5
GO
CREATE TRIGGER TriggerGV_HV ON GIAOVIEN
FOR INSERT,UPDATE
AS
BEGIN
    DECLARE @msgv int, @mshv int, @mshh int;
    -- Get msgv && mshh
    SELECT @msgv=MSGV, @mshh=MSHH
    FROM INSERTED
    -- GET MSHV
    SELECT @mshv=MSHV
    FROM GV_HV_CN
    WHERE MSGV=@msgv
    -- Check HOCHAM
    IF (@mshh = 1)
        BEGIN
            -- Check MSHV
            IF (@mshv=4)
                PRINT 'THANH CONG'
            ELSE
                BEGIN
                    PRINT 'KHONG THANH CONG'
                    ROLLBACK TRANSACTION
                END
        END
    ELSE
        PRINT 'THANH CONG'
END

GO
INSERT INTO GIAOVIEN VALUES(00206,N'Trần Trung',N'Bến Tre','35353535',1,'1996')

--- CLEAR
GO
DROP TRIGGER DeleteDT_DT -- C.1
DROP TRIGGER Trigger_DT_HDDT -- C.3.1
DROP TRIGGER MAX10 -- C.3.2
DROP TRIGGER TriggerGV_HV -- C.5
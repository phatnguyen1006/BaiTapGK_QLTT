CREATE DATABASE QLSACH
GO
USE QLSACH
GO

SET DATEFORMAT DMY
GO

-- TABLE
CREATE TABLE TACGIA (
	MSTG char(4) PRIMARY KEY, 
	TENTG nvarchar(60), 
	SDT char(10), 
	EMAIL nvarchar(20),
);

CREATE TABLE NXB (
	MSNXB char(3) PRIMARY KEY, 
	TENXB nvarchar(25), 
	SDTNXB char(10), 
	EMAILXB nvarchar(20)
);

CREATE TABLE SACH (
	MSSACH char(3) PRIMARY KEY, 
	TENSACH nvarchar(25), 
	SOTRANG int, 
	SOTIEN money, 
	MSNXB char(3) REFERENCES NXB(MSNXB),
);

CREATE TABLE TG_SACH (
	MSTG char(4), 
	MSSACH char(3), 
	NAMXB int,

    constraint PK_TG_S primary key(MSTG, MSSACH)
);
---

-- PRIMARY KEYS AND FOREIGNS
GO
--- A.BẢNG TACGIA
INSERT INTO TACGIA VALUES('TG01',N'Nguyễn Thụy Quỳnh Trang','0906762722','tg02@gmail.com')
INSERT INTO TACGIA VALUES('TG02',N'Nguyễn Văn An','0906762255','tg01@gmail.com')
INSERT INTO TACGIA VALUES('TG03',N'Nguyễn Thúy Vi','090671234','tg03@gmail.com')

---B.BẢNG NXB
INSERT INTO NXB VALUES('111','Kim Đồng','0799999999','kimdong@gmail.com')
INSERT INTO NXB VALUES('112','DHQG','0788888888','dhqg@gmail.com')
INSERT INTO NXB VALUES('113','Y Học','0722222222','yds@gmail.com')

---C.BẢNG SACH
INSERT INTO SACH VALUES('S01',N'Đắc Nhân Tâm',120,200000,'111')
INSERT INTO SACH VALUES('S02',N'Vũ Trụ',300,370000,'111')
INSERT INTO SACH VALUES('S03',N'DevOps Handbook',430,500000,'112')

--D. BẢNG TACGIA_SACH
INSERT INTO TG_SACH VALUES('TG01','S01',2020)
INSERT INTO TG_SACH VALUES('TG01','S02',2019)
INSERT INTO TG_SACH VALUES('TG02','S01',2020)
INSERT INTO TG_SACH VALUES('TG03','S03',2021)

USE master
-- GO
-- DROP DATABASE QLSACH

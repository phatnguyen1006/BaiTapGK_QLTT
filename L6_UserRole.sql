use QLDT
go

CREATE LOGIN LAB6 WITH PASSWORD = '@Str0ng@P4ssWorD'
CREATE USER GIANGVIEN FOR LOGIN LAB6
CREATE USER GIAOVU FOR LOGIN LAB6
CREATE USER SINHVIEN FOR LOGIN LAB6

-- GRANT
-- GIAOVU
GRANT SELECT,UPDATE ON CHUYENNGANH TO GIAOVU
GRANT SELECT,UPDATE ON DETAI TO GIAOVU
GRANT SELECT,UPDATE ON GIAOVIEN TO GIAOVU
GRANT SELECT,UPDATE ON GV_HDDT TO GIAOVU
GRANT SELECT,UPDATE ON GV_HV_CN TO GIAOVU
GRANT SELECT,UPDATE ON GV_PBDT TO GIAOVU
GRANT SELECT,UPDATE ON GV_UVDT TO GIAOVU
GRANT SELECT,UPDATE ON HOCHAM TO GIAOVU
GRANT SELECT,UPDATE ON HOCVI TO GIAOVU
GRANT SELECT,UPDATE ON HOIDONG TO GIAOVU
GRANT SELECT,UPDATE ON HOIDONG_DT TO GIAOVU
GRANT SELECT,UPDATE ON HOIDONG_GV TO GIAOVU
GRANT SELECT,UPDATE ON SINHVIEN TO GIAOVU
GRANT SELECT,UPDATE ON DETAI TO GIAOVU

-- GIAOVIEN
GRANT SELECT,UPDATE ON GIAOVIEN TO GIAOVIEN
GRANT SELECT ON SINHVIEN TO GIAOVIEN
GRANT SELECT ON DETAI TO GIAOVIEN
GRANT SELECT ON GV_HDDT TO GIAOVIEN
GRANT SELECT ON GV_PBDT TO GIAOVIEN
GRANT SELECT ON GV_UVDT TO GIAOVIEN
GRANT SELECT ON HOIDONG TO GIAOVIEN
GRANT SELECT ON HOIDONG_GV TO GIAOVIEN

-- SINHVIEN
GRANT SELECT ON SINHVIEN TO SINHVIEN
GRANT SELECT ON HOIDONG TO SINHVIEN
GRANT SELECT ON DETAI TO SINHVIEN
-- GRANT SELECT ON SV_DETAI TO SINHVIEN
-- GRANT SELECT ON HOIDONG_DT TO SINHVIEN

--DENY
-- GIAOVU
DENY DELETE ON CHUYENNGANH TO GIAOVU
DENY DELETE ON DETAI TO GIAOVU
DENY DELETE ON GIAOVIEN TO GIAOVU
DENY DELETE ON GV_HDDT TO GIAOVU
DENY DELETE ON GV_HV_CN TO GIAOVU
DENY DELETE ON GV_PBDT TO GIAOVU
DENY DELETE ON GV_UVDT TO GIAOVU
DENY DELETE ON HOCHAM TO GIAOVU
DENY DELETE ON HOCVI TO GIAOVU
DENY DELETE ON HOIDONG TO GIAOVU
DENY DELETE ON HOIDONG_DT TO GIAOVU
DENY DELETE ON HOIDONG_GV TO GIAOVU
DENY DELETE ON SINHVIEN TO GIAOVU
DENY DELETE ON DETAI TO GIAOVU

-- GIAOVIEN
DENY DELETE ON CHUYENNGANH TO GIAOVIEN
DENY DELETE ON DETAI TO GIAOVIEN
DENY DELETE ON GIAOVIEN TO GIAOVIEN
DENY DELETE ON GV_HDDT TO GIAOVIEN
DENY DELETE ON GV_HV_CN TO GIAOVIEN
DENY DELETE ON GV_PBDT TO GIAOVIEN
DENY DELETE ON GV_UVDT TO GIAOVIEN
DENY DELETE ON HOCHAM TO GIAOVIEN
DENY DELETE ON HOCVI TO GIAOVIEN
DENY DELETE ON HOIDONG TO GIAOVIEN
DENY DELETE ON HOIDONG_DT TO GIAOVIEN
DENY DELETE ON HOIDONG_GV TO GIAOVIEN
DENY DELETE ON SINHVIEN TO GIAOVIEN
DENY DELETE ON DETAI TO GIAOVIEN

-- SINHVIEN
DENY DELETE ON CHUYENNGANH TO SINHVIEN
DENY DELETE ON DETAI TO SINHVIEN
DENY DELETE ON GIAOVU TO SINHVIEN
DENY DELETE ON GV_HDDT TO SINHVIEN
DENY DELETE ON GV_HV_CN TO SINHVIEN
DENY DELETE ON GV_PBDT TO SINHVIEN
DENY DELETE ON GV_UVDT TO SINHVIEN
DENY DELETE ON HOCHAM TO SINHVIEN
DENY DELETE ON HOCVI TO SINHVIEN
DENY DELETE ON HOIDONG TO SINHVIEN
DENY DELETE ON HOIDONG_DT TO SINHVIEN
DENY DELETE ON HOIDONG_GV TO SINHVIEN
DENY DELETE ON SINHVIEN TO SINHVIEN
DENY DELETE ON DETAI TO SINHVIEN

GO
USE master
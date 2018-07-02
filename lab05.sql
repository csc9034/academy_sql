------ DML
-- 실습 01

-- 데이터 구조 조회
DESC customer;
-- 데이터 삽입
INSERT INTO customer (userid, name, birthday, regdate, address)
VALUES ('C001', '김수현', 1988, sysdate, '경기');

INSERT INTO customer (userid, name, birthday, regdate, address)
VALUES ('C002', '이효리', 1979, sysdate, '제주');

INSERT INTO customer (userid, name, birthday, regdate, address)
VALUES ('C003', '원빈', 1977, sysdate, '강원');

-- 테이블 데이터 조회
SELECT c.*
  FROM customer c
;

/* -----------------------------------------------------
USERID, NAME, BIRTHDAY, REGDATE, ADDRESS, PHONE, GRADE
C001	김수현   	1988	  18/07/02	경기		
C002	이효리	    1979	  18/07/02	제주		
C003	원빈	      1977	  18/07/02	강원		
----------------------------------------------------- */

-- 실습 02
UPDATE customer c
   SET c.NAME      = '차태현'
      ,c.BIRTHDAY  = 1976
 WHERE c.USERID = 'C001'
;

SELECT c.* 
  FROM customer c
 WHERE c.USERID = 'C001'
;

/* ----------------------------------------------------
USERID, NAME, BIRTHDAY, REGDATE, ADDRESS, PHONE, GRADE
C001	차태현   	1976	  18/07/02	경기		
---------------------------------------------------- */

-- 실습 03
UPDATE customer c
   SET c.ADDRESS = '서울'
;

SELECT c.* 
  FROM customer c
;

/* ------------------------------------------------------------
USERID, NAME, BIRTHDAY,   REGDATE,  ADDRESS, PHONE, GRADE
C001	차태현	    1976	    18/07/02	서울		
C002	이효리	    1979	    18/07/02	서울		
C003	원빈      	1977	    18/07/02	서울	
------------------------------------------------------------ */

-- 실습 04
DELETE FROM customer c
      WHERE c.userid = 'C003'
;

SELECT c.*
  FROM customer c
;

/* ------------------------------------------------------
USERID, NAME, BIRTHDAY, REGDATE, ADDRESS, PHONE, GRADE
C001	차태현	    1976	18/07/02	서울		
C002	이효리   	1979	18/07/02	서울		
------------------------------------------------------ */

-- 실습 05
DELETE FROM customer;
-- 2개 행 이(가) 삭제되었습니다.

-- 실습 06
TRUNCATE TABLE customer;
-- Table CUSTOMER이(가) 잘렸습니다.

------------------- SEQUENCE
-- 실습 01
CREATE SEQUENCE seq_cust_userid
START WITH 1
MAXVALUE 99
NOCYCLE
;
-- Sequence SEQ_CUST_USERID이(가) 생성되었습니다.

-- 실습 02
SELECT s.SEQUENCE_NAME
      ,s.MIN_VALUE
      ,s.MAX_VALUE
      ,s.CYCLE_FLAG
      ,s.INCREMENT_BY
  FROM user_sequences s
 WHERE s.SEQUENCE_NAME = 'SEQ_CUST_USERID'
;

/* ------------------------------------------------------------------
    SEQUENCE_NAME, MIN_VALUE, MAX_VALUE, CYCLE_FLAG, INCREMENT_BY
    SEQ_CUST_USERID	    1	        99	        N	          1
------------------------------------------------------------------ */

-- 실습 03

-- customer 테이블에 있는 테이블 구조 lab_customer에 복사
CREATE TABLE lab_customer
AS
SELECT c.*
  FROM customer c
 WHERE 1 = 0
; 

CREATE INDEX idx_cust_userid
ON lab_customer(userid)
;
-- Index IDX_CUST_USERID이(가) 생성되었습니다.

-- 실습 04
SELECT i.INDEX_TYPE
      ,i.INDEX_NAME
      ,i.TABLE_NAME
      ,i.TABLE_OWNER
      ,i.INCLUDE_COLUMN
  FROM user_indexes i
;

/* -----------------------------------------------------------------
INDEX_TYPE, INDEX_NAME,       TABLE_NAME,   TABLE_OWNER, INCLUDE_COLUMN
  NORMAL	    PK_SUB_TABLE4	    SUB_TABLE	    SCOTT	
  NORMAL	    IDX_NEW_MEMBER_ID	NEW_MEMBER	  SCOTT	
  NORMAL	    PK_MEMBER       	MEMBER	      SCOTT	
  NORMAL	    IDX_CUST_USERID	  LAB_CUSTOMER	SCOTT	
  NORMAL	    PK_EMP	          EMP	          SCOTT	
  NORMAL	    PK_DEPT	          DEPT	        SCOTT	
  NORMAL	    PK_CUSTOMER	      CUSTOMER	    SCOTT	
----------------------------------------------------------------- */

-- 실습 05
SELECT i.INDEX_NAME
      ,i.TABLE_NAME
      ,i.COLUMN_NAME
      ,i.COLUMN_POSITION
  FROM user_ind_columns i
;

/* --------------------------------------------------------------------------------------
INDEX_NAME,                         TABLE_NAME,             COLUMN_NAME, COLUMN_POSITION
BIN$32fJ13X7Qe2CJYfBZP3QMQ==$0	BIN$qlbKRzM7SSmKxCMLaET6FQ==$0	ID	      1
BIN$3NtNqbgFTlqGqcX/ec/ZFg==$0	BIN$CAW7+4X9RTmR01WKvP3twQ==$0	MEMBER_ID	1
BIN$5w/XjhYpQRqe0YH5fS/M5w==$0	BIN$9xJwnVeCQjCUplilnrheRw==$0	NICKNAME	1
BIN$EDLD9FqVQRuwdMZsQmz4ww==$0	BIN$0ihCziLnTf2c0W2m3CUSLQ==$0	SUB_CODE	2
BIN$EDLD9FqVQRuwdMZsQmz4ww==$0	BIN$0ihCziLnTf2c0W2m3CUSLQ==$0	ID	      1
BIN$FBCHbSZnSQK0WSiy4WzjSA==$0	BIN$9xJwnVeCQjCUplilnrheRw==$0	ID	      1
BIN$HVtb3tRdTti2fTuDWq0KMg==$0	BIN$5La3rUwdT0Gh/74tIaQQDg==$0	ID	      1
BIN$Jydw03vWSAiiB2kdKLUVLg==$0	BIN$yNpLlWnATJKPUJLdhK3tCg==$0	ID      	1
BIN$LYEdddZdSpO85lCws4M2BQ==$0	BIN$5La3rUwdT0Gh/74tIaQQDg==$0	NICKNAME	1
BIN$LbCo7Fa7SYCL+x0xQpd1BQ==$0	BIN$39Et4n+/Q76/xmYOxXoR3w==$0	USERID	  1
BIN$NQicdTf2SpKZiErBRX8bdw==$0	BIN$pxXOvkO1TJeyZxo4RZSyMA==$0	MEMBER_ID	1
BIN$Pk8u7Sd2SDW3fVG0x884uA==$0	BIN$0KXG8c5fQ3ut/Ylu7xOj5Q==$0	ID	      1
BIN$TK6MeKh7QzScrvJqHVv9Lw==$0	BIN$qlbKRzM7SSmKxCMLaET6FQ==$0	NICKNAME	1
BIN$TYcLFzmWRU+817eXXtOKng==$0	BIN$OcAQv5NaTTaSi5GPWBeMLQ==$0	MEMBER_ID	1
BIN$VKVRqwhlSJa89jwxR74p1g==$0	BIN$yNpLlWnATJKPUJLdhK3tCg==$0	NICKNAME	1
BIN$Xfh8Qyi6TP+2gpxJUAKFgg==$0	BIN$0KXG8c5fQ3ut/Ylu7xOj5Q==$0	NICKNAME	1
BIN$x8V8bVvdQxehjGExM7P4xA==$0	BIN$HE0GhlP2QYyUWUZqN4ls1Q==$0	MEMBER_ID	1
BIN$z17TtfPQRVyYV7h/sznjuQ==$0	BIN$fxLRwCCXTlO6/4AApgHkyg==$0	MEMBER_ID	1
IDX_CUST_USERID	                LAB_CUSTOMER	                  USERID	  1
IDX_NEW_MEMBER_ID	              NEW_MEMBER	                    MEMBER_ID	1
PK_CUSTOMER	                    CUSTOMER	                      USERID	  1
PK_DEPT	                        DEPT	                          DEPTNO	  1
PK_EMP	                        EMP                           	EMPNO	    1
PK_MEMBER	                      MEMBER	                        MEMBER_ID	1
PK_SUB_TABLE4                 	SUB_TABLE	                      SUB_CODE	2
PK_SUB_TABLE4	                  SUB_TABLE	                      ID	      1
-------------------------------------------------------------------------------------- */

-- 실습 05
SELECT i.INDEX_TYPE
      ,i.INDEX_NAME
      ,i.TABLE_NAME
      ,i.TABLE_OWNER
      ,i.INCLUDE_COLUMN
  FROM user_indexes i
 WHERE i.INDEX_NAME = 'IDX_CUST_USERID'
;

/* -----------------------------------------------------------------
INDEX_TYPE, INDEX_NAME,       TABLE_NAME, TABLE_OWNER, INCLUDE_COLUMN
NORMAL	    IDX_CUST_USERID	  LAB_CUSTOMER	  SCOTT	
----------------------------------------------------------------- */

-- 실습 06
SELECT i.INDEX_NAME
      ,i.TABLE_NAME
      ,i.COLUMN_NAME
      ,i.COLUMN_POSITION
  FROM user_ind_columns i
 WHERE i.INDEX_NAME = 'IDX_CUST_USERID'
;

/* -------------------------------------------------------
INDEX_NAME,       TABLE_NAME, COLUMN_NAME, COLUMN_POSITION
IDX_CUST_USERID	LAB_CUSTOMER	USERID	        1
------------------------------------------------------- */

-- 실습 07
DROP INDEX idx_cust_userid
;
--Index IDX_CUST_USERID이(가) 삭제되었습니다.

-- 실습 08
SELECT i.INDEX_NAME
      ,i.TABLE_NAME
      ,i.COLUMN_NAME
      ,i.COLUMN_POSITION
  FROM user_ind_columns i
 WHERE i.INDEX_NAME = 'IDX_CUST_USERID'
;

---------------------- PL/SQL

-- 출력 설정 SQL*PLUS 설정
-- 기본 OFF 설정일 것임
SHOW SERVEROUTPUT 
;
-- ON 설정으로 변경
SET SERVEROUTPUT ON 
;
-- 실습 01
BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello, PL/SQL World!');
END;
/

/*
Hello, PL/SQL World!


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

-- 실습 02

DECLARE
    -- 변수 선언이 있는 ANONYMOUS PROCEDURE 작성
    Hello   VARCHAR2(20)  := 'Hello';
    -- Hello 변수는 선언하며 값을 저장
    World   VARCHAR2(20)  := 'PL/SQL World!';
    -- World 변수는 선언하며 값을 저장
BEGIN
    -- 프로시저에서 실행할 로직을 생성
    -- 일반적으로 SQL 구문처리가 들어감.
    -- 변수 처리, 비교, 반복 등의 로직이 들어감
   
    -- 화면 출력
    DBMS_OUTPUT.put_line(Hello || ', ' || World);
END;
/

/*
Hello, PL/SQL World!


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

-- 실습 03
--- 1). 테이블 생성
CREATE TABLE log_table
(  userid    VARCHAR2(20)
 , log_date  DATE)
;
-- Table LOG_TABLE이(가) 생성되었습니다.
DESC log_table;
/*
이름       널? 유형           
-------- -- ------------ 
USERID      VARCHAR2(20) 
LOG_DATE    DATE  
*/

--- 2). procedure 생성
CREATE OR REPLACE PROCEDURE log_execution
IS
   v_userid VARCHAR(20) := 'myid';
BEGIN
   INSERT INTO log_table
   VALUES (v_userid, sysdate);
END;
/
-- Procedure LOG_EXECUTION이(가) 컴파일되었습니다.

--- 3). procedure 실행
EXECUTE log_execution;
-- PL/SQL 프로시저가 성공적으로 완료되었습니다.

--- 4). 조회
SELECT l.* 
  FROM log_table l;

/*
USERID, LOG_DATE
myid	18/07/02
*/
  
-- 실습 04
CREATE OR REPLACE PROCEDURE log_execution
(  v_log_user IN VARCHAR2 
 , v_log_date OUT DATE)
IS
BEGIN
    v_log_date := sysdate;
    INSERT INTO log_table
    VALUES (v_log_user, v_log_date);  
    
END log_execution;
/
-- Procedure LOG_EXECUTION이(가) 컴파일되었습니다.

VAR v_log_date VARCHAR2
EXECUTE log_execution('cho', :v_log_date)
PRINT v_log_date

/*
Procedure LOG_EXECUTION이(가) 컴파일되었습니다.


PL/SQL 프로시저가 성공적으로 완료되었습니다.

V_LOG_DATE
--------------------------------------------------------------------------------
18/07/03
*/

-- 실습 05
CREATE OR REPLACE PROCEDURE chk_sal_per_month
(  v_sal       IN  NUMBER 
 , v_sal_month OUT NUMBER)
IS
BEGIN
    v_sal_month := v_sal/12;
END chk_sal_per_month;
/
-- Procedure CHK_SAL_PER_MONTH이(가) 컴파일되었습니다.

VAR v_sal_month NUMBER
EXECUTE chk_sal_per_month(6000, :v_sal_month)
PRINT v_sal_month
/*
PL/SQL 프로시저가 성공적으로 완료되었습니다.


V_SAL_MONTH
-----------
        500
*/
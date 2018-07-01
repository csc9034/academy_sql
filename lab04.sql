-- 실습 03
SELECT e1.EMPNO as "사원 번호"
      ,e1.ENAME as "사원 이름"
      ,'|'
      ,e1.MGR as "상사 번호"
      ,e2.ENAME as "상사 이름"
  FROM emp e1 LEFT OUTER JOIN emp e2
    ON e1.MGR = e2.EMPNO
 WHERE e1.MGR IS NULL
;
/* -------------------------------------------
사원 번호, 사원 이름, '|', 상사 번호, 상사 이름
      7777	J%JONES	   |		
      8888	J          |		
      9999	J_JUNE	   |		
      6666	JJ	       |		
      7839	KING	     |		
------------------------------------------- */

-- 실습 04
SELECT e2.EMPNO as "직원 사번"
     , e2.ENAME as "직원 이름" 
     , e1.EMPNO as "부하 사번"
     , e1.ENAME as "부하 이름"
  FROM emp e1 RIGHT OUTER JOIN emp e2
    ON e1.MGR = e2.EMPNO
 WHERE e1.MGR IS NULL
;

/* --------------------------
직원 사번, 직원 이름,     부하 사번,    부하 이름
-----------------------------------------
    8888	    J		
    7844	    TURNER		
    7777	    J%JONES		
    7521    	WARD		
    7654	    MARTIN		
    6666	    JJ		
    7499	    ALLEN		
    7934	    MILLER		
    9999	    J_JUNE		
    7369	    SMITH		
    7900	    JAMES		
-------------------------- */

-- 실습 05
SELECT e.ENAME
      ,e.JOB
  FROM emp e
 WHERE e.JOB = (SELECT e.JOB as "직무" 
                  FROM emp e
                 WHERE e.ENAME = 'JAMES')
 ;
 
 /*
ENAME,    JOB
-------------
SMITH	  CLERK
JAMES	  CLERK
MILLER	CLERK
J_JUNE	CLERK
J	      CLERK
J%JONES	CLERK
*/

-- 실습 06
SELECT e.EMPNO as "사번"
      ,e.ENAME as "이름"
      ,NVL((SELECT e1.ENAME
              FROM emp e1
             WHERE e1.EMPNO = e.MGR), '미배정') as "상사 이름"
  FROM emp e
;

/* ---------------------
사번, 이름, 상사 이름
7369	SMITH	  FORD
7499	ALLEN	  BLAKE
7521	WARD	  BLAKE
7566	JONES	  KING
7654	MARTIN	BLAKE
7698	BLAKE	  KING
7782	CLARK	  KING
7839	KING	  미배정
7844	TURNER	BLAKE
7900	JAMES	  BLAKE
7902	FORD	  JONES
7934	MILLER	CLARK
6666	JJ	    미배정
9999	J_JUNE	미배정
8888	J	      미배정
7777	J%JONES	미배정
--------------------- */

-- 실습 07
SELECT e.EMPNO
      ,e.ENAME 
      ,NVL(e.JOB, '미배정')                        as "JOB"  
      ,e.SAL
      ,NVL((SELECT d.DNAME
              FROM dept d
             WHERE e.DEPTNO = d.DEPTNO), '미배정') as "DNAME"
      ,NVL((SELECT d.LOC
              FROM dept d
             WHERE e.DEPTNO = d.DEPTNO), '미배정') as "LOC"
  FROM emp e
;

/* ------------------------------------------------
 EMPNO, ENAME,  JOB,      SAL,   DNAME,      LOC
  7369	SMITH	  CLERK	    800	  RESEARCH	  DALLAS
  7499	ALLEN	  SALESMAN	1600	SALES	      CHICAGO
  7521	WARD	  SALESMAN	1250	SALES	      CHICAGO
  7566	JONES	  MANAGER	  2975	RESEARCH	  DALLAS
  7654	MARTIN	SALESMAN	1250	SALES	      CHICAGO
  7698	BLAKE	  MANAGER	  2850	SALES	      CHICAGO
  7782	CLARK	  MANAGER	  2450	ACCOUNTING	NEW YORK
  7839	KING	  PRESIDENT	5000	ACCOUNTING	NEW YORK
  7844	TURNER	SALESMAN	1500	SALES	      CHICAGO
  7900	JAMES	  CLERK	    950	  SALES	      CHICAGO
  7902	FORD	  ANALYST	  3000	RESEARCH	  DALLAS
  7934	MILLER	CLERK	    1300	ACCOUNTING	NEW YORK
  6666	JJ		  미배정    2800	미배정	    미배정
  9999	J_JUNE	CLERK	    500	  미배정	    미배정
  8888	J	      CLERK	    400	  미배정	    미배정
  7777	J%JONES	CLERK	    500	  미배정	    미배정
------------------------------------------------ */

------------------------------------------------------------
---- DDL 실습
-- 실습 01
DROP TABLE customer;
CREATE TABLE customer
(  userid     VARCHAR2(4)     
  ,name       VARCHAR2(30)    NOT NULL
  ,birthday   NUMBER(4)
  ,regdate    DATE            DEFAULT sysdate
  ,address    VARCHAR2(30)
  ,CONSTRAINT pk_customer PRIMARY KEY(userid)
); 

CREATE TABLE CUSTOMER
(  userid     VARCHAR2(4)     PRIMARY KEY
  ,name       VARCHAR2(30)    NOT NULL
  ,birthday   NUMBER(4)
  ,regdate    DATE            DEFAULT sysdate
  ,address    VARCHAR2(30)
);
-- ==> Table CUSTOMER이(가) 생성되었습니다.

-- 실습 02
DESC customer;

/* ------------------------------
이름       널?       유형           
-------- -------- ------------ 
USERID   NOT NULL VARCHAR2(4)  
NAME     NOT NULL VARCHAR2(30) 
BIRTHDAY          NUMBER(4)    
REGDATE           DATE         
ADDRESS           VARCHAR2(30) 
------------------------------ */

-- 실습 03
CREATE TABLE new_cus
AS
SELECT *
  FROM customer
 WHERE 1 = 0
;
-- ==> Table NEW_CUS이(가) 생성되었습니다.

-- 실습 04
DESC new_cus;
/* ------------------------------
이름       널?       유형           
-------- -------- ------------ 
USERID            VARCHAR2(4)  
NAME     NOT NULL VARCHAR2(30) 
BIRTHDAY          NUMBER(4)    
REGDATE           DATE         
ADDRESS           VARCHAR2(30) 
------------------------------ */

-- 실습 05
CREATE TABLE salesman
AS
SELECT *
  FROM emp
 WHERE JOB = 'SALESMAN'
   AND 1 = 1 
;
-- ==> Table SALESMAN이(가) 생성되었습니다.

-- 실습 06
SELECT *
  FROM salesman
;

/* ----------------------------------------------------------
EMPNO, ENAME,   JOB,     MGR, HIREDATE, SAL, COMM, DEPTNO
7499	ALLEN	  SALESMAN	7698	81/02/20	1600	300  	30
7521	WARD	  SALESMAN	7698	81/02/22	1250	500	  30
7654	MARTIN	SALESMAN	7698	81/09/28	1250	1400	30
7844	TURNER	SALESMAN	7698	81/09/08	1500	0	    30
---------------------------------------------------------- */

-- 실습 07
ALTER TABLE customer ADD
(  phone   VARCHAR2(11)
 , grade   VARCHAR2(30) CHECK (grade IN('VIP', 'GOLD', 'SILVER'))
 );

ALTER TABLE customer ADD
(  phone   VARCHAR2(11)
 , grade   VARCHAR2(30)
 , CONSTRAINT ck_cus_grade CHECK (grade IN('VIP', 'GOLD', 'SILVER'))
 );
 
DESC customer;

SELECT u.CONSTRAINT_NAME
      ,u.CONSTRAINT_TYPE
      ,u.TABLE_NAME
  FROM user_constraints u
 WHERE u.TABLE_NAME IN ('CUSTOMER')
;

/* -------------------------------
이름       널?       유형           
-------- -------- ------------ 
USERID   NOT NULL VARCHAR2(4)  
NAME     NOT NULL VARCHAR2(30) 
BIRTHDAY          NUMBER(4)    
REGDATE           DATE         
ADDRESS           VARCHAR2(30) 
PHONE             VARCHAR2(11) 
GRADE             VARCHAR2(30) 
-------------------------------

CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
-----------------------------------------------
SYS_C007953       	C             	CUSTOMER
PK_CUSTOMER	        P             	CUSTOMER
CK_CUS_GRADE	      C	              CUSTOMER
*/

-- 실습 08
ALTER TABLE customer DROP COLUMN grade;
-- ==> Table CUSTOMER이(가) 변경되었습니다.

ALTER TABLE customer ADD
( grade   VARCHAR2(30)
 , CONSTRAINT ck_cus_grade CHECK (grade IN('VIP', 'GOLD', 'SILVER'))
 );
-- ==> Table CUSTOMER이(가) 변경되었습니다.


ALTER TABLE customer MODIFY phone VARCHAR(4);
DESC customer;

/*
이름       널?       유형           
-------- -------- ------------ 
USERID   NOT NULL VARCHAR2(30) 
NAME     NOT NULL VARCHAR2(30) 
BIRTHDAY          NUMBER(4)    
REGDATE           DATE         
ADDRESS           VARCHAR2(30) 
PHONE             VARCHAR2(4)  
GRADE             VARCHAR2(30) 
*/

ALTER TABLE customer MODIFY userid NUMBER(4);
DESC customer;

/*
이름       널?       유형           
-------- -------- ------------ 
USERID   NOT NULL NUMBER(4)    
NAME     NOT NULL VARCHAR2(30) 
BIRTHDAY          NUMBER(4)    
REGDATE           DATE         
ADDRESS           VARCHAR2(30) 
PHONE             VARCHAR2(4)  
GRADE             VARCHAR2(30) 
*/

ALTER TABLE customer MODIFY userid VARCHAR2(30);
DESC customer;

/*
이름       널?       유형           
-------- -------- ------------ 
USERID   NOT NULL VARCHAR2(30) 
NAME     NOT NULL VARCHAR2(30) 
BIRTHDAY          NUMBER(4)    
REGDATE           DATE         
ADDRESS           VARCHAR2(30) 
PHONE             VARCHAR2(4)  
GRADE             VARCHAR2(30) 
*/


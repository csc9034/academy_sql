-- 실습 01
SELECT e.EMPNO
      ,e.ENAME
      ,e.JOB
      ,e.SAL
  FROM emp e
 ORDER BY e.SAL DESC
;

/* ----------------------------
7839	KING	PRESIDENT	5000
7902	FORD	ANALYST	3000
7566	JONES	MANAGER	2975
7698	BLAKE	MANAGER	2850
7782	CLARK	MANAGER	2450
7499	ALLEN	SALESMAN	1600
7844	TURNER	SALESMAN	1500
7934	MILLER	CLERK	1300
7521	WARD	SALESMAN	1250
7654	MARTIN	SALESMAN	1250
7900	JAMES	CLERK	950
---------------------------- */

-- 실습 02
SELECT e.EMPNO
      ,e.ENAME
      ,e.HIREDATE
  FROM emp e
 ORDER BY e.HIREDATE
;

/* --------------------
7369	SMITH	80/12/17
7499	ALLEN	81/02/20
7521	WARD	81/02/22
7566	JONES	81/04/02
7698	BLAKE	81/05/01
7782	CLARK	81/06/09
7844	TURNER	81/09/08
7654	MARTIN	81/09/28
7839	KING	81/11/17
7900	JAMES	81/12/03
7902	FORD	81/12/03
7934	MILLER	82/01/23
9999	J_JUNE	18/06/26
8888	J	18/06/26
7777	J%JONES	18/06/26
-------------------- */

-- 실습 03
SELECT e.EMPNO
      ,e.ENAME  
      ,e.SAL
  FROM emp e
 ORDER BY e.SAL
;

/* --------------------
8888	J	400
9999	J_JUNE	500
7777	J%JONES	500
7369	SMITH	800
7900	JAMES	950
7521	WARD	1250
7654	MARTIN	1250
7934	MILLER	1300
7844	TURNER	1500
7499	ALLEN	1600
7782	CLARK	2450
7698	BLAKE	2850
7566	JONES	2975
7902	FORD	3000
7839	KING	5000
-------------------- */

-- 실습 04
SELECT e.EMPNO
      ,e.ENAME
      ,e.SAL
  FROM emp e
 ORDER BY e.SAL DESC
;

/* --------------------
7839	KING	5000
7902	FORD	3000
7566	JONES	2975
7698	BLAKE	2850
7782	CLARK	2450
7499	ALLEN	1600
7844	TURNER	1500
7934	MILLER	1300
7521	WARD	1250
7654	MARTIN	1250
7900	JAMES	950
7369	SMITH	800
9999	J_JUNE	500
7777	J%JONES	500
8888	J	400
-------------------- */

-- 실습 05
SELECT e.EMPNO    as "사번"
      ,e.ENAME    as "이름"
      ,e.SAL      as "급여"
      ,e.HIREDATE as "입사일"
  FROM emp e
;

/* ------------------------------
7369	SMITH	800	80/12/17
7499	ALLEN	1600	81/02/20
7521	WARD	1250	81/02/22
7566	JONES	2975	81/04/02
7654	MARTIN	1250	81/09/28
7698	BLAKE	2850	81/05/01
7782	CLARK	2450	81/06/09
7839	KING	5000	81/11/17
7844	TURNER	1500	81/09/08
7900	JAMES	950	81/12/03
7902	FORD	3000	81/12/03
7934	MILLER	1300	82/01/23
9999	J_JUNE	500	18/06/26
8888	J	400	18/06/26
------------------------------ */

-- 실습 06
SELECT *
  FROM emp  
;

SELECT e.EMPNO
      ,e.ENAME
      ,e.JOB 
      ,e.MGR
      ,e.HIREDATE
      ,e.SAL
      ,e.COMM
      ,e.DEPTNO
  FROM emp e
;

/* ----------------------------------------------------
7369	SMITH	CLERK	7902	80/12/17	800		20
7499	ALLEN	SALESMAN	7698	81/02/20	1600	300	30
7521	WARD	SALESMAN	7698	81/02/22	1250	500	30
7566	JONES	MANAGER	7839	81/04/02	2975		20
7654	MARTIN	SALESMAN	7698	81/09/28	1250	1400	30
7698	BLAKE	MANAGER	7839	81/05/01	2850		30
7782	CLARK	MANAGER	7839	81/06/09	2450		10
7839	KING	PRESIDENT		81/11/17	5000		10
7844	TURNER	SALESMAN	7698	81/09/08	1500	0	30
7900	JAMES	CLERK	7698	81/12/03	950		30
7902	FORD	ANALYST	7566	81/12/03	3000		20
7934	MILLER	CLERK	7782	82/01/23	1300		10
9999	J_JUNE	CLERK		18/06/26	500		
8888	J	CLERK		18/06/26	400		
---------------------------------------------------- */

-- 실습 07
SELECT e.EMPNO
      ,e.ENAME
      ,e.JOB 
      ,e.MGR
      ,e.HIREDATE
      ,e.SAL
      ,e.COMM
      ,e.DEPTNO
  FROM emp e
 WHERE e.ENAME = 'ALLEN'
;

/* ----------------------------------------------------
7499	ALLEN	SALESMAN	7698	81/02/20	1600	300	30
---------------------------------------------------- */

-- 실습 08
SELECT e.EMPNO
      ,e.ENAME
      ,e.DEPTNO
  FROM emp e
 WHERE e.DEPTNO = 20
;

/* ---------------------
7369	SMITH	20
7566	JONES	20
7902	FORD	20
--------------------- */

-- 실습 09
SELECT e.EMPNO
      ,e.ENAME
      ,e.SAL
      ,e.DEPTNO
  FROM emp e
 WHERE e.DEPTNO = 20
   AND e.SAL < 3000
;

/* ---------------------
7369	SMITH	800	20
7566	JONES	2975	20
--------------------- */

-- 실습 10
SELECT e.EMPNO
      ,e.ENAME
      ,e.SAL + e.COMM
  FROM emp e
;

/* ---------------------
7369	SMITH	
7499	ALLEN	1900
7521	WARD	1750
7566	JONES	
7654	MARTIN	2650
7698	BLAKE	
7782	CLARK	
7839	KING	
7844	TURNER	1500
7900	JAMES	
7902	FORD	
7934	MILLER	
9999	J_JUNE	
8888	J	
7777	J%JONES	
--------------------- */

-- 실습 11
SELECT e.EMPNO
      ,e.ENAME
      ,e.SAL * 12
  FROM emp e
;

/* -------------------
7369	SMITH	9600
7499	ALLEN	19200
7521	WARD	15000
7566	JONES	35700
7654	MARTIN	15000
7698	BLAKE	34200
7782	CLARK	29400
7839	KING	60000
7844	TURNER	18000
7900	JAMES	11400
7902	FORD	36000
7934	MILLER	15600
9999	J_JUNE	6000
8888	J	4800
------------------- */

-- 실습 12
SELECT e.EMPNO
      ,e.ENAME
      ,e.JOB
      ,e.SAL
      ,e.COMM
  FROM emp e
 WHERE e.ENAME = 'MARTIN'
    OR e.ENAME = 'BLAKE'
;

/* --------------------------------
7654	MARTIN	SALESMAN	1250	1400
7698	BLAKE	MANAGER	2850	
-------------------------------- */

-- 실습 13
SELECT e.EMPNO
      ,e.ENAME
      ,e.JOB
      ,e.SAL + e.COMM
  FROM emp e
 WHERE e.ENAME = 'MARTIN'
    OR e.ENAME = 'BLAKE'
;

/* -----------------------------
7654	MARTIN	SALESMAN	2650
7698	BLAKE	MANAGER	
----------------------------- */

-- 실습 14

--- (1). ~ NOT
SELECT e.EMPNO
      ,e.ENAME
      ,e.JOB 
      ,e.MGR
      ,e.HIREDATE
      ,e.SAL
      ,e.COMM
      ,e.DEPTNO
  FROM emp e
 WHERE NOT e.COMM = 0
;

--- (2). <>
SELECT e.EMPNO
      ,e.ENAME
      ,e.JOB 
      ,e.MGR
      ,e.HIREDATE
      ,e.SAL
      ,e.COMM
      ,e.DEPTNO
  FROM emp e
 WHERE e.COMM <> 0
;

--- (3). !=
SELECT e.EMPNO
      ,e.ENAME
      ,e.JOB 
      ,e.MGR
      ,e.HIREDATE
      ,e.SAL
      ,e.COMM
      ,e.DEPTNO
  FROM emp e
 WHERE e.COMM != 0
;

/* ---------------------------------------------------
7499	ALLEN	SALESMAN	7698	81/02/20	1600	300	30
7521	WARD	SALESMAN	7698	81/02/22	1250	500	30
7654	MARTIN	SALESMAN	7698	81/09/28	1250	1400	30
--------------------------------------------------- */

-- 실습 15

SELECT e.EMPNO
      ,e.ENAME
      ,e.JOB 
      ,e.MGR
      ,e.HIREDATE
      ,e.SAL
      ,e.COMM
      ,e.DEPTNO
  FROM emp e
 WHERE e.COMM IS NOT NULL 
;

/* ---------------------------------------------------
7499	ALLEN	SALESMAN	7698	81/02/20	1600	300	30
7521	WARD	SALESMAN	7698	81/02/22	1250	500	30
7654	MARTIN	SALESMAN	7698	81/09/28	1250	1400	30
7844	TURNER	SALESMAN	7698	81/09/08	1500	0	30
--------------------------------------------------- */

-- 실습 16
SELECT e.EMPNO
      ,e.ENAME
      ,e.JOB 
      ,e.MGR
      ,e.HIREDATE
      ,e.SAL
      ,e.COMM
      ,e.DEPTNO
  FROM emp e
 WHERE e.DEPTNO = 20
   AND e.SAL > 2500
;

/* ---------------------------------------------
7566	JONES	MANAGER	7839	81/04/02	2975		20
7902	FORD	ANALYST	7566	81/12/03	3000		20
--------------------------------------------- */

-- 실습 17
SELECT e.EMPNO
      ,e.ENAME
      ,e.JOB 
      ,e.MGR
      ,e.HIREDATE
      ,e.SAL
      ,e.COMM
      ,e.DEPTNO
  FROM emp e
 WHERE e.DEPTNO = 10
   AND e.JOB = 'MANAGER'
;

/* ---------------------------------------------
7782	CLARK	MANAGER	7839	81/06/09	2450		10
--------------------------------------------- */

-- 실습 18
SELECT e.EMPNO
      ,e.ENAME
      ,e.JOB 
      ,e.MGR
      ,e.HIREDATE
      ,e.SAL
      ,e.COMM
      ,e.DEPTNO
  FROM emp e
 WHERE e.JOB IN('MANAGER', 'CLERK', 'SALESMAN')
;

/* ------------------------------------------------------
7369	SMITH	CLERK	7902	80/12/17	800		20
7499	ALLEN	SALESMAN	7698	81/02/20	1600	300	30
7521	WARD	SALESMAN	7698	81/02/22	1250	500	30
7566	JONES	MANAGER	7839	81/04/02	2975		20
7654	MARTIN	SALESMAN	7698	81/09/28	1250	1400	30
7698	BLAKE	MANAGER	7839	81/05/01	2850		30
7782	CLARK	MANAGER	7839	81/06/09	2450		10
7844	TURNER	SALESMAN	7698	81/09/08	1500	0	30
7900	JAMES	CLERK	7698	81/12/03	950		30
7934	MILLER	CLERK	7782	82/01/23	1300		10
9999	J_JUNE	CLERK		18/06/26	500		
8888	J	CLERK		18/06/26	400		
7777	J%JONES	CLERK		18/06/26	500		
------------------------------------------------------ */

-- 실습 19
SELECT e.EMPNO
      ,e.ENAME
      ,e.JOB 
      ,e.MGR
      ,e.HIREDATE
      ,e.SAL
      ,e.COMM
      ,e.DEPTNO
  FROM emp e
 WHERE e.ENAME LIKE 'A%'
;

/*
7499	ALLEN	SALESMAN	7698	81/02/20	1600	300	30
*/

-- 실습 20
SELECT e.EMPNO
      ,e.ENAME
      ,e.JOB 
      ,e.MGR
      ,e.HIREDATE
      ,e.SAL
      ,e.COMM
      ,e.DEPTNO
  FROM emp e
 WHERE e.ENAME LIKE '%A%'
;

/* ------------------------------------------------------
7499	ALLEN	SALESMAN	7698	81/02/20	1600	300	30
7521	WARD	SALESMAN	7698	81/02/22	1250	500	30
7654	MARTIN	SALESMAN	7698	81/09/28	1250	1400	30
7698	BLAKE	MANAGER	7839	81/05/01	2850		30
7782	CLARK	MANAGER	7839	81/06/09	2450		10
7900	JAMES	CLERK	7698	81/12/03	950		30
------------------------------------------------------ */

-- 실습 21
SELECT e.EMPNO
      ,e.ENAME
      ,e.JOB 
      ,e.MGR
      ,e.HIREDATE
      ,e.SAL
      ,e.COMM
      ,e.DEPTNO
  FROM emp e
 WHERE e.ENAME LIKE '%S'
;

/* ---------------------------------------------
7566	JONES	MANAGER	7839	81/04/02	2975		20
7900	JAMES	CLERK	7698	81/12/03	950		30
7777	J%JONES	CLERK		18/06/26	500	
--------------------------------------------- */

-- 실습 22
SELECT e.EMPNO
      ,e.ENAME
      ,e.JOB 
      ,e.MGR
      ,e.HIREDATE
      ,e.SAL
      ,e.COMM
      ,e.DEPTNO
  FROM emp e
 WHERE e.ENAME LIKE '%E_'
;

/* --------------------------------------------------- 
7499	ALLEN	SALESMAN	7698	81/02/20	1600	300	30
7566	JONES	MANAGER	7839	81/04/02	2975		20
7844	TURNER	SALESMAN	7698	81/09/08	1500	0	30
7900	JAMES	CLERK	7698	81/12/03	950		30
7934	MILLER	CLERK	7782	82/01/23	1300		10
7777	J%JONES	CLERK		18/06/26	500		
--------------------------------------------------- */
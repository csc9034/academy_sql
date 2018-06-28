-- 실습 16
SELECT e.EMPNO as "사원번호"
      ,e.ENAME as "사원이름"
      ,e.SAL   as "급여"
      ,CASE e.JOB WHEN 'CLERK'     THEN 300
                  WHEN 'SALESMAN'  THEN 450
                  WHEN 'MANAGER'   THEN 600
                  WHEN 'ANALYST'   THEN 600
                  WHEN 'PRESIDENT' THEN 1000 
        END as "자기 계발비"
  FROM emp e
; 
/* ------------------------------------------
사원번호, 사원이름,   급여,   자기 계발비
------------------------------------------
7369	      SMITH	    800	      300
7499	      ALLEN	    1600	    450
7521	      WARD	    1250	    450
7566	      JONES	    2975	    600
7654	      MARTIN	  1250	    450
7698	      BLAKE	    2850	    600
7782	      CLARK	    2450	    600
7839	      KING	    5000	    1000
7844	      TURNER	  1500	    450
7900	      JAMES	    950	      300
7902	      FORD	    3000	    600
7934	      MILLER	  1300	    300
6666	      JJ	      2800	
------------------------------------------ */

-- 실습 17
SELECT e.EMPNO as "사원번호"
      ,e.ENAME as "사원이름"
      ,e.SAL   as "급여"
      ,CASE WHEN e.JOB = 'CLERK'     THEN 300
            WHEN e.JOB = 'SALESMAN'  THEN 450
            WHEN e.JOB = 'MANAGER'   THEN 600
            WHEN e.JOB = 'ANALYST'   THEN 600
            WHEN e.JOB = 'PRESIDENT' THEN 1000 
        END as "자기 계발비"
  FROM emp e
;
/* ------------------------------------------
사원번호, 사원이름,   급여,   자기 계발비
------------------------------------------
7369	      SMITH	    800	      300
7499	      ALLEN	    1600	    450
7521	      WARD	    1250	    450
7566	      JONES	    2975	    600
7654	      MARTIN	  1250	    450
7698	      BLAKE	    2850	    600
7782	      CLARK	    2450	    600
7839	      KING	    5000	    1000
7844	      TURNER	  1500	    450
7900	      JAMES	    950	      300
7902	      FORD	    3000	    600
7934	      MILLER	  1300	    300
6666	      JJ	      2800	
------------------------------------------ */

-- 실습 18
SELECT COUNT(*) as "전체 행 개수"
  FROM emp e
;

/* ---
16
--- */

-- 실습 19
SELECT DISTINCT COUNT(e.JOB) as "직책의 개수"
  FROM emp e
;
/* --- 
15
--- */

-- 실습 20
SELECT COUNT(e.COMM) as "커미션을 받는 사원 수"
  FROM emp e
;

/* ---
4
--- */

-- 실습 21
SELECT SUM(e.SAL) as "급여의 총합"
  FROM emp e
;

/* ----
29125
---- */

-- 실습 22
SELECT AVG(e.SAL) as "급여의 평균"
  FROM emp e
;

/* --------
1820.3125
-------- */

-- 실습 23
SELECT SUM(e.SAL) as "급여의 총합"
      ,AVG(e.SAL) as "급여의 평균"
      ,MAX(e.SAL) as "최대 급여"
      ,MIN(e.SAL) as "최소 급여"
  FROM emp e
;

/* --------------------------------------------
급여의 총합, 급여의 평균, 최대 급여, 최소 급여
    29125	     1820.3125	    5000	    400
-------------------------------------------- */

-- 실습 24
SELECT TRUNC(STDDEV(e.SAL), 1)   as "급여 표준편차"
      ,TRUNC(VARIANCE(e.SAL), 1) as "급여 분산"
  FROM emp e
;

/* ----------------------
급여 표준편차, 급여 분산
1255	          1575101.5
---------------------- */

-- 실습 25
SELECT TRUNC(STDDEV(e.SAL), 1)   as "급여 표준편차"
      ,TRUNC(VARIANCE(e.SAL), 1) as "급여 분산"
  FROM emp e
 WHERE e.JOB = 'SALESMAN'
;

/* ------------
177.9	31666.6
------------ */

-- 실습 26

SELECT NVL(e.DEPTNO || '' , '미배정') as "부서"
      ,SUM(DECODE(e.JOB
              ,'CLERK'    , '300'
              ,'SALESMAN' , '450'
              ,'MANAGER'  , '600'
              ,'ANALYST'  , '800'
              ,'PRESIDENT', '1000'
              )) as "자기개발비 총합"
   FROM emp e
  GROUP BY e.DEPTNO
  ORDER BY "부서"
;

/* ------------------
부서,   자기개발비 총합
  10	    1900
  20	    1700
  30	    2700
  미배정	900
------------------ */

-- 실습 27

SELECT NVL(e.DEPTNO || '', '미배정') as "부서"
      ,NVL(e.JOB, '미지정')          as "직책"
      ,SUM(DECODE(e.JOB
                ,'CLERK'    , '300'
                ,'SALESMAN' , '450'
                ,'MANAGER'  , '600'
                ,'ANALYST'  , '800'
                ,'PRESIDENT', '1000'
                )) as "자기개발비 총합"
  FROM emp e
 GROUP BY e.DEPTNO , e.JOB 
 ORDER BY "부서", "직책" DESC
;

/* -----------------------------------
부서,     직책,     자기개발비 총합
10	    PRESIDENT	    1000
10	    MANAGER     	600
10    	CLERK	        300
20	    MANAGER	      600
20	    CLERK	        300
20	    ANALYST	      800
30	    SALESMAN	    1800
30	    MANAGER	      600
30	    CLERK	        300
미배정	미지정	
미배정	CLERK	        900
----------------------------------- */


----------- JOIN
-- 실습 1
SELECT e.ENAME
     , d.DNAME
  FROM emp e NATURAL JOIN dept d
;
/* -------------------
ENAME,       DNAME
KING	    ACCOUNTING
CLARK   	ACCOUNTING
MILLER   	ACCOUNTING
FORD	    RESEARCH
SMITH	    RESEARCH
JONES	    RESEARCH
JAMES	    SALES
TURNER	  SALES
MARTIN	  SALES
WARD	    SALES
ALLEN	    SALES
BLAKE	    SALES
------------------- */

-- 실습 02
SELECT e.ENAME
     , d.DNAME
  FROM emp e JOIN dept d USING (deptno)
;
/* -------------------
ENAME,       DNAME
KING	    ACCOUNTING
CLARK   	ACCOUNTING
MILLER   	ACCOUNTING
FORD	    RESEARCH
SMITH	    RESEARCH
JONES	    RESEARCH
JAMES	    SALES
TURNER	  SALES
MARTIN	  SALES
WARD	    SALES
ALLEN	    SALES
BLAKE	    SALES
------------------- */
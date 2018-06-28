-- (3) 단일행 함수
--- 6) CASE
-- job별로 경조사비를 급여 대비 일정 비율로 지급하고 있다.
-- 각 지원들의 경조사비 지원금을 구하자
/*
  CLERK     : 5%
  SALESMAN  : 4%
  MANAGER   : 3.7%
  ANALYST   : 3%
  PRESIDENT : 1.5%
*/

-- 1. Simple CASE 구문으로 구해보자 : DECODE와 거의 유사, 동일 비교만 가능
--                                    괄호가 없고, 콤마 대신 키워드 WHEN, THEN, ELSE 등을 사용

SELECT e.EMPNO
      ,e.ENAME  
      ,e.JOB
      ,CASE e.JOB WHEN 'CLERK'     THEN e.SAL * 0.05
                  WHEN 'SALESMAN'  THEN e.SAL * 0.04
                  WHEN 'MANAGER'   THEN e.SAL * 0.037
                  WHEN 'ANALYST'   THEN e.SAL * 0.03
                  WHEN 'PRESIDENT' THEN e.SAL * 0.015
        END as "경조사 지원금"
  FROM emp e 
;
/* ------------------------------------
EMPNO ENAME   JOB      경조사 지원금
7369	SMITH	  CLERK	     40
7499	ALLEN	  SALESMAN	 64
7521	WARD	  SALESMAN	 50
7566	JONES	  MANAGER	   110.075
7654	MARTIN	SALESMAN   50
7698	BLAKE	  MANAGER	   105.45
7782	CLARK	  MANAGER	   90.65
7839	KING	  PRESIDENT	 75
7844	TURNER	SALESMAN	 60
7900	JAMES	  CLERK	     47.5
7902	FORD	  ANALYST	   90
7934	MILLER	CLERK	     65
9999	J_JUNE	CLERK	     25
8888	J	      CLERK	     20
7777	J%JONES	CLERK	     25
------------------------------------ */

--  2. Searched CASE 구문으로 구해보자 
SELECT e.EMPNO
     , e.ENAME
     , e.JOB
     , CASE WHEN e.JOB = 'CLERK'      THEN e.SAL * 0.05
            WHEN e.JOB = 'SALESMAN'   THEN e.SAL * 0.04
            WHEN e.JOB = 'MANAGER'    THEN e.SAL * 0.037
            WHEN e.JOB = 'ANALYST'    THEN e.SAL * 0.03
            WHEN e.JOB = 'PRESIDENT'  THEN e.SAL * 0.015
            ELSE 10
        END as "경조사 지원금"
  FROM emp e
;
/* ------------------------------------
EMPNO ENAME   JOB      경조사 지원금
7369	SMITH	  CLERK	     40
7499	ALLEN	  SALESMAN	 64
7521	WARD	  SALESMAN	 50
7566	JONES	  MANAGER	   110.075
7654	MARTIN	SALESMAN   50
7698	BLAKE	  MANAGER	   105.45
7782	CLARK	  MANAGER	   90.65
7839	KING	  PRESIDENT	 75
7844	TURNER	SALESMAN	 60
7900	JAMES	  CLERK	     47.5
7902	FORD	  ANALYST	   90
7934	MILLER	CLERK	     65
9999	J_JUNE	CLERK	     25
8888	J	      CLERK	     20
7777	J%JONES	CLERK	     25
------------------------------------ */

-- CASE 결과에 숫자 통화 패턴 씌우기 : $기호, 숫자 세 자리 끊어 읽기, 소수점 이하 2자리
SELECT e.EMPNO
     , e.ENAME
     , NVL(e.JOB, '미지정') as job
     , TO_CHAR(CASE WHEN e.JOB = 'CLERK'      THEN e.SAL * 0.05
                    WHEN e.JOB = 'SALESMAN'   THEN e.SAL * 0.04
                    WHEN e.JOB = 'MANAGER'    THEN e.SAL * 0.037
                    WHEN e.JOB = 'ANALYST'    THEN e.SAL * 0.03
                    WHEN e.JOB = 'PRESIDENT'  THEN e.SAL * 0.015
                    ELSE 10
                END, '$9,999.99') as "경조사 지원금"
  FROM emp e
;

/* ----------------------------------------
EMPNO ENAME     JOB       경조사 지원금
----------------------------------------
7369	SMITH	    CLERK	        $40.00
7499	ALLEN	    SALESMAN	    $64.00
7521	WARD	    SALESMAN	    $50.00
7566	JONES	    MANAGER	      $110.08
7654	MARTIN	  SALESMAN	    $50.00
7698	BLAKE	    MANAGER	      $105.45
7782	CLARK	    MANAGER	      $90.65
7839	KING	    PRESIDENT	    $75.00
7844	TURNER	  SALESMAN	    $60.00
7900	JAMES	    CLERK	        $47.50
7902	FORD	    ANALYST	      $90.00
7934	MILLER	  CLERK	        $65.00
6666	JJ	      미지정	      $10.00
9999	J_JUNE	  CLERK	        $25.00
8888	J	        CLERK	        $20.00
7777	J%JONES  	CLERK	        $25.00
---------------------------------------- */

/*SALGRADE 테이블의 내용 : 이 회사의 급여 등급 기준 값
GRADE LOSAL   HISAL
--------------------
1	     700	  1200
2	     1201 	1400
3      1401	  2000
4	     2001	  3000
5	     3001	  9999
*/

-- 제공되는 급여 등급을 바탕으로 각 사원들의 급여 등급을 구해보자
-- CASE 를 사용하여
SELECT e.EMPNO
     , e.ENAME
     , e.SAL
     , CASE WHEN e.SAL >= 700  AND e.SAL<= 1200 THEN 1
            WHEN e.SAL > 1200  AND e.SAL<= 1400 THEN 2
            WHEN e.SAL > 1400  AND e.SAL<= 2000 THEN 3
            WHEN e.SAL > 2000  AND e.SAL<= 3000 THEN 4
            WHEN e.SAL > 3000  AND e.SAL<= 9999 THEN 5
            ELSE 0
        END as "급여 등급"
  FROM emp e
 ORDER BY "급여 등급" DESC
;

/* ---------------------------
EMPNO, ENAME, SAL, 급여 등급
----------------------------
7839	KING	  5000	  5
6666	JJ	    2800	  4
7902	FORD  	3000  	4
7566	JONES	  2975  	4
7782	CLARK	  2450	  4
7698	BLAKE	  2850	  4 
7499	ALLEN	  1600	  3
7844	TURNER	1500	  3
7934	MILLER	1300	  2
7521	WARD	  1250	  2
7654	MARTIN	1250	  2
7900	JAMES	  950	    1
7369	SMITH	  800	    1
8888	J	      400	    0
7777	J%JONES	500	    0
9999	J_JUNE	500	    0
--------------------------- */

-- WHEN 안에 구문을 BETWEEN ~ AND ~ 으로 변경하여 작성
SELECT e.EMPNO
     , e.ENAME
     , e.SAL
     , CASE WHEN e.SAL BETWEEN 700  AND 1200 THEN 1
            WHEN e.SAL BETWEEN 1201 AND 1400 THEN 2
            WHEN e.SAL BETWEEN 1401 AND 2000 THEN 3
            WHEN e.SAL BETWEEN 2001 AND 3000 THEN 4
            WHEN e.SAL BETWEEN 3001 AND 9999 THEN 5
            ELSE 0
        END as "급여 등급"
  FROM emp e
 ORDER BY "급여 등급" DESC
;

-------------- 2. 그룹함수 (복수행 함수)
-- 1) COUNT(*) : 특정 테이블의 행의 개수(데이터의 개수)를 세어주는 함수
--               NULL 을 처리하는 <유일한> 그룹함수
--    COUNT(expr) : expr으로 등장한 값을 NULL 제외하고 세어주는 함수

-- dept, salgrade 테이블의 전체 데이터 개수 조회
SELECT * 
  FROM dept d
;
/*
10	ACCOUNTING	NEW YORK  ====> 
20	RESEARCH	  DALLAS    ====>   COUNT(*) ====> 4
30	SALES	      CHICAGO   ====>
40	OPERATIONS	BOSTON    ====>
*/

SELECT COUNT(*) as "부서 개수"
  FROM dept d
;

SELECT *
  FROM salgrade s
;
/*
700  	1200 ====>
1201	1400 ====>
1401	2000 ====>  COUNT(*) ====> 5
2001	3000 ====>
3001	9999 ====>
*/

SELECT COUNT(*) as "급여 등급 개수"
  FROM salgrade s
;

--- emp 테이블에서 job 컬럼의 데이터 개수를 카운트
SELECT COUNT(e.JOB)
  FROM emp e
;

SELECT e.EMPNO
     , e.ENAME
     , e.JOB
  FROM emp e
;

/*
EMPNO, ENAME,    JOB
7369	SMITH	    CLERK         ====>
7499	ALLEN	    SALESMAN      ====>
7521	WARD	    SALESMAN      ====>
7566	JONES	    MANAGER       ====>
7654	MARTIN	  SALESMAN      ====>     개수를 세는 기준 컬럼인 job이 null 인 값은 적용 안됨.
7698	BLAKE   	MANAGER       ====>
7782	CLARK	    MANAGER       ====>
7839	KING	    PRESIDENT     ====>     COUNT(e.JOB) = 15
7844	TURNER	  SALESMAN      ====>
7900	JAMES   	CLERK         ====>
7902	FORD    	ANALYST       ====>
7934	MILLER	  CLERK         ====>
6666	JJ	      (null)        ====>
9999	J_JUNE	  CLERK         ====>
8888	J	        CLERK         ====>
7777	J%JONES	  CLERK         ====>
*/

-- 회사에 매니저가 배정 된 직원이 몇명인가
SELECT COUNT(e.MGR) as "상사가 있는 직원의 수"
  FROM emp e
;

-- 매니저 직을 맡고 있는 직원이 몇명인가?
-- 1. mgr 컬럼을 중복 제거하여 조회
-- 2. 그 때의 결과를 카운트
SELECT COUNT(DISTINCT e.MGR) as "매니저 수"
  FROM emp e
;

-- 부서가 배정 된 직원이 몇명이나 있는가
SELECT COUNT(e.DEPTNO) as "부서 배정 된 인원"
  FROM emp e
;

-- COUNT(*) 가 아닌 COUNT(expr) 를 사용한 경우에는
SELECT e.DEPTNO
  FROM emp e
 WHERE e.DEPTNO IS NOT NULL
;
-- 을 수행한 결과를 카운트 한 것으로 생각할 수 있다.

SELECT COUNT(*) as "전체 인원"
     , COUNT(e.DEPTNO) as "부서 배정 된 인원"
     , COUNT(*) - COUNT(e.DEPTNO) as "부서 미배정 인원"
  FROM emp e
;

-- 2) SUM() : NULL 항목 제외하고
--            합산 가능한 행을 모두 더한 결과를 출력

-- SALESMAN 들의 수당 총합을 구해보자
SELECT SUM(e.COMM)
  FROM emp e
 WHERE e.JOB = 'SALESMAN'
;

/*
(null)
300     ====>
500     ====>
(null)
1400    ====>
(null)
(null)
(null)
0       ====> SUM(e.COMM) ====> 2200 : comm 컬럼이 NULL 인 것들은 합산에서 제외
(null)
(null)
(null)
(null)
(null)
(null)
(null)
*/

-- 수당 총합 결과에 숫자 출력 패턴, 별칭
SELECT TO_CHAR(SUM(e.COMM), '$9,999') as "수당 총합"
  FROM emp e
 WHERE e.JOB = 'SALESMAN'
;

-- 3) AVG(expr) : NULL 값 제외하고 연산 가능한 항목의 산술 평균

--   수당 평균을 구해보자
SELECT AVG(e.COMM) as "수당 평균"
  FROM emp e
;

SELECT TO_CHAR(AVG(e.COMM), '$9,999') as "수당 평균"
  FROM emp e
;  

-- 4) MAX(expr) : expr에 등장한 값 중 최댓값을 구함
--                expr 이 문자인 경우 알파벳 순 뒷쪽에 위치한 글자를 최댓값으로 계산

-- 이름이 가장 나중인 직원
SELECT MAX(e.ENAME)
  FROM emp e
;

-------------- 3. GROUP BY 절의 사용
-- 1) emp 테이블에서 각 부서별로 급여의 총합을 조회

--    총합을 구하기 위하여 SUM()을 사용
--    그룹화 기준을 부서번호(deptno)를 사용
--    그룹화 기준으로 잡은 부서번호가 GROUP BY 절에 등장해야 함

-- a) 먼저 emp 테이블에서 급여 총합 구하는 구문을 작성
SELECT SUM(e.SAL)
  FROM emp e 
;

-- b) 부서번호(deptno)를 기준으로 그룹화를 진행
--    SUM()은 그룹함수이므로 GROUP BY 절을 조합하면 그룹화 가능
--    그룹화를 하려면 기준 컬럼을 GROUP BY 절에 명시

SELECT SUM(e.SAL) as "급여 총합"
  FROM emp e 
 GROUP BY e.DEPTNO
;

SELECT e.DEPTNO as "부서번호"
     , SUM(e.SAL) as "급여 총합"
  FROM emp e 
 GROUP BY e.DEPTNO
 ORDER BY e.DEPTNO
;

-- GROUP BY 절에 등장하지 않은 컬럼이 SELECT 에 등장하면 오류, 실행 불가
SELECT e.DEPTNO as "부서번호", e.JOB
     , SUM(e.SAL) as "급여 총합"
  FROM emp e 
 GROUP BY e.DEPTNO
 ORDER BY e.DEPTNO
;
--ORA-00979: not a GROUP BY expression

-- 부서별 급여의 총합, 평균, 최대급여, 최소급여
SELECT SUM(e.SAL) as "총합"
     , AVG(e.SAL) as "평균"
     , MAX(e.SAL) as "최대 급여"
     , MIN(e.SAL) as "최소 급여"
  FROM emp e
 GROUP BY e.DEPTNO
;

-- 위의 쿼리는 수행 되지만 정확하게 어느 부서의 결과인지
-- 알 수가 없다는 단점이 존재
/* ----------------------------------------------------------------------------------
GROUP BY 절에 등장하는 그룹화 기준 컬럼은 반드시 SELECT 절에 똑같이 등장해야 한다.

하지만 위의 쿼리가 실행 되는 이유는
SELECT 절에 나열 된 컬럼 중에서 그룹함수가 사용되지 않은 컬럼이 없기 때문
즉, 모두 다 그룹함수가 사용 된 컬럼들이기 때문
---------------------------------------------------------------------------------- */

-- 부서 지정 안되어서 (null) 로 표현되는 값을 '부서 미지정' 으로 출력 되도록(DECODE 함수로 처리)
SELECT DECODE(e.DEPTNO
            , 10, '10'
            , 20, '20'
            , 30, '30'
            , '부서 미지정'
              ) as "부서 번호"
     , TO_CHAR(SUM(e.SAL), '$9,999.00') as "총합"
     , TO_CHAR(AVG(e.SAL), '$9,999.00') as "평균"
     , TO_CHAR(MAX(e.SAL), '$9,999.00') as "최대 급여"
     , TO_CHAR(MIN(e.SAL), '$9,999.00') as "최소 급여"
  FROM emp e
 GROUP BY e.DEPTNO
 ORDER BY e.DEPTNO
;

--SELECT (SELECT NVL(e.DEPTNO, 0)  as "부서 번호"
--          FROM emp e)                   as "e.DEPTNO"
--     , TO_CHAR(SUM(e.SAL), '$9,999.00') as "총합"
--     , TO_CHAR(AVG(e.SAL), '$9,999.00') as "평균"
--     , TO_CHAR(MAX(e.SAL), '$9,999.00') as "최대 급여"
--     , TO_CHAR(MIN(e.SAL), '$9,999.00') as "최소 급여"
--  FROM emp e
-- GROUP BY e.DEPTNO
-- ORDER BY e.DEPTNO
--;
-- 부서별, 직무별 급여의 총합, 평균, 최대, 최소를 구해보자

SELECT e.DEPTNO as "부서 번호"
     , e.JOB    as "직무"       
     , TO_CHAR(SUM(e.SAL), '$9,999.00') as "총합"
     , TO_CHAR(AVG(e.SAL), '$9,999.00') as "평균"
     , TO_CHAR(MAX(e.SAL), '$9,999.00') as "최대 급여"
     , TO_CHAR(MIN(e.SAL), '$9,999.00') as "최소 급여"
  FROM emp e
 GROUP BY e.DEPTNO, e.JOB             
 ORDER BY e.DEPTNO, e.JOB
;

-- ORA-00979: not a GROUP BY expression
SELECT e.DEPTNO as "부서 번호"
     , e.JOB    as "직무"       -- SELECT 에는 등장
     , TO_CHAR(SUM(e.SAL), '$9,999.00') as "총합"
     , TO_CHAR(AVG(e.SAL), '$9,999.00') as "평균"
     , TO_CHAR(MAX(e.SAL), '$9,999.00') as "최대 급여"
     , TO_CHAR(MIN(e.SAL), '$9,999.00') as "최소 급여"
  FROM emp e
 GROUP BY e.DEPTNO               -- GROUP BY 에는 누락 된 컬럼 JOB
 ORDER BY e.DEPTNO, e.JOB
;

-- 그룹함수가 적용되지 않았고, GROUP BY 절에도 등장하지 않은 JOB 컬럼이
-- SELECT 절에 있기 때문에 오류가 발생

-- ORA-00937: not a single-group group function
SELECT e.DEPTNO as "부서 번호"
     , e.JOB    as "직무"      
     , TO_CHAR(SUM(e.SAL), '$9,999.00') as "총합"
     , TO_CHAR(AVG(e.SAL), '$9,999.00') as "평균"
     , TO_CHAR(MAX(e.SAL), '$9,999.00') as "최대 급여"
     , TO_CHAR(MIN(e.SAL), '$9,999.00') as "최소 급여"
  FROM emp e
 -- GROUP BY e.DEPTNO              
 ORDER BY e.DEPTNO, e.JOB
;

-- 그룹함수가 적용되지 않은 컬럼들이 SELECT 에 등장하면
-- 그룹화 기준으로 가정되어야 함
-- 그룹화 기준으로 사용되는 GROUP BY 절 자체가 누락

-- JOB별 급여의 총합, 평균, 최대, 최소를 구해보자
SELECT e.JOB as "직무"
     , TO_CHAR(SUM(e.SAL), '$99,999.00') as "총합"
     , TO_CHAR(AVG(e.SAL), '$99,999.00') as "평균"
     , TO_CHAR(MAX(e.SAL), '$99,999.00') as "최대"
     , TO_CHAR(MIN(e.SAL), '$99,999.00') as "최소"
  FROM emp e
 GROUP BY e.JOB
 ORDER BY e.JOB
;
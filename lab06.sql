-- 실습 09
CREATE OR REPLACE VIEW v_cust_general_regdt
AS
SELECT c.USERID  as "아이디"
      ,c.REGDATE as "등록일"
  FROM customer c
 WHERE c.GRADE = 'General'
;
-- View V_CUST_GENERAL_REGDT이(가) 생성되었습니다.

-- 실습 10
SELECT c.*
  FROM v_cust_general_regdt c
;

-- 실습 11
SELECT u.VIEW_NAME
      ,u.TEXT
      ,u.READ_ONLY
  FROM user_views u
;

-- 실습 12
SELECT u.VIEW_NAME
      ,u.TEXT
      ,u.READ_ONLY
  FROM user_views u
;

-- 실습 13
DROP VIEW v_cust_general_regdt;
-- View V_CUST_GENERAL_REGDT이(가) 삭제되었습니다.

-- 실습 14
SELECT u.VIEW_NAME
      ,u.TEXT
      ,u.READ_ONLY
  FROM user_views u
;

------------------------------------------
-- PL/SQL
------------------------------------------
-- 실습07
-- 1) 프로시저 작성
DESC log_table;
CREATE OR REPLACE PROCEDURE log_execution
(  v_log_user IN  log_table.USERID%TYPE
 , v_log_date OUT log_table.LOG_DATE%TYPE)
IS
BEGIN
    v_log_date := '94/08/16';
    INSERT INTO log_table
    VALUES (v_log_user, v_log_date);  
    
END log_execution;
/
-- Procedure LOG_EXECUTION이(가) 컴파일되었습니다.

-- 2) VAR : BIND 변수 선언 
VAR v_log_result VARCHAR2(30)

-- 3) EXEC 실행
EXEC log_execution('cho', :v_log_result)

-- 4) 화면 출력
PRINT v_log_result

/*
PL/SQL 프로시저가 성공적으로 완료되었습니다.


V_LOG_RESULT
--------------------------------------------------------------------------------
94/08/16
*/

-- 실습 08
CREATE OR REPLACE PROCEDURE sp_chng_date_format
(   v_date  IN OUT VARCHAR2)
IS
BEGIN
  
    -- 1. 입력 된 초기 상태의 값 출력
    DBMS_OUTPUT.PUT_LINE('초기 입력 값 : ' || v_date);
    
    -- 2. 숫자 패턴화 변경
    v_date := TO_CHAR(TO_DATE(v_date, 'YYYY-MM-DD'), 'YYYY MON DD');
    
    -- 3. 화면 출력으로 변경된 패턴 확인
    DBMS_OUTPUT.PUT_LINE('패턴 적용 값 : ' || v_date);

END sp_chng_date_format;
/


-- 2. 컴파일 / 디버깅
-- Procedure SP_CHNG_DATE_FORMAT이(가) 컴파일되었습니다.

-- 3. VAR : BIND 변수 선언
-- IN OUT 으로 사용될 변수
VAR v_date_bind VARCHAR2(20)

-- 4. EXEC : 실행
-- 4.1 BIND 변수에 sysdate을 먼저 저장
EXEC :v_date_bind := sysdate
-- 4.2 sysdate이 저장된 BIND 변수를 프로시저에 전달
EXEC sp_chng_date_format(:v_date_bind)
/*
초기 입력 값 : 18/07/03
패턴 적용 값 : 0018 7월  03


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

-- 5. PRINT : BIND 변수 출력
PRINT v_number_bind;

/*
V_NUMBER_BIND
--------------------------------------------------------------------------------
 $1,000.00
*/

-- 실습 9)

-- 1) 프로시저 작성
CREATE OR REPLACE PROCEDURE sp_insert_dept
(  v_dname  IN  dept.DNAME%TYPE
 , v_loc    IN  dept.LOC%TYPE
)
IS
   v_max_auto_deptno    NUMBER;
BEGIN
    SELECT MAX(d.deptno)
      INTO v_max_auto_deptno
      FROM dept d
    ;
    
    INSERT INTO dept (deptno, dname, loc)
    VALUES (v_max_auto_deptno + 10, v_dname, v_loc)
    ;
    
    COMMIT;
END sp_insert_dept;
/

-- 2) 컴파일 / 디버깅
-- Procedure SP_INSERT_DEPT이(가) 컴파일되었습니다.

-- 3) EXEC 실행
EXEC sp_insert_dept('기획', '광주')

-- 4) 화면 출력
SELECT d.*
  FROM dept d
;
/* -----------------------
DEPTNO,    DNAME,     LOC
  10	ACCOUNTING	  NEW YORK
  20	RESEARCH	    DALLAS
  30	SALES	        CHICAGO
  40	OPERATIONS	  BOSTON
  50	기획	          광주
----------------------- */

-- 실습 10)
-- 1. 위치에 의한 전달법
EXEC sp_insert_dept('develop', 'gwangju')


-- 2. 변수명에 의한 전달
EXEC sp_insert_dept(v_dname => 'management', v_loc => 'seoul')

-- 3. 조회
SELECT d.*
  FROM dept d
;
/* ----------------------
DEPTNO, DNAME,    LOC
  10	ACCOUNTING	NEW YORK
  20	RESEARCH	  DALLAS
  30	SALES	      CHICAGO
  40	OPERATIONS	BOSTON
  50	기획	        광주
  60	develop	    gwangju
  70	management	seoul
---------------------- */

-- 실습 11)
-- 0. 새 테이블 작성 test_emp
DROP TABLE test_emp;
CREATE TABLE test_emp
AS
SELECT e.*
  FROM emp e
 WHERE 1 = 1 -- 테이블 구조와 데이터까지 복사
;
-- 적용할 특정 empno 조회
SELECT e.EMPNO
      ,e.ENAME
      ,e.JOB
      ,e.COMM
  FROM test_emp e
 WHERE e.EMPNO = 7844
;

/*
EMPNO, ENAME,   JOB,    COMM
7844	TURNER	SALESMAN	  0
*/

-- 1. 프로시저 작성
CREATE OR REPLACE PROCEDURE sp_job_comm
(  v_empno        IN  EMP.EMPNO%TYPE )
IS
  -- 사번인 직원의 직무를 저장할 지역 변수
   v_job     EMP.JOB%TYPE;
   v_comm    EMP.COMM%TYPE;
BEGIN
    -- 1. 입력 된 사번 직원의 직무와 급여를 조회하여 v_job과 v_comm에 저장
    SELECT e.JOB, e.COMM
      INTO v_job, v_comm
      FROM emp e
     WHERE e.EMPNO = v_empno 
    ;
     /*
          SALESMAN    : 1000
          MANGAER     : 1500
      */
      -- 2. 일정 비율로 sp_job_comm 를 계산
      IF      v_job = 'SALESMAN'  THEN v_COMM := 1000;
      ELSIF   v_job = 'MANAGER'   THEN v_COMM := 1500;
      ELSE    v_comm := 500;
      END IF;
      
    UPDATE test_emp e 
       SET e.COMM = v_comm
     WHERE e.EMPNO = v_empno
    ;
    COMMIT;
END sp_job_comm;
/
-- 2. 컴파일 / 디버깅
-- Procedure SP_JOB_COMM이(가) 컴파일되었습니다.

-- 3. EXEC
EXEC sp_job_comm(v_empno => 7844)
-- PL/SQL 프로시저가 성공적으로 완료되었습니다.

-- 5. 조회
SELECT e.EMPNO
      ,e.ENAME
      ,e.JOB
      ,e.COMM
  FROM test_emp e
 WHERE e.EMPNO = 7844
;

/* ----------------------------
EMPNO, ENAME, JOB,       COMM
7844	TURNER	SALESMAN	1000
---------------------------- */

-- 실습 12)
DECLARE 
  -- 1. 초기값 변수 선언 및 초기화
  v_init  NUMBER := 0;
  v_sum   NUMBER := 0;
BEGIN
  LOOP
      v_init := v_init + 1;
      v_sum  := v_sum + v_init;
     
      DBMS_OUTPUT.PUT_LINE('v_sum : ' || v_sum);
      -- 반복문 종료 조건
      EXIT WHEN v_init = 10;
  
      --합산 변수 출력
      DBMS_OUTPUT.PUT_LINE('1 ~ 10 합산 결과 ' || v_sum);
  
  END LOOP
  ;

END;
/

/*
v_sum : 1
1 ~ 10 합산 결과 1
v_sum : 3
1 ~ 10 합산 결과 3
v_sum : 6
1 ~ 10 합산 결과 6
v_sum : 10
1 ~ 10 합산 결과 10
v_sum : 15
1 ~ 10 합산 결과 15
v_sum : 21
1 ~ 10 합산 결과 21
v_sum : 28
1 ~ 10 합산 결과 28
v_sum : 36
1 ~ 10 합산 결과 36
v_sum : 45
1 ~ 10 합산 결과 45
v_sum : 55


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


-- 실습 13)
DECLARE
    -- 1. FOR LOOP 에서 사용할 카운터 변수 선언 / 초기화
    cnt  NUMBER := 0;
BEGIN
    -- 2. LOOP 작성
    FOR cnt IN REVERSE 1 .. 10 LOOP
      -- 3. 2의 배수 판단
        IF (MOD(cnt, 2) = 0)
            THEN SYS.DBMS_OUTPUT.PUT_LINE(cnt);
        END IF;
    END LOOP;
END;
/

/*
10
8
6
4
2
*/
-- 실습 14)
DECLARE
    -- 1. While LOOP 에서 사용할 카운터 변수 선언 / 초기화
    cnt  NUMBER := 0;
BEGIN
    -- 2. LOOP 작성
    WHILE cnt < 10 LOOP
       cnt := cnt + 1;
       SYS.DBMS_OUTPUT.PUT_LINE(cnt);
    END LOOP;
END;
/

/*
PL/SQL 프로시저가 성공적으로 완료되었습니다.

1
2
3
4
5
6
7
8
9
10
*/

-- 실습 15)
-- 1. 함수 작성
CREATE OR REPLACE FUNCTION fn_emp_sal_avg
(  v_job     IN    EMP.JOB%TYPE )
-- 함수의 리턴 구문 작성
RETURN NUMBER
IS
   v_avg_sal    EMP.SAL%TYPE;
BEGIN
   -- 직무별 급여 평균을 AVG() 함수를 사용하여 구하고 저장
   SELECT avg(e.sal)
     INTO v_avg_sal
     FROM emp e
    WHERE e.JOB = v_job
    ;

    RETURN ROUND(v_avg_sal);
END fn_emp_sal_avg;
/
-- 2. 컴파일 / 디버깅
-- Function FN_EMP_SAL_AVG이(가) 컴파일되었습니다.

-- 실습 16)
SELECT fn_emp_sal_avg('SALESMAN') as "직무 급여 평균"
  FROM dual
;
/*
직무 급여 평균
1400
*/
SELECT ROUND(AVG(e.SAL)) as "직무 급여 평균"
  FROM emp e
 WHERE e.JOB = 'SALESMAN'
;

-- 실습 17)
SELECT e.EMPNO
      ,e.ENAME
      ,e.SAL
  FROM emp e
 WHERE e.SAL > fn_emp_sal_avg('SALESMAN')
 ORDER BY e.SAL DESC
;
/*
EMPNO, ENAME,   SAL
  7839	KING	  5000
  7902	FORD	  3000
  7566	JONES	  2975
  7698	BLAKE	  2850
  6666	JJ	    2800
  7782	CLARK	  2450
  7499	ALLEN	  1600
  7844	TURNER	1500
*/




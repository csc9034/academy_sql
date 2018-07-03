-------------------------------------------------------------
-- PL/SQL
-------------------------------------------------------------
-- IN, OUT 모드 변수를 사용하는 프로시저
-- 문제 ) 한 달 급여를 입력(IN 모드 변수) 하면 
--        일년 급여를 계산해주는 프로시저를 작성

--  1) SP 이름 : sp_calc_year_sal
--  2) 변수    : IN  => v_sal
--               OUT => v_sal_year
--  3) PROCEDURE 작성
CREATE OR REPLACE PROCEDURE sp_calc_year_sal
(  v_sal      IN  NUMBER
 , v_sal_year OUT NUMBER)
IS
BEGIN
    v_sal_year := v_sal * 12;
END sp_calc_year_sal;
/

--  4) 컴파일 : SQL*PLUS CLi 라면 위 코드를 복사 붙여넣기
--              Oracle SQL Developer : ctrl + enter 키 입력

-- Procedure SP_CALC_YEAR_SAL이(가) 컴파일되었습니다.

--              오류가 존재하면 SHOW errors 명령으로 확인
--  5) OUT 모드 변수가 있는 프로시저이므로 BIND 변수가 필요
--    VAR 명령으로 SQL*PLUS 의 변수를 선언하는 명령
--    DESC 명령 : SQL*PLUS
VAR v_sal_year_bind NUMBER

--  6) 프로시저 실행 : EXEC[UTE] : SQL*PLUS 명령
EXEC sp_calc_year_sal(12000000, :V_SAL_YEAR_BIND);
-- PL/SQL 프로시저가 성공적으로 완료되었습니다.

--  7) 실행 결과가 담긴 BIND 변수를 SQL*PLUS 에서 출력
PRINT V_SAL_YEAR_BIND;
/* ---------------
V_SAL_YEAR_BIND
---------------
      144000000
--------------- */

-- 실습 06) 여러 형태의 변수를 사용하는 sp_variables 를 작성
/*
    IN 모드 변수 : v_deptno, v_loc
    지역 변수    : v_hiredate, v_empno, v_msg
    상 수        :v_max
*/

-- 1) 프로시저 작성
CREATE OR REPLACE PROCEDURE sp_variables
(  v_deptno IN VARCHAR2
  ,v_loc    IN VARCHAR2)
IS
    -- IS ~ BEGIN 사이는 지역변수 선언/초기화
    v_hiredate     VARCHAR2(30);
    v_empno        NUMBER := 1999;
    v_msg          VARCHAR2(500) DEFAULT 'Hello, PL/SQL';
    v_max CONSTANT NUMBER := 5000;
BEGIN
    DBMS_OUTPUT.PUT_LINE('v_hiredate:' || v_hiredate);
    
    v_hiredate := TO_CHAR(sysdate, 'YYYY-MM-DD HH24:MI:SS DY');
    DBMS_OUTPUT.PUT_LINE('v_hiredate:' || v_hiredate);
    DBMS_OUTPUT.PUT_LINE('v_deptno:' || v_deptno);
    DBMS_OUTPUT.PUT_LINE('v_loc:' || v_loc);
    DBMS_OUTPUT.PUT_LINE('v_empno:' || v_empno);
    
    v_msg := '내일 지구가 멸망하더라도 오늘 사과나무를 심겠다. by.스피노자';
    DBMS_OUTPUT.PUT_LINE('v_msg:' || v_msg);
    
    -- 상수인 v_max 에 할당 시도
--    v_max := 10000;
--    DBMS_OUTPUT.PUT_LINE('v_max:' || v_max);
END sp_variables;
/
-- 2) 컴파일 / 디버깅
/*
Procedure SP_VARIABLES이(가) 컴파일되었습니다.

LINE/COL  ERROR
--------- -------------------------------------------------------------
23/5      PL/SQL: Statement ignored
23/5      PLS-00363: expression 'V_MAX' cannot be used as an assignment target
오류: 컴파일러 로그를 확인하십시오.
*/

-- 3) BIND 변수가 필요하면 선언

-- 4) EXEC : SP 실행
EXEC SP_VARIABLES('10', '하와이')
EXEC SP_VARIABLES('20', '스페인')
EXEC SP_VARIABLES('30', '제주도')
EXEC SP_VARIABLES('40', '몰디브')

/* --------------------------------------------------------------
v_hiredate:
v_hiredate:2018-07-03 10:08:20 화
v_deptno:40
v_loc:몰디브
v_empno:1999
v_msg:내일 지구가 멸망하더라도 오늘 사과나무를 심겠다. by.스피노자


PL/SQL 프로시저가 성공적으로 완료되었습니다.
-------------------------------------------------------------- */

--------------------------------------------------------------
-- PL/SQL 변수 : REFERENCES 변수의 사용
-- 1) %TYPE 변수
--    DEPT 테이블의 부서번호를 입력(IN 모드) 받아서 
--    부서명을 (OUT 모드) 출력하는 저장 프로시저 작성

---- (1) SP 이름  : sp_get_dname
---- (2) IN 변수  : v_deptno
---- (3) OUT 변수 : v_dname

-- 1. 프로시저 작성
CREATE OR REPLACE PROCEDURE sp_get_dname
(  v_deptno IN  DEPT.DEPTNO%TYPE
  ,v_dname  OUT DEPT.DNAME%TYPE )
IS
BEGIN
    SELECT d.DNAME
      INTO v_dname 
      FROM dept d
     WHERE d.DEPTNO = v_deptno
    ;
END sp_get_dname;
/

-- 2. 컴파일 / 디버깅
-- Procedure SP_GET_DNAME이(가) 컴파일되었습니다.

-- 3. BIND 변수가 필요하면 선언
VAR v_dname_bind VARCHAR2(30)

-- 4. EXEC : 프로시저 실행
EXEC sp_get_dname(10, :v_dname_bind)
EXEC sp_get_dname(20, :v_dname_bind)
EXEC sp_get_dname(30, :v_dname_bind)
EXEC sp_get_dname(40, :v_dname_bind)


-- 5. PRINT : BIND 변수가 있으면 출력
PRINT v_dname_bind

EXEC sp_get_dname(50, :v_dname_bind)
/* ----------------------------------------------------------------------------------
BEGIN sp_get_dname(50, :v_dname_bind); END;
오류 보고 -
ORA-01403: no data found
ORA-06512: at "SCOTT.SP_GET_DNAME", line 6
ORA-06512: at line 1
01403. 00000 -  "no data found"
*Cause:    No data was found from the objects.
*Action:   There was no data from the objects which may be due to end of fetch.
---------------------------------------------------------------------------------- */
PRINT v_dname_bind

-- 2) %ROWTYPE 변수
--    DEPT 테이블의 부서번호를 입력(IN 모드) 받아서 
--    부서 전체 정보를 화면 출력하는 저장 프로시저 작성
---- (1) sp_get_dinfo
---- (2) IN 모드 변수 : v_deptno
----     지역변수     : v_dinfo

-- 1. 프로시저 작성
CREATE OR REPLACE PROCEDURE sp_get_dinfo
(  v_deptno IN  DEPT.DEPTNO%TYPE )
IS
   -- v_dinfo 변수는 dept 테이블의 한 행의 정보를 한번에 담는 변수
   v_dinfo   DEPT%ROWTYPE;
BEGIN
    -- IN 모드로 입력된 v_deptno 에 해당하는 부서 정보
    -- 1행을 조회하여
    -- dept 테이블의 ROWTYPE 변수인 v_dinfo 에 저장
    SELECT d.DEPTNO
          ,d.DNAME
          ,d.LOC
      INTO v_dinfo -- INTO 절에 명시되는 변수에는 1행만 저장 가능
      FROM dept d
     WHERE d.DEPTNO = v_deptno
    ;
    
    -- 조회 된 결과를 화면 출력
    DBMS_OUTPUT.PUT_LINE('부서 번호 : ' || v_dinfo.deptno);
    DBMS_OUTPUT.PUT_LINE('부서 이름 : ' || v_dinfo.dname);
    DBMS_OUTPUT.PUT_LINE('부서 위치 : ' || v_dinfo.loc);

END sp_get_dinfo;
/

-- 2. 컴파일 / 디버깅
-- Procedure SP_GET_DINFO이(가) 컴파일되었습니다.

-- 3. VAR : BIND 변수 필요시 선언

-- 4. EXEC : SP 실행
EXEC sp_get_dinfo(10)
EXEC sp_get_dinfo(20)
EXEC sp_get_dinfo(30)
EXEC sp_get_dinfo(40)

/*
PL/SQL 프로시저가 성공적으로 완료되었습니다.

부서 번호 : 40
부서 이름 : OPERATIONS
부서 위치 : BOSTON
*/

-- 5. PRINT : BIND 변수가 있을 때

------------------------------------------------------------
-- 수업 중 실습
-- 문제 ) 한 사람의 사번을 입력 받으면 그 사람의 소속 부서명, 부서 
--        위치를 함께 화면 출력

SELECT 
  FROM emp e
      ,dept d
 WHERE e.DEPTNO = d.DEPTNO
   AND e.empno = ?
;
-- (1) SP 이름 : sp_get_emp_info
-- (2) IN 변수 : v_empno
-- (3) %TYPE, %ROWTYPE 변수 활용

-- 1. 프로시저 작성
CREATE OR REPLACE PROCEDURE sp_get_emp_info
(  v_empno IN  EMP.EMPNO%TYPE )
IS
    v_ename EMP.ENAME%TYPE;
    v_dname DEPT.DNAME%TYPE;
    v_loc   DEPT.LOC%TYPE;
BEGIN
    SELECT e.ENAME
          ,d.DNAME
          ,d.LOC
      INTO v_ename
          ,v_dname
          ,v_loc
      FROM emp e
          ,dept d
     WHERE e.DEPTNO = d.DEPTNO
       AND e.empno = v_empno
    ;
    -- 조회 된 결과를 화면 출력
    DBMS_OUTPUT.PUT_LINE('사원 이름 : ' || v_ename);
    DBMS_OUTPUT.PUT_LINE('부서 이름 : ' || v_dname);
    DBMS_OUTPUT.PUT_LINE('부서 위치 : ' || v_loc);

END sp_get_emp_info;
/
-- 2. 컴파일 / 디버깅

-- 3. EXEC : SP 실행
SELECT e.*
  FROM emp e
;

SELECT d.*
  FROM dept d
;
desc dept;
EXEC sp_get_emp_info(7369)
EXEC sp_get_emp_info(7499)
EXEC sp_get_emp_info(7521)
EXEC sp_get_emp_info(7566)

---------------------------------------------------------------------------

-- (1) SP 이름 : sp_get_emp_info_ins
-- (2) IN 변수 : v_empno
-- (3) %TYPE, %ROWTYPE 변수 활용

-- 1. 프로시저 작성
CREATE OR REPLACE PROCEDURE sp_get_emp_info_ins
(  v_empno IN  EMP.EMPNO%TYPE )
IS
    v_emp  emp%ROWTYPE;
    v_dept dept%ROWTYPE;
BEGIN
    -- SP 의 좋은 점은 여러개의 쿼리를
    -- 순차적으로 실행하는 것이 가능
    -- 변수를 활용할 수 있기 때문에
    
    -- 1. IN 모드 변수로 들어오는 한 직원의 정보를 조회
    SELECT e.*
      INTO v_emp
      FROM emp e
     WHERE e.EMPNO = v_empno
    ;
    
    -- 2. 1의 결과에서 직원의 부서 번호를 얻을 수 있으므로
    --    부서 정보 조회
    SELECT d.*
      INTO v_dept
      FROM dept d
     WHERE d.DEPTNO = v_emp.deptno
     ;
     -- 3. v_emp, v_dept에서 필요한 필드만 화면 출력
    DBMS_OUTPUT.PUT_LINE('사원 이름 : ' || v_emp.ename);
    DBMS_OUTPUT.PUT_LINE('부서 이름 : ' || v_dept.dname);
    DBMS_OUTPUT.PUT_LINE('부서 위치 : ' || v_dept.loc);

END sp_get_emp_info_ins;
/

-- 2. 컴파일 / 디버깅
-- Procedure SP_GET_EMP_INFO_INS이(가) 컴파일되었습니다.

-- 3. EXEC : SP 실행
EXEC sp_get_emp_info_ins(7369)
EXEC sp_get_emp_info_ins(7499)
EXEC sp_get_emp_info_ins(7521)
EXEC sp_get_emp_info_ins(7566)

-------------------------------------------------------------
-- PL/SQL 변수 : RECORD TYPE 변수의 사용
-------------------------------------------------------------
-- RECORD TYPE : 한 개 혹은 그 이상 테이블에서
--               원하는 컬럼만 추출하여 구성

-- 문제 ) 사번을 입력(IN 모드 변수) 받아서
--        그 직원의 사번, 이름, 매니저 이름, 부서 이름, 부서 위치, 급여 등급 함께 출력

---- (1) SP 이름 : sp_get_emp_info_detail
---- (2) IN 변수 : v_empno
---- (3) RECORD 변수 : v_emp_record
CREATE OR REPLACE PROCEDURE sp_get_emp_info_detail
(   v_empno IN emp.empno%TYPE  )
IS
    -- 1. RECORD 타입 선언
    TYPE emp_record_type IS RECORD
    (   r_empno     EMP.EMPNO%TYPE
      , r_ename     EMP.ENAME%TYPE
      , r_mgrename  EMP.ENAME%TYPE
      , r_dname     DEPT.DNAME%TYPE
      , r_loc       DEPT.LOC%TYPE
      , r_salgrade  SALGRADE.GRADE%TYPE
      )
    ;
    -- 2. 1에서 선언한 타입의 변수를 선언
    v_emp_record  emp_record_type;
BEGIN
    -- 3. 1에서 선언한 RECORD 타입은 조인의 결과를 받을 수 있음
    SELECT e.EMPNO
          ,e.ENAME
          ,e1.ENAME
          ,d.DNAME
          ,d.LOC
          ,s.GRADE
      INTO v_emp_record
      FROM emp e
          ,emp e1
          ,dept d
          ,salgrade s
     WHERE e.MGR = e1.EMPNO(+)  -- mgr 배정 안된 직원
       AND e.DEPTNO = d.DEPTNO(+)  -- dept 배정 안된 직원 
       AND e.SAL BETWEEN s.LOSAL AND s.HISAL
       AND e.EMPNO = v_empno
    ;
    
    DBMS_OUTPUT.PUT_LINE('사    번  : ' || v_emp_record.r_empno);
    DBMS_OUTPUT.PUT_LINE('이    름  : ' || v_emp_record.r_ename);
    DBMS_OUTPUT.PUT_LINE('매 니 저  : ' || v_emp_record.r_mgrename);
    DBMS_OUTPUT.PUT_LINE('부 서 명  : ' || v_emp_record.r_dname);
    DBMS_OUTPUT.PUT_LINE('부서 위치 : ' || v_emp_record.r_loc);
    DBMS_OUTPUT.PUT_LINE('급여 등급 : ' || v_emp_record.r_salgrade);

END sp_get_emp_info_detail;
/

EXEC sp_get_emp_info_detail(7369)
EXEC sp_get_emp_info_detail(7499)
EXEC sp_get_emp_info_detail(6666)
EXEC sp_get_emp_info_detail(7839)

/*
Procedure SP_GET_EMP_INFO_DETAIL이(가) 컴파일되었습니다.

사    번  : 7369
이    름  : SMITH
매 니 저  : FORD
부 서 명  : RESEARCH
부서 위치 : DALLAS
급여 등급 : 1


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

--------------------------------------------------------------
-- 프로시저는 다른 프로시저에서 호출 가능

-- ANONYMOUS PROCEDURE 를 이용하여 지금 정의한
-- sp_get_emp_info_detail 실행
DECLARE
    v_empno     EMP.EMPNO%TYPE;
BEGIN
    SELECT e.empno
      INTO v_empno
      FROM emp e
     WHERE e.empno = 7902
     ;
     
     sp_get_emp_info_detail(v_empno);
END;
/

/*
사    번  : 7902
이    름  : FORD
매 니 저  : JONES
부 서 명  : RESEARCH
부서 위치 : DALLAS
급여 등급 : 4


PL/SQL 프로시저가 성공적으로 완료되었습니다.

*/

-------------------------------------------------------------
-- PL/SQL 변수 : 아규먼트 변수 IN OUT 모드의 사용
-------------------------------------------------------------
-- IN : SP로 값이 전달될 때 사용
--      프로시저를 사용하는 쪽(SQL*PLUS) 에서 프로시저로 전달
-------------------------------------------------------------
-- OUT : SP에서 수행 결과 값이 저장되는 용도, 출력용
--       프로시저는 리턴(변환)이 없기 때문에
--       SP를 호출한 쪽에 돌려주는 방법으로 사용
-------------------------------------------------------------
-- IN OUT : 하나의 매개 변수에 입력, 출력을 함께 사용
-------------------------------------------------------------
-- 문제) 기본 숫자값을 입력 받아서 숫자 포맷화 '$9,999.00'
--       출력하는 프로시저를 작성 IN OUT 모드 변수를 활용

---- (1) SP 이름 : sp_chng_number_format
---- (2) IN OUT 변수 : v_number
---- (3) BIND 변수 : v_numver_bind

-- 1. 프로시저 작성
CREATE OR REPLACE PROCEDURE sp_chng_number_format
(   v_number  IN OUT VARCHAR2)
IS
BEGIN
    -- 1. 입력 된 초기 상태의 값 출력
    DBMS_OUTPUT.PUT_LINE('초기 입력 값 : ' || v_number);
    
    -- 2. 숫자 패턴화 변경
    v_number := TO_CHAR(TO_NUMBER(v_number), '$9,999.99');
    
    -- 3. 화면 출력으로 변경된 패턴 확인
    DBMS_OUTPUT.PUT_LINE('패턴 적용 값 : ' || v_number);

END sp_chng_number_format;
/


-- 2. 컴파일 / 디버깅
-- Procedure SP_CHNG_NUMBER_FORMAT이(가) 컴파일되었습니다.

-- 3. VAR : BIND 변수 선언
-- IN OUT 으로 사용될 변수
VAR v_number_bind VARCHAR2(20)

-- 4. EXEC : 실행
-- 4.1BIND 변수에 1000을 먼저 저장
EXEC :v_number_bind := 1000
-- 4.2 1000이 저장된 BIND 변수를 프로시저에 전달
EXEC sp_chng_number_format(:v_number_bind)
/*
PL/SQL 프로시저가 성공적으로 완료되었습니다.

초기 입력 값 : 1000
패턴 적용 값 :  $1,000.00
*/

-- 5. PRINT : BIND 변수 출력
PRINT v_number_bind

/*
V_NUMBER_BIND
--------------------------------------------------------------------------------
 $1,000.00
*/

-- 위의 문제를 다른 방법으로 풀이 : SELECT ~ INTO 절을 사용
CREATE OR REPLACE PROCEDURE sp_chng_number_format
(   in_number  IN  NUMBER
  , out_number OUT VARCHAR2)
IS
BEGIN
    -- in_number 로 입력 된 값을 INTO절을 사용하여
    -- out_number 변수로 입력
    SELECT TO_CHAR(in_number, '$9,999.99')
      INTO out_number
      FROM dual
    ;
    
END sp_chng_number_format;
/

VAR v_out_number_bind VARCHAR2(10)
EXEC sp_chng_number_format(1000, :v_out_number_bind)
PRINT v_out_number

/*
V_OUT_NUMBER
--------------------------------------------------------------------------------
 $1,000.00
*/

-------------------------------------------------------------------------
-- 매개 변수 전달법 : SP 에서는 위치, 변수명에 의한 전달 방식이 있다.
-------------------------------------------------------------------------
-- 1. 위치에 의한 전달법
EXEC sp_chng_number_format(1000, :v_out_number_bind)


-- 2. 변수명에 의한 전달
EXEC sp_chng_number_format(in_number => 1000, out_number => :v_out_number_bind)
PRINT v_out_number_bind
/*
V_OUT_NUMBER_BIND
--------------------------------------------------------------------------------
 $1,000.00
*/

EXEC sp_chng_number_format(in_number => 2000, out_number => :v_out_number_bind)
PRINT v_out_number_bind
/*
V_OUT_NUMBER_BIND
--------------------------------------------------------------------------------
 $2,000.00
*/

--------------------------------------------------------------------------------
-- PL/SQL 제어문
--------------------------------------------------------------------------------
-- 1. IF 제어문
--  IF ~ THEN ~ [ELSE IF]

-- job별로 경조사비를 급여대비 일정 비율로 지급하고 있다.
-- 각 직원들의 경조사비 지원금을 구하는 프로시저 작성

-- (1) SP 이름 : sp_get_tribute_fee
-- (2) IN 변수 : v_empno (사번)
-- (3) OUT 변수 : v_tribute_fee (급여타입)

-- 1. 프로시저 작성
CREATE OR REPLACE PROCEDURE sp_get_tribute_fee
(  v_empno        IN  EMP.EMPNO%TYPE
  ,v_tribute_fee  OUT EMP.SAL%TYPE  )
IS
  -- 사번인 직원의 직무를 저장할 지역 변수
   v_job    EMP.JOB%TYPE;
   v_sal    EMP.SAL%TYPE;
BEGIN
    -- 1. 입력 된 사번 직원의 직무와 급여를 조회하여 v_job과 v_sal에 저장
    SELECT e.JOB, e.sal
      INTO v_job, v_sal
      FROM emp e
     WHERE e.EMPNO = v_empno
    ;
     /*
          CLERK       : 5%
          SALESMAN    : 4%
          MANGAER     : 3.7%
          ANALYST     : 3%
          PRESIDENT   : 1.5%
      */
      -- 2. 일정 비율로 v_tribute_fee 를 계산
      IF      v_job = 'CLERK'     THEN v_tribute_fee := v_sal * 0.05;
      ELSIF   v_job = 'SALESMAN'  THEN v_tribute_fee := v_sal * 0.04;
      ELSIF   v_job = 'MANAGER'   THEN v_tribute_fee := v_sal * 0.037;
      ELSIF   v_job = 'ANALYST'   THEN v_tribute_fee := v_sal * 0.03;
      ELSIF   v_job = 'PRESIDENT' THEN v_tribute_fee := v_sal * 0.015;
      END IF;
      
END sp_get_tribute_fee;
/
-- 2. 컴파일 / 디버깅
-- Procedure SP_GET_TRIBUTE_FEE이(가) 컴파일되었습니다.

-- 3. VAR
VAR v_tribute_fee_bind NUMBER

-- 4. EXEC
EXEC sp_get_tribute_fee(v_tribute_fee => :v_tribute_fee_bind, v_empno => 7566)

-- 5. PRINT
PRINT v_tribute_fee_bind
/*
PL/SQL 프로시저가 성공적으로 완료되었습니다.


V_TRIBUTE_FEE_BIND
------------------
            110.08
*/

--------------------------------------------------------------------------------
-- 2. LOOP 기본 반복문
--------------------------------------------------------------------------------
-- ANONYMOUS PROCEDURE 로 실행 예
-- 문제 ) 1 ~ 10 까지의 합을 출력

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

--------------------------------------------------------------------------------
-- 2. LOOP : FOR LOOP 카운터 변수를 사용하는 반복문
--------------------------------------------------------------------------------
-- 지정된 횟수만큼 실행 반복문
-- 문제 1) 1 ~ 20 의 3의 배수를 출력 : ANONYMOUS PROCEDURE
DECLARE
    -- 1. FOR LOOP 에서 사용할 카운터 변수 선언 / 초기화
    cnt  NUMBER := 0;
BEGIN
    -- 2. LOOP 작성
    FOR cnt IN 1 .. 20 LOOP
      -- 3. 3의 배수 판단
        IF (MOD(cnt, 3) = 0)
            THEN SYS.DBMS_OUTPUT.PUT_LINE(cnt);
        END IF;
    END LOOP;
END;
/

/*
3
6
9
12
15
18


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

--------------------------------------------------------------------------------
-- 2. LOOP : WHILE LOOP 조건에 따라 수행되는 반복문
--------------------------------------------------------------------------------
-- 문제) 1 ~ 20 사이의 수 중에서 2의 배수를 화면 출력
--       ANONYMOUS PROCEDURE 로 바로 수행
DECLARE
    -- 반복 조건으로 사용할 횟수 변수 선언
    cnt   NUMBER := 0;
BEGIN
    WHILE cnt < 20 LOOP
        cnt := cnt + 2;
        DBMS_OUTPUT.PUT_LINE(cnt);
    END LOOP;
END;
/
/*
0
2
4
6
8
10
12
14
16
18
20


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

-------------------------------------------------
-- PL/SQL : Stored Function (저장 함수)
-------------------------------------------------
-- 대부분 SP량 유사
-- IS 블록 전에 RETURN 구문이 존재
-- RETURN 구문에는 문장 종료 기호 (;) 없음
-- 실행은 기존 사용하는 함수와 동일하게 SELECT, WHERE 절 등에 사용함.

-- 문제) 부서 번호를 입력 받아서 해당 부서의 급여 평균을 구하는 함수 작성
---- (1) FN 이름 : fn_avg_sal_by_dept
---- (2) IN 변수 : v_deptno (부서번호 타입)
---- (3) 지역변수 : v_avg_sal (급여타입) 계산 된 평균 급여를 저장
-- 1. 함수 작성
CREATE OR REPLACE FUNCTION fn_avg_sal_by_dept
(  v_deptno     IN    EMP.DEPTNO%TYPE )
-- 함수의 리턴 구문 작성
RETURN NUMBER
IS
   v_avg_sal    EMP.SAL%TYPE;
BEGIN
   -- 부서별 급여 평균을 AVG() 함수를 사용하여 구하고 저장
   SELECT avg(e.sal)
     INTO v_avg_sal
     FROM emp e
    WHERE e.DEPTNO = v_deptno
    ;
    
    RETURN ROUND(v_avg_sal);
END fn_avg_sal_by_dept;
/
-- 2. 컴파일 / 디버깅
-- Function FN_AVG_SAL_BY_DEPT이(가) 컴파일되었습니다.

-- 3. 이 함수를 사용하는 쿼리를 작성하여 실행해 본다.

-- 10번 부서의 급여 평균을 알고 싶다.
SELECT fn_avg_sal_by_dept(10) as "부서 급여 평균"
  FROM dual
;

SELECT AVG(SAL)
  FROM emp
 WHERE deptno = 10
;

-- 10번 부서의 급여 평균보다 높은 평균을 가지고 있는 부서는?
SELECT e.DEPTNO
      ,AVG(e.SAL)
  FROM emp e
 GROUP BY e.deptno
HAVING AVG(e.SAL) > fn_avg_sal_by_dept(30)
;

-----------------------------------------------------------------
-- SP / FN 에서 예외 처리
-----------------------------------------------------------------
-- 예외 처리 : 오라클에서 프로시저 실행 중 발생할 수 있는
--             이미 잘 알려진 상황에 대한 사전 정의 예외목록을 제공

-- 1. NO_DATA_FOUND
CREATE OR REPLACE PROCEDURE sp_get_emp_info_detail
(   v_empno IN emp.empno%TYPE  )
IS
    -- 1. RECORD 타입 선언
    TYPE emp_record_type IS RECORD
    (   r_empno     EMP.EMPNO%TYPE
      , r_ename     EMP.ENAME%TYPE
      , r_mgrename  EMP.ENAME%TYPE
      , r_dname     DEPT.DNAME%TYPE
      , r_loc       DEPT.LOC%TYPE
      , r_salgrade  SALGRADE.GRADE%TYPE
      )
    ;
    -- 2. 1에서 선언한 타입의 변수를 선언
    v_emp_record  emp_record_type;
BEGIN
    -- 3. 1에서 선언한 RECORD 타입은 조인의 결과를 받을 수 있음
    SELECT e.EMPNO
          ,e.ENAME
          ,e1.ENAME
          ,d.DNAME
          ,d.LOC
          ,s.GRADE
      INTO v_emp_record
      FROM emp e
          ,emp e1
          ,dept d
          ,salgrade s
     WHERE e.MGR = e1.EMPNO
       AND e.DEPTNO = d.DEPTNO
       AND e.SAL BETWEEN s.LOSAL AND s.HISAL
       AND e.EMPNO = v_empno
    ;
    
    DBMS_OUTPUT.PUT_LINE('사    번  : ' || v_emp_record.r_empno);
    DBMS_OUTPUT.PUT_LINE('이    름  : ' || v_emp_record.r_ename);
    DBMS_OUTPUT.PUT_LINE('매 니 저  : ' || v_emp_record.r_mgrename);
    DBMS_OUTPUT.PUT_LINE('부 서 명  : ' || v_emp_record.r_dname);
    DBMS_OUTPUT.PUT_LINE('부서 위치 : ' || v_emp_record.r_loc);
    DBMS_OUTPUT.PUT_LINE('급여 등급 : ' || v_emp_record.r_salgrade);
    
    -- 5. NO_DATA_FOUND 예외 처리
    EXCEPTION
         WHEN NO_DATA_FOUND
         THEN DBMS_OUTPUT.PUT_LINE('해당 직원의 매니저 혹은 부서가 배정 되지 않았습니다.');
         
END sp_get_emp_info_detail;
/

EXEC sp_get_emp_info_detail(7839)
EXEC sp_get_emp_info_detail(6666);

-- 2. DUP_VAL_ON_INDEX
-- 문제) member 테이블에 member_id, member_name 을
--       입력 받아서 신규로 1행을 추가하는
--       sp_insert_member 작성

-- 1), 프로시저 작성
CREATE OR REPLACE PROCEDURE sp_insert_member
(   v_member_id     IN member.member_id%TYPE
  , v_member_name   IN member.member_name%TYPE )
IS
BEGIN
    -- 입력 된 IN 모드 변수 값을 INSERT 시도
    INSERT INTO member (member_id, member_name)
    VALUES (v_member_id, v_member_name);
    commit;
    DBMS_OUTPUT.PUT_LINE(v_member_id || ' 신규 추가 진행');

    
    -- 입력 시도에는 항상 DUP_VAL_ON_INDEX 예외 위험 존재
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX
        THEN -- 이미 존재하는 키의 값이면 신규 추가가 아니라
             -- 수정으로 진행
             UPDATE member m
                SET m.member_name = v_member_name
              WHERE m.member_id = v_member_id
              ;
              -- 처리 내용을 화면 출력
              DBMS_OUTPUT.PUT_LINE(v_member_id || '가 이미 존재하므로 멤버 수정 진행');
END sp_insert_member;
/

EXEC sp_insert_member('M13', '채한나');
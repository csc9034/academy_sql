-------------------------------------------------------------
-- PL/SQL
-------------------------------------------------------------
-- 1. ANONYMOUS PROCEDURE : 이름 없이 1회 실행 저장 프로시저

-- 출력 설정 SQL*PLUS 설정
-- 기본 OFF 설정일 것임
SHOW SERVEROUTPUT 
;
-- ON 설정으로 변경
SET SERVEROUTPUT ON 
;

-- 1) 변수 선언이 있는 ANONYMOUS PROCEDURE 작성
DECLARE
    -- 변수 선언이 있는 ANONYMOUS PROCEDURE 작성
    name  VARCHAR(20) := 'Hannam Univ';
    -- name 변수는 선언하며 값을 저장
    year  NUMBER;
    -- year 변수는 선언만 하고 값을 저장하지 않음
BEGIN
    -- 프로시저에서 실행할 로직을 생성
    -- 일반적으로 SQL 구문처리가 들어감.
    -- 변수 처리, 비교, 반복 등의 로직이 들어감
    
    -- year 변수에 값 저장
    year := 1956; 
    
    -- 화면 출력
    DBMS_OUTPUT.put_line(name || 'Since' || year);
END;
/

/*
Hannam UnivSince1956


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

-- DECLARE 에서는 변수만 선언
-- BEGIN 에서 값을 저장
-- 출력

-- 1) 변수 선언이 있는 ANONYMOUS PROCEDURE 작성
DECLARE
    -- 변수 선언이 있는 ANONYMOUS PROCEDURE 작성
    name  VARCHAR(20);
    -- name 변수는 선언만 하고 값을 저장하지 않음
    year  NUMBER;
    -- year 변수는 선언만 하고 값을 저장하지 않음
BEGIN
    -- 프로시저에서 실행할 로직을 생성
    -- 일반적으로 SQL 구문처리가 들어감.
    -- 변수 처리, 비교, 반복 등의 로직이 들어감
    
    name := '조성철';
    
    -- year 변수에 값 저장
    year := 1994; 
    
    -- 화면 출력
    DBMS_OUTPUT.put_line(name || ' Since ' || year);
END;
/

-- 2) 변수 선언이 없는 1회용 프로시저는 DECLARE 블록 생략 가능
BEGIN
    DBMS_OUTPUT.PUT_LINE('한남대학교 개교 1956년');
END;
/

-- PL/SQL 프로시저가 성공적으로 완료되었습니다.

-----------------------------------------------
-- 2. STORED PROCEDURE : (SP) 저장 프로시저
-----------------------------------------------
-- 반복적으로 호출하여 사용하기 위한 목적으로
-- PROCEDURE 를 DBMS 에 선 컴파일 하여 저장하고
-- 사용하는 객체

-- TABLE, SEQUENCE, INDEX, VIEW 등과 같은 객체이므로
-- 동일한 이름의 다른 테이블명 등으로 생성 불가능

--- 1) 저장 프로시저(SP)의 생성
CREATE OR REPLACE PROCEDURE sp_maxim
(  name     IN  VARCHAR2
 , message  IN  VARCHAR2)
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE(name || ' : ' || message);
END sp_maxim;
/

--- 2) Oracle SQL Developer ==> ctrl + enter KEY 입력으로 컴파일 진행
--     SQL*PLUS 명령창 코드 붙여넣기로 컴파일 가능

-- Procedure SP_MAXIM이(가) 컴파일되었습니다.
-- 저장 프로시저는 컴파일과 동시 실행이 아님 컴파일만 실행
-- 실행은 따로 해야 함
-- 구문에 오류가 있으면 오류와 함께 컴파일이 진행
-- 오류 상태로 컴파일 된 프로시저는 실행이 안됨

--- 3) 오류 상태로 컴파일되면 오류 수정 후 재컴파일 진행
--     재컴파일 진행을 쉽게 하기 위해서
--     OR REPLACE 옵션 사용을 권장
--     오류가 있는 경우 SHOW ERRORS 명령으로 오류 확인 가능
SHOW errors;
/*
7/1       PLS-00103: Encountered the symbol "END" when expecting one of the following:     
          := . ( % ; 
          The symbol ";" was substituted for "END" to continue. 
*/

--- 4) 실행
----- a. BIND 변수를 선언 (OUT 변수가 선언된 경우만)
----- b. EXECUTE 명령을 실행
----- c. PRINT 명령으로 BIND 변수 값 출력(OUT 변수가 선언된 경우만)

-- EXECUTE 프로시저이름(전달할 값1, 전달할 값2) : SQL*PLUS 명령
EXECUTE SP_MAXIM('소크라테스', '너 자신을 알라')
EXECUTE SP_MAXIM('홍길동', '호부호형을 못하니...')
EXECUTE SP_MAXIM('데카르트', 'I think therefore I am.')
EXECUTE SP_MAXIM('장 폴 사르트르', '인생은 B와 D사이의 C이다.')

-- 입력 아큐먼트가 없는 sp 작성
CREATE OR REPLACE PROCEDURE sp_maxim_noagrgs
IS
    -- 지역변수 선언 블록, BEGIN ~ END 사이에서 사용되는 변수 선언부
    -- 변수 타입 선언 시 크기까지 지정
    name     VARCHAR2(30)   := '소크라테스';
    message  VARCHAR2(100)  := '너 자신을 알라';
BEGIN
    DBMS_OUTPUT.PUT_LINE(name || ' : ' || message);
END sp_maxim_noagrgs;
/
-- Procedure SP_MAXIM_NOAGRGS이(가) 컴파일되었습니다.

EXECUTE sp_maxim_noagrgs
;
/*
소크라테스 : 너 자신을 알라


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/



-----------------------------------------------------------
-- OUT 모드 변수가 있는 SP
-- 1) sp_maxim 을 out 변수가 있는 SP로 수정
CREATE OR REPLACE PROCEDURE sp_maxim
(  name     IN  VARCHAR2
 , message  IN  VARCHAR2
 , result   OUT VARCHAR2)
IS
BEGIN
    -- 블록 안에서 바로 출력
    DBMS_OUTPUT.PUT_LINE(name || ' : ' || message);
    -- result OUT 변수에 저장
    result := name || ' : ' || message;
END sp_maxim;
/
-- Procedure SP_MAXIM이(가) 컴파일되었습니다.
-- 2) 실행을 위해 
--- a. BIND 변수 선언 : SQL*PLUS 의 변수
--     VAR[IABLE] 바인드변수이름 타입
VAR v_maxim_result VARCHAR2(200)
--     BIND 변수를 출력
PRINT v_maxim
-- SP2-0552: 바인드 변수 "V_MAXIM"이(가) 선언되지 않았습니다.

PRINT v_maxim_result
/*
V_MAXIM_RESULT
--------------------------------------------------------------------------------
*/

--- b. EXECUTE 로 SP 실행
EXECUTE sp_maxim('소크라테스', '너 자신을 알라', : v_maxim_result);
/* -------------------------------------------
소크라테스 : 너 자신을 알라


PL/SQL 프로시저가 성공적으로 완료되었습니다.
------------------------------------------- */

--- c. PRINT 로 BIND 변수를 출력
PRINT v_maxim_result;
/*
V_MAXIM_RESULT
--------------------------------------------------------------------------------
소크라테스 : 너 자신을 알라
*/



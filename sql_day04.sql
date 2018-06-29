---- JOIN 계속..
-- EQUI 조인 구문 구조

-- 1. 오라클 전용 조인 구조
SELECT [별칭1.]컬럼명1, [별칭2.]컬럼명2 [, ...]
  FROM 테이블1 별칭1, 테이블2 별칭2 [, ...]
 WHERE 별칭1.공통컬럼1 = 별칭2.공통컬럼1 -- 조인 조건을 WHERE 에 작성
  [AND 별칭1.공통컬럼2 = 별칭n.공통컬럼2] -- FROM 에 나열 된 테이블이 2개가 넘을 때
  [AND ... 추가 가능한 일반 조건들 등장]
;

-- 2. NATRUAL JOIN 을 사용하는 구조
SELECT [별칭1.]컬럼명1, [별칭2.]컬럼명2 [, ...]
  FROM 테이블1 별칭1 NATURAL JOIN 테이블2 별칭2
                    [NATURAL JOIN 테이블n 별칭n]
;                    
-- 3. JOIN ~ USING 을 사용하는 구조 : 여러 테이블에서 공통컬럼 이름이 동일해야 함
SELECT [별칭1.]컬럼명1, [별칭2.]컬럼명2 [, ...]
  FROM 테이블1 별칭1 JOIN 테이블2 별칭2 USING (공통컬럼) -- 공통컬럼에 별칭 사용하지 않음
; 
-- 4. JOIN ~ ON 을 사용하는 구조 : 표준 SQL 구문
SELECT [별칭1.]컬럼명1, [별칭2.]컬럼명2 [, ...]
  FROM 테이블1 별칭1 JOIN 테이블2 별칭2 ON (별칭1.공통컬럼2 = 별칭n.공통컬럼2)
                    [JOIN 테이블n 별칭n ON (별칭1.공통컬럼n = 별칭n.공통컬럼n)]
;
--------------------------------------------------------------------------------------------------------
---- 4) NON-EQUI JOIN : WHERE 조건절에 join attribute 사용하는 대신
--                      다른 비교 연산자를 사용하여 여러 테이블을 엮는 기법

-- 문제 ) emp, salgrade 테이블을 사용하여 직원의 급여에 따른 등급을 함께 조회
--        emp 테이블에는 salgrade 테이블과 연결할 수 있는 동일한 값이 없음

SELECT e.EMPNO
      ,e.ENAME
      ,e.SAL
      ,s.grade
      ,s.LOSAL
      ,s.HISAL
  FROM emp e
      ,salgrade s
  WHERE e.SAL BETWEEN s.LOSAL AND s.HISAL
;

---- 5) OUTER JOIN : 조인 대상 테이블 중 공통 컬럼에 NULL 값이 데이터의 경우도 출력을 원할 때

--  연산자 : (+), LEFT OUTER JOIN, RIGHT OUTER JOIN

----- 1. (+) : 오라클이 사용하는 전통적인 OUTER JOIN 연산자
--             왼쪽, 오른쪽 어느 쪽에나 NULL 값을 출력하기 원하는 쪽에
--             붙여서 사용

--    2. (+) 연산자 사용시 JOIN 구문 구조
SELECT ......
  FROM 테이블1 별칭1, 테이블2 별칭2
 WHERE 별칭1.공통컬럼(+) = 별칭2.공통컬럼 -- RIGHT OUTER JOIN, 왼쪽 테이블의 NULL 데이터 출력
[WHERE 별칭1.공통컬럼 = 별칭2.공통컬럼(+) -- LEFT OUTER JOIN, 오른쪽 테이블의 NULL 데이터 출력]
;
--        RIGHT OUTER JOIN ~ ON 구문 구조
SELECT ......
  FROM 테이블1 별칭1 RIGHT OUTER JOIN 테이블2 별칭2 -- RIGHT OUTER JOIN, 왼쪽 테이블의 NULL 데이터 출력
    ON  별칭1.공통컬럼 = 별칭2.공통컬럼
;       
--        LEFT OUTER JOIN ~ ON 구문 구조
SELECT ......
  FROM 테이블1 별칭1 LEFT OUTER JOIN 테이블2 별칭2 -- LEFT OUTER JOIN, 오른쪽 테이블의 NULL 데이터 출력
    ON  별칭1.공통컬럼 = 별칭2.공통컬럼 
;    
-- 문제) 직원 중에 부서가 배치되지 않은 사람이 있을 때
-- 1. 일반 조인(EQUI-JOIN)을 걸면 조회가 되지 않는다.
SELECT e.EMPNO
      ,e.ENAME
      ,e.DEPTNO
      ,d.DNAME
  FROM emp e
      ,dept d
  WHERE e.DEPTNO = d.DEPTNO
;

-- 2. OUTER JOIN 으로 해결
SELECT e.EMPNO
      ,e.ENAME
      ,e.DEPTNO
      ,d.DNAME
  FROM emp e
      ,dept d
  WHERE e.DEPTNO = d.DEPTNO(+) 
;
-- (+) 연산자는 오른쪽에 붙이고 이는 NULL 상태로 출력 될 테이블을 결정
-- 전체 데이터를 기준 삼는 테이블이 왼쪽이기 때문에 LEFT OUTER JOIN 발생

-- 3. LEFT OUTER JOIN ~ ON 으로
SELECT e.EMPNO
      ,e.ENAME
      ,e.DEPTNO
      ,d.DNAME
  FROM emp e LEFT OUTER JOIN dept d
    ON e.DEPTNO = d.DEPTNO
;

-- 문제) 아직 아무도 배치되지 않은 부서가 있어도
--       부서를 다 조회하고 싶다면
-- 1. (+) 연산자로 해결
SELECT e.EMPNO
      ,e.ENAME
      ,e.DEPTNO
      ,'|'
      ,d.DEPTNO
      ,d.DNAME
  FROM emp e
      ,dept d
 WHERE e.DEPTNO(+) = d.DEPTNO
;

-- 2. RIGHT OUTER JOIN ~ ON 으로 해결
SELECT e.EMPNO
      ,e.ENAME
      ,e.DEPTNO
      ,'|'
      ,d.DEPTNO
      ,d.DNAME
  FROM emp e RIGHT OUTER JOIN dept d
    ON e.DEPTNO = d.DEPTNO
;

-- 문제) 부서배치가 안된 직원도 보고 싶고
--       직원이 아직 아무도 없는 부서도 모두 싶을 때
--       즉, 양 쪽 모두에 존재하는 NULL 값들을 모두 한번 조회하려면 어떻게 해야 하는가?

-- 1. (+) 연산자로는 양쪽 아우터 조인 불가능
SELECT e.EMPNO
      ,e.ENAME
      ,e.DEPTNO
      ,'|'
      ,d.DEPTNO
      ,d.DNAME      
  FROM emp e                  -- ====> ORA-01468: a predicate may reference only one outer-joined table
      ,dept d
 WHERE e.DEPTNO(+) = d.DEPTNO(+)
;

-- 2. FULL OUTER JOIN ~ ON 구문으로 지원
SELECT e.EMPNO
      ,e.ENAME
      ,e.DEPTNO
      ,'|'
      ,d.DEPTNO
      ,d.DNAME      
  FROM emp e FULL OUTER JOIN dept d
    ON e.DEPTNO = d.DEPTNO
;

---- 6) SELF JOIN : 한 테이블 내에서 자기 자신의 컬럼끼리 연결하여 새 행을 만드는 기법
-- 문제) emp 테이블에서 mgr에 해당하는 상사의 이름을 같이 조회하려면
SELECT e1.EMPNO as "직원 사번"
     , e1.ENAME as "지원 이름"
     , e1.MGR   as "상사 사번"
     , e2.ENAME as "상사 이름"
  FROM emp e1
     , emp e2
 WHERE e1.MGR = e2.EMPNO
;
 
-- 상사가 없는 직원도 조회하고 싶다.
-- a) a1 테이빌이 기준 => LEFT OUTER JOIN
-- b) (+) 기호를 오른쪽에 붙인다.
SELECT e1.EMPNO as "직원 사번"
     , e1.ENAME as "지원 이름"
     , e1.MGR   as "상사 사번"
     , e2.ENAME as "상사 이름"
  FROM emp e1
     , emp e2
 WHERE e1.MGR = e2.EMPNO(+)
;

SELECT e1.EMPNO as "직원 사번"
     , e1.ENAME as "지원 이름"
     , e1.MGR   as "상사 사번"
     , e2.ENAME as "상사 이름"
  FROM emp e1 LEFT OUTER JOIN emp e2
    ON e1.MGR = e2.EMPNO
;

-- 부하 직원이 없는 사람
SELECT e1.EMPNO as "직원 사번"
     , e1.ENAME as "지원 이름"
     , e1.MGR   as "상사 사번"
     , e2.ENAME as "상사 이름"
  FROM emp e1 RIGHT OUTER JOIN emp e2
    ON e1.MGR = e2.EMPNO
;

SELECT e1.EMPNO as "직원 사번"
     , e1.ENAME as "지원 이름"
     , e1.MGR   as "상사 사번"
     , e2.ENAME as "상사 이름"
  FROM emp e1
     , emp e2
 WHERE e1.MGR(+) = e2.EMPNO
;
------------ 7. 조인과 서브쿼리
---- (2) 서브쿼리 : SUB-QUERY
--                  SELECT, FROM, WHERE 절에 사용할 수 있다.
-- 문제 ) BLAKE와 직무와 동일한 직원의 정보를 조회
-- 1. BLAKE 의 직무를 조회
SELECT e.JOB
  FROM emp e
 WHERE e.ENAME = 'BLAEK'
;
-- 2. 1의 결과를 WHERE 조건 절에 사용하는 메인 쿼리 작성
SELECT e.EMPNO
      ,e.ENAME
      ,e.JOB
  FROM emp e
 WHERE e.JOB = (SELECT e.JOB
                  FROM emp e
                 WHERE e.ENAME = 'BLAKE')
;
-- ==> 메인 쿼리의 WHERE 절에 () 안에 전달되는 값이 1의 결과인
--     'MANAGER' 라는 값이다.

-----------------------------------------------------------------

-- 서브쿼리 실습

-- 1. 이 회사의 평균 급여보다 급여가 큰 직원들이 목록을 조회
-- (사번, 이름, 급여)

-- a) 회사의 평균 급여 : AVG(sal)
SELECT AVG(e.SAL)
  FROM emp e
;

-- b) 평균 급여보다 급여가 높은 직원 조회

SELECT e.EMPNO
      ,e.ENAME
      ,e.SAL
  FROM emp e
 WHERE e.SAL > (SELECT AVG(e.SAL)
                  FROM emp e)
 ORDER BY e.SAL DESC
;

-- 2. 급여가 평균 급여보다 크면서 사번이 7700 번보다 높은 직원 조회
-- (사번, 이름, 급여)

-- a) 1번의 결과를 사용
SELECT e.EMPNO
      ,e.ENAME
      ,e.SAL
  FROM emp e
 WHERE e.SAL > (SELECT AVG(e.SAL)
                  FROM emp e)
   AND e.EMPNO > 7700
 ORDER BY e.SAL DESC
;

-- b) sub-query 로 해결 : FROM 절에 1의 결과를 임시테이블처럼 사용
SELECT a.*
  FROM (SELECT e.EMPNO
      ,e.ENAME
      ,e.SAL
          FROM emp e
         WHERE e.SAL > (SELECT AVG(e.SAL)
                  FROM emp e)) a
 WHERE a.EMPNO > 7700
;

-- 3. 각 직무별로 최대 급여를 받는 직원 목록을 조회
-- (사번, 이름, 직무, 급여)
-- a) 직무별 최대 급여를 구하는 쿼리
SELECT e.JOB
      ,MAX(e.SAL) as "max_sal"
  FROM emp e
  GROUP BY e.JOB
;

-- b) a를 사용할 메인 쿼리
--    최대 급여가 자신의 급여와 같은지,
--    그 때의 직무가 나의 직무와 같은 비교 필요
SELECT e.EMPNO
      ,e.ENAME
      ,e.JOB
      ,e.SAL
  FROM emp e
 WHERE e.SAL = (SELECT e.JOB  -- ===> ORA-00913: too many values
                     , MAX(e.SAL)
                  FROM emp e
                 GROUP BY e.JOB)
;
-- > WHERE 절에서 비교 되는 e.SAL 은 한 개의 컬럼
--   그런데 서브쿼리에서 돌아오는 값은 두 개의 컬럼이라 비교 불가능

SELECT e.EMPNO
      ,e.ENAME
      ,e.JOB
      ,e.SAL
  FROM emp e
 WHERE e.SAL = (SELECT MAX(e.SAL)
                  FROM emp e
                 GROUP BY e.JOB)
;
-- ORA-01427: single-row subquery returns more than one row
/*
  WHERE 조건에 있는 e.SAL 은 1행을 비교하기 위한 행인데
  서브쿼리 GROUP BY로 묶여있음.
*/
--> IN 연산자를 사용하여 해결 
SELECT e.EMPNO
      ,e.ENAME
      ,e.JOB
      ,e.SAL
  FROM emp e
 WHERE (e.JOB, e.SAL) IN (SELECT e.JOB  
                               , MAX(e.SAL)
                            FROM emp e
                           GROUP BY e.JOB)
;


SELECT e.EMPNO
      ,e.ENAME
      ,e.JOB
      ,e.SAL
  FROM emp e
 WHERE e.SAL IN (SELECT MAX(e.SAL)
                   FROM emp e
                  GROUP BY e.JOB)
;   --> e.SAL만 IN 연산으로 비교 했을 경우 데이터가 다양해지면 잘 못 작동할 수 있음.

-- 4. 각 월별 입사 인원만을 세로로 출력
-- a) 입사일 데이터에서 월을 추출
SELECT TO_CHAR(e.HIREDATE, 'FMMM')
  FROM emp e
;

-- b) 입사 월별 인원 => 그룹화 기준 월
--    인원을 구하는 함수 => COUNT(*)

SELECT TO_CHAR(e.HIREDATE, 'FMMM')
      ,COUNT(*)
  FROM emp e
 GROUP BY TO_CHAR(e.HIREDATE, 'FMMM')
 ORDER BY 
;

-- c) 입사 월 순으로 정렬
SELECT TO_CHAR(e.HIREDATE, 'FMMM') as "입사월"
      ,COUNT(*) as "인원(명)"
  FROM emp e
 GROUP BY TO_CHAR(e.HIREDATE, 'FMMM')
 ORDER BY "입사월"
;

-- d) 숫자형으로 변환 후 정렬
SELECT TO_NUMBER(TO_CHAR(e.HIREDATE, 'FMMM')) as "입사월"
      ,COUNT(*) as "인원(명)"
  FROM emp e
 GROUP BY TO_CHAR(e.HIREDATE, 'FMMM')
 ORDER BY "입사월"
;

-- e) 입사월 데이터 값 뒤에 '월' 붙이기
SELECT TO_NUMBER(TO_CHAR(e.HIREDATE, 'FMMM')) || '월' as "입사월"
      ,COUNT(*) as "인원(명)"
  FROM emp e
 GROUP BY TO_CHAR(e.HIREDATE, 'FMMM')
 ORDER BY "입사월"
;
-- ==> '월'을 붙이면 다시 문자화 되서 정렬 안됨.

-- 서브쿼리로 감싸서 정렬 시도
SELECT a."입사월" || '월'
      ,a."인원(명)"
  FROM (SELECT TO_NUMBER(TO_CHAR(e.HIREDATE, 'FMMM')) as "입사월"
              ,COUNT(*) as "인원(명)"
          FROM emp e
         GROUP BY TO_CHAR(e.HIREDATE, 'FMMM')
         ORDER BY "입사월") a
;

----------------------------------------------------------------------------
-- DDL : DBMS 가 OBJECT(객체) 로 관리/인식하는 대상을
--       생성, 수정, 삭제하는 언어
--
--    생성 : CREATE
--    수정 : ALTER
--    삭제 : DROP

-- vs DML
--    생성 : INSERT
--    수정 : UPDATE
--    삭제 : DELETE
----------------------------------------------------------------------------
/*
  CREATE | ALTER | DROP {관리할 객체의 타입명}
  
  DBMS 의 객체들 타입
  SCHEMA, DOMAIN, TABLE, VIEW, INDEX, SEQUENCE, USER, DATABASE
*/

CREATE TABLE 테이블이름
( 컬럼1이름 데이터타입[(길이)] [DEFAULT 기본값] [컬럼의 제약사항]
[,컬럼2이름 데이터타입[(길이)] [DEFAULT 기본값] [컬럼의 제약사항]]
........
[,컬럼n이름 데이터타입[(길이)] [DEFAULT 기본값] [컬럼의 제약사항]]
);

/* -------------------------------------------------
   컬럼의 제약사항
   -------------------------------------------------
   1. PRIMARY KEY : 이 컬럼에 입력되는 값은 중복되지 않으며
                    한 행을 유일하게 식별 가능한 값으로 설정
                    NULL 데이터 입력이 불가능한 값이어야 한다.
                    
   2. FOREIGN KEY : 주로 JOIN에 사용되는 조건으로
                    다른 테이블의 PRIMARY KEY 로 사용되었던 값이 등장
   
   3. UNIQUE      : 이 컬럼에 입력되는 값은 중복되지 않음을 보장
                    NULL 일 수 있음
   
   4. NOT NULL    : 이 컬럼에 입력되는 값의 중복은 상관 없으나
                    NULL 상태는 되지 않도록 보장
                    
   ==> PK : UNIQUE + NOT NULL 의 형태라는 것을 알 수 있다.

*/

-- 예) 아카데미 구성 인원 정보를 저장할 테이블을 정의
/*
  테이블 이름 : member
  1. 멤버아이디       : member_id      : 문자 : VARCHAR2 : PK
  2. 멤버 이름        : member_name    : 문자 : VARCHAR2 : NOT NULL
  3. 전화번호 뒷자리  : phone          : 문자 : VARCHAR2 
  4. 시스템등록일     : reg_date       : 날짜 : DATE     : DEFAULT
  5. 사는 곳(동 이름) : address        : 문자 : VARCHAR2
  6. 좋아하는 숫자    : like_number    : 숫자 : NUMBER
*/
-- 1. 테이블 생성 구문
CREATE TABLE member
(  member_id     VARCHAR2(3)  PRIMARY KEY
 , member_name   VARCHAR2(15) NOT NULL
 , phone         VARCHAR2(4) -- NULL 허용시 제약조건 비우면 됨
 , reg_date      DATE         DEFAULT sysdate
 , address       VARCHAR2(30)
 , like_number   NUMBER
);
-- Table MEMBER이(가) 생성되었습니다.

-- 2. 테이블 삭제 구문
DROP TABLE 테이블이름;

DROP TABLE member;
-- Table MEMBER이(가) 삭제되었습니다.

-- 3. 테이블 수정 구문
/* ------------------------------------
   수정의 종류
   ------------------------------------
   1. 컬럼을 추가 : ADD
   2. 컬럼을 삭제 : DROP COLUMN
   3. 컬럼을 수정 : MODIFY
   ------------------------------------
*/


ALTER TABLE 테이블이름 {ADD | DROP COLUMN | MODIFY} .... ;

-- 예) 생성한 member 테이블에 컬럼 2개 추가
-- 1) ADD
-- 출생 월 : birth_month : NUMBER 
-- 성별    : gender      : VARCHAR2(1)

ALTER TABLE member ADD 
(  birth_month NUMBER
 , gender      VARCHAR(1) CHECK (gender IN ('M', 'F'))
);

-- 예) 수정 한 member 테이블에서 like_number 컬럼을 삭제
-- 2) DROP COLUMN
ALTER TABLE 테이블이름 DROP COLUMN 컬럼이름;
ALTER TABLE member DROP COLUMN like_number;
-- Table MEMBER이(가) 변경되었습니다.

-- 예) 출생월 컬럼을 숫자 2자리까지만으로 제한하도록 수정
-- 3) MODIFY
ALTER TABLE 테이블이름 MODIFY 컬럼이름 데이터타입(크기);
ALTER TABLE member MODIFY birth_month NUMBER(2);
-- Table MEMBER이(가) 변경되었습니다.

------------------------------------------------------------
-- 예로 사용할 member 테이블의 최종 형태 작성 구문

CREATE TABLE member
(  member_id     VARCHAR2(3)  PRIMARY KEY
 , member_name   VARCHAR2(15) NOT NULL
 , phone         VARCHAR2(4)  -- NULL 허용시 제약조건 비우면 됨
 , reg_date      DATE         DEFAULT sysdate
 , address       VARCHAR2(30)
 , birth_month   NUMBER(2)
 , gender        VARCHAR(1)   CHECK (gender IN ('M', 'F'))
);
-- 가장 단순화 된 테이블 정의 구문
-- 제약조건을 각 컬럼 뒤에 바로 제약조건 이름 없이 생성



-- 테이블 생성시 정의한 제약조건이 저장되는 형태
-- DDL 로 정의 된 제약 조건은 시스템 카탈로그에 저장됨
-- user_constraint 라는 테이블에 저장
SELECT u.CONSTRAINT_NAME
      ,u.CONSTRAINT_TYPE
      ,u.TABLE_NAME
  FROM user_constraints u
 WHERE u.TABLE_NAME = 'MEMBER'
;

-- 제약조건에 이름을 부여해서 생성
DROP TABLE member;
-- Table MEMBER이(가) 삭제되었습니다.
CREATE TABLE member
(  member_id     VARCHAR2(3)  
 , member_name   VARCHAR2(15)   NOT NULL
 , phone         VARCHAR2(4)  
 , reg_date      DATE           DEFAULT sysdate
 , address       VARCHAR2(30)
 , birth_month   NUMBER(2)
 , gender        VARCHAR(1)   
 , CONSTRAINT pk_member        PRIMARY KEY (member_id)
 , CONSTRAINT ck_member_gender CHECK(gender IN ('M', 'F'))
);

-- 테이블 생성 기법 중 이미 존재하는 테이블로부터 복사 생성
-- 예) 앞서 생성한 member 테이블을 복사 생성 : new_member
DROP TABLE new_member ;
CREATE TABLE new_member
AS
SELECT *
  FROM member
 WHERE 1 = 2 -- 항상 거짓이 되는 조건
;
-- ==> PK 설정은 복사되지 않고 테이블 구조만 복사됨
DESC new_member;

/*

INSERT INTO "SCOTT"."MEMBER" (MEMBER_ID, MEMBER_NAME, PHONE, ADDRESS, BIRTH_MONTH, GENDER) VALUES ('M01', '유재성', '0238', '용운동', '3', 'M')
INSERT INTO "SCOTT"."MEMBER" (MEMBER_ID, MEMBER_NAME, PHONE, ADDRESS, BIRTH_MONTH, GENDER) VALUES ('M02', '윤홍식', '4091', '오정동', '12', 'M')
INSERT INTO "SCOTT"."MEMBER" (MEMBER_ID, MEMBER_NAME, PHONE, ADDRESS, BIRTH_MONTH, GENDER) VALUES ('M03', '윤한수', '9034', '오정동', '8', 'M')

*/

-- 오정동에 사는 인원의 정보만 복사해서 새 테이블 생성
-- ojung_member

DROP TABLE ojung_member;
CREATE TABLE ojung_member
AS
SELECT *
  FROM member
 WHERE address = '오정동'
;
-- Table OJUNG_MEMBER이(가) 생성되었습니다.

SELECT *
  FROM ojung_member
;

-- 복사할 조건에 항상 참이 되는 조건을 주면 
-- 모든 데이터를 복사하여 새 테이블 생성

CREATE TABLE full_member
AS
SELECT *
  FROM member
 WHERE 1 = 1 -- 항상 참이 되는 조건
;

SELECT * 
  FROM full_member
;

------------------------------------------------------------------------------------
-- 테이블 수정할 때 주의사항

-- 1) 컬럼에 데이터가 없을 때는 타입 변경, 크기 변경 모두 자유로움
-- 2) 컬럼에 데이터가 들어 있을 때 데이터 크기는 동일 혹시 커지는 방향으로만 가능
--    숫자는 정밀도 증가로만 허용
-- 3) 기본값(DEFAULT) 설정은 수정 이후 입력값부터 적용


-- 예)
-- 오정동에 사는 멤버만 복사하 ojung_member 테이블을 생각해보자
-- 주소가 '오정동' 으로 고정되어도 될 것 같다.

-- 1) 기본 값 설정 전에 멤버 데이터 추가 : address 가 NULL 인 데이터
INSERT INTO "SCOTT"."OJUNG_MEMBER" (MEMBER_ID, MEMBER_NAME, PHONE, BIRTH_MONTH, GENDER) VALUES ('M99', '홍길동', '0000', '9', 'M');

-- 2) 홍길동 정보 입력 후 기본 값 설정
ALTER TABLE ojung_member MODIFY (address DEFAULT '오정동');
-- Table OJUNG_MEMBER이(가) 변경되었습니다.

-- 3) 기본값 변경 후 새 멤버 추가
INSERT INTO "SCOTT"."OJUNG_MEMBER" (MEMBER_ID, MEMBER_NAME, PHONE, BIRTH_MONTH, GENDER) 
VALUES ('M98', '허균', '9999', '7', 'M');

-- 이미 데이터가 들어있는 컬럼의 크기 변경
-- 예) ojung_member 테이블의 출생월 birth_month 컬럼을 1칸으로 줄이면
ALTER TABLE ojung_member MODIFY birth_month NUMBER(1);
-- ORA-01440: column to be modified must be empty to decrease precision or scale
ALTER TABLE ojung_member MODIFY birth_month NUMBER(10, 2);
-- Table OJUNG_MEMBER이(가) 변경되었습니다.
-- 숫자 데이터를 확장하는 방식으로 변경 성공

-- 예) 출생월 birth_month 를 문자 2자리로 변경
ALTER TABLE ojung_member MODIFY birth_month VARCHAR2(2);
-- ORA-01439: column to be modified must be empty to change datatype
-- 데이터 타입 변경을 위해서는 컬럼에 데이터가 없어야 함.

SELECT * FROM ojung_member;

--------------------------------------------------------------------------------
-- (3) 데이터 무결성 제약 조건 처리 방법 4가지
--- 1. 컬럼 정의할 때 제약 조건 이름 없이 바로 선언
DROP TABLE main_table;

CREATE TABLE main_table
(  id       VARCHAR2(10)      PRIMARY KEY
 , nickname VARCHAR2(30)      UNIQUE
 , reg_date DATE              DEFAULT sysdate
 , gender   VARCHAR2(1)       CHECK (gender IN ('F', 'M'))
 , message  VARCHAR2(100)
);

DROP TABLE sub_table;
CREATE TABLE sub_table
(  id       VARCHAR2(10)      REFERENCES main_table(id)
 , sub_code NUMBER(4)         NOT NULL
 , sub_name VARCHAR(30)
);

-- 생성 된 제약조건 확인 쿼리
SELECT u.CONSTRAINT_NAME
      ,u.CONSTRAINT_TYPE
      ,u.TABLE_NAME
  FROM user_constraints u
 WHERE u.TABLE_NAME IN ('MAIN_TABLE', 'SUB_TABLE')
;
--- 2. 컬럼 정의할 때 제약 조건 이름 주며 선언
DROP TABLE main_table;
CREATE TABLE main_table
(  id       VARCHAR2(10) CONSTRAINT pk_main_table        PRIMARY KEY
 , nickname VARCHAR2(30) CONSTRAINT uq_main_table_nick   UNIQUE
 , reg_date DATE         DEFAULT sysdate
 , gender   VARCHAR2(1)  CONSTRAINT ck_main_table_gender CHECK (gender IN ('F', 'M'))
 , message  VARCHAR2(100)
);

DROP TABLE sub_table;
CREATE TABLE sub_table
(  id       VARCHAR2(10) CONSTRAINT fk_sub_table REFERENCES main_table(id)
 , sub_code NUMBER(4)    NOT NULL
 , sub_name VARCHAR(30)
);

--- 3. 컬럼 정의 후 제약 조건 따로 선언
DROP TABLE main_table;
CREATE TABLE main_table
(  id       VARCHAR2(10)
 , nickname VARCHAR2(30) 
 , reg_date DATE         DEFAULT sysdate
 , gender   VARCHAR2(1)  
 , message  VARCHAR2(100)
 , CONSTRAINT pk_main_table        PRIMARY KEY(id)
 , CONSTRAINT uq_main_table_nick   UNIQUE(nickname)
 , CONSTRAINT ck_main_table_gender CHECK (gender IN ('F', 'M'))
);

DROP TABLE sub_table;
CREATE TABLE sub_table
(  id       VARCHAR2(10) 
 , sub_code NUMBER(4)    NOT NULL
 , sub_name VARCHAR(30)
 , CONSTRAINT fk_sub_table FOREIGN KEY(id) REFERENCES main_table(id)
 -- sub_table 의 키는 id, sub_code 를 묶어서 복합키 형태로 설정
 , CONSTRAINT pk_sub_table PRIMARY KEY (id, sub_code)
 -- 복합키로 PK를 설정 할 때는 제약조건을 따로 설정하는 방법으로만 가능

);
--- 4. 테이블 정의 후 테이블 수정(ALTER TABLE) 로 제약조건 추가
DROP TABLE sub_table;
DROP TABLE main_table;

-- 제약 조건이 없는 테이블 생성
CREATE TABLE main_table
(  id       VARCHAR2(10)
 , nickname VARCHAR2(30) 
 , reg_date DATE         DEFAULT sysdate
 , gender   VARCHAR2(1)  
 , message  VARCHAR2(100)
);

-- 제약 조건 사후 추가
ALTER TABLE main_table ADD
(  CONSTRAINT pk_main_table4        PRIMARY KEY(id)
 , CONSTRAINT uq_main_table_nick4   UNIQUE(nickname)
 , CONSTRAINT ck_main_table_gender4 CHECK (gender IN ('F', 'M'))
);

-- 제약조건 없이 테이블 생성
CREATE TABLE sub_table
(  id       VARCHAR2(10) 
 , sub_code NUMBER(4)    NOT NULL
 , sub_name VARCHAR(30)
);

-- 제약조건 사후 추가
ALTER TABLE sub_table ADD
(  CONSTRAINT fk_sub_table4 FOREIGN KEY(id) REFERENCES main_table(id)
 -- sub_table 의 키는 id, sub_code 를 묶어서 복합키 형태로 설정
 , CONSTRAINT pk_sub_table4 PRIMARY KEY (id, sub_code)
 -- 복합키로 PK를 설정 할 때는 제약조건을 따로 설정하는 방법으로만 가능
);

--- 테이블 이름의 변경 : RENAME
-- ojung_member ====> member_of_ojung
RENAME ojung_member TO member_of_ojung;
-- 테이블 이름이 변경되었습니다.
DESC ojung_member;
-- ORA-04043: ojung_member 객체가 존재하지 않습니다.
DESC member_of_ojung;
-- 테이블 이름 다시 변경
RENAME member_of_ojung TO ojung_member;

--- 테이블 삭제 : DROP


DROP TABLE main_table;
-- ORA-02449: unique/primary keys in table referenced by foreign keys
-- sub_table 의 id 컬럼이 main_table 의 id 컬럼을 참조 하기 때문
-- 테이블 삭제에 순서가 필요

-- 참조 관계에 상관 없이 테이블 바로 삭제
DROP TABLE main_table CASCADE CONSTRAINT;
-- sub_table 과의 참조 관계가 끊어지면 바로 삭제 됨.

-- 생성 된 제약조건 확인 쿼리
SELECT u.CONSTRAINT_NAME
      ,u.CONSTRAINT_TYPE
      ,u.TABLE_NAME
  FROM user_constraints u
 WHERE u.TABLE_NAME IN ('MAIN_TABLE', 'SUB_TABLE')
;

/* -- sub_table 에 생성되어 있던 R 이 같이 제거되었음을 확인
--------------------------------------------------------------
SYS_C007933	  C	SUB_TABLE
PK_SUB_TABLE4	P	SUB_TABLE
*/

-- day 05 : SQL
---------------------------------------
-- ORACLE 의 특별한 컬럼

-- 1. ROWID : 물리적으로 디스크에 저장된 위치를 가리키는 값
--            물리적으로 저장된 위치이므로 한 행당 유일할 수 밖에 없음.
--            ORDER BY 절에 의해서 변경되지 않는 값
--            

-- 예) emp 테이블에서 'SMITH'인 사람의 정보를 조회
SELECT e.EMPNO
      ,e.ENAME
  FROM emp e
  WHERE e.ENAME = 'SMITH'
;

-- rowid를 같이 조회
SELECT e.rowid
      ,e.EMPNO
      ,e.ENAME
  FROM emp e
  WHERE e.ENAME = 'SMITH'
;

-- rowid는 order by에 의해 변경되지 않는다.
SELECT e.rowid
      ,e.EMPNO
      ,e.ENAME
  FROM emp e
 ORDER BY e.ENAME
;

SELECT e.rowid
      ,e.EMPNO
      ,e.ENAME
  FROM emp e
 ORDER BY e.EMPNO
;

-- 2. ROWNUM : 조회 된 절과의 첫번째 행부터 1로 증가하는 값
SELECT rownum
      ,e.EMPNO
      ,e.ENAME
  FROM emp e
 WHERE e.ENAME LIKE 'J%'
;

/*
ROWNUM, EMPNO, ENAME
    1	  7566	JONES
    2	  7900	JAMES
    3	  6666	JJ
    4	  9999	J_JUNE
    5	  8888	J
    6	  7777	J%JONES
*/

SELECT rownum
      ,e.EMPNO
      ,e.ENAME
  FROM emp e
 WHERE e.ENAME LIKE 'J%'
 ORDER BY e.ENAME
;

/*
ROWNUM, EMPNO, ENAME
    5	   8888	  J
    6	   7777	  J%JONES
    2	   7900	  JAMES
    3    6666	  JJ
    1    7566	  JONES
    4	   9999	  J_JUNE
*/
-- 위의 두 결과를 비교하면 rownum 도 ORDER BY에 영향을
-- 받지 않는 것 처럼 보일 수 있으나
-- SUB-QUERY 로 사용할 때 영향을 받음

SELECT rownum
      ,a.EMPNO
      ,a.ENAME
      ,a.deli
      ,a.numrow
  FROM (SELECT e.EMPNO
              ,e.ENAME
              ,'|'    as deli
              ,rownum as numrow
          FROM emp e
         WHERE e.ENAME LIKE 'J%'
         ORDER BY e.ENAME) a
;

-----------------------------------------------------------
-- DML : 데이터 조작어
-----------------------------------------------------------
-- 1) INSERT : 테이블에 데이터 행(row)을 추가하는 명령
DROP TABLE member;
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
 , CONSTRAINT ck_member_birth  CHECK(birth_month > 0 AND birth_month < = 12)
);

-- 테이블 구조 확인
DESC member;

-- 테이블 제약조건 확인
SELECT u.CONSTRAINT_NAME
      ,u.CONSTRAINT_TYPE
      ,u.TABLE_NAME
  FROM user_constraints u
 WHERE u.TABLE_NAME IN ('MEMBER')
;

--- 1. INTO 구문에 컬럼 이름 생략 시 데이터 추가
-- 전체 데이터 추가
INSERT INTO member
VALUES('M01', '전현찬', '5250', sysdate, '덕명동', 11, 'M');

INSERT INTO member
VALUES('M02', '조성철', '9034', sysdate, '오정동', 11, 'M');

INSERT INTO member
VALUES('M03', '전현찬', '5219', sysdate, '오정동', 1, 'M');

-- 몇몇 컬럼에 NULL 데이터 추가
INSERT INTO member
VALUES('M04', '박길수', '4003', sysdate, NULL, NULL, 'M');

INSERT INTO member
VALUES('M05', '강현', NULL, NULL, '홍도동', 6, 'M');

INSERT INTO member
VALUES('M06', '김소민', NULL, sysdate, '월평동', NULL, NULL);

SELECT m.*
  FROM member m
;
-- check 옵션에 위배되는 데이터 추가 시도
INSERT INTO member
VALUES('M07', '강병우', '2260', sysdate, '사정동', 6, 'N'); -- gender 위반
/*
오류 보고 -
ORA-02290: check constraint (SCOTT.CK_MEMBER_GENDER) violated
*/
-- 수정
INSERT INTO member
VALUES('M07', '강병우', '2260', sysdate, '사정동', 6, 'M');

INSERT INTO member
VALUES('M08', '정준호', NULL, sysdate, '나성동', 0, NULL);  -- birth_month 위반
/*
오류 보고 -
ORA-02290: check constraint (SCOTT.CK_MEMBER_BIRTH) violated
*/
-- 수정
INSERT INTO member
VALUES('M08', '정준호', NULL, sysdate, '나성동', 1, NULL);

-- 멤버 테이블 조회
SELECT m.*
  FROM member m
;

--- 2. INTO 구문에 컬럼 이름 명시하여 데이터 추가
--      : VALUES 절에 INTO의 순서대로
--        값의 타입, 개수를 맞추어서 작성

INSERT INTO member (member_id, member_name, gender)
VALUES('M09', '윤홍식', 'M');
-- reg_date 컬럼 : DEFAULT 설정이 작동하여 시스템 날짜 자동 입력
-- phone, address 컬럼 : NULL 값으로 입력되는 것 확인

-- INTO 절에 컬럼 나열시 테이블 정의 순서와 별개로 나열 가능
INSERT INTO member (member_name, address, member_id)
VALUES('이주영', '용전동', 'M10');

-- PK 값이 중복되는 입력 시도
INSERT INTO member (member_name, member_id)
VALUES('남정규', 'M10');
/*
오류 보고 -
ORA-00001: unique constraint (SCOTT.PK_MEMBER) violated
*/

-- 수정 : 이름 컬럼에 주소가 들어가는 데이터
--        이름, 주소 모두 문제 데이터이기 때문에 타입이 맞아서
--        논리 오류 발생
INSERT INTO member (member_name, member_id)
VALUES('목동', 'M11');

-- 필수 입력 컬럼인 member_name 누락
INSERT INTO member (member_id)
VALUES('M12');
/*
오류 보고 -
ORA-01400: cannot insert NULL into ("SCOTT"."MEMBER"."MEMBER_NAME")
*/

-- 수정
INSERT INTO member (member_id, member_name)
VALUES('M12', '이동희');
select * from member;

-- INTO 절에 나열된 컬럼(3개)과 VALUESE 절의 값의 개수 불일치
INSERT INTO member(member_id, member_name, gender)
VALUES('M13', '유재성');
/*
오류 보고 -
SQL 오류: ORA-00926: missing VALUES keyword
*/

-- INTO 절에 나열된 컬럼과 VALUES 절의 데이터 타입이 불일치
INSERT INTO member(member_id, member_name, birth_month)
VALUES('M13', '유재성', 'M');
/*
오류 보고 -
ORA-01722: invalid number
*/
-- 숫자가 들어가는 컬럼에 문자 입력 :
INSERT INTO member(member_id, member_name, birth_month)
VALUES('M13', '유재성', 3);


-----------------------------------------------------------------------------
-- 다중 행 입력 : SUB-QUERY 를 사용하여 가능

-- 구문구조
INSERT INTO 테이블이름
SELECT 문장 -- 서브쿼리
;

-- CREATE AS SELECT 는 데이터를 복사하며 테이블 생성
-- vs.
-- INSERT INTO ~ SELECT 는 이미 만들어진 테이블에
-- 데이터만 복사 추가

-- member 테이블의 내용을 조회해서 new_member 로 insert
INSERT INTO new_member
SELECT m.*
  FROM member m
 WHERE m.PHONE IS NOT NULL
;
-- ==> 5개 행 이(가) 삽입되었습니다.

INSERT INTO new_member
SELECT m.*
  FROM member m
 WHERE m.MEMBER_ID > 'M09'
;
-- ==> 4개 행 이(가) 삽입되었습니다.
-- NEW_MEMBER 테이블 데이터 삭제 X 버튼 클릭 후 

-- 성이 '김' 인 멤버 데이터를 복사 입력
INSERT INTO new_member
SELECT m.*
  FROM member m
 WHERE m.MEMBER_NAME LIKE '김%'
;

--짝수 달에 태어나 멤버데이터를 복사 입력
INSERT INTO new_member
SELECT m.*
  FROM member m
 WHERE MOD(m.BIRTH_MONTH, 2) = 0 
;

-----------------------------------------------------------
-- 1) UPDATE : 테이블의 행을 수정
--             WHERE 조건절의 조합에 따라 1행 혹은 다행 수정이 가능

-- member 테이블에서 이름이 잘 못 들어간 'M11' 멤버 정보를 수정


-- 데이터 수정 전에 영구반영을 실행
commit; -- 커밋 완료.

UPDATE member m
   SET m.MEMBER_NAME = '남정규'
 WHERE m.MEMBER_ID = 'M11'
;
-- 1 행 이(가) 업데이트되었습니다.

-- 'M05' 회원의 전화번호 필드를 업데이트
commit;

UPDATE member m
   SET m.PHONE = '1743'
-- WHERE m.MEMBER_ID = 'M05'
;
-- 13개 행 이(가) 업데이트 되었습니다.
-- WHERE 조건절의 실수로 DML 작업 실수가 발생
-- 데이터 상태 되돌리기
rollback; -- 롤백 완료. / 마지막 커밋 상태까지 되돌림

UPDATE member m
   SET m.PHONE = '1743'
 WHERE m.MEMBER_ID = 'M05'
;

-- 2개 이상의 컬럼을 한번에 업데이트 SET 절에 나열
UPDATE member m
   SET m.PHONE = '1743'
      ,m.REG_DATE = sysdate
 WHERE m.MEMBER_ID = 'M05'
;
commit;

-- '월평동' 사는 '김소민' 멤버의 NULL 업데이트
UPDATE member m
   SET m.PHONE = '4724'
      ,m.BIRTH_MONTH = 1
      ,m.GENDER = 'F'
 WHERE m.ADDRESS = '월평동' 
 -- m.MEMBER_ID = 'M06'
;
-- 위의 실행 결과는 의도대로 반영되는 것 처럼 보이나
-- 월평동에 사는 사람이 다수라면
-- 월평동의 모든 사람 정보가 수정될 것.
-- 따라서 UPDATE 구문 작성시 WHERE 조건은
-- 주의를 기울여서 작성해야 함.

/* DML : UPDATE, DELETE 작업 시 주의점

  딱 하나의 데이터를 수정/삭제 하려면
  WHERE 절의 비교 조건에 반드시 PK 로 설정한
  컬럼의 값을 비교하도록 권장.
  
  => WHY?
  PK는 전체 행에서 유일하고, NOT NULL 임이 보장 되기 때문.
  
  UPDATE, DELETE 는 구문에 물리적 오류가 없으면
  WHERE 조건에 맞는 전체 행 대상으로 작업하는 것이 기본이므로
  항상 주의!!!
  
*/

-- UPDATE 구문에 SELECT 서브쿼리 사용
-- 'M08' 아이디의 phone, gender 수정
-- 권장 되는 PK로 걸어서 수정하는 구문
UPDATE member m
   SET m.PHONE = '3418'
     , m.GENDER = 'M'
 WHERE m.MEMBER_ID = 'M08'
;

-- 서브쿼리 적용
UPDATE member m
   SET m.PHONE = '3418'
     , m.GENDER = 'M'
 WHERE m.ADDRESS = (SELECT m.ADDRESS
                      FROM member m
                     WHERE m.MEMBER_ID = 'M08')
;
-- 1 행 이(가) 업데이트되었습니다.

SELECT m.ADDRESS
  FROM member m
 WHERE m.MEMBER_ID = 'M08'
;               

-- 'M13' 유재성 멤버의 성별 업데이트
UPDATE member m
   SET m.GENDER = (SELECT substr('MATH', 1, 1)
                     FROM dual)
 WHERE m.MEMBER_ID = 'M13'
; 
--1 행 이(가) 업데이트되었습니다.

SELECT substr('MATH', 1, 1)
  FROM dual
;

-- 'M12' 데이터 gender 컬럼 수정 시 제약 조건 위반
UPDATE member m
   SET m.GENDER = 'N'
 WHERE m.MEMBER_ID = 'M12'
;
/*
오류 보고 -
ORA-02290: check constraint (SCOTT.CK_MEMBER_GENDER) violated
*/

-- ADDRESS 가 NULL 인 사람들의 주소는 일괄 '대전' 으로 수정
UPDATE member m
   SET m.ADDRESS = '대전'
 WHERE m.ADDRESS IS NULL
;

commit;

-----------------------------------------------------------
-- 1) DELETE : 테이블에서 행단위로 데이터 삭제

--- 1. WHERE 조건이 있는 DELETE 구문

-- 삭제 전 커밋
commit;
-- GENDER 가 'F'인 데이터를 삭제
DELETE FROM member m
 WHERE m.GENDER = 'R'
;
-- 0개 행 이(가) 삭제되었습니다.
-- 이 결과는 GENTDER에 R값이 없으므로
-- 삭제 된 행이 없는 결과를 얻은 것 뿐
-- 구문 오류는 아님, 논리적으로 잘못된 결과인 것.

DELETE FROM member m
 WHERE m.GENDER = 'F'
;
-- 2개 행 이(가) 삭제되었습니다.
-- WHERE 조건절을 만족하는 모든 행에 대해 삭제 작업 진행

-- 데이터 되돌림
rollback;

-- M99 1행을 삭제하고 싶다면 PK로 삭제하자
DELETE member m
 WHERE m.MEMBER_ID = 'M99'
;
-- 1 행 이(가) 삭제되었습니다.
commit;
-- 커밋 완료

-- WHERE 조건을 아예 누락(생략)한 경우 전체 행 삭제
DELETE FROM member;
-- 13개 행 이(가) 삭제되었습니다.
rollback;
-- 롤백 완료


--- 3. DELETE 의 WHERE 에 서브쿼리 조합
-- 주소가 대전인 사람을 모두 삭제
-- (1) 주소가 대전인 사람을 조회
SELECT m.MEMBER_ID
  FROM member m
 WHERE m.ADDRESS = '대전'
;

-- (2) 삭제하는 메인 쿼리 작성
DELETE FROM member m
 WHERE m.MEMBER_ID IN (SELECT m.MEMBER_ID
                         FROM member m
                        WHERE m.ADDRESS = '대전')
;

rollback;

-- 위와 동일한 작업을 일반 WHERE로 삭제
DELETE FROM member m
 WHERE m.ADDRESS = '대전'; 

--------------------------------------------------------
-- DELETE vs. TRUNCATE
/*
  1. TRUNCATE 는 DDL 에 속하는 명령어
     ROLLBACK 지점을 생성하지 안ㅇ흠
     따라서 한 번 실행 된 DDL을 되돌릴 수 없음.
     
  2. TRUNCATE 는 WHERE 절 조합이 안되므로
     특정 데이터를 선별하여 삭제하는 것이 불가능
     
     사용시 주의
*/

-- new_member 테이블을 TRUNCATE로 날려보자

-- 실행 전 되돌아 갈 커밋 지점 생성
commit;

-- new_member 내용 확인
SELECT m.* 
  FROM new_member m;
  
-- TRUNCATE 로 new_member 테이블 잘라내기
TRUNCATE TABLE new_member;
-- Table NEW_MEMBER이(가) 잘렸습니다.

-- 되돌리기 시도
rollback;

-- DDL 종류의 구문은 생성 즉시 바로 커밋이 이루어짐.
-- 롤백의 시점이 이미 DDL 실행 다음 시점으로 잡힘.

--------------------------------------------------------
-- TCL : Transaction Control Language
-- 1) COMMIT

-- 2) ROLLBAKC

-- 3) SAVEPOINT
--- 1. new_member 테이블에 1행 추가
commit;
INSERT INTO new_member(MEMBER_ID, MEMBER_NAME)
VALUES ('M01', '홍길동')
;
-- 1행 추가 상태까지 중간 저장
SAVEPOINT do_insert;

--- 2. '홍길동' 데이터의 주소를 수정
UPDATE new_member m
   SET m.ADDRESS = '율도국'
 WHERE m.MEMBER_ID = 'M01'
;
--1 행 이(가) 업데이트되었습니다.

-- 수정 상태까지 중간 저장
SAVEPOINT do_update_addr; -- Savepoint이(가) 생성되었습니다.

--- 2. '홍길동' 데이터의 전화번호를 수정
UPDATE new_member m
   SET m.PHONE = '0001'
 WHERE m.MEMBER_ID = 'M01'
;
-- 1 행 이(가) 업데이트되었습니다.


-- 전화번호 수정 상태까지 중간 저장
SAVEPOINT do_update_phone; -- Savepoint이(가) 생성되었습니다.

--- 4. '홍길동' 데이터의 성별을 수정
UPDATE new_member m
   SET m.GENDER = 'M'
 WHERE m.MEMBER_ID = 'M01'
;

SAVEPOINT do_update_gender;


----------------------------------------------------
-- 홍길동 데이터의 ROLLBACK 시나리오

-- 1. 주소 수정까지는 맞는데, 전화번호, 성별 수정은 잘못 됨
--   : 되돌아가야 할 SAVEPOINT = do_update_addr
ROLLBACK;

ROLLBACK TO do_update_addr;

SELECT *
  FROM new_member;

-- 2. 주소, 전화번호까지 수정이 맞고, 성별 수정이 잘못 됨
ROLLBACK TO do_update_phone;
/*
  ORA-01086: savepoint 'DO_UPDATE_PHONE' never established in this session or is invalid
  SAVEPOINT 의 순서가 do_update_addr 이 앞서기 때문에 여기까지 한번 ROLLBACK이
  일어나면 그 후에 생성된 SAVEPOINT는 삭제 됨.
  
  앞의 수정 구문 재 실행 후 다시 성별 수정까지 돌아감
*/
ROLLBACK TO do_update_phone;



SELECT *
  FROM new_member;

-- 3. 2번 수행 후 어디까지 롤백이 가능한가
ROLLBACK TO do_update_addr;
ROLLBACK TO do_update_insert;
ROLLBACK;

------------------------------------------------------
-- SEQUENCE : 기본 키 등으로 사용되는 일련번호 생성 객체

-- 1. 시작 번호 : 1, 최대 : 30, 사이클이 없는 시퀀스 생성
CREATE SEQUENCE seq_member_id 
START WITH 1
MAXVALUE 30
NOCYCLE
;

-- Sequence SEQ_MEMBER_ID이(가) 생성되었습니다.

-- 시퀀스가 생성되면 유지 딕셔너리에 정보가 저장됨.
--  : user_sequences

SELECT s.SEQUENCE_NAME
      ,s.MIN_VALUE
      ,s.MAX_VALUE
      ,s.CYCLE_FLAG
      ,s.INCREMENT_BY
  FROM user_sequences s
 WHERE s.SEQUENCE_NAME = 'SEQ_MEMBER_ID'
;

/*
SEQUENCE_NAME, MIN_VALUE, MAX_VALUE, CYCLE_FLAG, INCREMENT_BY
--------------------------------------------------------------
SEQ_MEMBER_ID	    1	        30	          N	          1
*/

/*
오류 보고 -
ORA-00955: name is already used by an existing object
*/

-- 사용자의 객체가 저장되는 딕셔너리 테이블
-- : user_objects
SELECT o.OBJECT_NAME
      ,o.OBJECT_TYPE
      ,o.OBJECT_ID
  FROM user_objects o
;

/* -----------------------------------
   메타 데이터를 저장하는 유저 딕셔너리
   -----------------------------------
   무결성 제약조건 : user_constraints
   시퀀스 생성정보 : user_sequences
   테이블 생성정보 : user_tables
   인덱스 생성정보 : user_indexes
   객체를 생성정보 : user_objects
  ----------------------------------- */
  
-- 2. 생성 된 시퀀스 사용
---- (1) NEXTVAL : 시퀀스의 다음 번호를 생성  
--                 CREATE 되고 나서 반드시 최초에 한번은
--                 NEXTVAL 호출 되어야 생성 시작됨

--       사용법  : 시퀀스이름.NEXTVAL
SELECT SEQ_MEMBER_ID.NEXTVAL
  FROM dual;
-- MAXVALUE 이상 생성하면
-- ORA-08004: sequence SEQ_MEMBER_ID.NEXTVAL exceeds MAXVALUE and cannot be instantiated

---- (2) CURRVAL : 시퀀스에서 현재 생성 된 번호 확인
--                 시퀀스 생성 후 NEXTVAL 한번도 호출된 적 없으면 비활성화 상태

--        사용법 : 시퀀스이름.CURRVAL 
SELECT SEQ_MEMBER_ID.CURRVAL
  FROM dual
;

/* NEXTVAL 최초 한번 실행 전 CURRVAL 를 실행하면 아래와 같은 오류
ORA-08002: sequence SEQ_TES.CURRVAL is not yet defined in this session
*/

-- 3. 시퀀스 수정 : ALTER SEQUENCE
--                 생성한 시퀀스 seq_member_id 의 MAXVALUE 옵션을 NOMAXVALUE로
ALTER SEQUENCE seq_member_id
NOMAXVALUE
;
-- Sequence SEQ_MEMBER_ID이(가) 변경되었습니다.

-- 4. 시퀀스 삭제 : DROP SEQUENCE
--                 생성한 시퀀스 seq_member_id 삭제
DROP SEQUENCE seq_member_id
;
-- Sequence SEQ_MEMBER_ID이(가) 삭제되었습니다.

-- 존재하지 않는 시퀀스에서 CURRVAL 시도
SELECT SEQ_MEMBER_ID.CURRVAL
  FROM dual
;
-- ORA-02289: sequence does not exist

-- 멤버 아이디에 조합할 시퀀스 신규 생성
CREATE SEQUENCE seq_member_id 
START WITH 1
NOMAXVALUE
NOCYCLE
;

-- 일괄적으로 증가하는 값을 멤버아이디로 자동 생성
-- 'M01', 'M02', ... 'M0x' 이런 형태의 값을 조합

SELECT 'M' || LPAD(seq_member_id.NEXTVAL, 2, 0) as "member_id"
  FROM dual;
  
INSERT INTO new_member(MEMBER_ID, MEMBER_NAME)
VALUES ('M' || LPAD(seq_member_id.CURRVAL, 2, 0), '허균')
;

-----------------------------------------------------------------
-- INDEX : 데이터의 검색(조회)시 일정한 검색 속도를 보장하기 위하여
--         DBMS 가 관리하는 객체

-- 1. user_indexes 딕셔너리에서 검색

SELECT i.INDEX_TYPE
      ,i.INDEX_NAME
      ,i.TABLE_NAME
      ,i.TABLE_OWNER
      ,i.INCLUDE_COLUMN
  FROM user_indexes i
;

-- 2. 테이블의 주키(PK) 컬럼에 대해서는 이미 DBMS가 자동으로
--    인덱스가 생성함.
--    따라서 또 생성 시도 시 생성 불가능

-- 예) member 테이블의 member_id 컬럼에 인덱스 생성 시도
CREATE INDEX idx_member_id
ON member (member_id)
;
-- ORA-01408: such column list already indexed

-- 3. 복사한 테이블인 new_member 에는 PK가 없으므로 인덱스도 없는 상태
--    new_member 테이블에 index 생성 시도
CREATE INDEX idx_new_member_id
ON new_member(member_id)
;
-- Index IDX_NEW_MEMBER_ID이(가) 생성되었습니다.


-- user_indexes 딕셔너리에서 검색
SELECT i.INDEX_TYPE
      ,i.INDEX_NAME
      ,i.TABLE_NAME
      ,i.TABLE_OWNER
      ,i.INCLUDE_COLUMN
  FROM user_indexes i
;

/*
INDEX_TYPE, INDEX_NAME,      TABLE_NAME, TABLE_OWNER, INCLUDE_COLUMN
NORMAL	    PK_SUB_TABLE4	    SUB_TABLE	  SCOTT	
NORMAL	    IDX_NEW_MEMBER_ID	NEW_MEMBER	SCOTT	
NORMAL	    PK_MEMBER       	MEMBER	    SCOTT	
NORMAL	    PK_EMP	          EMP	        SCOTT	
NORMAL	    PK_DEPT	          DEPT	      SCOTT	
NORMAL	    PK_CUSTOMER     	CUSTOMER	  SCOTT	
*/

-- INDEX 가 명시적으로 사용되는 경우

-- 오라클에 빠른 검색을 위해 HINT 절을 SELECT에 사용하는
-- 경우가 존재



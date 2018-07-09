/*
   CUSTOMER 테이블에 이름, 주소, 전화번호 값을 insert 하는 
   프로시저 sp_insert_customer 를 작성하라.
   
   CUSTOMER 테이블의 구조
   ------------------------------------------------------------------------------------------
   userid       VARCHAR2(4)  : PK
   name         VARCHAR2(15) : NOT NULL
   birthyear    NUMBER(4)
   address      VARCHAR2(30)
   phone        VARCHAR2(13)
   grade        VARCHAR2(6)  기본값  : 'SILVER'
                             입력 가능 값 : 'GENERAL', 'SILVER' , 'GOLD', 'VIP' 
   regdate      DATE         기본값 : sysdate  (시스템 등록일)
   updatedt     DATE         기본값 : sysdate  (데이터 수정일 = update 쿼리 사용시 업데이트 시점이 들어가도록 사용)
   ------------------------------------------------------------------------------------------
   
   ------------------------------------------------------------------------------------------
   sp_insert_customer 프로시저 구현 상세
   ------------------------------------------------------------------------------------------
   IN MODE  : 이름(v_name), 주소(v_address), 전화번호(v_phone) 값
   OUT MODE : 메시지 출력용 변수(v_msg)를 입력받아서
   
   CUSTOMER 테이블에 INSERT 할
   userid 는 sequence를 사용하여 자동 생성하여 시스템이 자동으로 부여하도록 한다.
   userid 의 패턴은 C001, C002 .. 형태로 부여한다.

   sp 실행 후 OUT 변수에 전달될 메시지의 포맷은
   "유저아이디, 유저이름 정보추가" 형태로 생성한다.
   
*1) seq 를 max 없고 nocycle 이도록 생성 : seq_cust_userid 
*2) customer 테이블의 데이터를 삭제후 진행
*3) 작성한 프로시저로만 데이터를 입력한 후
*4) 목록을 조회 - SELECT 쿼리로 조회 진행
*/
--0. customer DROP, seq DROP : 이미 존재하는 객체가 있으면 드롭 후 진행
DROP TABLE customer;
DROP SEQUENCE seq_cust_userid;

--1. customer DDL 작성 : customer
CREATE TABLE customer
(  userid       VARCHAR2(4)
 , name         VARCHAR2(15)        NOT NULL
 , birthyear    NUMBER(4)
 , address      VARCHAR2(30)
 , phone        VARCHAR2(13)
 , grade        VARCHAR2(6)         DEFAULT 'SILVER'
 , regdate      DATE                DEFAULT sysdate
 , updatedt     DATE                DEFAULT sysdate
 , CONSTRAINT   PK_CUSTOMER         PRIMARY KEY (userid)
 , CONSTRAINT   CK_CUSTOMER_GRADE   CHECK (grade IN ('GENERAL', 'SILVER' , 'GOLD', 'VIP'))
);
-- Table CUSTOMER이(가) 생성되었습니다.

DESC customer;
/*
이름        널?       유형           
--------- -------- ------------ 
USERID    NOT NULL VARCHAR2(4)  
NAME      NOT NULL VARCHAR2(15) 
BIRTHYEAR          NUMBER(4)    
ADDRESS            VARCHAR2(30) 
PHONE              VARCHAR2(13) 
GRADE              VARCHAR2(6)  
REGDATE            DATE         
UPDATEDT           DATE    
*/

--2. Sequence DDL 작성 : seq_cust_userid
CREATE SEQUENCE seq_cust_userid
START WITH 1
NOCYCLE
;
-- Sequence SEQ_CUST_USERID이(가) 생성되었습니다.

--3. procedure 작성 : sp_insert_customer

/*
 IN MODE  : 이름(v_name), 주소(v_address), 전화번호(v_phone) 값
   OUT MODE : 메시지 출력용 변수(v_msg)를 입력받아서
   
   CUSTOMER 테이블에 INSERT 할
   userid 는 sequence를 사용하여 자동 생성하여 시스템이 자동으로 부여하도록 한다.
   userid 의 패턴은 C001, C002 .. 형태로 부여한다.

   sp 실행 후 OUT 변수에 전달될 메시지의 포맷은
   "유저아이디, 유저이름 정보추가" 형태로 생성한다.
   */
CREATE OR REPLACE PROCEDURE sp_insert_customer
(   v_name     IN  customer.NAME%TYPE
  , v_address  IN  customer.ADDRESS%TYPE
  , v_phone    IN  customer.PHONE%TYPE
  , v_msg      OUT VARCHAR2)
IS
    v_userid NUMBER;
BEGIN
    SELECT seq_cust_userid.NEXTVAL
      INTO v_userid
      FROM dual
    ;
    -- 입력 된 IN 모드 변수 값을 INSERT 시도
    INSERT INTO customer (userid, name, address, phone)
    VALUES ('C' || LPAD(v_userid, 3, '0'), v_name, v_address, v_phone);
    commit;
    
    v_msg := (('C' || LPAD(v_userid, 3, '0')) || ', ' || v_name || ' 정보 추가');
    -- 입력 시도에는 항상 DUP_VAL_ON_INDEX 예외 위험 존재
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX
        THEN -- 이미 존재하는 키의 값이면 신규 추가가 아니라
             -- 수정으로 진행
             UPDATE customer c
                SET c.name = v_name
                   ,c.address = v_address
                   ,c.phone = v_phone
                   ,c.updatedt = sysdate
              WHERE c.userid = v_userid
              ;
              commit;
              -- 처리 내용을 화면 출력
              v_msg := (('C' || LPAD(v_userid, 3, '0')) || ', ' || v_name || ' 정보 수정');
              
END sp_insert_customer;
/
--4. procedure 실행 코드
VAR v_msg_bind VARCHAR2(300);
EXEC sp_insert_customer('손흥민', '대한민국', '010-5454-5666',  v_msg => :v_msg_bind);
EXEC sp_insert_customer('조현우', '대한민국', '010-2333-2111',  v_msg => :v_msg_bind);
EXEC sp_insert_customer('기성용', '대한민국', '010-2345-3454',  v_msg => :v_msg_bind);
/*
Procedure SP_INSERT_CUSTOMER이(가) 컴파일되었습니다.


PL/SQL 프로시저가 성공적으로 완료되었습니다.


PL/SQL 프로시저가 성공적으로 완료되었습니다.


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

PRINT v_msg_bind;

--5. SELECT * FROM customer; 실행결과 text 캡쳐
SELECT c.*
  FROM customer c
;

/*
USERID, NAME, BIRTHYEAR, ADDRESS,    PHONE,     GRADE,   REGDATE, UPDATEDT
C001	손흥민		   -       대한민국	010-5454-5666	SILVER	18/07/10	18/07/10
C002	조현우		   -       대한민국	010-2333-2111	SILVER	18/07/10	18/07/10
C003	기성용		   -       대한민국	010-2345-3454	SILVER	18/07/10	18/07/10
*/
--1. employees 테이블에서 job_id 를 중복 배제하여 조회 하고

--   job_title 같이 출력

--19건
desc employees;
SELECT DISTINCT e.JOB_ID
     , j.JOB_TITLE
  FROM employees e, JOBS j
 WHERE e.JOB_ID = j.JOB_ID
;

/* ------------------------------------------
JOB_ID,         JOB_TITLE
-------------------------------------
AD_ASST	    Administration Assistant
SA_REP	    Sales Representative
IT_PROG	    Programmer
MK_MAN	    Marketing Manager
AC_MGR	    Accounting Manager
FI_MGR	    Finance Manager
AC_ACCOUNT	Public Accountant
PU_MAN	    Purchasing Manager
SH_CLERK	  Shipping Clerk
FI_ACCOUNT	Accountant
AD_PRES	    President
SA_MAN	    Sales Manager
MK_REP	    Marketing Representative
AD_VP	      Administration Vice President
PU_CLERK	  Purchasing Clerk
ST_MAN	    Stock Manager
ST_CLERK	  Stock Clerk
HR_REP	    Human Resources Representative
PR_REP	    Public Relations Representative
------------------------------------------ */





--2. employees 테이블에서 사번, 라스트네임, 급여, 커미션 팩터,

--   급여x커미션팩터(null 처리) 조회

--   커미션 컬럼에 대해 null 값이면 0으로 처리하도록 함

--107건
SELECT e.EMPLOYEE_ID                               as "사번"
     , e.LAST_NAME                                 as "라스트 네임"
     , e.SALARY                                    as "급여"
     , NVL(e.COMMISSION_PCT, 0)                    as "커미션 팩터"
     , NVL(e.SALARY * e.COMMISSION_PCT, 0)  as "급여x커미션팩터"
  FROM employees e
;

/* ---------------------------
100	King	  24000	0	0
101	Kochhar	17000	0	0
102	De Haan	17000	0	0
103	Hunold	9000	0	0
104	Ernst	6000	0	0
105	Austin	4800	0	0
106	Pataballa	4800	0	0
107	Lorentz	4200	0	0
108	Greenberg	12008	0	0
109	Faviet	9000	0	0
110	Chen	8200	0	0
111	Sciarra	7700	0	0
112	Urman	7800	0	0
113	Popp	6900	0	0
114	Raphaely	11000	0	0
115	Khoo	3100	0	0
116	Baida	2900	0	0
117	Tobias	2800	0	0
118	Himuro	2600	0	0
119	Colmenares	2500	0	0
120	Weiss	8000	0	0
121	Fripp	8200	0	0
122	Kaufling	7900	0	0
123	Vollman	6500	0	0
124	Mourgos	5800	0	0
125	Nayer	3200	0	0
126	Mikkilineni	2700	0	0
127	Landry	2400	0	0
128	Markle	2200	0	0
129	Bissot	3300	0	0
130	Atkinson	2800	0	0
131	Marlow	2500	0	0
132	Olson	2100	0	0
133	Mallin	3300	0	0
134	Rogers	2900	0	0
135	Gee	2400	0	0
136	Philtanker	2200	0	0
137	Ladwig	3600	0	0
138	Stiles	3200	0	0
139	Seo	2700	0	0
140	Patel	2500	0	0
141	Rajs	3500	0	0
142	Davies	3100	0	0
143	Matos	2600	0	0
144	Vargas	2500	0	0
145	Russell	14000	0.4	5600
146	Partners	13500	0.3	4050
147	Errazuriz	12000	0.3	3600
148	Cambrault	11000	0.3	3300
149	Zlotkey	10500	0.2	2100
150	Tucker	10000	0.3	3000
151	Bernstein	9500	0.25	2375
152	Hall	9000	0.25	2250
153	Olsen	8000	0.2	1600
154	Cambrault	7500	0.2	1500
155	Tuvault	7000	0.15	1050
156	King	10000	0.35	3500
157	Sully	9500	0.35	3325
158	McEwen	9000	0.35	3150
159	Smith	8000	0.3	2400
160	Doran	7500	0.3	2250
161	Sewall	7000	0.25	1750
162	Vishney	10500	0.25	2625
163	Greene	9500	0.15	1425
164	Marvins	7200	0.1	720
165	Lee	6800	0.1	680
166	Ande	6400	0.1	640
167	Banda	6200	0.1	620
168	Ozer	11500	0.25	2875
169	Bloom	10000	0.2	2000
170	Fox	9600	0.2	1920
171	Smith	7400	0.15	1110
172	Bates	7300	0.15	1095
173	Kumar	6100	0.1	610
174	Abel	11000	0.3	3300
175	Hutton	8800	0.25	2200
176	Taylor	8600	0.2	1720
177	Livingston	8400	0.2	1680
178	Grant	7000	0.15	1050
179	Johnson	6200	0.1	620
180	Taylor	3200	0	0
181	Fleaur	3100	0	0
182	Sullivan	2500	0	0
183	Geoni	2800	0	0
184	Sarchand	4200	0	0
185	Bull	4100	0	0
186	Dellinger	3400	0	0
187	Cabrio	3000	0	0
188	Chung	3800	0	0
189	Dilly	3600	0	0
190	Gates	2900	0	0
191	Perkins	2500	0	0
192	Bell	4000	0	0
193	Everett	3900	0	0
194	McCain	3200	0	0
195	Jones	2800	0	0
196	Walsh	3100	0	0
197	Feeney	3000	0	0
198	OConnell	2600	0	0
199	Grant	2600	0	0
200	Whalen	4400	0	0
201	Hartstein	13000	0	0
202	Fay	6000	0	0
203	Mavris	6500	0	0
204	Baer	10000	0	0
205	Higgins	12008	0	0
206	Gietz	8300	0	0
--------------------------- */

--3. employees 테이블에서 사번, 라스트네임, 급여, 커미션 팩터(null 값 처리) 조회

--   단, 2007년 이 후 입사자에 대하여 조회, 고용년도 순 오름차순 정렬

--30건

SELECT e.EMPLOYEE_ID                               as "사번"
     , e.LAST_NAME                                 as "라스트 네임"
     , e.SALARY                                    as "급여"
     , NVL(e.COMMISSION_PCT, 0)                    as "커미션 팩터"
     , e.HIRE_DATE
  FROM employees e
 WHERE TO_CHAR(e.HIRE_DATE, 'YYYY') >= '2007'
;

/* -----------------------------
104	Ernst	6000	0	07/05/21
107	Lorentz	4200	0	07/02/07
113	Popp	6900	0	07/12/07
119	Colmenares	2500	0	07/08/10
124	Mourgos	5800	0	07/11/16
127	Landry	2400	0	07/01/14
128	Markle	2200	0	08/03/08
132	Olson	2100	0	07/04/10
135	Gee	2400	0	07/12/12
136	Philtanker	2200	0	08/02/06
148	Cambrault	11000	0.3	07/10/15
149	Zlotkey	10500	0.2	08/01/29
155	Tuvault	7000	0.15	07/11/23
163	Greene	9500	0.15	07/03/19
164	Marvins	7200	0.1	08/01/24
165	Lee	6800	0.1	08/02/23
166	Ande	6400	0.1	08/03/24
167	Banda	6200	0.1	08/04/21
171	Smith	7400	0.15	07/02/23
172	Bates	7300	0.15	07/03/24
173	Kumar	6100	0.1	08/04/21
178	Grant	7000	0.15	07/05/24
179	Johnson	6200	0.1	08/01/04
182	Sullivan	2500	0	07/06/21
183	Geoni	2800	0	08/02/03
187	Cabrio	3000	0	07/02/07
191	Perkins	2500	0	07/12/19
195	Jones	2800	0	07/03/17
198	OConnell	2600	0	07/06/21
199	Grant	2600	0	08/01/13
----------------------------- */



--4. Finance 부서에 소속된 직원의 목록 조회

--조인으로 해결
SELECT e.EMPLOYEE_ID
      ,e.FIRST_NAME
      ,e.LAST_NAME
      ,d.DEPARTMENT_NAME
  FROM employees e, departments d
 WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID
   AND d.DEPARTMENT_NAME = 'Finance'
;

/* ------------------------------------------------------
EMPLOYEE_ID, FIRST_NAME,    LAST_NAME, DEPARTMENT_NAME
108	          Nancy	          Greenberg	    Finance
109	          Daniel	        Faviet	      Finance
110	          John	          Chen	        Finance
111	          Ismael	        Sciarra	      Finance
112         	Jose Manuel	    Urman	        Finance
113	          Luis	          Popp	        Finance
------------------------------------------------------ */





--서브쿼리로 해결
SELECT a.*
  FROM(SELECT e.EMPLOYEE_ID
             ,e.FIRST_NAME
             ,e.LAST_NAME
             ,d.DEPARTMENT_NAME
         FROM employees e, departments d
        WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID
          AND d.DEPARTMENT_NAME = 'Finance') a
;

/* ------------------------------------------------------
EMPLOYEE_ID, FIRST_NAME,    LAST_NAME, DEPARTMENT_NAME
108	          Nancy	          Greenberg	    Finance
109	          Daniel	        Faviet	      Finance
110	          John	          Chen	        Finance
111	          Ismael	        Sciarra	      Finance
112         	Jose Manuel	    Urman	        Finance
113	          Luis	          Popp	        Finance
------------------------------------------------------ */



--6건

 

--5. Steven King 의 직속 부하직원의 모든 정보를 조회

--14건

-- 조인 이용
SELECT * 
  FROM employees 
;

SELECT e2.*
  FROM employees e1,
       employees e2
 WHERE e1.EMPLOYEE_ID = e2.MANAGER_ID
   AND e1.FIRST_NAME = 'Steven'
   AND e1.LAST_NAME  = 'King'
;

/*
EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL,  PHONE_NUMBER,      HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID
    101	    Neena       	Kochhar	  NKOCHHAR	515.123.4568	      05/09/21	AD_VP	  17000		                100	          90
    102	    Lex	          De Haan 	LDEHAAN   515.123.4569	      01/01/13	AD_VP	  17000		                100	          90
    114	    Den	          Raphaely	DRAPHEAL	515.127.4561	      02/12/07	PU_MAN	11000		                100	          30
    120	    Matthew     	Weiss	    MWEISS  	650.123.1234	      04/07/18	ST_MAN	8000		                100	          50
    121	    Adam	        Fripp	    AFRIPP	  650.123.2234	      05/04/10	ST_MAN	8200		                100	          50
    122	    Payam	        Kaufling	PKAUFLIN	650.123.3234	      03/05/01	ST_MAN	7900		                100	          50
    123	    Shanta	      Vollman	  SVOLLMAN  650.123.4234	      05/10/10	ST_MAN	6500		                100	          50
    124	    Kevin	        Mourgos 	KMOURGOS  650.123.5234	      07/11/16	ST_MAN	5800		                100	          50
    145	    John        	Russell	  JRUSSEL	  011.44.1344.429268	04/10/01	SA_MAN	14000	    0.4	          100	          80
    146	    Karen       	Partners	KPARTNER  011.44.1344.467268	05/01/05	SA_MAN	13500	    0.3	          100	          80
    147   	Alberto     	Errazuriz	AERRAZUR	011.44.1344.429278	05/03/10	SA_MAN	12000	    0.3	          100	          80
    148   	Gerald	      Cambrault	GCAMBRAU	011.44.1344.619268	07/10/15	SA_MAN	11000	    0.3	          100	          80
    149	    Eleni	        Zlotkey 	EZLOTKEY	011.44.1344.429018	08/01/29	SA_MAN	10500	    0.2	          100	          80
    201	    Michael     	Hartstein	MHARTSTE	515.123.5555	      04/02/17	MK_MAN	13000		                100	          20
*/



-- 서브쿼리 이용
SELECT *
  FROM employees e1
 WHERE e1.MANAGER_ID = (SELECT e2.EMPLOYEE_ID
                          FROM employees e2
                         WHERE e2.FIRST_NAME = 'Steven'
                           AND e2.LAST_NAME  = 'King')
;
/*
EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL,  PHONE_NUMBER,      HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID
    101	    Neena       	Kochhar	  NKOCHHAR	515.123.4568	      05/09/21	AD_VP	  17000		                100	          90
    102	    Lex	          De Haan 	LDEHAAN   515.123.4569	      01/01/13	AD_VP	  17000		                100	          90
    114	    Den	          Raphaely	DRAPHEAL	515.127.4561	      02/12/07	PU_MAN	11000		                100	          30
    120	    Matthew     	Weiss	    MWEISS  	650.123.1234	      04/07/18	ST_MAN	8000		                100	          50
    121	    Adam	        Fripp	    AFRIPP	  650.123.2234	      05/04/10	ST_MAN	8200		                100	          50
    122	    Payam	        Kaufling	PKAUFLIN	650.123.3234	      03/05/01	ST_MAN	7900		                100	          50
    123	    Shanta	      Vollman	  SVOLLMAN  650.123.4234	      05/10/10	ST_MAN	6500		                100	          50
    124	    Kevin	        Mourgos 	KMOURGOS  650.123.5234	      07/11/16	ST_MAN	5800		                100	          50
    145	    John        	Russell	  JRUSSEL	  011.44.1344.429268	04/10/01	SA_MAN	14000	    0.4	          100	          80
    146	    Karen       	Partners	KPARTNER  011.44.1344.467268	05/01/05	SA_MAN	13500	    0.3	          100	          80
    147   	Alberto     	Errazuriz	AERRAZUR	011.44.1344.429278	05/03/10	SA_MAN	12000	    0.3	          100	          80
    148   	Gerald	      Cambrault	GCAMBRAU	011.44.1344.619268	07/10/15	SA_MAN	11000	    0.3	          100	          80
    149	    Eleni	        Zlotkey 	EZLOTKEY	011.44.1344.429018	08/01/29	SA_MAN	10500	    0.2	          100	          80
    201	    Michael     	Hartstein	MHARTSTE	515.123.5555	      04/02/17	MK_MAN	13000		                100	          20
*/


--6. Steven King의 직속 부하직원 중에서 Commission_pct 값이 null이 아닌 직원 목록

--5건

SELECT e2.EMPLOYEE_ID as "ID"
      ,e2.FIRST_NAME  as "F_NAME"
      ,e2.LAST_NAME   as "L_NAME"
  FROM employees e1,
       employees e2
 WHERE e1.EMPLOYEE_ID = e2.MANAGER_ID
   AND e1.FIRST_NAME = 'Steven'
   AND e1.LAST_NAME  = 'King'
   AND e2.COMMISSION_PCT IS NOT NULL
;

/* -------------------
ID, F_NAME, L_NAME
----------------------
145	John	  Russell
146	Karen	  Partners
147	Alberto	Errazuriz
148	Gerald	Cambrault
149	Eleni	  Zlotkey
------------------- */

--7. 각 job 별 최대급여를 구하여 출력 job_id, job_title, job별 최대급여 조회

--19건

SELECT e.JOB_ID       
      ,j.JOB_TITLE
      ,MAX(e.SALARY) as "MAX_SALARY"
  FROM employees e
      ,jobs j 
 WHERE e.JOB_ID = j.JOB_ID
 GROUP BY e.job_id, j.job_title
;

/* --------------------------------------------------------
JOB_ID,         JOB_TITLE,               MAX_SALARY
-----------------------------------------------------------
AD_ASST	      Administration Assistant	      4400
IT_PROG	      Programmer	                    9000
MK_MAN	      Marketing Manager	              13000
SA_REP	      Sales Representative	          11500
AC_MGR	      Accounting Manager	            12008
AC_ACCOUNT	  Public Accountant           	  8300
FI_MGR	      Finance Manager	                12008
PU_MAN	      Purchasing Manager	            11000
SH_CLERK	    Shipping Clerk	                4200
FI_ACCOUNT	  Accountant	                    9000
AD_PRES	      President	                      24000
MK_REP	      Marketing Representative	      6000
SA_MAN	      Sales Manager	                  14000
AD_VP	        Administration Vice President	  17000
PU_CLERK	    Purchasing Clerk	              3100
ST_CLERK	    Stock Clerk	                    3600
ST_MAN	      Stock Manager               	  8200
HR_REP	      Human Resources Representative	6500
-------------------------------------------------------- */


 

--8. 각 Job 별 최대급여를 받는 사람의 정보를 출력,

--  급여가 높은 순서로 출력
SELECT e.JOB_ID
      ,MAX(e.SALARY)
  FROM employees e
 GROUP BY e.JOB_ID
;
----서브쿼리 이용
SELECT e.JOB_ID
     , e.FIRST_NAME
     , e.LAST_NAME
     , e.SALARY     AS "최대 급여"
  FROM employees e
 WHERE (e.JOB_ID, e.SALARY) IN (SELECT e.JOB_ID
                                      ,MAX(e.SALARY)
                                  FROM employees e
                                 GROUP BY e.JOB_ID)
 ORDER BY e.SALARY DESC
;

/*
JOB_ID, FIRST_NAME,   LAST_NAME, 최대 급여
PU_CLERK	  Alexander	Khoo	      3100
ST_CLERK	  Renske	  Ladwig	    3600
SH_CLERK	  Nandita	  Sarchand	  4200
AD_ASST	    Jennifer	Whalen	    4400
MK_REP	    Pat	      Fay	        6000
HR_REP	    Susan	    Mavris	    6500
ST_MAN	    Adam	    Fripp	      8200
AC_ACCOUNT	William	  Gietz	      8300
IT_PROG	    Alexander	Hunold	    9000
FI_ACCOUNT	Daniel	  Faviet	    9000
PR_REP	    Hermann	  Baer	      10000
PU_MAN	    Den	      Raphaely  	11000
SA_REP	    Lisa	    Ozer	      11500
FI_MGR	    Nancy	    Greenberg	  12008
AC_MGR	    Shelley	  Higgins	    12008
MK_MAN	    Michael	  Hartstein	  13000
SA_MAN	    John	    Russell	    14000
AD_VP	      Neena	    Kochhar	    17000
AD_VP	      Lex	De    Haan	      17000
AD_PRES	    Steven	  King	      24000
*/

 

----join 이용
SELECT e.JOB_ID
      ,MAX(e.SALARY)
  FROM employees e
  ,
 GROUP BY e.JOB_ID
;

SELECT a.JOB_ID
     , e.FIRST_NAME
     , e.LAST_NAME
     , a."최대 급여"
  FROM employees e
      ,(SELECT e.JOB_ID
              ,MAX(e.SALARY) as "최대 급여"
          FROM employees e
         GROUP BY e.JOB_ID) a
 WHERE e.SALARY = a."최대 급여"
   AND e.JOB_ID = a.JOB_ID
 ORDER BY "최대 급여" DESC
;


  



--20건



--9. 7번 출력시 job_id 대신 Job_name, manager_id 대신 Manager의 last_name, department_id 대신 department_name 으로 출력
--20건
SELECT e1.EMPLOYEE_ID         as "사번"
      ,e1.LAST_NAME           as "사원 이름"
      ,j.JOB_TITLE            as "직무 이름"
      ,NVL(e2.LAST_NAME, '-') as "매니저 이름"
      ,d.DEPARTMENT_NAME      as "사원 부서명"
      ,e1.SALARY              as "급여"
  FROM employees e1
      ,employees e2
      ,departments d
      ,jobs j
 WHERE e1.MANAGER_ID    = e2.EMPLOYEE_ID(+)
   AND e1.JOB_ID        = j.JOB_ID
   AND e1.DEPARTMENT_ID = d.DEPARTMENT_ID
   AND (e1.JOB_ID, e1.SALARY) IN (SELECT e.JOB_ID
                                        ,MAX(e.SALARY)
                                    FROM employees e
                                   GROUP BY e.JOB_ID)
 ORDER BY e1.SALARY DESC;
;

/*
사번, 사원 이름,    직무 이름,                       매니저 이름,     사원 부서명,      급여
100	    King	      President		                    -                Executive	      24000
101	    Kochhar	    Administration Vice President   King	           Executive	      17000
102	    De Haan	    Administration Vice President   King	           Executive	      17000
145	    Russell	    Sales Manager	                  King	           Sales	          14000
201	    Hartstein	  Marketing Manager	              King	           Marketing	      13000
108	    Greenberg	  Finance Manager	                Kochhar	         Finance	        12008
205	    Higgins	    Accounting Manager              Kochhar	         Accounting	      12008
168	    Ozer	      Sales Representative            Cambrault	       Sales	          11500
114	    Raphaely	  Purchasing Manager  	          King	           Purchasing	      11000
204	    Baer	      Public Relations Representative	Kochhar	         Public Relations	10000
103	    Hunold	    Programmer	                    De Haan	         IT	              9000
109	    Faviet	    Accountant	                    Greenberg	       Finance	        9000
206	    Gietz	      Public Accountant	              Higgins	         Accounting	      8300
121	    Fripp	      Stock Manager	                  King	           Shipping	        8200
203	    Mavris	    Human Resources Representative	Kochhar	         Human Resources	6500
202	    Fay	        Marketing Representative	      Hartstein	       Marketing	      6000
200	    Whalen	    Administration Assistant	      Kochhar	         Administration	  4400
184	    Sarchand	  Shipping Clerk	                Fripp	           Shipping	        4200
137	    Ladwig	    Stock Clerk	                    Vollman          Shipping	        3600
115	    Khoo	      Purchasing Clerk	              Raphaely	       Purchasing	      3100
*/

--10. 전체 직원의 급여 평균을 구하여 출력
SELECT ROUND(AVG(e.SALARY), 2) as "급여 평균"
  FROM employees e
;
/*
급여 평균
6461.83  
*/



--11. 전체 직원의 급여 평균보다 높은 급여를 받는 사람의 목록 출력. 급여 오름차순 정렬

--51건
SELECT e.EMPLOYEE_ID                   as "사번"
      ,e.FIRST_NAME                    as "사원 이름"           
      ,e.LAST_NAME                     as "사원 이름(성)"
      ,e.SALARY                        as "급여"
      ,(SELECT ROUND(AVG(e.SALARY), 2)
                     FROM employees e) as "급여 평균"
  FROM employees e
 WHERE e.SALARY > (SELECT ROUND(AVG(e.SALARY), 2)
                     FROM employees e)
;

/*
사번, 사원 이름, 사원 이름(성),  급여, 급여 평균
100	    Steven	    King	      24000	6461.83
101	    Neena	      Kochhar	    17000	6461.83
102	    Lex	De      Haan	      17000	6461.83
103	    Alexander 	Hunold	    9000	6461.83
108	    Nancy	      Greenberg	  12008	6461.83
109	    Daniel	    Faviet	    9000	6461.83
110	    John	      Chen	      8200	6461.83
111	    Ismael	    Sciarra   	7700	6461.83
112	    Jose Manuel	Urman	      7800	6461.83
113	    Luis	      Popp	      6900	6461.83
114	    Den	        Raphaely	  11000	6461.83
*/

--12. 각 부서별 평균 급여를 구하여 출력

--12건
SELECT NVL(e.DEPARTMENT_ID || '', '미배정')  as "부서 번호"
      ,NVL(d.DEPARTMENT_NAME    , '미배정')  as "부서 이름"
      ,ROUND(AVG(e.SALARY), 2)               as "평균 급여" 
  FROM employees e
      ,departments d
  WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID(+)
 GROUP BY e.DEPARTMENT_ID, d.DEPARTMENT_NAME
 ORDER BY "평균 급여" DESC
;

/*
부서 번호, 부서 이름,         평균 급여
    90	    Executive	        19333.33
    110	    Accounting	      10154
    70	    Public Relations	10000
    20	    Marketing	        9500
    80	    Sales	            8955.88
    100	    Finance	          8601.33
    미배정  미배정             7000
    40	    Human Resources	  6500
    60	    IT	              5760
    10	    Administration	  4400
    30	    Purchasing	      4150
*/


--13. 12번의 결과에 department_name 같이 출력

--12건
SELECT NVL(e.DEPARTMENT_ID || '', '미배정')  as "부서 번호"
      ,NVL(d.DEPARTMENT_NAME    , '미배정')  as "부서 이름"
      ,ROUND(AVG(e.SALARY), 2)               as "평균 급여" 
  FROM employees e
      ,departments d
  WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID(+)
 GROUP BY e.DEPARTMENT_ID, d.DEPARTMENT_NAME
 ORDER BY "평균 급여" DESC
;

/*
부서 번호, 부서 이름,         평균 급여
    90	    Executive	        19333.33
    110	    Accounting	      10154
    70	    Public Relations	10000
    20	    Marketing	        9500
    80	    Sales	            8955.88
    100	    Finance	          8601.33
    미배정  미배정             7000
    40	    Human Resources	  6500
    60	    IT	              5760
    10	    Administration	  4400
    30	    Purchasing	      4150
*/


--14. employees 테이블이 각 job_id 별 인원수와 job_title을 같이 출력하고 job_id 오름차순 정렬
SELECT e.JOB_ID             as "직무 번호"
      ,j.JOB_TITLE          as "직무 이름"
      ,count(e.EMPLOYEE_ID) as "직무별 인원(명)"
  FROM employees e
      ,jobs j
 WHERE e.JOB_ID = j.JOB_ID
 GROUP BY e.JOB_ID, j.JOB_TITLE
 ORDER BY e.JOB_ID
;
/*
직무 번호,    직무 이름,                 직무별 인원(명)
AC_ACCOUNT	  Public Accountant	              1
AC_MGR	      Accounting Manager	            1
AD_ASST	      Administration Assistant	      1
AD_PRES	      President                       1
AD_VP	        Administration Vice President	  2
FI_ACCOUNT	  Accountant	                    5
FI_MGR	      Finance Manager	                1
HR_REP	      Human Resources Representative	1
IT_PROG	      Programmer	                    5
MK_MAN	      Marketing Manager	              1
MK_REP	      Marketing Representative	      1
PR_REP	      Public Relations Representative	1
PU_CLERK      Purchasing Clerk	              5
PU_MAN	      Purchasing Manager	            1
SA_MAN	      Sales Manager	                  5
SA_REP	      Sales Representative	          30
SH_CLERK	    Shipping Clerk	                20
ST_CLERK	    Stock Clerk	                    20
ST_MAN	      Stock Manager	                  5
*/


--15. employees 테이블의 job_id별 최저급여,

--   최대급여를 job_title과 함께 출력 job_id 알파벳순 오름차순 정렬
SELECT e.JOB_ID      as "직무 번호"
      ,j.JOB_TITLE   as "직무 이름"
      ,MAX(e.SALARY) as "최대 급여"
      ,MIN(e.SALARY) as "최저 급여"
  FROM employees e
      ,jobs      j
 WHERE e.JOB_ID = j.JOB_ID
 GROUP BY e.JOB_ID, j.JOB_TITLE
 ORDER BY e.JOB_ID 
;
/*
직무 번호,     직무 이름,                 최대 급여,  최저 급여
AC_ACCOUNT	Public Accountant	              8300	    8300
AC_MGR	    Accounting Manager	            12008	    12008
AD_ASST   	Administration Assistant	      4400	    4400
AD_PRES	    President	                      24000	    24000
AD_VP	      Administration Vice President	  17000	    17000
FI_ACCOUNT	Accountant	                    9000	    6900
FI_MGR	    Finance Manager	                12008	    12008
HR_REP	    Human Resources Representative	6500	    6500
IT_PROG	    Programmer	                    9000	    4200
MK_MAN	    Marketing Manager	              13000   	13000
MK_REP	    Marketing Representative	      6000	    6000
PR_REP	    Public Relations Representative	10000	    10000
PU_CLERK	  Purchasing Clerk	              3100	    2500
PU_MAN	    Purchasing Manager	            11000	    11000
SA_MAN	    Sales Manager	                  14000	    10500
SA_REP	    Sales Representative	          11500   	6100
SH_CLERK	  Shipping Clerk	                4200	    2500
ST_CLERK	  Stock Clerk	                    3600	    2100
ST_MAN	    Stock Manager	                  8200	    5800
*/

 

--16. Employees 테이블에서 인원수가 가장 많은 job_id를 구하고

--   해당 job_id 의 job_title 과 그 때 직원의 인원수를 같이 출력
SELECT e.JOB_ID      as "직무 번호"
      ,j.JOB_TITLE   as "직무 이름"
      ,COUNT(e.EMPLOYEE_ID) as "최대 인원(명)"
  FROM employees e
      ,jobs j
 WHERE e.JOB_ID = j.JOB_ID
 GROUP BY e.JOB_ID, j.JOB_TITLE
HAVING COUNT(e.EMPLOYEE_ID) IN (SELECT MAX(COUNT(e.EMPLOYEE_ID))
                                  FROM employees e
                                 GROUP BY e.JOB_ID);
;

/* -----------------------------------------------
직무 번호,      직무 이름,         최대 인원(명)
SA_REP	  Sales Representative	      30
----------------------------------------------- */



--17.사번,last_name, 급여, 직책이름(job_title), 부서명(department_name), 부서매니저이름

--  부서 위치 도시(city), 나라(country_name), 지역(region_name) 을 출력

----------- 부서가 배정되지 않은 인원 고려 ------

DESC employees;
DESC departments;
DESC jobs;
SELECT e1.EMPLOYEE_ID               as "사번"
      ,e1.LAST_NAME                 as "사원 이름"
      ,NVL(j.JOB_TITLE, '-')        as "직무명"
      ,NVL(d.DEPARTMENT_NAME, '-')  as "부서명"
      ,NVL(e2.LAST_NAME, '-')       as "부서매니저 이름"
      ,NVL(l.CITY, '-')             as "부서 위치 도시"
      ,NVL(c.COUNTRY_NAME, '-')     as "부서 나라명"
      ,NVL(r.REGION_NAME, '-')      as "부서 지역명"
  FROM employees e1
      ,employees e2
      ,departments d
      ,jobs j
      ,locations l
      ,countries c
      ,regions r
 WHERE e1.DEPARTMENT_ID = d.DEPARTMENT_ID(+)
   AND e1.JOB_ID = j.JOB_ID
   AND d.MANAGER_ID = e2.EMPLOYEE_ID(+)
   AND d.LOCATION_ID = l.LOCATION_ID(+)
   AND l.COUNTRY_ID = c.COUNTRY_ID(+)
   AND c.REGION_ID = r.REGION_ID(+)
;

/*
200	Whalen	Administration Assistant	Administration	Whalen	Seattle	United States of America	Americas
202	Fay	Marketing Representative	Marketing	Hartstein	Toronto	Canada	Americas
201	Hartstein	Marketing Manager	Marketing	Hartstein	Toronto	Canada	Americas
114	Raphaely	Purchasing Manager	Purchasing	Raphaely	Seattle	United States of America	Americas
119	Colmenares	Purchasing Clerk	Purchasing	Raphaely	Seattle	United States of America	Americas
118	Himuro	Purchasing Clerk	Purchasing	Raphaely	Seattle	United States of America	Americas
117	Tobias	Purchasing Clerk	Purchasing	Raphaely	Seattle	United States of America	Americas
115	Khoo	Purchasing Clerk	Purchasing	Raphaely	Seattle	United States of America	Americas
116	Baida	Purchasing Clerk	Purchasing	Raphaely	Seattle	United States of America	Americas
203	Mavris	Human Resources Representative	Human Resources	Mavris	London	United Kingdom	Europe
120	Weiss	Stock Manager	Shipping	Fripp	South San Francisco	United States of America	Americas
121	Fripp	Stock Manager	Shipping	Fripp	South San Francisco	United States of America	Americas
122	Kaufling	Stock Manager	Shipping	Fripp	South San Francisco	United States of America	Americas
123	Vollman	Stock Manager	Shipping	Fripp	South San Francisco	United States of America	Americas
124	Mourgos	Stock Manager	Shipping	Fripp	South San Francisco	United States of America	Americas
139	Seo	Stock Clerk	Shipping	Fripp	South San Francisco	United States of America	Americas
138	Stiles	Stock Clerk	Shipping	Fripp	South San Francisco	United States of America	Americas
137	Ladwig	Stock Clerk	Shipping	Fripp	South San Francisco	United States of America	Americas
136	Philtanker	Stock Clerk	Shipping	Fripp	South San Francisco	United States of America	Americas
135	Gee	Stock Clerk	Shipping	Fripp	South San Francisco	United States of America	Americas
134	Rogers	Stock Clerk	Shipping	Fripp	South San Francisco	United States of America	Americas
133	Mallin	Stock Clerk	Shipping	Fripp	South San Francisco	United States of America	Americas
144	Vargas	Stock Clerk	Shipping	Fripp	South San Francisco	United States of America	Americas
131	Marlow	Stock Clerk	Shipping	Fripp	South San Francisco	United States of America	Americas
130	Atkinson	Stock Clerk	Shipping	Fripp	South San Francisco	United States of America	Americas
129	Bissot	Stock Clerk	Shipping	Fripp	South San Francisco	United States of America	Americas
128	Markle	Stock Clerk	Shipping	Fripp	South San Francisco	United States of America	Americas
127	Landry	Stock Clerk	Shipping	Fripp	South San Francisco	United States of America	Americas
126	Mikkilineni	Stock Clerk	Shipping	Fripp	South San Francisco	United States of America	Americas
125	Nayer	Stock Clerk	Shipping	Fripp	South San Francisco	United States of America	Americas
140	Patel	Stock Clerk	Shipping	Fripp	South San Francisco	United States of America	Americas
141	Rajs	Stock Clerk	Shipping	Fripp	South San Francisco	United States of America	Americas
142	Davies	Stock Clerk	Shipping	Fripp	South San Francisco	United States of America	Americas
143	Matos	Stock Clerk	Shipping	Fripp	South San Francisco	United States of America	Americas
132	Olson	Stock Clerk	Shipping	Fripp	South San Francisco	United States of America	Americas
183	Geoni	Shipping Clerk	Shipping	Fripp	South San Francisco	United States of America	Americas
182	Sullivan	Shipping Clerk	Shipping	Fripp	South San Francisco	United States of America	Americas
181	Fleaur	Shipping Clerk	Shipping	Fripp	South San Francisco	United States of America	Americas
180	Taylor	Shipping Clerk	Shipping	Fripp	South San Francisco	United States of America	Americas
199	Grant	Shipping Clerk	Shipping	Fripp	South San Francisco	United States of America	Americas
198	OConnell	Shipping Clerk	Shipping	Fripp	South San Francisco	United States of America	Americas
197	Feeney	Shipping Clerk	Shipping	Fripp	South San Francisco	United States of America	Americas
196	Walsh	Shipping Clerk	Shipping	Fripp	South San Francisco	United States of America	Americas
195	Jones	Shipping Clerk	Shipping	Fripp	South San Francisco	United States of America	Americas
194	McCain	Shipping Clerk	Shipping	Fripp	South San Francisco	United States of America	Americas
193	Everett	Shipping Clerk	Shipping	Fripp	South San Francisco	United States of America	Americas
192	Bell	Shipping Clerk	Shipping	Fripp	South San Francisco	United States of America	Americas
191	Perkins	Shipping Clerk	Shipping	Fripp	South San Francisco	United States of America	Americas
190	Gates	Shipping Clerk	Shipping	Fripp	South San Francisco	United States of America	Americas
189	Dilly	Shipping Clerk	Shipping	Fripp	South San Francisco	United States of America	Americas
188	Chung	Shipping Clerk	Shipping	Fripp	South San Francisco	United States of America	Americas
187	Cabrio	Shipping Clerk	Shipping	Fripp	South San Francisco	United States of America	Americas
186	Dellinger	Shipping Clerk	Shipping	Fripp	South San Francisco	United States of America	Americas
185	Bull	Shipping Clerk	Shipping	Fripp	South San Francisco	United States of America	Americas
184	Sarchand	Shipping Clerk	Shipping	Fripp	South San Francisco	United States of America	Americas
105	Austin	Programmer	IT	Hunold	Southlake	United States of America	Americas
106	Pataballa	Programmer	IT	Hunold	Southlake	United States of America	Americas
107	Lorentz	Programmer	IT	Hunold	Southlake	United States of America	Americas
104	Ernst	Programmer	IT	Hunold	Southlake	United States of America	Americas
103	Hunold	Programmer	IT	Hunold	Southlake	United States of America	Americas
204	Baer	Public Relations Representative	Public Relations	Baer	Munich	Germany	Europe
162	Vishney	Sales Representative	Sales	Russell	Oxford	United Kingdom	Europe
150	Tucker	Sales Representative	Sales	Russell	Oxford	United Kingdom	Europe
151	Bernstein	Sales Representative	Sales	Russell	Oxford	United Kingdom	Europe
152	Hall	Sales Representative	Sales	Russell	Oxford	United Kingdom	Europe
153	Olsen	Sales Representative	Sales	Russell	Oxford	United Kingdom	Europe
154	Cambrault	Sales Representative	Sales	Russell	Oxford	United Kingdom	Europe
177	Livingston	Sales Representative	Sales	Russell	Oxford	United Kingdom	Europe
176	Taylor	Sales Representative	Sales	Russell	Oxford	United Kingdom	Europe
175	Hutton	Sales Representative	Sales	Russell	Oxford	United Kingdom	Europe
174	Abel	Sales Representative	Sales	Russell	Oxford	United Kingdom	Europe
173	Kumar	Sales Representative	Sales	Russell	Oxford	United Kingdom	Europe
172	Bates	Sales Representative	Sales	Russell	Oxford	United Kingdom	Europe
171	Smith	Sales Representative	Sales	Russell	Oxford	United Kingdom	Europe
170	Fox	Sales Representative	Sales	Russell	Oxford	United Kingdom	Europe
169	Bloom	Sales Representative	Sales	Russell	Oxford	United Kingdom	Europe
168	Ozer	Sales Representative	Sales	Russell	Oxford	United Kingdom	Europe
167	Banda	Sales Representative	Sales	Russell	Oxford	United Kingdom	Europe
166	Ande	Sales Representative	Sales	Russell	Oxford	United Kingdom	Europe
165	Lee	Sales Representative	Sales	Russell	Oxford	United Kingdom	Europe
164	Marvins	Sales Representative	Sales	Russell	Oxford	United Kingdom	Europe
163	Greene	Sales Representative	Sales	Russell	Oxford	United Kingdom	Europe
179	Johnson	Sales Representative	Sales	Russell	Oxford	United Kingdom	Europe
161	Sewall	Sales Representative	Sales	Russell	Oxford	United Kingdom	Europe
160	Doran	Sales Representative	Sales	Russell	Oxford	United Kingdom	Europe
159	Smith	Sales Representative	Sales	Russell	Oxford	United Kingdom	Europe
158	McEwen	Sales Representative	Sales	Russell	Oxford	United Kingdom	Europe
157	Sully	Sales Representative	Sales	Russell	Oxford	United Kingdom	Europe
156	King	Sales Representative	Sales	Russell	Oxford	United Kingdom	Europe
155	Tuvault	Sales Representative	Sales	Russell	Oxford	United Kingdom	Europe
149	Zlotkey	Sales Manager	Sales	Russell	Oxford	United Kingdom	Europe
145	Russell	Sales Manager	Sales	Russell	Oxford	United Kingdom	Europe
146	Partners	Sales Manager	Sales	Russell	Oxford	United Kingdom	Europe
147	Errazuriz	Sales Manager	Sales	Russell	Oxford	United Kingdom	Europe
148	Cambrault	Sales Manager	Sales	Russell	Oxford	United Kingdom	Europe
101	Kochhar	Administration Vice President	Executive	King	Seattle	United States of America	Americas
102	De Haan	Administration Vice President	Executive	King	Seattle	United States of America	Americas
100	King	President	Executive	King	Seattle	United States of America	Americas
108	Greenberg	Finance Manager	Finance	Greenberg	Seattle	United States of America	Americas
112	Urman	Accountant	Finance	Greenberg	Seattle	United States of America	Americas
111	Sciarra	Accountant	Finance	Greenberg	Seattle	United States of America	Americas
113	Popp	Accountant	Finance	Greenberg	Seattle	United States of America	Americas
109	Faviet	Accountant	Finance	Greenberg	Seattle	United States of America	Americas
110	Chen	Accountant	Finance	Greenberg	Seattle	United States of America	Americas
205	Higgins	Accounting Manager	Accounting	Higgins	Seattle	United States of America	Americas
206	Gietz	Public Accountant	Accounting	Higgins	Seattle	United States of America	Americas
178	Grant	Sales Representative	-	-	-	-	-
*/

--18.부서 아이디, 부서명, 부서에 속한 인원숫자를 출력
SELECT d.DEPARTMENT_ID      as "부서 아이디"
      ,d.DEPARTMENT_NAME    as "부서명"
      ,NVL((SELECT COUNT(*)
              FROM employees e
             WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID
             GROUP BY d.DEPARTMENT_ID, d.DEPARTMENT_NAME) || '', '-') as "인원(명)수"
  FROM departments d
; 
-- NULL 인 아닌 부서번호 : 10 20 3040 50 60 70 80 90 100 110

SELECT DISTINCT e.DEPARTMENT_ID
  FROM employees e
 ORDER BY e.DEPARTMENT_ID
;

/*
부서 아이디,   부서명,       인원(명)수
      10	Administration	      1
      20	Marketing	            2
      30	Purchasing	          6
      40	Human Resources	      1
      50	Shipping	            45
      60	IT	                  5
      70	Public Relations	    1
      80	Sales	                34
      90	Executive	            3
      100	Finance           	  6
      110	Accounting	          2
      120	Treasury	            -
      130	Corporate Tax	        -
      140	Control And Credit	  -
      150	Shareholder Services	-
      160	Benefits	            -
      170	Manufacturing	        -
      180	Construction	        -
      190	Contracting	          -
      200	Operations	          -
      210	IT Support	          -
      220	NOC	                  -
      230	IT Helpdesk	          -
      240	Government Sales	    -
      250	Retail Sales        	-
      260	Recruiting	          -
      270	Payroll	              -
*/

--19.인원이 가장 많은 상위 다섯 부서아이디, 부서명, 인원수 목록 출력
SELECT r.*
  FROM (SELECT d.DEPARTMENT_ID      as "부서 아이디"
              ,d.DEPARTMENT_NAME    as "부서명"
              ,(SELECT COUNT(*)
                  FROM employees e
                 WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID
                 GROUP BY e.DEPARTMENT_ID) as "인원(명)수"
          FROM departments d
         ORDER BY "인원(명)수" DESC) r
 WHERE r."인원(명)수" IS NOT NULL
   AND ROWNUM <= 5;

/*
부서 아이디, 부서명, 인원(명)수
50	        Shipping	  45
80	        Sales	      34
30	        Purchasing	6
100	        Finance   	6
60	        IT	        5
*/


 

--20. 부서별, 직책별 평균 급여를 구하여라.

--   부서이름, 직책이름, 평균급여 소수점 둘째자리에서 반올림으로 구하여라.
SELECT d.DEPARTMENT_NAME       as "부서 이름"
      ,j.JOB_TITLE             as "직책 이름"
      ,TO_CHAR(ROUND(AVG(e.SALARY), 2), '$99,999,999.99') as "평균 급여"
  FROM employees e
      ,departments d
      ,jobs j
 WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID
   AND e.JOB_ID = j.JOB_ID
 GROUP BY d.DEPARTMENT_NAME, j.JOB_TITLE 
 ORDER BY "평균 급여" DESC
;

/*    
부서 이름,        직책 이름,                        평균 급여
Executive	        President	                      $24,000.00
Executive	        Administration Vice President	  $17,000.00
Marketing	        Marketing Manager	              $13,000.00
Sales	            Sales Manager	                  $12,200.00
Accounting	      Accounting Manager	            $12,008.00
Finance	          Finance Manager	                $12,008.00
Purchasing	      Purchasing Manager	            $11,000.00
Public Relations	Public Relations Representative	$10,000.00
Sales	            Sales Representative	          $8,396.55
Accounting	      Public Accountant	              $8,300.00
Finance	          Accountant	                    $7,920.00
Shipping	        Stock Manager	                  $7,280.00
Human Resources	  Human Resources Representative	$6,500.00
Marketing	        Marketing Representative	      $6,000.00
IT	              Programmer	                    $5,760.00
Administration	  Administration Assistant	      $4,400.00
Shipping	        Shipping Clerk	                $3,215.00
Shipping	        Stock Clerk	                    $2,785.00
Purchasing	      Purchasing Clerk	              $2,780.00
*/



--21.각 부서의 정보를 부서매니저 이름과 함께 출력(부서는 모두 출력되어야 함)
SELECT d.DEPARTMENT_ID         as "부서번호"
      ,d.DEPARTMENT_NAME       as "부서명"
      ,NVL(e.FIRST_NAME, '-')  as "매니저 이름(성)"
      ,NVL(e.LAST_NAME, '-')   as "매니저 이름"
  FROM employees e
      ,departments d
 WHERE d.MANAGER_ID = e.EMPLOYEE_ID(+)
 ORDER BY d.DEPARTMENT_ID 
;

SELECT * FROM EMPLOYEES;

SELECT * FROM DEPARTMENTS;

/*
부서번호, 부서명,         매니저 이름(성),     매니저 이름
    10	Administration	      Jennifer	      Whalen
    20	Marketing	            Michael	        Hartstein
    30	Purchasing	          Den	            Raphaely
    40	Human Resources	      Susan	          Mavris
    50	Shipping	            Adam	          Fripp
    60	IT	                  Alexander	      Hunold
    70	Public Relations	    Hermann	        Baer
    80	Sales	                John	          Russell
    90	Executive	            Steven	        King
    100	Finance	              Nancy	          Greenberg
    110	Accounting	          Shelley	        Higgins
    120	Treasury	            -               -
    130	Corporate Tax         -               -
    140	Control And Credit	  -               -
    150	Shareholder Services	-               -
    160	Benefits	            -               -
    170	Manufacturing	        -               -
    180	Construction	        -               -
    190	Contracting	          -               - 
    200	Operations	          -               -
    210	IT Support	          -               -
    220	NOC	                  -               -
    230	IT Helpdesk	          -               -
    240	Government Sales	    -               -
    250	Retail Sales	        -               -
    260	Recruiting	          -               -
    270	Payroll	              -               -
*/
 

--22. 부서가 가장 많은 도시이름을 출력
SELECT l.*
  FROM (SELECT l.CITY   
              ,(SELECT COUNT(*)
                  FROM departments d
                 WHERE d.LOCATION_ID = l.LOCATION_ID
                 GROUP BY l.CITY) as "인원(명)수"
          FROM locations l
         ORDER BY "인원(명)수" DESC) l
 WHERE l."인원(명)수" IS NOT NULL
   AND rownum = 1 
;
/* ---------------
CITY, 인원(명)수
Seattle	21
--------------- */

--23. 부서가 없는 도시 목록 출력

--조인사용
SELECT l.LOCATION_ID   as "도시번호"
      ,l.CITY          as "도시명"
  FROM departments d
      ,locations l
 WHERE d.LOCATION_ID(+) = l.LOCATION_ID
   AND d.DEPARTMENT_ID IS NULL
;


--집합연산 사용
SELECT l.LOCATION_ID   as "도시번호"
      ,l.CITY          as "도시명"
  FROM departments d
      ,locations l
 WHERE d.LOCATION_ID(+) = l.LOCATION_ID
MINUS
SELECT l.LOCATION_ID   as "도시번호"
      ,l.CITY          as "도시명"
  FROM departments d
      ,locations l
 WHERE d.LOCATION_ID = l.LOCATION_ID
;

--서브쿼리 사용
SELECT l.LOCATION_ID   as "도시번호"
      ,l.CITY          as "도시명"
  FROM departments d
      ,locations l
WHERE d.LOCATION_ID = l.LOCATION_ID
;

SELECT l.LOCATION_ID   as "도시번호"
      ,l.CITY          as "도시명"
  FROM locations l
 WHERE NOT l.LOCATION_ID IN (SELECT d.location_id
                               FROM departments d)
;
/* -------------------
도시번호, 도시명
  1000	Roma
  1100	Venice
  1200	Tokyo
  1300	Hiroshima
  1600	South Brunswick
  1900	Whitehorse
  2000	Beijing
  2100	Bombay
  2200	Sydney
  2300	Singapore
  2600	Stretford
  2800	Sao Paulo
  2900	Geneva
  3000	Bern
  3100	Utrecht
  3200	Mexico City
------------------- */

--24.평균 급여가 가장 높은 부서명을 출력
SELECT avgSal.*
  FROM (SELECT d.DEPARTMENT_ID          as "부서 번호"
              ,d.DEPARTMENT_NAME        as "부서명"
              ,ROUND(AVG(e.SALARY), 2)  as "평균 급여"
          FROM employees e
              ,departments d
         WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID
         GROUP BY d.DEPARTMENT_ID 
                 ,d.DEPARTMENT_NAME 
         ORDER BY "평균 급여" DESC) avgSal
 WHERE ROWNUM = 1
;

/*
부서 번호,    부서명,     평균 급여
  90	      Executive	   19333.33
*/

--25. Finance 부서의 평균 급여보다 높은 급여를 받는 직원의 목록 출력
SELECT
      AVG(e.SALARY)
FROM departments d, employees e
WHERE d.DEPARTMENT_NAME = 'Finance'
AND e.DEPARTMENT_ID = d.DEPARTMENT_ID
;

SELECT e.EMPLOYEE_ID  as "사번"
      ,e.FIRST_NAME   as "사원 이름"
      ,e.SALARY       as "급여"
  FROM employees e
 WHERE e.SALARY > (SELECT AVG(e.SALARY)
                     FROM departments d, employees e
                    WHERE d.DEPARTMENT_NAME = 'Finance'
                      AND e.DEPARTMENT_ID = d.DEPARTMENT_ID)
; 
/* ------------------------------
  사번, 사원 이름,   급여
  100	Steven	      24000
  101	Neena	        17000
  102	Lex	          17000
  103	Alexander	    9000
  108	Nancy	        12008
  109	Daniel	      9000
  114	Den	          11000
  145	John	        14000
  146	Karen	        13500
  147	Alberto	      12000
  148	Gerald	      11000
  149	Eleni	        10500
  150	Peter	        10000
  151	David	        9500
  152	Peter	        9000
  156	Janette	      10000
  157	Patrick	      9500
  158	Allan	        9000
  162	Clara	        10500
  163	Danielle	    9500
  168	Lisa	        11500
  169	Harrison	    10000
  170	Tayler	      9600
  174	Ellen	        11000
  175	Alyssa	      8800
  201	Michael     	13000
  204	Hermann	      10000
  205	Shelley	      12008
------------------------------ */

-- 26. 각 부서별 인원수를 출력하되, 인원이 없는 부서는 0으로 나와야 하며

--     부서는 정식 명칭으로 출력하고 인원이 많은 순서로 정렬.

SELECT d.DEPARTMENT_ID      as "부서 아이디"
      ,d.DEPARTMENT_NAME    as "부서명"
      ,NVL((SELECT COUNT(*)
              FROM employees e
             WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID
             GROUP BY d.DEPARTMENT_ID, d.DEPARTMENT_NAME), 0) as "인원(명)수"
  FROM departments d
 ORDER BY "인원(명)수" DESC
; 

/* ----------------------------------------
부서 아이디, 부서명,       인원(명)수
      50	Shipping	          45
      80	Sales	              34
      30	Purchasing  	       6
      100	Finance	             6
      60	IT	                 5
      90	Executive   	       3
      110	Accounting	         2
      20	Marketing	           2
      40	Human Resources	     1
      70	Public Relations	   1
      10	Administration	     1
      230	IT Helpdesk	         0
      240	Government Sales	   0
      250	Retail Sales	       0
      260	Recruiting	         0
      220	NOC	                 0
      210	IT Support	         0
      200	Operations	         0
      190	Contracting	         0
      180	Construction	       0
      170	Manufacturing	       0
      160	Benefits	           0
      150	Shareholder Services 0
      270	Payroll	             0
      130	Corporate Tax	       0
      120	Treasury	           0
      140	Control And Credit	 0
---------------------------------------- */




--27. 지역별 등록된 나라의 갯수 출력(지역이름, 등록된 나라의 갯수)
SELECT c.COUNTRY_NAME as "지역 이름"
      ,COUNT(*)       as "등록 된 나라의 갯수"
  FROM countries c
      ,locations l
 WHERE c.COUNTRY_ID = l.COUNTRY_ID
 GROUP BY c.COUNTRY_NAME
 ORDER BY "등록 된 나라의 갯수" DESC;

SELECT *
  FROM countries;

SELECT l.*
  FROM locations l
 WHERE l.COUNTRY_ID = 'US'
    OR l.COUNTRY_ID = 'UK';



/* ---------------------------------------
지역 이름,              등록 된 나라의 갯수
United States of America	    4
United Kingdom	              3
Japan	                        2
Italy	                        2
Switzerland	                  2
Canada	                      2
Mexico	                      1
Singapore	                    1
Netherlands	                  1
India	                        1
Germany	                      1
China	                        1
Brazil	                      1
Australia	                    1
--------------------------------------- */



--28. 가장 많은 나라가 등록된 지역명 출력
SELECT cnc.*
  FROM (SELECT c.COUNTRY_NAME as "지역 이름"
              ,COUNT(*)       as "등록 된 나라의 갯수"
          FROM countries c
              ,locations l
         WHERE c.COUNTRY_ID = l.COUNTRY_ID
         GROUP BY c.COUNTRY_NAME
         ORDER BY "등록 된 나라의 갯수" DESC) cnc
 WHERE ROWNUM = 1
;
/* ---------------------------------------
지역 이름,            등록 된 나라의 갯수
United States of America	    4
--------------------------------------- */
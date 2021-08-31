/*
 질문내용
 1. fk 설정기준 -> 서로다른 테이블이 같은컬럼으로 겹쳐있는게 있으면 전부 fk를 설정해 주어야 하는가?
 2. pay_price -> pay_num * movie_price 식을 이용해서 insert가 가능할까? -> 안되면 insert에는 null로 하고 추가로 update 해야하나?
 3. 결제내역 조회하는 코드 간추릴수 없을까?
 4. 예매취소시 한사람이 여러개의 영화를 예매한 상황이라면 그중 선택해서 예매를 취소해야한다. -> 구현방법 찾기
 	ㄴ 해당 사람이 예매한 영화목록 불러오기(영화제목, 날짜, 시간)
 	ㄴ 취소할 영화를 입력받으면 해당되는 행을 찾아 삭제 -> 입력받을 방법 찾기
 */


-- 테이블 생성 ------------------------------------------------------------------------------------------------------
DROP TABLE members;
DROP TABLE seat;
DROP TABLE movieinfo;
DROP TABLE payment;
DROP TABLE TICKETINFO ;
-- 회원정보
CREATE TABLE MEMBERS (
mem_code varchar2(10) PRIMARY KEY,		-- 회원코드	pk
name varchar2(20) NOT NULL,				-- 이름
id varchar2(30) NOT NULL,				-- 아이디
password varchar2(30) NOT NULL,			-- 비밀번호
email varchar2(40),						-- 이메일
tel varchar2(20)						-- 전화번호
);

CREATE SEQUENCE mem_code;

-- 영화정보
CREATE TABLE MOVIEINFO (
movie_num varchar2(10) NOT null,		-- 영화번호	
movie_name varchar2(20) PRIMARY KEY,	-- 영화제목	pk
run_time varchar2(10) NOT NULL,			-- 영화 상영시간
movie_genre varchar2(20) NOT NULL,		-- 영화 장르 
playdate DATE NOT NULL,					-- 영화개봉일
nation varchar2(20) NOT NULL,			-- 국가
movie_rating varchar2(20) NOT NULL		-- 관람가
);

-- 일일별 영화 상영계획 -> 엑셀로 자료 가져오기
CREATE TABLE TICKETINFO (
movie_code varchar2(30) PRIMARY KEY,	-- 영화코드	pk
movie_name varchar2(20) NOT NULL,		-- 영화제목   영화정보 fk
movie_date DATE NOT NULL,				-- 상영날짜
movie_time varchar2(20) NOT NULL,		-- 영화시간
movie_theater varchar2(20) NOT NULL,	-- 영화 상영관
movie_price number(6) NOT NULL			-- 영화가격
);

ALTER TABLE ticketinfo ADD PRIMARY KEY (movie_code);
ALTER TABLE ticketinfo ADD FOREIGN KEY (movie_name)
	REFERENCES movieinfo (movie_name);

-- 결제정보
CREATE TABLE PAYMENT (
pay_code varchar2(20) PRIMARY KEY,		-- 결제코드	pk
mem_code varchar2(10) NOT NULL,			-- 회원코드	회원정보 fk
movie_code varchar2(30) NOT NULL,		-- 영화코드	상영계획 fk
pay_time DATE DEFAULT sysdate,			-- 결제시간
pay_num number(3) NOT NULL,				-- 결제인원수
movie_price number(6) NOT NULL,			-- 영화 금액
pay_price number(10) NOT NULL,			-- 총결제금액(movie_price * pay_num)
FOREIGN KEY (mem_code) REFERENCES members (mem_code),
FOREIGN KEY (movie_code) REFERENCES ticketinfo (movie_code)
);

CREATE SEQUENCE pay_code;

-- 좌석정보
CREATE TABLE SEAT (
mem_code varchar2(10),					-- 회원코드	회원정보 fk
movie_theater varchar2(20)NOT NULL, 	-- 영화 상영관
movie_code varchar2(30) NOT NULL,		-- 영화코드	상영계획 fk
movie_seat varchar2(20) NOT NULL,		-- 영화 좌석
FOREIGN KEY (mem_code) REFERENCES members (mem_code),
FOREIGN KEY (movie_code) REFERENCES ticketinfo (movie_code)
);

-- 테이블 생성 -end-------------------------------------------------------------------------------------------------------

DROP TABLE PAYMENT ;
SELECT * FROM PAYMENT p ;
SELECT * FROM TICKETINFO t ;
INSERT INTO PAYMENT (pay_code, mem_code, movie_code, pay_num, movie_price, pay_price) VALUES (pay_code.nextval, mem_code.nextval, 'm0603511020', 2, 12000, 24000);

-- movieinfo 테이블 정보 insert------------------------------------------------------------------------------------------
INSERT INTO MOVIEINFO(movie_num ,movie_name,run_time,movie_genre,
	PLAYDATE,NATION,MOVIE_RATING)
	VALUES('1', '모가디슈', '121', '액션,드라마','2021-07-28','한국','15세');
INSERT INTO MOVIEINFO(movie_num ,movie_name,run_time,movie_genre,
	PLAYDATE,NATION,MOVIE_RATING)
	VALUES('2', '인질', '94', '액션,스릴러','2021-08-18','한국','15세');
INSERT INTO MOVIEINFO(movie_num ,movie_name,run_time,movie_genre,
	PLAYDATE,NATION,MOVIE_RATING)
	VALUES('3', '싱크홀', '113', '코미디','2021-08-11','한국','12세');
INSERT INTO MOVIEINFO(movie_num ,movie_name,run_time,movie_genre,
	PLAYDATE,NATION,MOVIE_RATING)
	VALUES('4', '프리가이', '115', '액션,어드벤쳐','2021-08-11','미국','12세');
INSERT INTO MOVIEINFO(movie_num ,movie_name,run_time,movie_genre,
	PLAYDATE,NATION,MOVIE_RATING)
	VALUES('5', '올드', '108', '공포,스릴러','2021-08-18','미국','12세');

-- movieinfo insert -end---------------------------------------------------------------------------------------------


-- 아이디 가입여부 확인
SELECT * FROM members WHERE id = '' AND password = '';

	
-- 결제코드로 예매내역 조회
SELECT movie_code FROM PAYMENT WHERE pay_code = '123';

SELECT * FROM TICKETINFO WHERE movie_code IN (SELECT movie_code FROM PAYMENT WHERE pay_code = '123');


-- 이름 및 아이디로 결제여부 조회
SELECT MEM_CODE FROM MEMBERS WHERE name = '윈터' AND id = 'winter';

SELECT movie_code FROM payment WHERE mem_code = '1';

SELECT movie_code FROM payment WHERE mem_code = (SELECT MEM_CODE FROM MEMBERS WHERE name = '윈터' AND id = 'winter');
SELECT * FROM PAYMENT p ;
SELECT * FROM MEMBERS m ;
SELECT * FROM TICKETINFO t ;

SELECT * FROM TICKETINFO WHERE movie_code IN (SELECT movie_code FROM PAYMENT WHERE mem_code = (SELECT MEM_CODE FROM MEMBERS WHERE name = '윈터' AND id = 'winter'));



-- 이름 및 비밀번호로 결제여부 조회
SELECT MEM_CODE FROM MEMBERS WHERE id = 'winter' AND password = 'espa';

SELECT movie_code FROM PAYMENT WHERE mem_code = (SELECT MEM_CODE FROM MEMBERS WHERE id = 'winter' AND password = 'espa');

SELECT * FROM TICKETINFO WHERE movie_code IN (SELECT movie_code FROM PAYMENT WHERE mem_code = (SELECT MEM_CODE FROM MEMBERS WHERE id = 'winter' AND password = 'espa'));


-- 전화번호로 결제여부 조회
SELECT MEM_CODE FROM MEMBERS WHERE tel = '01012345678';

SELECT movie_code FROM PAYMENT WHERE mem_code = (SELECT MEM_CODE FROM MEMBERS WHERE tel = '01012345678');

SELECT * FROM TICKETINFO WHERE movie_code IN (SELECT movie_code FROM PAYMENT WHERE mem_code = (SELECT MEM_CODE FROM MEMBERS WHERE tel = '01012345678'));


-- 예매번호 일치여부 확인---------------------
SELECT * FROM payment WHERE movie_code = '651011020' AND mem_code = (SELECT mem_code FROM members WHERE id = 'winter' AND password = 'espa');

-- 상영관 및 좌석번호 조회--------------------
SELECT movie_code, movie_theater, movie_seat FROM seat WHERE mem_code = (SELECT MEM_CODE FROM MEMBERS WHERE tel = '01012345678') AND movie_code = 'm0603511020';

SELECT movie_time FROM TICKETINFO WHERE movie_date = '2021-09-06' AND MOVIE_NAME = '싱크홀' AND MOVIE_TIME = '10:20';

	
-- 예매취소 ----------------------------
DELETE FROM payment WHERE mem_code = (SELECT mem_code FROM members WHERE id = '' AND password = '')
	AND movie_code = '';


-- 데이터 삭제할때 fk로 묶여있으면 아래 코드 이용해서 자식테이블까지 같이 삭제가능
CONSTRAINT pcode_fk FOREIGN KEY (pcode)
	REFERENCES product#(pcode) ON DELETE CASCADE
-- fk 옵션 on delete cascade :
	-- 부모테이블 참조값이 삭제될때, 참조하는 자식테이블 row가 삭제


DELETE FROM payment WHERE mem_code =
	(SELECT mem_code FROM members WHERE id = ? AND password = ?)
	AND movie_code = ?
	
DELETE FROM payment WHERE mem_code = (SELECT mem_code FROM members WHERE id = 'cdw0807' AND password = 'lksy0520')
	AND movie_code = 'm0603511020';

DELETE FROM seat WHERE mem_code = (SELECT mem_code FROM members WHERE id = 'cdw0807' AND password = 'lksy0520') AND movie_code = 'm0603511020';
	

SELECT * FROM TICKETINFO WHERE movie_code IN (SELECT movie_code FROM PAYMENT WHERE mem_code = (SELECT MEM_CODE FROM MEMBERS WHERE tel = ?))
	
	
	
	
	
	
	
	
	
	
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

-- 회원정보
CREATE TABLE MEMBERS (
mem_code char(6) PRIMARY KEY,			-- 회원코드	(pk)
name varchar2(20) NOT NULL,				-- 이름
id varchar2(20) NOT NULL,				-- 아이디
password varchar2(20) NOT NULL,			-- 비밀번호
email varchar2(40),						-- 이메일
tel varchar2(20)						-- 전화번호
);

-- 결제정보
CREATE TABLE PAYMENT (
pay_code varchar2(20) PRIMARY KEY,		-- 결제코드	(pk)
mem_code char(6) NOT NULL,				-- 회원코드	(fk)
movie_code char(10) NOT NULL,			-- 영화코드	(fk)
pay_time DATE NOT NULL,					-- 결제시간
pay_num number(3) NOT NULL,				-- 결제인원수
movie_price number(6) NOT NULL,			-- 영화 금액
pay_price number(10) NOT NULL			-- 총결제금액(movie_price * pay_num)
);

-- 좌석정보
CREATE TABLE SEAT (
movie_theater varchar2(20)NOT NULL, 	-- 영화 상영관
movie_code char(10) NOT NULL,			-- 영화코드	(fk)
movie_seat varchar2(20) NOT NULL		-- 영화 좌석
);

-- 영화정보
CREATE TABLE MOVIEINFO (
movie_num char(5) PRIMARY KEY,			-- 영화번호	(pk)
movie_name varchar2(20) NOT NULL,		-- 영화제목	(pk)
run_time varchar2(10) NOT NULL,			-- 영화 상영시간
movie_genre varchar2(20) NOT NULL,		-- 영화 장르 
playdate DATE NOT NULL,					-- 영화개봉일
nation varchar2(20) NOT NULL,			-- 국가
movie_rating varchar2(20) NOT NULL		-- 관람가
);

-- 영화별 상영일자 -> 엑셀로 자료 가져오기
CREATE TABLE MOVIESCHEDULE (
movie_name varchar2(20) PRIMARY KEY,	-- 영화제목	(pk)
6 char(2),								-- 6일
7 char(2),								-- 7일
8 char(2),								-- 8일
9 char(2),								-- 9일
10 char(2),								-- 10일
11 char(2),								-- 11일
12 char(2)								-- 12일
);

-- 일일별 영화 상영계획 -> 엑셀로 자료 가져오기
CREATE TABLE TICKETINFO (
movie_code char(10) PRIMARY KEY,		-- 영화코드	(pk)
movie_name varchar2(20) NOT NULL,		-- 영화제목   (fk)
movie_date DATE NOT NULL,				-- 상영날짜
movie_time varchar2(20) NOT NULL,		-- 영화시간
movie_theater varchar2(20) NOT NULL,	-- 영화 상영관
movie_price number(6) NOT NULL			-- 영화가격
);

-- 테이블 생성 -end-------------------------------------------------------------------------------------------------------



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
SELECT t.movie_name, t.movie_date, t.movie_time, t.movie_theater,
s.movie_seat, p.pay_num, p.movie_price, p.movie_price
	FROM TICKETINFO t , SEAT s , PAYMENT p
	WHERE t.MOVIE_CODE = (SELECT movie_code FROM payment WHERE pay_code = '')
	AND p.pay_code = '';
	

-- 이름 및 아이디로 결제내역 조회
SELECT t.movie_name, t.movie_date, t.movie_time, t.movie_theater, s.movie_seat, p.pay_num, p.movie_price, p.pay_price
	FROM TICKETINFO t , SEAT s , PAYMENT p WHERE t.MOVIE_CODE = (SELECT movie_code FROM payment
		WHERE mem_code = (SELECT mem_code FROM members WHERE name = '' AND id = ''))
	AND p.mem_code = (SELECT mem_code FROM members WHERE name = '' AND id = '') ;



-- 이름 및 비밀번호로 결제내역 조회
SELECT t.movie_name, t.movie_date, t.movie_time, t.movie_theater,
	s.movie_seat, p.pay_num, p.movie_price, p.movie_price
	FROM TICKETINFO t , SEAT s , PAYMENT p
	WHERE t.MOVIE_CODE = (SELECT movie_code FROM payment
		WHERE mem_code = (SELECT mem_code FROM members WHERE id = '' AND password = ''))
	AND p.mem_code = (SELECT mem_code FROM members WHERE id = '' AND password = '');


-- 전화번호로 결제내역 조회
SELECT t.movie_name, t.movie_date, t.movie_time, t.movie_theater,
	s.movie_seat, p.pay_num, p.movie_price, p.movie_price
	FROM TICKETINFO t , SEAT s , PAYMENT p
	WHERE t.MOVIE_CODE = (SELECT movie_code FROM payment
		WHERE mem_code = (SELECT mem_code FROM members WHERE tel = ''))
		AND p.mem_code = (SELECT mem_code FROM members WHERE tel = '');

	
	
-- 예매취소 ----------------------------
DELETE FROM payment WHERE mem_code = (SELECT mem_code FROM members WHERE name = '' AND id = '');



-- 데이터 삭제할때 fk로 묶여있으면 아래 코드 이용해서 자식테이블까지 같이 삭제가능
CONSTRAINT pcode_fk FOREIGN KEY (pcode)
	REFERENCES product#(pcode) ON DELETE CASCADE
-- fk 옵션 on delete cascade :
	-- 부모테이블 참조값이 삭제될때, 참조하는 자식테이블 row가 삭제



-- 시험용 데이터 insert -> 나중에 삭제후 진행 예정----------------------------------------------------------
INSERT INTO SEAT (movie_theater, movie_code, MOVIE_SEAT)
	VALUES ('5층 1관', '651011020', 'A4');

INSERT INTO members (mem_code, name, id, password, email, tel) 
	VALUES ('1', '윈터', 'winter', 'espa', 'winter@naver.com', '01012345678');

INSERT INTO payment (pay_code, mem_code, MOVIE_CODE, PAY_TIME, pay_num, movie_price, pay_price)
	VALUES ('123', '1', '651011020', '2021-09-05', '2', '12000', '24000');

INSERT INTO payment (pay_code, mem_code, MOVIE_CODE, PAY_TIME, pay_num, movie_price, pay_price)
	VALUES ('124', '1', '695020900', '2021-09-05', '1', '11000', '11000');

INSERT INTO payment (pay_code, mem_code, MOVIE_CODE, PAY_TIME, pay_num, movie_price, pay_price)
	VALUES ('456', '2', '651011020', '2021-09-05', '3', '12000', '36000');


-- 연습장--------------------------------------------------------------------------------------------
SELECT * FROM TICKETINFO;
SELECT * FROM PAYMENT;
SELECT * FROM MOVIEINFO;

/*
4. 예매취소시 한사람이 여러개의 영화를 예매한 상황이라면 그중 선택해서 예매를 취소해야한다. -> 구현방법 찾기
 	ㄴ 해당 사람이 예매한 영화목록 불러오기(결제코드, 영화제목, 날짜, 시간, 결제시간)
 	ㄴ 취소할 영화를 입력받으면 해당되는 행을 찾아 삭제 -> 입력받을 방법 찾기
 */
DELETE FROM payment WHERE pay_code = '';

-- 5. 값이 두개가 나왔고 이 값을 or 로 진행시키고 싶으면 어떻게 해야할까?
SELECT movie_code FROM payment
	WHERE mem_code = (SELECT mem_code FROM members WHERE name = '윈터' AND id = 'winter');
	
SELECT p.pay_code, t.movie_name, t.movie_date, t.movie_time, p.pay_time, t.movie_code FROM PAYMENT p, TICKETINFO t WHERE t.movie_code = '651011020' OR t.movie_code = '695020900';










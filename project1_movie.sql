-- 회원정보, 결제정보, 영화정보, 좌석 테이블 생성 -----------------------

CREATE TABLE MEMBERS (
mem_code char(6) PRIMARY KEY,			-- 회원코드
name varchar2(20) NOT NULL,				-- 이름
id varchar2(20) NOT NULL,				-- 아이디
password varchar2(20) NOT NULL,			-- 비밀번호
email varchar2(20),						-- 이메일
tel varchar2(20)						-- 전화번호
);

CREATE TABLE PAYMENT (
pay_code varchar2(20) PRIMARY KEY,		-- 결제코드
mem_code char(6) NOT NULL,				-- 회원코드
movie_code number(6) NOT NULL,			-- 영화코드
pay_time DATE NOT NULL					-- 결제시간
);

--CREATE TABLE MOVIEINFO (
--movie_code char(10) PRIMARY KEY,		-- 영화코드
--movie_name varchar2(20) NOT NULL,		-- 영화제목   
--movie_date DATE NOT NULL,				-- 상영날짜
--movie_time varchar2(20) NOT NULL,		-- 영화시간
--movie_theater varchar2(20) NOT NULL,	-- 영화 상영관
--run_time varchar2(10) NOT NULL,			-- 영화 상영시간
--movie_price number(6) NOT NULL			-- 영화가격
--);

CREATE TABLE SEAT (
movie_theater varchar2(20)NOT NULL, 	-- 영화 상영관
movie_code char(10) NOT NULL,			-- 영화코드
movie_seat varchar2(20) NOT NULL		-- 영화 좌석
);

-- 영화코드값 바꾸고 좌석테이블에 pk 변경하기 -> 두테이블에서 pk를 같은값 써도 되는가?

SELECT * FROM MEMBERS;
SELECT * FROM payment;
SELECT * FROM movieinfo;
SELECT * FROM seat;

DROP TABLE members;
DROP TABLE payment;
--DROP TABLE movieinfo;
DROP TABLE seat;


-- 예매내역 조회 select -----------
SELECT mem_code FROM members WHERE name = '' AND id = '';

SELECT movie_code FROM payment
	WHERE mem_code = (SELECT mem_code FROM members WHERE name = '' AND id = '');

SELECT * FROM movieinfo
	WHERE movie_code = (SELECT pay_code FROM payment
	WHERE mem_code = (SELECT mem_code FROM members WHERE name = '' AND id = ''));



SELECT movie_code FROM payment WHERE pay_code = '';

SELECT * FROM movieinfo WHERE movie_code = (SELECT movie_code FROM payment WHERE pay_code = '');

-- 예매취소 ----------------------------
DELETE FROM payment WHERE mem_code = (SELECT mem_code FROM members WHERE name = '' AND id = '');













-- 영화목록(9.6) --------------------------------------------------------

INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('011020', '싱크홀', '2021-09-06', '10시 20분', '5층 1관', '114분', 12000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('011500', '싱크홀', '2021-09-06', '15시 00분', '5층 1관', '114분', 12000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('011940', '싱크홀', '2021-09-06', '19시 40분', '5층 1관', '114분', 12000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('011140', '싱크홀', '2021-09-06', '11시 40분', '7층 3관', '114분', 12000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('011620', '싱크홀', '2021-09-06', '16시 20분', '7층 3관', '114분', 12000);

INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('020900', '인질', '2021-09-06', '09시 00분', '9층 5관', '94분', 11000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('021300', '인질', '2021-09-06', '13시 00분', '9층 5관', '94분', 11000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('021700', '인질', '2021-09-06', '17시 00분', '9층 5관', '94분', 11000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('021000', '인질', '2021-09-06', '10시 00분', '9층 6관', '94분', 11000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('021600', '인질', '2021-09-06', '16시 00분', '9층 6관', '94분', 11000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('022000', '인질', '2021-09-06', '20시 00분', '9층 6관', '94분', 11000);

INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('030940', '모가디슈', '2021-09-06', '09시 40분', '5층 2관', '121분', 13000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('031945', '모가디슈', '2021-09-06', '19시 45분', '5층 2관', '121분', 13000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('031620', '모가디슈', '2021-09-06', '16시 20분', '7층 4관', '121분', 13000);

INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('040920', '올드', '2021-09-06', '09시 20분', '7층 4관', '108분', 11500);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('041405', '올드', '2021-09-06', '14시 05분', '7층 4관', '108분', 11500);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('041850', '올드', '2021-09-06', '18시 50분', '7층 4관', '108분', 11500);

INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('050920', '프리가이', '2021-09-06', '09시 20분', '7층 3관', '115분', 12500);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('051135', '프리가이', '2021-09-06', '15시 35분', '7층 3관', '115분', 12500);

-- 요일별 반복 (9.7)---------------------------------------------------------

INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('011020', '싱크홀', '2021-09-07', '10시 20분', '5층 1관', '114분', 12000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('011500', '싱크홀', '2021-09-07', '15시 00분', '5층 1관', '114분', 12000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('011940', '싱크홀', '2021-09-07', '19시 40분', '5층 1관', '114분', 12000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('011140', '싱크홀', '2021-09-07', '11시 40분', '7층 3관', '114분', 12000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('011620', '싱크홀', '2021-09-07', '16시 20분', '7층 3관', '114분', 12000);

INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('020900', '인질', '2021-09-07', '09시 00분', '9층 5관', '94분', 11000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('021300', '인질', '2021-09-07', '13시 00분', '9층 5관', '94분', 11000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('021700', '인질', '2021-09-07', '17시 00분', '9층 5관', '94분', 11000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('021000', '인질', '2021-09-07', '10시 00분', '9층 6관', '94분', 11000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('021600', '인질', '2021-09-07', '16시 00분', '9층 6관', '94분', 11000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('022000', '인질', '2021-09-07', '20시 00분', '9층 6관', '94분', 11000);

INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('030940', '모가디슈', '2021-09-07', '09시 40분', '5층 2관', '121분', 13000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('031945', '모가디슈', '2021-09-07', '19시 45분', '5층 2관', '121분', 13000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('031620', '모가디슈', '2021-09-07', '16시 20분', '7층 4관', '121분', 13000);

INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('040920', '올드', '2021-09-07', '09시 20분', '7층 4관', '108분', 11500);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('041405', '올드', '2021-09-07', '14시 05분', '7층 4관', '108분', 11500);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('041850', '올드', '2021-09-07', '18시 50분', '7층 4관', '108분', 11500);

INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('050920', '프리가이', '2021-09-07', '09시 20분', '7층 3관', '115분', 12500);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('051135', '프리가이', '2021-09-07', '15시 35분', '7층 3관', '115분', 12500);

-- 요일별 반복 (9.8)---------------------------------------------------------

INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('011020', '싱크홀', '2021-09-08', '10시 20분', '5층 1관', '114분', 12000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('011500', '싱크홀', '2021-09-08', '15시 00분', '5층 1관', '114분', 12000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('011940', '싱크홀', '2021-09-08', '19시 40분', '5층 1관', '114분', 12000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('011140', '싱크홀', '2021-09-08', '11시 40분', '7층 3관', '114분', 12000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('011620', '싱크홀', '2021-09-08', '16시 20분', '7층 3관', '114분', 12000);

INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('020900', '인질', '2021-09-08', '09시 00분', '9층 5관', '94분', 11000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('021300', '인질', '2021-09-08', '13시 00분', '9층 5관', '94분', 11000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('021700', '인질', '2021-09-08', '17시 00분', '9층 5관', '94분', 11000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('021000', '인질', '2021-09-08', '10시 00분', '9층 6관', '94분', 11000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('021600', '인질', '2021-09-08', '16시 00분', '9층 6관', '94분', 11000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('022000', '인질', '2021-09-08', '20시 00분', '9층 6관', '94분', 11000);

INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('030940', '모가디슈', '2021-09-08', '09시 40분', '5층 2관', '121분', 13000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('031945', '모가디슈', '2021-09-08', '19시 45분', '5층 2관', '121분', 13000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('031620', '모가디슈', '2021-09-08', '16시 20분', '7층 4관', '121분', 13000);

INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('040920', '올드', '2021-09-08', '09시 20분', '7층 4관', '108분', 11500);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('041405', '올드', '2021-09-08', '14시 05분', '7층 4관', '108분', 11500);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('041850', '올드', '2021-09-08', '18시 50분', '7층 4관', '108분', 11500);

INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('050920', '프리가이', '2021-09-08', '09시 20분', '7층 3관', '115분', 12500);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('051135', '프리가이', '2021-09-08', '15시 35분', '7층 3관', '115분', 12500);

-- 요일별 반복 (9.9)---------------------------------------------------------

INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('011020', '싱크홀', '2021-09-09', '10시 20분', '5층 1관', '114분', 12000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('011500', '싱크홀', '2021-09-09', '15시 00분', '5층 1관', '114분', 12000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('011940', '싱크홀', '2021-09-09', '19시 40분', '5층 1관', '114분', 12000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('011140', '싱크홀', '2021-09-09', '11시 40분', '7층 3관', '114분', 12000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('011620', '싱크홀', '2021-09-09', '16시 20분', '7층 3관', '114분', 12000);

INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('020900', '인질', '2021-09-09', '09시 00분', '9층 5관', '94분', 11000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('021300', '인질', '2021-09-09', '13시 00분', '9층 5관', '94분', 11000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('021700', '인질', '2021-09-09', '17시 00분', '9층 5관', '94분', 11000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('021000', '인질', '2021-09-09', '10시 00분', '9층 6관', '94분', 11000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('021600', '인질', '2021-09-09', '16시 00분', '9층 6관', '94분', 11000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('022000', '인질', '2021-09-09', '20시 00분', '9층 6관', '94분', 11000);

INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('030940', '모가디슈', '2021-09-09', '09시 40분', '5층 2관', '121분', 13000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('031945', '모가디슈', '2021-09-09', '19시 45분', '5층 2관', '121분', 13000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('031620', '모가디슈', '2021-09-09', '16시 20분', '7층 4관', '121분', 13000);

INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('040920', '올드', '2021-09-09', '09시 20분', '7층 4관', '108분', 11500);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('041405', '올드', '2021-09-09', '14시 05분', '7층 4관', '108분', 11500);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('041850', '올드', '2021-09-09', '18시 50분', '7층 4관', '108분', 11500);

INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('050920', '프리가이', '2021-09-09', '09시 20분', '7층 3관', '115분', 12500);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('051135', '프리가이', '2021-09-09', '15시 35분', '7층 3관', '115분', 12500);






























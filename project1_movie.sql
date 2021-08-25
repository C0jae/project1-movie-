/*
 ��������
 1. fk �������� -> ���δٸ� ���̺��� �����÷����� �����ִ°� ������ ���� fk�� ������ �־�� �ϴ°�?
 2. pay_price -> pay_num * movie_price ���� �̿��ؼ� insert�� �����ұ�? -> �ȵǸ� insert���� null�� �ϰ� �߰��� update �ؾ��ϳ�?
 3. �������� ��ȸ�ϴ� �ڵ� ���߸��� ������?
 4. ������ҽ� �ѻ���� �������� ��ȭ�� ������ ��Ȳ�̶�� ���� �����ؼ� ���Ÿ� ����ؾ��Ѵ�. -> ������� ã��
 	�� �ش� ����� ������ ��ȭ��� �ҷ�����(��ȭ����, ��¥, �ð�)
 	�� ����� ��ȭ�� �Է¹����� �ش�Ǵ� ���� ã�� ���� -> �Է¹��� ��� ã��
 */


-- ���̺� ���� ------------------------------------------------------------------------------------------------------

-- ȸ������
CREATE TABLE MEMBERS (
mem_code char(6) PRIMARY KEY,			-- ȸ���ڵ�	(pk)
name varchar2(20) NOT NULL,				-- �̸�
id varchar2(20) NOT NULL,				-- ���̵�
password varchar2(20) NOT NULL,			-- ��й�ȣ
email varchar2(40),						-- �̸���
tel varchar2(20)						-- ��ȭ��ȣ
);

-- ��������
CREATE TABLE PAYMENT (
pay_code varchar2(20) PRIMARY KEY,		-- �����ڵ�	(pk)
mem_code char(6) NOT NULL,				-- ȸ���ڵ�	(fk)
movie_code char(10) NOT NULL,			-- ��ȭ�ڵ�	(fk)
pay_time DATE NOT NULL,					-- �����ð�
pay_num number(3) NOT NULL,				-- �����ο���
movie_price number(6) NOT NULL,			-- ��ȭ �ݾ�
pay_price number(10) NOT NULL			-- �Ѱ����ݾ�(movie_price * pay_num)
);

-- �¼�����
CREATE TABLE SEAT (
movie_theater varchar2(20)NOT NULL, 	-- ��ȭ �󿵰�
movie_code char(10) NOT NULL,			-- ��ȭ�ڵ�	(fk)
movie_seat varchar2(20) NOT NULL		-- ��ȭ �¼�
);

-- ��ȭ����
CREATE TABLE MOVIEINFO (
movie_num char(5) PRIMARY KEY,			-- ��ȭ��ȣ	(pk)
movie_name varchar2(20) NOT NULL,		-- ��ȭ����	(pk)
run_time varchar2(10) NOT NULL,			-- ��ȭ �󿵽ð�
movie_genre varchar2(20) NOT NULL,		-- ��ȭ �帣 
playdate DATE NOT NULL,					-- ��ȭ������
nation varchar2(20) NOT NULL,			-- ����
movie_rating varchar2(20) NOT NULL		-- ������
);

-- ��ȭ�� ������ -> ������ �ڷ� ��������
CREATE TABLE MOVIESCHEDULE (
movie_name varchar2(20) PRIMARY KEY,	-- ��ȭ����	(pk)
6 char(2),								-- 6��
7 char(2),								-- 7��
8 char(2),								-- 8��
9 char(2),								-- 9��
10 char(2),								-- 10��
11 char(2),								-- 11��
12 char(2)								-- 12��
);

-- ���Ϻ� ��ȭ �󿵰�ȹ -> ������ �ڷ� ��������
CREATE TABLE TICKETINFO (
movie_code char(10) PRIMARY KEY,		-- ��ȭ�ڵ�	(pk)
movie_name varchar2(20) NOT NULL,		-- ��ȭ����   (fk)
movie_date DATE NOT NULL,				-- �󿵳�¥
movie_time varchar2(20) NOT NULL,		-- ��ȭ�ð�
movie_theater varchar2(20) NOT NULL,	-- ��ȭ �󿵰�
movie_price number(6) NOT NULL			-- ��ȭ����
);

-- ���̺� ���� -end-------------------------------------------------------------------------------------------------------



-- movieinfo ���̺� ���� insert------------------------------------------------------------------------------------------
INSERT INTO MOVIEINFO(movie_num ,movie_name,run_time,movie_genre,
	PLAYDATE,NATION,MOVIE_RATING)
	VALUES('1', '�𰡵�', '121', '�׼�,���','2021-07-28','�ѱ�','15��');
INSERT INTO MOVIEINFO(movie_num ,movie_name,run_time,movie_genre,
	PLAYDATE,NATION,MOVIE_RATING)
	VALUES('2', '����', '94', '�׼�,������','2021-08-18','�ѱ�','15��');
INSERT INTO MOVIEINFO(movie_num ,movie_name,run_time,movie_genre,
	PLAYDATE,NATION,MOVIE_RATING)
	VALUES('3', '��ũȦ', '113', '�ڹ̵�','2021-08-11','�ѱ�','12��');
INSERT INTO MOVIEINFO(movie_num ,movie_name,run_time,movie_genre,
	PLAYDATE,NATION,MOVIE_RATING)
	VALUES('4', '��������', '115', '�׼�,��庥��','2021-08-11','�̱�','12��');
INSERT INTO MOVIEINFO(movie_num ,movie_name,run_time,movie_genre,
	PLAYDATE,NATION,MOVIE_RATING)
	VALUES('5', '�õ�', '108', '����,������','2021-08-18','�̱�','12��');

-- movieinfo insert -end---------------------------------------------------------------------------------------------



-- ���̵� ���Կ��� Ȯ��
SELECT * FROM members WHERE id = '' AND password = '';

	
-- �����ڵ�� ���ų��� ��ȸ
SELECT t.movie_name, t.movie_date, t.movie_time, t.movie_theater,
s.movie_seat, p.pay_num, p.movie_price, p.movie_price
	FROM TICKETINFO t , SEAT s , PAYMENT p
	WHERE t.MOVIE_CODE = (SELECT movie_code FROM payment WHERE pay_code = '')
	AND p.pay_code = '';
	

-- �̸� �� ���̵�� �������� ��ȸ
SELECT t.movie_name, t.movie_date, t.movie_time, t.movie_theater, s.movie_seat, p.pay_num, p.movie_price, p.pay_price
	FROM TICKETINFO t , SEAT s , PAYMENT p WHERE t.MOVIE_CODE = (SELECT movie_code FROM payment
		WHERE mem_code = (SELECT mem_code FROM members WHERE name = '' AND id = ''))
	AND p.mem_code = (SELECT mem_code FROM members WHERE name = '' AND id = '') ;



-- �̸� �� ��й�ȣ�� �������� ��ȸ
SELECT t.movie_name, t.movie_date, t.movie_time, t.movie_theater,
	s.movie_seat, p.pay_num, p.movie_price, p.movie_price
	FROM TICKETINFO t , SEAT s , PAYMENT p
	WHERE t.MOVIE_CODE = (SELECT movie_code FROM payment
		WHERE mem_code = (SELECT mem_code FROM members WHERE id = '' AND password = ''))
	AND p.mem_code = (SELECT mem_code FROM members WHERE id = '' AND password = '');


-- ��ȭ��ȣ�� �������� ��ȸ
SELECT t.movie_name, t.movie_date, t.movie_time, t.movie_theater,
	s.movie_seat, p.pay_num, p.movie_price, p.movie_price
	FROM TICKETINFO t , SEAT s , PAYMENT p
	WHERE t.MOVIE_CODE = (SELECT movie_code FROM payment
		WHERE mem_code = (SELECT mem_code FROM members WHERE tel = ''))
		AND p.mem_code = (SELECT mem_code FROM members WHERE tel = '');

	
	
-- ������� ----------------------------
DELETE FROM payment WHERE mem_code = (SELECT mem_code FROM members WHERE name = '' AND id = '');



-- ������ �����Ҷ� fk�� ���������� �Ʒ� �ڵ� �̿��ؼ� �ڽ����̺���� ���� ��������
CONSTRAINT pcode_fk FOREIGN KEY (pcode)
	REFERENCES product#(pcode) ON DELETE CASCADE
-- fk �ɼ� on delete cascade :
	-- �θ����̺� �������� �����ɶ�, �����ϴ� �ڽ����̺� row�� ����



-- ����� ������ insert -> ���߿� ������ ���� ����----------------------------------------------------------
INSERT INTO SEAT (movie_theater, movie_code, MOVIE_SEAT)
	VALUES ('5�� 1��', '651011020', 'A4');

INSERT INTO members (mem_code, name, id, password, email, tel) 
	VALUES ('1', '����', 'winter', 'espa', 'winter@naver.com', '01012345678');

INSERT INTO payment (pay_code, mem_code, MOVIE_CODE, PAY_TIME, pay_num, movie_price, pay_price)
	VALUES ('123', '1', '651011020', '2021-09-05', '2', '12000', '24000');

INSERT INTO payment (pay_code, mem_code, MOVIE_CODE, PAY_TIME, pay_num, movie_price, pay_price)
	VALUES ('124', '1', '695020900', '2021-09-05', '1', '11000', '11000');

INSERT INTO payment (pay_code, mem_code, MOVIE_CODE, PAY_TIME, pay_num, movie_price, pay_price)
	VALUES ('456', '2', '651011020', '2021-09-05', '3', '12000', '36000');


-- ������--------------------------------------------------------------------------------------------
SELECT * FROM TICKETINFO;
SELECT * FROM PAYMENT;
SELECT * FROM MOVIEINFO;

/*
4. ������ҽ� �ѻ���� �������� ��ȭ�� ������ ��Ȳ�̶�� ���� �����ؼ� ���Ÿ� ����ؾ��Ѵ�. -> ������� ã��
 	�� �ش� ����� ������ ��ȭ��� �ҷ�����(�����ڵ�, ��ȭ����, ��¥, �ð�, �����ð�)
 	�� ����� ��ȭ�� �Է¹����� �ش�Ǵ� ���� ã�� ���� -> �Է¹��� ��� ã��
 */
DELETE FROM payment WHERE pay_code = '';

-- 5. ���� �ΰ��� ���԰� �� ���� or �� �����Ű�� ������ ��� �ؾ��ұ�?
SELECT movie_code FROM payment
	WHERE mem_code = (SELECT mem_code FROM members WHERE name = '����' AND id = 'winter');
	
SELECT p.pay_code, t.movie_name, t.movie_date, t.movie_time, p.pay_time, t.movie_code FROM PAYMENT p, TICKETINFO t WHERE t.movie_code = '651011020' OR t.movie_code = '695020900';










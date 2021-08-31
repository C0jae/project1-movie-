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
DROP TABLE members;
DROP TABLE seat;
DROP TABLE movieinfo;
DROP TABLE payment;
DROP TABLE TICKETINFO ;
-- ȸ������
CREATE TABLE MEMBERS (
mem_code varchar2(10) PRIMARY KEY,		-- ȸ���ڵ�	pk
name varchar2(20) NOT NULL,				-- �̸�
id varchar2(30) NOT NULL,				-- ���̵�
password varchar2(30) NOT NULL,			-- ��й�ȣ
email varchar2(40),						-- �̸���
tel varchar2(20)						-- ��ȭ��ȣ
);

CREATE SEQUENCE mem_code;

-- ��ȭ����
CREATE TABLE MOVIEINFO (
movie_num varchar2(10) NOT null,		-- ��ȭ��ȣ	
movie_name varchar2(20) PRIMARY KEY,	-- ��ȭ����	pk
run_time varchar2(10) NOT NULL,			-- ��ȭ �󿵽ð�
movie_genre varchar2(20) NOT NULL,		-- ��ȭ �帣 
playdate DATE NOT NULL,					-- ��ȭ������
nation varchar2(20) NOT NULL,			-- ����
movie_rating varchar2(20) NOT NULL		-- ������
);

-- ���Ϻ� ��ȭ �󿵰�ȹ -> ������ �ڷ� ��������
CREATE TABLE TICKETINFO (
movie_code varchar2(30) PRIMARY KEY,	-- ��ȭ�ڵ�	pk
movie_name varchar2(20) NOT NULL,		-- ��ȭ����   ��ȭ���� fk
movie_date DATE NOT NULL,				-- �󿵳�¥
movie_time varchar2(20) NOT NULL,		-- ��ȭ�ð�
movie_theater varchar2(20) NOT NULL,	-- ��ȭ �󿵰�
movie_price number(6) NOT NULL			-- ��ȭ����
);

ALTER TABLE ticketinfo ADD PRIMARY KEY (movie_code);
ALTER TABLE ticketinfo ADD FOREIGN KEY (movie_name)
	REFERENCES movieinfo (movie_name);

-- ��������
CREATE TABLE PAYMENT (
pay_code varchar2(20) PRIMARY KEY,		-- �����ڵ�	pk
mem_code varchar2(10) NOT NULL,			-- ȸ���ڵ�	ȸ������ fk
movie_code varchar2(30) NOT NULL,		-- ��ȭ�ڵ�	�󿵰�ȹ fk
pay_time DATE DEFAULT sysdate,			-- �����ð�
pay_num number(3) NOT NULL,				-- �����ο���
movie_price number(6) NOT NULL,			-- ��ȭ �ݾ�
pay_price number(10) NOT NULL,			-- �Ѱ����ݾ�(movie_price * pay_num)
FOREIGN KEY (mem_code) REFERENCES members (mem_code),
FOREIGN KEY (movie_code) REFERENCES ticketinfo (movie_code)
);

CREATE SEQUENCE pay_code;

-- �¼�����
CREATE TABLE SEAT (
mem_code varchar2(10),					-- ȸ���ڵ�	ȸ������ fk
movie_theater varchar2(20)NOT NULL, 	-- ��ȭ �󿵰�
movie_code varchar2(30) NOT NULL,		-- ��ȭ�ڵ�	�󿵰�ȹ fk
movie_seat varchar2(20) NOT NULL,		-- ��ȭ �¼�
FOREIGN KEY (mem_code) REFERENCES members (mem_code),
FOREIGN KEY (movie_code) REFERENCES ticketinfo (movie_code)
);

-- ���̺� ���� -end-------------------------------------------------------------------------------------------------------

DROP TABLE PAYMENT ;
SELECT * FROM PAYMENT p ;
SELECT * FROM TICKETINFO t ;
INSERT INTO PAYMENT (pay_code, mem_code, movie_code, pay_num, movie_price, pay_price) VALUES (pay_code.nextval, mem_code.nextval, 'm0603511020', 2, 12000, 24000);

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
SELECT movie_code FROM PAYMENT WHERE pay_code = '123';

SELECT * FROM TICKETINFO WHERE movie_code IN (SELECT movie_code FROM PAYMENT WHERE pay_code = '123');


-- �̸� �� ���̵�� �������� ��ȸ
SELECT MEM_CODE FROM MEMBERS WHERE name = '����' AND id = 'winter';

SELECT movie_code FROM payment WHERE mem_code = '1';

SELECT movie_code FROM payment WHERE mem_code = (SELECT MEM_CODE FROM MEMBERS WHERE name = '����' AND id = 'winter');
SELECT * FROM PAYMENT p ;
SELECT * FROM MEMBERS m ;
SELECT * FROM TICKETINFO t ;

SELECT * FROM TICKETINFO WHERE movie_code IN (SELECT movie_code FROM PAYMENT WHERE mem_code = (SELECT MEM_CODE FROM MEMBERS WHERE name = '����' AND id = 'winter'));



-- �̸� �� ��й�ȣ�� �������� ��ȸ
SELECT MEM_CODE FROM MEMBERS WHERE id = 'winter' AND password = 'espa';

SELECT movie_code FROM PAYMENT WHERE mem_code = (SELECT MEM_CODE FROM MEMBERS WHERE id = 'winter' AND password = 'espa');

SELECT * FROM TICKETINFO WHERE movie_code IN (SELECT movie_code FROM PAYMENT WHERE mem_code = (SELECT MEM_CODE FROM MEMBERS WHERE id = 'winter' AND password = 'espa'));


-- ��ȭ��ȣ�� �������� ��ȸ
SELECT MEM_CODE FROM MEMBERS WHERE tel = '01012345678';

SELECT movie_code FROM PAYMENT WHERE mem_code = (SELECT MEM_CODE FROM MEMBERS WHERE tel = '01012345678');

SELECT * FROM TICKETINFO WHERE movie_code IN (SELECT movie_code FROM PAYMENT WHERE mem_code = (SELECT MEM_CODE FROM MEMBERS WHERE tel = '01012345678'));


-- ���Ź�ȣ ��ġ���� Ȯ��---------------------
SELECT * FROM payment WHERE movie_code = '651011020' AND mem_code = (SELECT mem_code FROM members WHERE id = 'winter' AND password = 'espa');

-- �󿵰� �� �¼���ȣ ��ȸ--------------------
SELECT movie_code, movie_theater, movie_seat FROM seat WHERE mem_code = (SELECT MEM_CODE FROM MEMBERS WHERE tel = '01012345678') AND movie_code = 'm0603511020';

SELECT movie_time FROM TICKETINFO WHERE movie_date = '2021-09-06' AND MOVIE_NAME = '��ũȦ' AND MOVIE_TIME = '10:20';

	
-- ������� ----------------------------
DELETE FROM payment WHERE mem_code = (SELECT mem_code FROM members WHERE id = '' AND password = '')
	AND movie_code = '';


-- ������ �����Ҷ� fk�� ���������� �Ʒ� �ڵ� �̿��ؼ� �ڽ����̺���� ���� ��������
CONSTRAINT pcode_fk FOREIGN KEY (pcode)
	REFERENCES product#(pcode) ON DELETE CASCADE
-- fk �ɼ� on delete cascade :
	-- �θ����̺� �������� �����ɶ�, �����ϴ� �ڽ����̺� row�� ����


DELETE FROM payment WHERE mem_code =
	(SELECT mem_code FROM members WHERE id = ? AND password = ?)
	AND movie_code = ?
	
DELETE FROM payment WHERE mem_code = (SELECT mem_code FROM members WHERE id = 'cdw0807' AND password = 'lksy0520')
	AND movie_code = 'm0603511020';

DELETE FROM seat WHERE mem_code = (SELECT mem_code FROM members WHERE id = 'cdw0807' AND password = 'lksy0520') AND movie_code = 'm0603511020';
	

SELECT * FROM TICKETINFO WHERE movie_code IN (SELECT movie_code FROM PAYMENT WHERE mem_code = (SELECT MEM_CODE FROM MEMBERS WHERE tel = ?))
	
	
	
	
	
	
	
	
	
	
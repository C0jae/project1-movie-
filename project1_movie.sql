-- ȸ������, ��������, ��ȭ����, �¼� ���̺� ���� -----------------------

CREATE TABLE MEMBERS (
mem_code char(6) PRIMARY KEY,			-- ȸ���ڵ�
name varchar2(20) NOT NULL,				-- �̸�
id varchar2(20) NOT NULL,				-- ���̵�
password varchar2(20) NOT NULL,			-- ��й�ȣ
email varchar2(20),						-- �̸���
tel varchar2(20)						-- ��ȭ��ȣ
);

CREATE TABLE PAYMENT (
pay_code varchar2(20) PRIMARY KEY,		-- �����ڵ�
mem_code char(6) NOT NULL,				-- ȸ���ڵ�
movie_code number(6) NOT NULL,			-- ��ȭ�ڵ�
pay_time DATE NOT NULL					-- �����ð�
);

--CREATE TABLE MOVIEINFO (
--movie_code char(10) PRIMARY KEY,		-- ��ȭ�ڵ�
--movie_name varchar2(20) NOT NULL,		-- ��ȭ����   
--movie_date DATE NOT NULL,				-- �󿵳�¥
--movie_time varchar2(20) NOT NULL,		-- ��ȭ�ð�
--movie_theater varchar2(20) NOT NULL,	-- ��ȭ �󿵰�
--run_time varchar2(10) NOT NULL,			-- ��ȭ �󿵽ð�
--movie_price number(6) NOT NULL			-- ��ȭ����
--);

CREATE TABLE SEAT (
movie_theater varchar2(20)NOT NULL, 	-- ��ȭ �󿵰�
movie_code char(10) NOT NULL,			-- ��ȭ�ڵ�
movie_seat varchar2(20) NOT NULL		-- ��ȭ �¼�
);

-- ��ȭ�ڵ尪 �ٲٰ� �¼����̺� pk �����ϱ� -> �����̺��� pk�� ������ �ᵵ �Ǵ°�?

SELECT * FROM MEMBERS;
SELECT * FROM payment;
SELECT * FROM movieinfo;
SELECT * FROM seat;

DROP TABLE members;
DROP TABLE payment;
--DROP TABLE movieinfo;
DROP TABLE seat;


-- ���ų��� ��ȸ select -----------
SELECT mem_code FROM members WHERE name = '' AND id = '';

SELECT movie_code FROM payment
	WHERE mem_code = (SELECT mem_code FROM members WHERE name = '' AND id = '');

SELECT * FROM movieinfo
	WHERE movie_code = (SELECT pay_code FROM payment
	WHERE mem_code = (SELECT mem_code FROM members WHERE name = '' AND id = ''));



SELECT movie_code FROM payment WHERE pay_code = '';

SELECT * FROM movieinfo WHERE movie_code = (SELECT movie_code FROM payment WHERE pay_code = '');

-- ������� ----------------------------
DELETE FROM payment WHERE mem_code = (SELECT mem_code FROM members WHERE name = '' AND id = '');













-- ��ȭ���(9.6) --------------------------------------------------------

INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('011020', '��ũȦ', '2021-09-06', '10�� 20��', '5�� 1��', '114��', 12000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('011500', '��ũȦ', '2021-09-06', '15�� 00��', '5�� 1��', '114��', 12000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('011940', '��ũȦ', '2021-09-06', '19�� 40��', '5�� 1��', '114��', 12000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('011140', '��ũȦ', '2021-09-06', '11�� 40��', '7�� 3��', '114��', 12000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('011620', '��ũȦ', '2021-09-06', '16�� 20��', '7�� 3��', '114��', 12000);

INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('020900', '����', '2021-09-06', '09�� 00��', '9�� 5��', '94��', 11000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('021300', '����', '2021-09-06', '13�� 00��', '9�� 5��', '94��', 11000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('021700', '����', '2021-09-06', '17�� 00��', '9�� 5��', '94��', 11000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('021000', '����', '2021-09-06', '10�� 00��', '9�� 6��', '94��', 11000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('021600', '����', '2021-09-06', '16�� 00��', '9�� 6��', '94��', 11000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('022000', '����', '2021-09-06', '20�� 00��', '9�� 6��', '94��', 11000);

INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('030940', '�𰡵�', '2021-09-06', '09�� 40��', '5�� 2��', '121��', 13000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('031945', '�𰡵�', '2021-09-06', '19�� 45��', '5�� 2��', '121��', 13000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('031620', '�𰡵�', '2021-09-06', '16�� 20��', '7�� 4��', '121��', 13000);

INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('040920', '�õ�', '2021-09-06', '09�� 20��', '7�� 4��', '108��', 11500);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('041405', '�õ�', '2021-09-06', '14�� 05��', '7�� 4��', '108��', 11500);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('041850', '�õ�', '2021-09-06', '18�� 50��', '7�� 4��', '108��', 11500);

INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('050920', '��������', '2021-09-06', '09�� 20��', '7�� 3��', '115��', 12500);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('051135', '��������', '2021-09-06', '15�� 35��', '7�� 3��', '115��', 12500);

-- ���Ϻ� �ݺ� (9.7)---------------------------------------------------------

INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('011020', '��ũȦ', '2021-09-07', '10�� 20��', '5�� 1��', '114��', 12000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('011500', '��ũȦ', '2021-09-07', '15�� 00��', '5�� 1��', '114��', 12000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('011940', '��ũȦ', '2021-09-07', '19�� 40��', '5�� 1��', '114��', 12000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('011140', '��ũȦ', '2021-09-07', '11�� 40��', '7�� 3��', '114��', 12000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('011620', '��ũȦ', '2021-09-07', '16�� 20��', '7�� 3��', '114��', 12000);

INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('020900', '����', '2021-09-07', '09�� 00��', '9�� 5��', '94��', 11000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('021300', '����', '2021-09-07', '13�� 00��', '9�� 5��', '94��', 11000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('021700', '����', '2021-09-07', '17�� 00��', '9�� 5��', '94��', 11000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('021000', '����', '2021-09-07', '10�� 00��', '9�� 6��', '94��', 11000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('021600', '����', '2021-09-07', '16�� 00��', '9�� 6��', '94��', 11000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('022000', '����', '2021-09-07', '20�� 00��', '9�� 6��', '94��', 11000);

INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('030940', '�𰡵�', '2021-09-07', '09�� 40��', '5�� 2��', '121��', 13000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('031945', '�𰡵�', '2021-09-07', '19�� 45��', '5�� 2��', '121��', 13000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('031620', '�𰡵�', '2021-09-07', '16�� 20��', '7�� 4��', '121��', 13000);

INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('040920', '�õ�', '2021-09-07', '09�� 20��', '7�� 4��', '108��', 11500);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('041405', '�õ�', '2021-09-07', '14�� 05��', '7�� 4��', '108��', 11500);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('041850', '�õ�', '2021-09-07', '18�� 50��', '7�� 4��', '108��', 11500);

INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('050920', '��������', '2021-09-07', '09�� 20��', '7�� 3��', '115��', 12500);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('051135', '��������', '2021-09-07', '15�� 35��', '7�� 3��', '115��', 12500);

-- ���Ϻ� �ݺ� (9.8)---------------------------------------------------------

INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('011020', '��ũȦ', '2021-09-08', '10�� 20��', '5�� 1��', '114��', 12000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('011500', '��ũȦ', '2021-09-08', '15�� 00��', '5�� 1��', '114��', 12000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('011940', '��ũȦ', '2021-09-08', '19�� 40��', '5�� 1��', '114��', 12000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('011140', '��ũȦ', '2021-09-08', '11�� 40��', '7�� 3��', '114��', 12000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('011620', '��ũȦ', '2021-09-08', '16�� 20��', '7�� 3��', '114��', 12000);

INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('020900', '����', '2021-09-08', '09�� 00��', '9�� 5��', '94��', 11000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('021300', '����', '2021-09-08', '13�� 00��', '9�� 5��', '94��', 11000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('021700', '����', '2021-09-08', '17�� 00��', '9�� 5��', '94��', 11000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('021000', '����', '2021-09-08', '10�� 00��', '9�� 6��', '94��', 11000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('021600', '����', '2021-09-08', '16�� 00��', '9�� 6��', '94��', 11000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('022000', '����', '2021-09-08', '20�� 00��', '9�� 6��', '94��', 11000);

INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('030940', '�𰡵�', '2021-09-08', '09�� 40��', '5�� 2��', '121��', 13000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('031945', '�𰡵�', '2021-09-08', '19�� 45��', '5�� 2��', '121��', 13000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('031620', '�𰡵�', '2021-09-08', '16�� 20��', '7�� 4��', '121��', 13000);

INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('040920', '�õ�', '2021-09-08', '09�� 20��', '7�� 4��', '108��', 11500);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('041405', '�õ�', '2021-09-08', '14�� 05��', '7�� 4��', '108��', 11500);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('041850', '�õ�', '2021-09-08', '18�� 50��', '7�� 4��', '108��', 11500);

INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('050920', '��������', '2021-09-08', '09�� 20��', '7�� 3��', '115��', 12500);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('051135', '��������', '2021-09-08', '15�� 35��', '7�� 3��', '115��', 12500);

-- ���Ϻ� �ݺ� (9.9)---------------------------------------------------------

INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('011020', '��ũȦ', '2021-09-09', '10�� 20��', '5�� 1��', '114��', 12000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('011500', '��ũȦ', '2021-09-09', '15�� 00��', '5�� 1��', '114��', 12000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('011940', '��ũȦ', '2021-09-09', '19�� 40��', '5�� 1��', '114��', 12000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('011140', '��ũȦ', '2021-09-09', '11�� 40��', '7�� 3��', '114��', 12000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('011620', '��ũȦ', '2021-09-09', '16�� 20��', '7�� 3��', '114��', 12000);

INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('020900', '����', '2021-09-09', '09�� 00��', '9�� 5��', '94��', 11000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('021300', '����', '2021-09-09', '13�� 00��', '9�� 5��', '94��', 11000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('021700', '����', '2021-09-09', '17�� 00��', '9�� 5��', '94��', 11000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('021000', '����', '2021-09-09', '10�� 00��', '9�� 6��', '94��', 11000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('021600', '����', '2021-09-09', '16�� 00��', '9�� 6��', '94��', 11000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('022000', '����', '2021-09-09', '20�� 00��', '9�� 6��', '94��', 11000);

INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('030940', '�𰡵�', '2021-09-09', '09�� 40��', '5�� 2��', '121��', 13000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('031945', '�𰡵�', '2021-09-09', '19�� 45��', '5�� 2��', '121��', 13000);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('031620', '�𰡵�', '2021-09-09', '16�� 20��', '7�� 4��', '121��', 13000);

INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('040920', '�õ�', '2021-09-09', '09�� 20��', '7�� 4��', '108��', 11500);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('041405', '�õ�', '2021-09-09', '14�� 05��', '7�� 4��', '108��', 11500);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('041850', '�õ�', '2021-09-09', '18�� 50��', '7�� 4��', '108��', 11500);

INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('050920', '��������', '2021-09-09', '09�� 20��', '7�� 3��', '115��', 12500);
INSERT INTO MOVIEINFO (movie_code, movie_name, movie_date, movie_time,
	movie_theater, run_time, movie_price)
	VALUES ('051135', '��������', '2021-09-09', '15�� 35��', '7�� 3��', '115��', 12500);






























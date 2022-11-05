CREATE TABLE COMPANY_DIMENSION
(
  SYMBOL_key        number primary key,
  SYMBOL        VARCHAR2(100 BYTE) not null,
  COMPANY_NAME  VARCHAR2(100 BYTE),
  SECTOR        VARCHAR2(100 BYTE),
  INDUSTRY      VARCHAR2(100 BYTE),
  CITY          VARCHAR2(100 BYTE),
  STATE         VARCHAR2(100 BYTE)
)

CREATE TABLE DATE_DIMENSION
(
  Date_key    varchar(50) primary key ,
  FULL_DATE   DATE   not null,
  YEAR        VARCHAR2(100 BYTE),
  MONTH       VARCHAR2(100 BYTE),
  MONTH_NAME  VARCHAR2(100 BYTE),
  WEEK        VARCHAR2(100 BYTE),
  DAY         VARCHAR2(100 BYTE),
  DAY_NAME    VARCHAR2(100 BYTE),
  QUARTER     VARCHAR2(100 BYTE)
)

CREATE TABLE DAILY_MONITORING_FACT
(
  DATE_key  varchar(50),
  SYMBOL_key     number,
  OPEN       NUMBER(20,2),
  HIGH       NUMBER(20,2),
  LOW        NUMBER(20,2),
  CLOSE      NUMBER(20,2),
  VOLUME     NUMBER(20,2),
  
);

CREATE TABLE GOLD_FACT
(
  DATE_key  varchar(50),
  OPEN       NUMBER(20,2),
  HIGH       NUMBER(20,2),
  LOW        NUMBER(20,2),
  CLOSE      NUMBER(20,2),
  VOLUME     NUMBER(20,2)
)

CREATE TABLE STOCK_MARKET_FACT
(
  SYMBOL_key             number,
  PRICE                  NUMBER(20,2),
  PRICE_EARNING          NUMBER(20,2),
  DIVIDEND_YIELD         NUMBER(20,2),
  EARNING_SHARE          NUMBER(20,2),
  year_high              number(20,2),
  year_low               number(20,2),
  MARKET_CAP             NUMBER(20,2),
  EBITDA                 NUMBER(20,2),
  PRICE_per_sale         NUMBER(20,2),
  price_per_book         number(20,2)
  
  
)
CREATE TABLE SP_Index_FACT
(
  full_date date,
  OPEN       NUMBER(20,2),
  HIGH       NUMBER(20,2),
  LOW        NUMBER(20,2),
  CLOSE      NUMBER(20,2),
  VOLUME     NUMBER(20,2)
)

ALTER TABLE DAILY_MONITORING_FACT ADD (
  CONSTRAINT DATE_FK 
 FOREIGN KEY (DATE_key) 
 REFERENCES DATE_DIMENSION(DATE_key),
  CONSTRAINT SYMB_FK 
 FOREIGN KEY (SYMBOL_key) 
 REFERENCES COMPANY_DIMENSION(symbol_key));

ALTER TABLE GOLD_FACT ADD (
  CONSTRAINT DAT_FK 
 FOREIGN KEY (DATE_key) 
 REFERENCES DATE_DIMENSION(date_key));

ALTER TABLE STOCK_MARKET_FACT ADD (
  CONSTRAINT SYM_FK 
 FOREIGN KEY (SYMBOL_key) 
 REFERENCES COMPANY_DIMENSION(symbol_key));

ALTER TABLE SP_Index_FACT ADD (
  CONSTRAINT dat_FK 
 FOREIGN KEY (full_date) 
 REFERENCES COMPANY_DIMENSION(full_date));




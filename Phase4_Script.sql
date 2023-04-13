purge recyclebin;
SET SERVEROUTPUT on;

DECLARE
   CUSTOMER_table_count number;
   EMPLOYEE_table_count number;
   COFFEE_SHOP_table_count number;
   ORDERS_table_count number;
   MENU_ITEM_table_count number;
   INVENTORY_table_count number;
   ITEM_PREP_REQ_table_count number;
   ITEM_ORDER_BRIDGE_table_count number;
   ORDER_EMPLOYEE_type_table_count number;
   EMPLOYEE_INVENTORY_type_table_count number;
BEGIN
  select count(*)
  into CUSTOMER_table_count from user_tables
  where table_name = 'CUSTOMER';
  
  select count(*)
  into EMPLOYEE_table_count from user_tables
  where table_name = 'EMPLOYEE';
  
  select count(*)
  into COFFEE_SHOP_table_count from user_tables
  where table_name = 'COFFEE_SHOP';
  
  select count(*)
  into ORDERS_table_count from user_tables
  where table_name = 'ORDERS';
  
  select count(*)
  into MENU_ITEM_table_count from user_tables
  where table_name = 'MENU_ITEM';
  
  select count(*)
  into INVENTORY_table_count from user_tables
  where table_name = 'INVENTORY';
  
  select count(*)
  into ITEM_PREP_REQ_table_count from user_tables
  where table_name = 'ITEM_PREP_REQ';
  
  select count(*)
  into ITEM_ORDER_BRIDGE_table_count from user_tables
  where table_name = 'ITEM_ORDER_BRIDGE';
  
  select count(*)
  into ORDER_EMPLOYEE_type_table_count from user_tables
  where table_name = 'ORDER_EMPLOYEE';
  
  select count(*)
  into EMPLOYEE_INVENTORY_type_table_count from user_tables
  where table_name = 'EMPLOYEE_INVENTORY';
  
  if(EMPLOYEE_INVENTORY_type_table_count > 0) THEN EXECUTE IMMEDIATE 'DROP TABLE EMPLOYEE_INVENTORY CASCADE CONSTRAINTS'; END IF;
  
  if(ORDER_EMPLOYEE_type_table_count > 0) THEN EXECUTE IMMEDIATE 'DROP TABLE ORDER_EMPLOYEE CASCADE CONSTRAINTS'; END IF;
  
  if(ITEM_PREP_REQ_table_count > 0) THEN EXECUTE IMMEDIATE 'DROP TABLE ITEM_PREP_REQ CASCADE CONSTRAINTS'; END IF;
  
  if(ITEM_ORDER_BRIDGE_table_count > 0) THEN EXECUTE IMMEDIATE 'DROP TABLE ITEM_ORDER_BRIDGE CASCADE CONSTRAINTS'; END IF;
  
  if(INVENTORY_table_count > 0) THEN EXECUTE IMMEDIATE 'DROP TABLE INVENTORY CASCADE CONSTRAINTS'; END IF;
  
  if(MENU_ITEM_table_count > 0) THEN EXECUTE IMMEDIATE 'DROP TABLE MENU_ITEM CASCADE CONSTRAINTS'; END IF;
  
  if(ORDERS_table_count > 0) THEN EXECUTE IMMEDIATE 'DROP TABLE ORDERS CASCADE CONSTRAINTS'; END IF;
  
  IF(CUSTOMER_table_count > 0) THEN EXECUTE IMMEDIATE 'DROP TABLE CUSTOMER CASCADE CONSTRAINTS'; END IF;
  
  if(EMPLOYEE_table_count > 0) THEN EXECUTE IMMEDIATE 'DROP TABLE EMPLOYEE CASCADE CONSTRAINTS'; END IF;
  
  if(COFFEE_SHOP_table_count > 0) THEN EXECUTE IMMEDIATE 'DROP TABLE COFFEE_SHOP CASCADE CONSTRAINTS'; END IF;
  
  BEGIN
  DBMS_OUTPUT.PUT_LINE('1. ALL TABLES DROPPED');
  END;
  
END;
/

--------------- 2. Existing triggers deletions ---------------



DECLARE

    v_new_customer_addition_trigger_count number;
    v_new_order_placed_update_inventory_trigger_count number;
    v_ORDER_CANCELLATION_TRIGGER_count number;

BEGIN

    --ORDER_CANCELLATION_TRIGGER
    SELECT COUNT(*) INTO v_new_order_placed_update_inventory_trigger_count FROM USER_TRIGGERS 
    WHERE TRIGGER_NAME = 'NEW_ORDER_PLACED_UPDATE_INVENTORY_TRIGGER';
    
    SELECT COUNT(*) INTO v_new_customer_addition_trigger_count FROM USER_TRIGGERS 
    WHERE TRIGGER_NAME = 'NEW_CUSTOMER_ADDITION_TRIGGER';
    
    SELECT COUNT(*) INTO v_ORDER_CANCELLATION_TRIGGER_count FROM USER_TRIGGERS 
    WHERE TRIGGER_NAME = 'ORDER_CANCELLATION_TRIGGER';
    
    IF v_new_order_placed_update_inventory_trigger_count>0 
    THEN
    EXECUTE IMMEDIATE 'DROP TRIGGER NEW_ORDER_PLACED_UPDATE_INVENTORY_TRIGGER';
    END IF;
    
    IF v_new_customer_addition_trigger_count > 0
    THEN
    EXECUTE IMMEDIATE 'DROP TRIGGER NEW_CUSTOMER_ADDITION_TRIGGER';
    END IF;
    
    IF v_ORDER_CANCELLATION_TRIGGER_count > 0
    THEN
    EXECUTE IMMEDIATE 'DROP TRIGGER ORDER_CANCELLATION_TRIGGER';
    END IF;
    
    BEGIN
    DBMS_OUTPUT.PUT_LINE('2. ALL TRIGGERS DROPPED');
    END;

END;
/


--------------- TRIGGERS CREATION DONE ---------------


--------------- 3. SEQUENCES CREATION ---------------

DECLARE

    v_item_id_sequence_count number;
    v_order_id_sequence_count number;
    v_inventory_id_sequence_count number;
    v_customer_id_sequence_count number;
    v_employee_id_sequence_count number;
    v_coffee_shop_id_sequence_count number;
    

BEGIN
    
    SELECT COUNT(*) INTO v_item_id_sequence_count FROM USER_SEQUENCES 
    WHERE SEQUENCE_NAME = 'ITEM_ID_SEQUENCE';
    
    SELECT COUNT(*) INTO v_order_id_sequence_count FROM USER_SEQUENCES 
    WHERE SEQUENCE_NAME = 'ORDER_ID_SEQUENCE';
    
    SELECT COUNT(*) INTO v_inventory_id_sequence_count FROM USER_SEQUENCES 
    WHERE SEQUENCE_NAME = 'INVENTORY_ID_SEQUENCE';
    
    SELECT COUNT(*) INTO v_customer_id_sequence_count FROM USER_SEQUENCES 
    WHERE SEQUENCE_NAME = 'CUSTOMER_ID_SEQUENCE';
    
    SELECT COUNT(*) INTO v_employee_id_sequence_count FROM USER_SEQUENCES 
    WHERE SEQUENCE_NAME = 'EMPLOYEE_ID_SEQUENCE';
    
    SELECT COUNT(*) INTO v_coffee_shop_id_sequence_count FROM USER_SEQUENCES 
    WHERE SEQUENCE_NAME = 'COFFEE_SHOP_ID_SEQUENCE';
    
    
    IF v_item_id_sequence_count > 0
    THEN
    EXECUTE IMMEDIATE 'DROP SEQUENCE ITEM_ID_SEQUENCE';
    END IF;
    
    IF v_order_id_sequence_count > 0 
    THEN
    EXECUTE IMMEDIATE 'DROP SEQUENCE ORDER_ID_SEQUENCE';
    END IF;
    
    IF v_inventory_id_sequence_count > 0
    THEN
    EXECUTE IMMEDIATE 'DROP SEQUENCE INVENTORY_ID_SEQUENCE';
    END IF;
    
    IF v_customer_id_sequence_count > 0
    THEN
    EXECUTE IMMEDIATE 'DROP SEQUENCE CUSTOMER_ID_SEQUENCE';
    END IF;
    
    IF v_employee_id_sequence_count > 0 
    THEN
    EXECUTE IMMEDIATE 'DROP SEQUENCE EMPLOYEE_ID_SEQUENCE';
    END IF;
    
    IF v_coffee_shop_id_sequence_count > 0
    THEN
    EXECUTE IMMEDIATE 'DROP SEQUENCE COFFEE_SHOP_ID_SEQUENCE';
    END IF;
    
    BEGIN
    DBMS_OUTPUT.PUT_LINE('3. ALL SEQUENCES DROPPED');
    END;

END;
/

------------------------ Sequence Creation Done ------------------------

------------------------ 4. Existing Views Deletion ------------------------

DECLARE

    v_view_menu_item_to_customer_view_count number;
    v_current_inventory_status_view_count number;
    v_current_order_and_barista_view_count number;
    v_order_type_view_count number;
    v_item_wise_sale_view_count number;
    v_TOP5_CUSTOMERS_count number;
    v_TOP5_CUSTOMERS_DENSE_count number;
    v_UNUSED_INVENTORY_count NUMBER;

    
BEGIN
    
    SELECT COUNT(*) INTO v_view_menu_item_to_customer_view_count 
    FROM USER_VIEWS 
    WHERE VIEW_NAME = 'VIEW_MENU_ITEM_TO_CUSTOMER';
    
    SELECT COUNT(*) INTO v_current_inventory_status_view_count 
    FROM USER_VIEWS 
    WHERE VIEW_NAME = 'CURRENT_INVENTORY_STATUS_VIEW';
    
    SELECT COUNT(*) INTO v_current_order_and_barista_view_count 
    FROM USER_VIEWS 
    WHERE VIEW_NAME = 'CURRENT_ORDER_AND_BARISTA_VIEW';
    
    SELECT COUNT(*) INTO v_order_type_view_count 
    FROM USER_VIEWS 
    WHERE VIEW_NAME = 'ORDER_TYPE_VIEW';
    
    SELECT COUNT(*) INTO v_item_wise_sale_view_count 
    FROM USER_VIEWS 
    WHERE VIEW_NAME = 'ITEM_WISE_SALE_VIEW';
    
    SELECT COUNT(*) INTO v_TOP5_CUSTOMERS_count 
    FROM USER_VIEWS 
    WHERE VIEW_NAME = 'TOP5_CUSTOMERS';
    
    SELECT COUNT(*) INTO v_TOP5_CUSTOMERS_DENSE_count 
    FROM USER_VIEWS 
    WHERE VIEW_NAME = 'TOP5_CUSTOMERS_DENSE';
    
    SELECT COUNT(*) INTO v_UNUSED_INVENTORY_count 
    FROM USER_VIEWS 
    WHERE VIEW_NAME = 'UNUSED_INVENTORY';
    
    IF v_view_menu_item_to_customer_view_count > 0
    THEN
    EXECUTE IMMEDIATE 'DROP VIEW VIEW_MENU_ITEM_TO_CUSTOMER';
    END IF;
    
    IF v_current_inventory_status_view_count > 0 
    THEN
    EXECUTE IMMEDIATE 'DROP VIEW CURRENT_INVENTORY_STATUS_VIEW';
    END IF;
    
    IF v_current_order_and_barista_view_count > 0
    THEN
    EXECUTE IMMEDIATE 'DROP VIEW CURRENT_ORDER_AND_BARISTA_VIEW';
    END IF;
    
    IF v_order_type_view_count > 0
    THEN
    EXECUTE IMMEDIATE 'DROP VIEW ORDER_TYPE_VIEW';
    END IF;
    
    IF v_item_wise_sale_view_count > 0 
    THEN
    EXECUTE IMMEDIATE 'DROP VIEW ITEM_WISE_SALE_VIEW';
    END IF;
    
    IF v_TOP5_CUSTOMERS_count > 0
    THEN
    EXECUTE IMMEDIATE 'DROP VIEW TOP5_CUSTOMERS';
    END IF;
    
    IF v_TOP5_CUSTOMERS_DENSE_count > 0
    THEN
    EXECUTE IMMEDIATE 'DROP VIEW TOP5_CUSTOMERS_DENSE';
    END IF;
    
    IF v_UNUSED_INVENTORY_count > 0
    THEN
    EXECUTE IMMEDIATE 'DROP VIEW UNUSED_INVENTORY';
    END IF;
    
    BEGIN
    DBMS_OUTPUT.PUT_LINE('4. ALL VIEWS DROPPED');
    END;

END;
/




------------------------ Views Deleted ------------------------


------------------------ TABLES CREATION BELOW ------------------------

CREATE TABLE CUSTOMER (
    CUSTOMER_ID NUMBER PRIMARY KEY,
    CUSTOMER_FNAME VARCHAR2(30) NOT NULL,
    CUSTOMER_LNAME VARCHAR2(30) NOT NULL,
    CITY varchar(30) NOT NULL,
    STATE_NAME varchar2(20) NOT NULL,
    PHONE_NUMBER NUMBER NOT NULL,
    CUSTOMER_CREATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE COFFEE_SHOP (
    COFFEE_SHOP_ID NUMBER PRIMARY KEY,
    PHONE_NUMBER NUMBER NOT NULL,
    STREET VARCHAR2(50) NOT NULL,
    CITY VARCHAR2(30) NOT NULL,
    STATE_NAME VARCHAR2(20) NOT NULL,
    ZIP_CODE NUMBER NOT NULL
);


CREATE TABLE EMPLOYEE (
    EMPLOYEE_ID NUMBER PRIMARY KEY,
    EMPLOYEE_NAME varchar2(20) NOT NULL,
    EMPLOYEE_ROLE VARCHAR2(20) NOT NULL,
    PHONE_NUMBER NUMBER NOT NULL,
    STREET VARCHAR2(50) NOT NULL,
    CITY VARCHAR2(30) NOT NULL,
    STATE_NAME VARCHAR2(20) NOT NULL,
    ZIP_CODE NUMBER NOT NULL,
    EMP_WAGE DECIMAL(10,2) NOT NULL,
    coffee_shop_id int references coffee_shop(coffee_shop_id)
);

CREATE TABLE ORDERS (
    ORDER_ID NUMBER PRIMARY KEY,
    CUSTOMER_ID NUMBER NOT NULL REFERENCES CUSTOMER(CUSTOMER_ID),
    ORDER_TYPE VARCHAR2(10) NOT NULL,
    ORDER_INITIATION_DATE_TIME DATE DEFAULT SYSTIMESTAMP,
    ORDER_STATUS VARCHAR2(20) NOT NULL,
    ORDER_COMPLETION_DATE_TIME DATE DEFAULT (SYSTIMESTAMP + INTERVAL '1' HOUR),
    ORDER_DELIVERY_DATE_TIME DATE DEFAULT (SYSTIMESTAMP + INTERVAL '1' HOUR),
    TOTAL_AMOUNT DECIMAL(10,2) NOT NULL,
    coffee_shop_id int references coffee_shop(coffee_shop_id)
);


CREATE TABLE MENU_ITEM (
    ITEM_ID NUMBER PRIMARY KEY,
    ITEM_NAME varchar(25) NOT NULL,    
    ITEM_DESC VARCHAR2(200) NOT NULL,
    ITEM_PRICE DECIMAL(10,2) NOT NULL,
    coffee_shop_id int references coffee_shop(coffee_shop_id)

);


CREATE TABLE INVENTORY (
    INVENTORY_ID NUMBER PRIMARY KEY,
    INVENTORY_NAME VARCHAR2(20) NOT NULL,
    INVENTORY_QTY DECIMAL(10,2) NOT NULL,
    INVENTORY_STATUS VARCHAR(40) NOT NULL,
    INVENTORY_TYPE VARCHAR2(30) NOT NULL,
    UNIT_OF_MEASUREMENT VARCHAR2(10) NOT NULL,
    coffee_shop_id int references coffee_shop(coffee_shop_id),
    qty_supplied decimal(10,2)

);

CREATE TABLE ITEM_PREP_REQ (
    ITEM_INVENTORY_BRIDGE_ID NUMBER PRIMARY KEY,
    ITEM_ID NUMBER REFERENCES MENU_ITEM(ITEM_ID), 
    INVENTORY_ID NUMBER REFERENCES INVENTORY(INVENTORY_ID),
    QTY_REQUIRED DECIMAL(10,2) NOT NULL,
    inventory_availability varchar(20)
);

CREATE TABLE ORDER_EMPLOYEE (
  ORDER_EMPLOYEE_ID NUMBER PRIMARY KEY,
  ORDER_ID REFERENCES ORDERS(ORDER_ID),
  EMPLOYEE_ID REFERENCES EMPLOYEE(EMPLOYEE_ID)
);

CREATE TABLE EMPLOYEE_INVENTORY (
    EMPLOYEE_INVENTORY_ID NUMBER PRIMARY KEY,
    EMPLOYEE_ID REFERENCES EMPLOYEE(EMPLOYEE_ID),
    INVENTORY_ID REFERENCES INVENTORY(INVENTORY_ID)
);

CREATE TABLE ITEM_ORDER_BRIDGE (
    ITEM_ORDER_BRIDGE_ID NUMBER PRIMARY KEY,
    ITEM_ID REFERENCES MENU_ITEM(ITEM_ID),
    ORDER_ID REFERENCES ORDERS(ORDER_ID),
    QTY_ORDERED NUMBER DEFAULT 1
);

CREATE OR REPLACE PACKAGE INSERT_DATA AS

PROCEDURE INSERT_CUSTOMER_PROC
    (
           v_CUSTOMER_ID IN CUSTOMER.CUSTOMER_ID%TYPE,
           v_CUSTOMER_FNAME IN CUSTOMER.CUSTOMER_FNAME%TYPE,
           V_CUSTOMER_LNAME IN CUSTOMER.CUSTOMER_LNAME%TYPE,
           v_CITY IN CUSTOMER.CITY%TYPE,
           v_STATE_NAME IN CUSTOMER.STATE_NAME%TYPE,
           v_PHONE_NUMBER IN CUSTOMER.PHONE_NUMBER%TYPE,
           v_createdat IN CUSTOMER.CUSTOMER_CREATED_AT%TYPE DEFAULT CURRENT_TIMESTAMP
);

PROCEDURE insert_coffee_shop
    (
       v_coffee_shop_id IN coffee_shop.coffee_shop_ID%TYPE,
       v_phone_number IN coffee_shop.phone_number%TYPE,
       v_street IN coffee_shop.street%TYPE,
       v_city IN coffee_shop.city%TYPE,
       v_state_name IN coffee_shop.state_name%TYPE,
       v_zip_code IN coffee_shop.zip_code%TYPE
    ) ;
    
PROCEDURE insert_employee
    (
           v_employee_id IN employee.employee_id%TYPE,
           v_employee_name IN employee.employee_name%TYPE,
           v_employee_role IN employee.employee_role%TYPE,
           v_phone_number IN employee.phone_number%TYPE,
           v_street IN employee.street%TYPE,
           v_city IN employee.city%TYPE,
           v_state_name IN employee.state_name%TYPE,
           v_zip_code IN employee.zip_code%TYPE,
           v_emp_wage IN employee.emp_wage%TYPE,
           v_coffee_shop_id IN employee.coffee_shop_id%TYPE
    );
    
    
PROCEDURE insert_employee_inventory
    (
           v_employee_inventory_id IN employee_inventory.employee_inventory_id%TYPE,
           v_employee_id IN employee_inventory.employee_id%TYPE,
           v_inventory_id IN employee_inventory.inventory_id%TYPE
    );
    
PROCEDURE insert_order_employee
    (    
           v_order_employee_id IN order_employee.order_employee_id%TYPE,
           v_order_id IN order_employee.order_id%TYPE,
           v_employee_id IN order_employee.employee_id%TYPE
    );
    
PROCEDURE insert_inventory
    (
           v_inventory_id IN inventory.inventory_id%TYPE,
           v_inventory_name IN inventory.inventory_name%TYPE,
           v_inventory_qty inventory.inventory_qty%TYPE,
           v_inventory_status IN inventory.inventory_status%TYPE,
           v_inventory_type IN inventory.inventory_type%TYPE,
           v_unit_of_measurement IN inventory.unit_of_measurement%TYPE,
           v_coffee_shop_id IN inventory.coffee_shop_id%TYPE,
           v_qty_supplied in inventory.qty_supplied%TYPE
    );

PROCEDURE insert_menu_item
    (
           v_item_id IN menu_item.item_id%TYPE,
           v_item_name IN menu_item.item_name%TYPE, 
           v_item_desc IN menu_item.item_desc%TYPE,
           v_item_price IN menu_item.item_price%TYPE,
            v_coffee_shop_id IN orders.coffee_shop_id%TYPE

    );

PROCEDURE insert_orders
    (
           v_order_id IN orders.order_id%TYPE,
           v_customer_id IN orders.customer_id%TYPE,
           v_order_type IN orders.order_type%TYPE,
           v_order_initiation_date_time IN orders.order_initiation_date_time%TYPE,
           v_order_status IN orders.order_status%TYPE,
           v_order_completion_date_time IN orders.order_completion_date_time%TYPE,
           v_order_delivery_date_time IN orders.order_delivery_date_time%TYPE,
           v_total_amount IN orders.total_amount%TYPE,
           v_coffee_shop_id IN orders.coffee_shop_id%TYPE
    );
    
PROCEDURE INSERT_ITEM_PREP_REQ(

    v_item_inventory_bridge_id IN item_prep_req.item_inventory_bridge_id%TYPE,
    v_item_id IN item_prep_req.item_id%TYPE,
    v_inventory_id IN item_prep_req.inventory_id%TYPE,
    v_qty_required IN item_prep_req.qty_required%TYPE,
    v_inventory_availability in item_prep_req.inventory_availability%TYPE
);

PROCEDURE INSERT_ITEM_ORDER_BRIDGE(

    v_item_order_bridge_id IN ITEM_ORDER_BRIDGE.item_order_bridge_id%TYPE,
    v_item_id IN ITEM_ORDER_BRIDGE.item_id%TYPE,
    v_order_id IN ITEM_ORDER_BRIDGE.order_id%TYPE,
    v_qty_ordered IN ITEM_ORDER_BRIDGE.qty_ordered%TYPE
);

END INSERT_DATA;
/


CREATE OR REPLACE PACKAGE BODY INSERT_DATA AS

PROCEDURE INSERT_CUSTOMER_PROC
    (
           v_CUSTOMER_ID IN CUSTOMER.CUSTOMER_ID%TYPE,
           v_CUSTOMER_FNAME IN CUSTOMER.CUSTOMER_FNAME%TYPE,
           V_CUSTOMER_LNAME IN CUSTOMER.CUSTOMER_LNAME%TYPE,
           v_CITY IN CUSTOMER.CITY%TYPE,
           v_STATE_NAME IN CUSTOMER.STATE_NAME%TYPE,
           v_PHONE_NUMBER IN CUSTOMER.PHONE_NUMBER%TYPE,
           v_createdat IN CUSTOMER.CUSTOMER_CREATED_AT%TYPE DEFAULT CURRENT_TIMESTAMP
)
    IS
    BEGIN
      INSERT INTO CUSTOMER(CUSTOMER_ID, CUSTOMER_FNAME, CUSTOMER_LNAME, CITY, STATE_NAME, PHONE_NUMBER, CUSTOMER_CREATED_AT)
      VALUES (V_CUSTOMER_ID, v_CUSTOMER_FNAME, v_CUSTOMER_LNAME, v_CITY, v_STATE_NAME, v_PHONE_NUMBER, v_createdat);
    END;
    
PROCEDURE insert_employee
    (
           v_employee_id IN employee.employee_id%TYPE,
           v_employee_name IN employee.employee_name%TYPE,
           v_employee_role IN employee.employee_role%TYPE,
           v_phone_number IN employee.phone_number%TYPE,
           v_street IN employee.street%TYPE,
           v_city IN employee.city%TYPE,
           v_state_name IN employee.state_name%TYPE,
           v_zip_code IN employee.zip_code%TYPE,
           v_emp_wage IN employee.emp_wage%TYPE,
           v_coffee_shop_id IN employee.coffee_shop_id%TYPE
    )
    IS
    BEGIN
      INSERT INTO employee (employee_id, employee_name, employee_role, phone_number, street, city, state_name, zip_code, emp_wage, coffee_shop_id)
      VALUES (v_employee_id, v_employee_name, v_employee_role, v_phone_number, v_street, v_city, v_state_name, v_zip_code, v_emp_wage, v_coffee_shop_id);
    END;
    
PROCEDURE insert_coffee_shop
    (
       v_coffee_shop_id IN coffee_shop.coffee_shop_ID%TYPE,
       v_phone_number IN coffee_shop.phone_number%TYPE,
       v_street IN coffee_shop.street%TYPE,
       v_city IN coffee_shop.city%TYPE,
       v_state_name IN coffee_shop.state_name%TYPE,
       v_zip_code IN coffee_shop.zip_code%TYPE
    )   
    IS
    BEGIN
        INSERT INTO coffee_shop VALUES(v_coffee_shop_id, v_phone_number, v_street, v_city, v_state_name, v_zip_code);
    END;

PROCEDURE insert_employee_inventory
    (
           v_employee_inventory_id IN employee_inventory.employee_inventory_id%TYPE,
           v_employee_id IN employee_inventory.employee_id%TYPE,
           v_inventory_id IN employee_inventory.inventory_id%TYPE
    )
    IS
    BEGIN
      INSERT INTO employee_inventory(employee_inventory_id, employee_id, inventory_id)
      VALUES (v_employee_inventory_id, v_employee_id, v_inventory_id);
    END;
 
PROCEDURE insert_order_employee
    (    
           v_order_employee_id IN order_employee.order_employee_id%TYPE,
           v_order_id IN order_employee.order_id%TYPE,
           v_employee_id IN order_employee.employee_id%TYPE
    )       
    IS
    BEGIN
       INSERT INTO order_employee(order_employee_id, order_id, employee_id) VALUES(v_order_employee_id, v_order_id, v_employee_id);
    END;
    
PROCEDURE insert_inventory
    (
           v_inventory_id IN inventory.inventory_id%TYPE,
           v_inventory_name IN inventory.inventory_name%TYPE,
           v_inventory_qty inventory.inventory_qty%TYPE,
           v_inventory_status IN inventory.inventory_status%TYPE,
           v_inventory_type IN inventory.inventory_type%TYPE,
           v_unit_of_measurement IN inventory.unit_of_measurement%TYPE,
           v_coffee_shop_id IN inventory.coffee_shop_id%TYPE,
           v_qty_supplied in inventory.qty_supplied%TYPE
    )
    IS
    BEGIN
      INSERT INTO inventory(inventory_id, inventory_name, inventory_qty, inventory_status, inventory_type, unit_of_measurement,coffee_shop_id,qty_supplied) 
      VALUES (v_inventory_id, v_inventory_name, v_inventory_qty, v_inventory_status, v_inventory_type, v_unit_of_measurement,v_coffee_shop_id,v_qty_supplied);
    END;

PROCEDURE insert_menu_item
    (
           v_item_id IN menu_item.item_id%TYPE,
           v_item_name IN menu_item.item_name%TYPE, 
           v_item_desc IN menu_item.item_desc%TYPE,
           v_item_price IN menu_item.item_price%TYPE,
           v_coffee_shop_id IN orders.coffee_shop_id%TYPE
    )
    IS
    BEGIN
       INSERT INTO menu_item(item_id, item_name, item_desc, item_price, coffee_shop_id) values(v_item_id, v_item_name, v_item_desc, v_item_price,v_coffee_shop_id );
    END;

PROCEDURE insert_orders
    (
           v_order_id IN orders.order_id%TYPE,
           v_customer_id IN orders.customer_id%TYPE,
           v_order_type IN orders.order_type%TYPE,
           v_ORDER_INITIATION_DATE_TIME IN orders.ORDER_INITIATION_DATE_TIME%TYPE,
           v_order_status IN orders.order_status%TYPE,
           v_order_completion_date_time IN orders.order_completion_date_time%TYPE,
           v_order_delivery_date_time IN orders.order_delivery_date_time%TYPE,
           v_total_amount IN orders.total_amount%TYPE,
           v_coffee_shop_id IN orders.coffee_shop_id%TYPE
    )
    IS
    BEGIN
      INSERT INTO orders(order_id, customer_id, order_type, ORDER_INITIATION_DATE_TIME, order_status, order_completion_date_time,order_delivery_date_time ,total_amount,coffee_shop_id) 
      VALUES (v_order_id, v_customer_id, v_order_type, v_ORDER_INITIATION_DATE_TIME, v_order_status, v_order_completion_date_time, v_order_delivery_date_time,v_total_amount,v_coffee_shop_id );
    END;


PROCEDURE INSERT_ITEM_PREP_REQ(

    v_item_inventory_bridge_id IN item_prep_req.item_inventory_bridge_id%TYPE,
    v_item_id IN item_prep_req.item_id%TYPE,
    v_inventory_id IN item_prep_req.inventory_id%TYPE,
    v_qty_required IN item_prep_req.qty_required%TYPE,
    v_inventory_availability in item_prep_req.inventory_availability%TYPE
)
IS 
BEGIN
INSERT INTO ITEM_PREP_REQ(item_inventory_bridge_id, item_id, inventory_id, qty_required, inventory_availability)
values(v_item_inventory_bridge_id, v_item_id, v_inventory_id, v_qty_required, v_inventory_availability);
END;


PROCEDURE INSERT_ITEM_ORDER_BRIDGE(

    v_item_order_bridge_id IN ITEM_ORDER_BRIDGE.item_order_bridge_id%TYPE,
    v_item_id IN ITEM_ORDER_BRIDGE.item_id%TYPE,
    v_order_id IN ITEM_ORDER_BRIDGE.order_id%TYPE,
    v_qty_ordered IN ITEM_ORDER_BRIDGE.qty_ordered%TYPE
)
IS 
BEGIN
INSERT INTO ITEM_ORDER_BRIDGE(item_order_bridge_id, item_id, order_id, qty_ordered)
values(v_item_order_bridge_id, v_item_id, v_order_id, v_qty_ordered);
END;

END INSERT_DATA;
/



---------------- SEQUENCE CREATION BELOW ----------------

CREATE SEQUENCE item_id_sequence
START WITH 1
INCREMENT BY 1
MINVALUE 1
MAXVALUE 10
NOCYCLE ;

CREATE SEQUENCE order_id_sequence
START WITH 100
INCREMENT BY 1
MINVALUE 1
MAXVALUE 1000000
NOCYCLE ;

CREATE SEQUENCE inventory_id_sequence
START WITH 10
INCREMENT BY 1
MINVALUE 1
MAXVALUE 1000000
NOCYCLE ;

CREATE SEQUENCE customer_id_sequence
START WITH 80000
INCREMENT BY 1
MINVALUE 1
MAXVALUE 1000000
NOCYCLE ;

CREATE SEQUENCE employee_id_sequence
START WITH 1000
INCREMENT BY 1
MINVALUE 1
MAXVALUE 1000000
NOCYCLE ;

CREATE SEQUENCE coffee_shop_id_sequence
START WITH 1
INCREMENT BY 1
MINVALUE 1
MAXVALUE 1000000
NOCYCLE ;


-------------------------- TRGIGGERS DEFINITION BELOW ------------------

CREATE OR REPLACE TRIGGER new_order_placed_update_inventory_trigger     --- when a new order is placed
 AFTER INSERT OR UPDATE ON HARRY.item_order_bridge
 REFERENCING NEW AS new
 FOR EACH ROW
 when (new.order_id > 0)
 DECLARE
     v_req_qty ITEM_PREP_REQ.QTY_REQUIRED%TYPE;
     v_ordered_qty item_order_bridge.QTY_ORDERED%TYPE ;
     v_inventory_qty inventory.INVENTORY_QTY%TYPE ;
     v_item_id item_order_bridge.item_id%TYPE;
     v_inventory_id ITEM_PREP_REQ.inventory_id%TYPE;
     v_order_id item_order_bridge.order_id%TYPE;
 BEGIN
    DBMS_OUTPUT.PUT_LINE('Trigger begins...');
    v_item_id := :new.item_id;
    v_order_id := :new.order_id;
    v_ordered_qty := :new.QTY_ORDERED;
    DBMS_OUTPUT.PUT_LINE(v_order_id);
    DBMS_OUTPUT.PUT_LINE('QTY_ORDERED ' || v_ordered_qty || ', item_id = ' || v_item_id);
    
    
    FOR q in
       ( select QTY_REQUIRED,INVENTORY_ID  into v_req_qty, v_inventory_id
        from ITEM_PREP_REQ
        where item_id =: new.item_id
        and INVENTORY_AVAILABILITY = 'Available')
        loop
        DBMS_OUTPUT.PUT_LINE('QTY_REQUIRED = ' || q.QTY_REQUIRED || ' , ' || ' INVENTORY_ID = ' || q.INVENTORY_ID );
        v_req_qty := q.QTY_REQUIRED;
        v_inventory_id := q.INVENTORY_ID;
        
        select INVENTORY_QTY into v_inventory_qty from inventory where inventory_id = v_inventory_id;
        
        DBMS_OUTPUT.PUT_LINE('total qty : ' || v_ordered_qty*v_req_qty || ', Inventory_QTY : ' || v_inventory_qty );
        
        UPDATE HARRY.inventory SET INVENTORY_QTY = (INVENTORY_QTY - (v_ordered_qty*v_req_qty))
        WHERE inventory_id = v_inventory_id;
                
        if v_ordered_qty*v_req_qty > v_inventory_qty 
        then
        UPDATE HARRY.ITEM_PREP_REQ SET INVENTORY_AVAILABILITY = 'Unavailable'
        WHERE inventory_id = v_inventory_id;
        
        
        UPDATE HARRY.inventory SET INVENTORY_STATUS = 'Unavailable' 
        WHERE inventory_id = v_inventory_id;
        
        ELSIF  v_inventory_qty <= 0
        THEN
        UPDATE HARRY.INVENTORY SET INVENTORY_QTY = 0;
        
        DBMS_OUTPUT.PUT_LINE('Data updated!!');
        
        end if;
    end loop;
    DBMS_OUTPUT.PUT_LINE('Trigger ends...');
 END;
/

CREATE OR REPLACE TRIGGER new_customer_addition_trigger    -- update the item_inventory_bridge table when inventory becomes available or unavailable
 AFTER INSERT OR UPDATE ON customer 
 FOR EACH ROW
 
 DECLARE
     v_customer_fname customer.customer_fname%TYPE;
     v_customer_lname customer.customer_lname%TYPE;
     v_customer_id customer.customer_id%type;
 
 BEGIN
 
   --select customer_id, customer_fname, customer_lname  into v_customer_id, v_customer_fname, v_customer_lname from customer where customer_id =: new.customer_id;         
   
   DBMS_OUTPUT.PUT_LINE('Hey ' || :new.customer_fname ||' ' || :new.customer_lname || ' !');
   DBMS_OUTPUT.PUT_LINE('Welcome to Group 6 Coffee Shop');
   
 END;
/


CREATE OR REPLACE TRIGGER ORDER_CANCELLATION_TRIGGER    -- update the item_inventory_bridge table when an order is cancelled
 AFTER UPDATE ON ORDERS 
 REFERENCING NEW AS new 
 OLD as old
 FOR EACH ROW
 
 DECLARE
 
     v_order_id ORDERS.order_id%TYPE;
     v_order_status ORDERS.order_status%TYPE;
     v_req_qty ITEM_PREP_REQ.QTY_REQUIRED%TYPE;
     v_ordered_qty item_order_bridge.QTY_ORDERED%TYPE ;
     v_item_id item_order_bridge.item_id%TYPE;
     v_inventory_id ITEM_PREP_REQ.inventory_id%TYPE;
     v_inventory_qty INVENTORY.inventory_qty%TYPE;
 
 BEGIN
   DBMS_OUTPUT.PUT_LINE('Trigger begins...');
   
   v_order_id := :new.order_id;
   v_order_status := :old.order_status;
   
   DBMS_OUTPUT.PUT_LINE('statement 1 : order_id = ' ||v_order_id || ', order_staus = ' || v_order_status);
   
   
   FOR q in
       ( select item_id, QTY_ORDERED  into v_item_id, v_ordered_qty
        from HARRY.item_order_bridge
        where order_id = v_order_id)
        loop
        
        DBMS_OUTPUT.PUT_LINE('Statement 2 : item_id = ' || q.item_id ||' , QTY_ORDERED = ' || q.QTY_ORDERED);
        
        FOR i in
           ( select QTY_REQUIRED,INVENTORY_ID  into v_req_qty, v_inventory_id
            from HARRY.ITEM_PREP_REQ
            where item_id = q.item_id)
            loop
                
                DBMS_OUTPUT.PUT_LINE('Statement 3 : QTY_REQUIRED = ' || i.QTY_REQUIRED ||', INVENTORY_ID = ' || i.INVENTORY_ID);
                
                UPDATE HARRY.inventory SET INVENTORY_QTY = (INVENTORY_QTY + (q.QTY_ORDERED*i.QTY_REQUIRED))
                WHERE inventory_id = i.INVENTORY_ID;
                
                select INVENTORY_QTY into v_inventory_qty from HARRY.inventory where inventory_id = i.INVENTORY_ID;
                
                if v_inventory_qty > 0
                then
                UPDATE HARRY.inventory SET INVENTORY_STATUS = 'Available'
                WHERE inventory_id = i.INVENTORY_ID and v_inventory_qty > 0; 
                end if;
        
        end loop;
        DBMS_OUTPUT.PUT_LINE('Data updated!!');
    end loop;
 END;
/



EXEC INSERT_DATA.insert_coffee_shop(coffee_shop_id_sequence.nextval, 6178282828, '120 SouthBay', 'Boston', 'Massachusetts', 02107);

EXEC INSERT_DATA.INSERT_CUSTOMER_PROC(customer_id_sequence.nextval, 'Kelly', 'Key', 'BOSTON', 'MASSACHUSETTS', 8678978743, '02-SEP-2022 13:24:00');
EXEC INSERT_DATA.INSERT_CUSTOMER_PROC(customer_id_sequence.nextval, 'Clark', 'Schroeder', 'CAMBRIDGE', 'MASSACHUSETTS', 8678543563, '01-OCT-2022 11:29:00');
EXEC INSERT_DATA.INSERT_CUSTOMER_PROC(customer_id_sequence.nextval, 'Elvis ', 'Cardenas', 'BOSTON', 'MASSACHUSETTS', 8678976098, '11-NOV-2022 09:45:45');
EXEC INSERT_DATA.INSERT_CUSTOMER_PROC(customer_id_sequence.nextval, 'Rafael ', 'Estes', 'BOSTON', 'MASSACHUSETTS', 8678434563, '12-NOV-2022 10:50:55');
EXEC INSERT_DATA.INSERT_CUSTOMER_PROC(customer_id_sequence.nextval, 'Colin ', 'Lynn', 'LOWELL', 'MASSACHUSETTS', 8678900063, '29-NOV-2022 15:40:30');
EXEC INSERT_DATA.INSERT_CUSTOMER_PROC(customer_id_sequence.nextval, 'JACK', 'SPARROW', 'BOSTON', 'MASSACHUSETTS', 8678976563, '12-DEC-2022 18:30:35');
EXEC INSERT_DATA.INSERT_CUSTOMER_PROC(customer_id_sequence.nextval, 'Ram', 'Singh', 'BOSTON', 'MASSACHUSETTS', 8678978700, '23-DEC-2022  20:22:23');
EXEC INSERT_DATA.INSERT_CUSTOMER_PROC(customer_id_sequence.nextval, 'Ben', 'Deigo', 'CAMBRIDGE', 'MASSACHUSETTS', 8678549993, '1-JAN-2023 13:24:34');
EXEC INSERT_DATA.INSERT_CUSTOMER_PROC(customer_id_sequence.nextval, 'Big ', 'San', 'BOSTON', 'MASSACHUSETTS', 8578976098,'12-JAN-2023 20:56:56');
EXEC INSERT_DATA.INSERT_CUSTOMER_PROC(customer_id_sequence.nextval, 'Paris ', 'Wall', 'BOSTON', 'MASSACHUSETTS', 8978434563, '15-FEB-2023 12:09:09');
EXEC INSERT_DATA.INSERT_CUSTOMER_PROC(customer_id_sequence.nextval, 'Indy ', 'Lynn', 'LOWELL', 'MASSACHUSETTS', 8678980063, '12-MAR-2022 16:56:20');

EXEC INSERT_DATA.insert_employee(employee_id_sequence.nextval, 'Sue Tindale', 'Store_Manager', 8578765439, '3 Mass Ave', 'Boston', 'Massachusetts', 02115, 34,1);
EXEC INSERT_DATA.insert_employee(employee_id_sequence.nextval, 'Kelsey Cameron', 'Inventory_Manager', 8579876543, '43 Alphonsus Street', 'Boston', 'Massachusetts', 02121, 30,1);
EXEC INSERT_DATA.insert_employee(employee_id_sequence.nextval, 'Caldwell Veda', 'Order_Delivery_Emp', 6172563748, '369 Hunter Street', 'Boston', 'Massachusetts', 02120, 20,1);
EXEC INSERT_DATA.insert_employee(employee_id_sequence.nextval, 'Bucky Burnes', 'Barista', 6177777345, '75 Omingo Street', 'Boston', 'Massachusetts', 02113, 26,1);
EXEC INSERT_DATA.insert_employee(employee_id_sequence.nextval, 'Rupert Nickson', 'Barista', 8569855210, '16 Wilmington Street', 'Boston', 'Massachusetts', 02118, 24,1);
EXEC INSERT_DATA.insert_employee(employee_id_sequence.nextval, 'Montery Keel', 'Cashier', 857987442, '6 Brakes Street', 'Cambridge', 'Massachusetts', 02111, 20,1);


EXEC INSERT_DATA.insert_menu_item(item_id_sequence.nextval, 'Nitro Cold Brew', 'Exotic Cold Brew along with Fresh Almond Milk', 8.95, 1);
EXEC INSERT_DATA.insert_menu_item(item_id_sequence.nextval, 'Pumpkin Spice Latte', 'Latte in Fresh Whole Milk with 3 Pumpkin Spice Pumps', 8.95, 1);
EXEC INSERT_DATA.insert_menu_item(item_id_sequence.nextval, 'Caffe Mocha', 'Simply the Best Mocha ever', 9.45, 1);
EXEC INSERT_DATA.insert_menu_item(item_id_sequence.nextval, 'Caffe Americano', 'If American accent has a taste...', 4.50, 1);
EXEC INSERT_DATA.insert_menu_item(item_id_sequence.nextval, 'Java Chip Frappuccino', 'Freshly made Java Chip Frappuccino', 8.95, 1);
EXEC INSERT_DATA.insert_menu_item(item_id_sequence.nextval, 'Signature Hot Chocolate', 'Hot Chocolate in Winter keeps you warm', 7.95, 1);


EXEC INSERT_DATA.insert_inventory(inventory_id_sequence.nextval, 'Whole Milk', 30.00, 'Available', 'Perishable', 'Gallon',1 ,0.00);
EXEC INSERT_DATA.insert_inventory(inventory_id_sequence.nextval, 'Almond Milk', 30.00, 'Available', 'Perishable', 'Gallon',1 ,0.00);
EXEC INSERT_DATA.insert_inventory(inventory_id_sequence.nextval, 'Hazelnut Syrup', 20.00, 'Available', 'Perishable', 'Oz',1, 0.00);
EXEC INSERT_DATA.insert_inventory(inventory_id_sequence.nextval, 'Vanilla Syrup', 20.00, 'Available', 'Perishable', 'Oz',1,0.00);
EXEC INSERT_DATA.insert_inventory(inventory_id_sequence.nextval, 'Cups', 200.00, 'Available', 'Non-Perishable', 'Pieces',1,0.00);
EXEC INSERT_DATA.insert_inventory(inventory_id_sequence.nextval, 'Stirrer', 300.00, 'Available', 'Non-Perishable', 'Pieces',1,0.00);
EXEC INSERT_DATA.insert_inventory(inventory_id_sequence.nextval, 'Pumpkin Spice Syrup', 20.00, 'Available', 'Perishable', 'Oz',1,0.00);
EXEC INSERT_DATA.insert_inventory(inventory_id_sequence.nextval, 'Espresso Coffee', 20.00, 'Available', 'Perishable', 'Gallon',1,0.00);
EXEC INSERT_DATA.insert_inventory(inventory_id_sequence.nextval, 'Chocolate', 20.00, 'Available', 'Perishable', 'Gallon',1,0.00);
EXEC INSERT_DATA.insert_inventory(inventory_id_sequence.nextval, 'Sugar', 30.00, 'Available', 'Perishable', 'Gallon',1, 0.00);
EXEC INSERT_DATA.insert_inventory(inventory_id_sequence.nextval, 'MOCHA Sauce', 178.00, 'Available', 'Perishable', 'Oz',1,0.00);
EXEC INSERT_DATA.insert_inventory(inventory_id_sequence.nextval, 'JAVA Chips', 1000.00, 'Available', 'Perishable', 'Pieces',1,0.00);
EXEC INSERT_DATA.insert_inventory(inventory_id_sequence.nextval, 'Americano Blend', 2960.00, 'Available', 'Perishable', 'Oz',1,0.00);
EXEC INSERT_DATA.insert_inventory(inventory_id_sequence.nextval, 'Distilled Water', 89.00, 'Available', 'Perishable', 'Gallon',1,0.00);
EXEC INSERT_DATA.insert_inventory(inventory_id_sequence.nextval, 'Chocolate Syrup', 212.00, 'Available', 'Perishable', 'Oz',1,0.00);
EXEC INSERT_DATA.insert_inventory(inventory_id_sequence.nextval, 'Raspberry Syrup', 52.00, 'Available', 'Perishable', 'Oz',1,0.00);


EXEC INSERT_DATA.INSERT_ITEM_PREP_REQ(50001, 2, 10, 0.1, 'Available');
EXEC INSERT_DATA.INSERT_ITEM_PREP_REQ(50002, 2, 16, 8, 'Available');
EXEC INSERT_DATA.INSERT_ITEM_PREP_REQ(50000, 2, 17, 0.2, 'Available');
EXEC INSERT_DATA.INSERT_ITEM_PREP_REQ(50004, 1, 11, 0.1, 'Available');
EXEC INSERT_DATA.INSERT_ITEM_PREP_REQ(50006, 1, 17, 0.2, 'Available');
EXEC INSERT_DATA.INSERT_ITEM_PREP_REQ(50009, 1, 13, 8, 'Available');
EXEC INSERT_DATA.INSERT_ITEM_PREP_REQ(50011, 3, 20, 2, 'Available');
EXEC INSERT_DATA.INSERT_ITEM_PREP_REQ(50012, 3, 19, 0.2, 'Available');
EXEC INSERT_DATA.INSERT_ITEM_PREP_REQ(50010, 3, 24, 2, 'Available');
EXEC INSERT_DATA.INSERT_ITEM_PREP_REQ(50014, 4, 23, 0.3, 'Available');
EXEC INSERT_DATA.INSERT_ITEM_PREP_REQ(50016, 4, 22, 2, 'Available');
EXEC INSERT_DATA.INSERT_ITEM_PREP_REQ(50019, 5, 21, 5, 'Available');
EXEC INSERT_DATA.INSERT_ITEM_PREP_REQ(50020, 5, 10, 0.1, 'Available');
EXEC INSERT_DATA.INSERT_ITEM_PREP_REQ(50021, 5, 13,0.05, 'Available');
EXEC INSERT_DATA.INSERT_ITEM_PREP_REQ(50022, 5, 20, 2, 'Available');
EXEC INSERT_DATA.INSERT_ITEM_PREP_REQ(50023, 6, 24, 8, 'Available');
EXEC INSERT_DATA.INSERT_ITEM_PREP_REQ(50024, 6, 10, 0.1, 'Available');
EXEC INSERT_DATA.INSERT_ITEM_PREP_REQ(50025, 6, 23, 2, 'Available');

EXEC INSERT_DATA.insert_orders(order_id_sequence.nextval, 80006, 'ONLINE', '23-DEC-2022 20:25:56','Ready for Pickup', '12-DEC-2022 20:45:56', '12-DEC-2022 21:25:56',  8.95,1);
EXEC INSERT_DATA.insert_orders(order_id_sequence.nextval, 80002, 'IN-STORE', '08-JAN-2023 14:56:03','Delivered', '08-JAN-2023 15:26:03', '08-JAN-2023 15:56:03', 8.95,1);
EXEC INSERT_DATA.insert_orders(order_id_sequence.nextval, 80004, 'IN-STORE', '23-JAN-2023 13:24:24','Ready for Pickup', '23-JAN-2023 13:44:24', '23-JAN-2023 14:24:24', 9.95,1);
EXEC INSERT_DATA.insert_orders(order_id_sequence.nextval, 80009, 'IN-STORE', '15-FEB-2023 12:15:15','In Progress', '15-FEB-2023 12:35:15', '15-FEB-2023 13:15:15', 9.45,1);
EXEC INSERT_DATA.insert_orders(order_id_sequence.nextval, 80004, 'ONLINE', '21-FEB-2023 16:23:49','In Progress', '21-FEB-2023 16:43:49', '21-FEB-2023 15:23:49', 26.85,1);
EXEC INSERT_DATA.insert_orders(order_id_sequence.nextval, 80004, 'IN-STORE', '05-MAR-2023 09:45:34','Ready for Pickup', '05-MAR-2023 10:15:34', '05-MAR-2023 10:45:34',  8.95,1);
EXEC INSERT_DATA.insert_orders(order_id_sequence.nextval, 80007, 'ONLINE', '13-MAR-2023 16:56:45','Delivered', '13-MAR-2023 17:26:45', '13-MAR-2023 17:56:45',28.35,1);
EXEC INSERT_DATA.insert_orders(order_id_sequence.nextval, 80005, 'IN-STORE', '15-MAR-2023 12:44:45' ,'Ready for Pickup', '15-MAR-2023 13:04:45', '15-MAR-2023 13:44:45', 17.9,1);
EXEC INSERT_DATA.insert_orders(order_id_sequence.nextval, 80003, 'IN-STORE', '18-MAR-2023 11:20:00','In Progress', '18-MAR-2023 11:40:00', '18-MAR-2023 12:20:00', 17.9,1);
EXEC INSERT_DATA.insert_orders(order_id_sequence.nextval, 80003, 'ONLINE', '05-APR-2023 14:34:35','Ready for Pickup', '05-APR-2023 14:54:35', '05-APR-2023 15:34:35',9,1);
EXEC INSERT_DATA.insert_orders(order_id_sequence.nextval, 80003, 'IN-STORE', '10-APR-2023 19:34:35','Ready for Pickup', '10-APR-2023 19:54:35', '10-APR-2023 18:34:35', 8.95,1);


EXEC INSERT_DATA.INSERT_ITEM_ORDER_BRIDGE(1110, 1, 100, 1);
EXEC INSERT_DATA.INSERT_ITEM_ORDER_BRIDGE(1111, 2, 100,   3);
EXEC INSERT_DATA.INSERT_ITEM_ORDER_BRIDGE(1112, 1, 101,   1);
EXEC INSERT_DATA.INSERT_ITEM_ORDER_BRIDGE(1113, 6, 101,  2);
EXEC INSERT_DATA.INSERT_ITEM_ORDER_BRIDGE(1114, 5, 102,   1);
EXEC INSERT_DATA.INSERT_ITEM_ORDER_BRIDGE(1115, 2, 102,   2);
EXEC INSERT_DATA.INSERT_ITEM_ORDER_BRIDGE(1116, 5, 103,   1);
EXEC INSERT_DATA.INSERT_ITEM_ORDER_BRIDGE(1117, 3, 103,   3);
EXEC INSERT_DATA.INSERT_ITEM_ORDER_BRIDGE(1118, 1, 104,   1);
EXEC INSERT_DATA.INSERT_ITEM_ORDER_BRIDGE(1119, 2, 104,   3);
EXEC INSERT_DATA.INSERT_ITEM_ORDER_BRIDGE(1120, 1, 105,   1);
EXEC INSERT_DATA.INSERT_ITEM_ORDER_BRIDGE(1121, 2, 105,   1);
EXEC INSERT_DATA.INSERT_ITEM_ORDER_BRIDGE(1122, 5, 106,   2);
EXEC INSERT_DATA.INSERT_ITEM_ORDER_BRIDGE(1123, 2, 107,   1);
EXEC INSERT_DATA.INSERT_ITEM_ORDER_BRIDGE(1124, 5, 108,   2);
EXEC INSERT_DATA.INSERT_ITEM_ORDER_BRIDGE(1125, 3, 109,   1);
EXEC INSERT_DATA.INSERT_ITEM_ORDER_BRIDGE(1126, 3, 109,   1);
EXEC INSERT_DATA.INSERT_ITEM_ORDER_BRIDGE(1127, 5, 109,   1);
EXEC INSERT_DATA.INSERT_ITEM_ORDER_BRIDGE(1128, 3, 110,   3);
EXEC INSERT_DATA.INSERT_ITEM_ORDER_BRIDGE(1129, 4, 110,   2);
EXEC INSERT_DATA.INSERT_ITEM_ORDER_BRIDGE(1130, 1, 110,   1);
EXEC INSERT_DATA.INSERT_ITEM_ORDER_BRIDGE(1131, 4, 110,   2);


EXEC INSERT_DATA.insert_employee_inventory(1001, 1001, 10);
EXEC INSERT_DATA.insert_employee_inventory(1002, 1001, 11);
EXEC INSERT_DATA.insert_employee_inventory(1003, 1001, 12);
EXEC INSERT_DATA.insert_employee_inventory(1004, 1001, 13);
EXEC INSERT_DATA.insert_employee_inventory(1005, 1001, 15);
EXEC INSERT_DATA.insert_employee_inventory(1006, 1001, 14);
EXEC INSERT_DATA.insert_employee_inventory(1007, 1001, 13);
EXEC INSERT_DATA.insert_employee_inventory(1008, 1001, 16);
EXEC INSERT_DATA.insert_employee_inventory(1009, 1001, 20);
EXEC INSERT_DATA.insert_employee_inventory(1010, 1001, 21);
EXEC INSERT_DATA.insert_employee_inventory(1011, 1001, 25);
EXEC INSERT_DATA.insert_employee_inventory(1012, 1001, 22);
EXEC INSERT_DATA.insert_employee_inventory(1013, 1001, 24);
EXEC INSERT_DATA.insert_employee_inventory(1014, 1001, 23);

EXEC INSERT_DATA.insert_order_employee(2001, 103, 1003);
EXEC INSERT_DATA.insert_order_employee(1001, 104, 1003);
EXEC INSERT_DATA.insert_order_employee(1002, 108, 1004);
EXEC INSERT_DATA.insert_order_employee(2002, 100, 1002);
EXEC INSERT_DATA.insert_order_employee(1011, 102, 1002);
EXEC INSERT_DATA.insert_order_employee(2010, 105, 1002);
EXEC INSERT_DATA.insert_order_employee(2101, 107, 1002);
EXEC INSERT_DATA.insert_order_employee(1101, 110, 1002);
EXEC INSERT_DATA.insert_order_employee(1102, 106, 1002);
EXEC INSERT_DATA.insert_order_employee(2102, 101, 1002);




------------------------- VIEWS creation -------------------------------


create or replace view  view_menu_item_to_customer as                  -- this is the actual menu card which customer will see. Uneccessary details like inventory unavailability etc are hidden from customer.
    select item_name, item_price from menu_item
    where item_id not in
    (
    select req.item_id
    from item_prep_req req, menu_item i
    where req.inventory_availability = 'Unavailable'
    and i.item_id = req.item_id
    group by req.item_id, i.item_name, i.item_price
    having count(req.inventory_availability) > 0
    );
    
    
------------------------- REPORT GENERATION  -------------------------------


Create or replace view current_inventory_status_VIEW as                -- report to view at the end of the day, what is the inventory status
select INVENTORY_NAME ,
    INVENTORY_QTY ,
    INVENTORY_STATUS ,
    INVENTORY_TYPE ,
    UNIT_OF_MEASUREMENT 
    from INVENTORY
    ORDER BY INVENTORY_STATUS DESC;


create or replace view CURRENT_ORDER_AND_BARISTA_VIEW as               -- this view displays which order is being prepared by which employee
    select oe.order_id, oe.employee_id, o.ORDER_STATUS
    from ORDER_EMPLOYEE oe, orders o 
    where o.order_id = oe.order_id 
    and o.order_status = 'In Progress';


create or replace  view order_type_view as                             -- report to view how many instore orders were placed and how many online orders were placed
  SELECT
  COUNT(CASE WHEN order_type = 'ONLINE' THEN 1 ELSE NULL END) AS Online_Order_Count,
  COUNT(CASE WHEN order_type = 'IN-STORE' THEN 1 ELSE NULL END) AS Instore_Order_Count, 
  ORDER_INITIATION_DATE_TIME, ORDER_COMPLETION_DATE_TIME, ORDER_DELIVERY_DATE_TIME
  FROM orders 
  where order_status != 'canceled'
  group by ORDER_INITIATION_DATE_TIME, ORDER_COMPLETION_DATE_TIME, ORDER_DELIVERY_DATE_TIME;



CREATE or replace VIEW ITEM_WISE_SALE_VIEW AS                            -- report to view the Item wise sale
    SELECT i.item_id, i.item_name, SUM(io.qty_ordered) AS total_qty_ordered, SUM(io.qty_ordered * i.item_price) AS total_sales
    FROM item_order_bridge io
    JOIN menu_item i ON io.item_id = i.item_id
    JOIN orders o ON io.order_id = o.order_id
    GROUP BY i.item_id, i.item_name;


CREATE OR REPLACE VIEW TOP5_CUSTOMERS_DENSE AS           --- DENSE RANK USAGE
SELECT c.customer_fname,c.customer_lname, o.customer_id, total_sales, DENSE_RANK() OVER (ORDER BY total_sales DESC) AS sales_rank
FROM (
  SELECT customer_id, SUM(io.qty_ordered * i.item_price) AS total_sales
  FROM orders o
  JOIN item_order_bridge io ON o.order_id = io.order_id
  JOIN menu_item i ON io.item_id = i.item_id
  GROUP BY customer_id
  ORDER BY total_sales DESC
  FETCH FIRST 5 ROWS ONLY
) o
JOIN customer c ON o.customer_id = c.customer_id
ORDER BY sales_rank;



CREATE OR REPLACE VIEW TOP5_CUSTOMERS AS                    --- Normal RANK USAGE
SELECT o.customer_id, SUM(io.qty_ordered * i.item_price) AS total_sales
FROM orders o
JOIN item_order_bridge io ON o.order_id = io.order_id
JOIN menu_item i ON io.item_id = i.item_id
GROUP BY o.customer_id
ORDER BY total_sales DESC
FETCH FIRST 5 ROWS ONLY;

CREATE OR REPLACE VIEW UNUSED_INVENTORY AS                  -- REPORT TO SEE WHAT INVENTORY IS NOT BEING USED FOR PREPARAION
SELECT INVENTORY_NAME FROM INVENTORY
WHERE INVENTORY_ID NOT IN (
SELECT INVENTORY_ID FROM ITEM_PREP_REQ
);


-------------------- FUNCTIONS to apply discount ----------------------------------------------

CREATE OR REPLACE FUNCTION apply_discount15(p_order_id in orders.order_id%TYPE)
return number
as
  v_total_amount orders.total_amount%TYPE;
  v_discounted_amount NUMBER;
BEGIN
  -- get the total amount of the order
  SELECT total_amount
  INTO v_total_amount
  FROM orders
  WHERE order_id = p_order_id;
 DBMS_OUTPUT.PUT_LINE('Order id ' || p_order_id);
  -- calculate the discounted amount
  v_discounted_amount := v_total_amount * 0.85;
 
  -- update the order with the discounted amount
  UPDATE orders
  SET total_amount = v_discounted_amount
  WHERE order_id = p_order_id;
 
  -- return the discounted amount
  RETURN v_discounted_amount;
END;
/

DECLARE
  v_discounted_amount NUMBER;
BEGIN
  v_discounted_amount := apply_discount15(108);
  DBMS_OUTPUT.PUT_LINE('Discounted amount: ' || v_discounted_amount);
END;
/

SELECT * FROM orders WHERE order_id = 108 ;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

select * from inventory;

update orders set order_status = 'Cancelled' 
where order_id = '108' 
and order_status not in ('Delivered', 'Ready for Pickup', 'Cancelled');

select * from inventory;

select * from view_menu_item_to_customer;

select * from orders;

------------------------- REPORTS BELOW  -------------------------------



select * from current_inventory_status_VIEW;

select * from CURRENT_ORDER_AND_BARISTA_VIEW;

select * from order_type_view;

select * from ITEM_WISE_SALE_VIEW;

select * from TOP5_CUSTOMERS_DENSE;

select * from TOP5_CUSTOMERS;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

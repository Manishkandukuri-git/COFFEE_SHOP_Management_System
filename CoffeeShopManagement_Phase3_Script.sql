purge recyclebin;
SET SERVEROUTPUT on;
/*
DECLARE
   StoreManager number;
   Cashier number;
   Barista number;
   InventoryManager number;
   OrderDeliveryEmp number;
BEGIN
  select count(*)
  into StoreManager from DBA_ROLES
  where grantee = 'STORE_MANAGER';
  select count(*)
  into Cashier from dba_role_privs
  where grantee = 'CASHIER';
  select count(*)
  into Barista from dba_role_privs
  where grantee = 'BARISTA';
  select count(*)
  into InventoryManager from dba_role_privs
  where grantee = 'INVENTORY_MANAGER';
  select count(*)
  into OrderDeliveryEmp from dba_role_privs
  where grantee = 'ORDER_DELIVERY_EMP';
  
  IF(StoreManager > 0) THEN EXECUTE IMMEDIATE 'DROP ROLE STORE_MANAGER'; END IF;
  IF(Barista > 0) THEN EXECUTE IMMEDIATE 'DROP ROLE BARISTA'; END IF;
  IF(InventoryManager > 0) THEN EXECUTE IMMEDIATE 'DROP ROLE INVENTORY_MANAGER'; END IF;
  IF(Cashier > 0) THEN EXECUTE IMMEDIATE 'DROP ROLE CASHIER'; END IF;
  IF(OrderDeliveryEmp > 0) THEN EXECUTE IMMEDIATE 'DROP ROLE ORDER_DELIVERY_EMP'; END IF;
END;
/

CREATE role STORE_MANAGER;
CREATE role CASHIER;
CREATE role BARISTA;
CREATE role INVENTORY_MANAGER;
CREATE role ORDER_DELIVERY_EMP;


GRANT CONNECT, RESOURCE TO STORE_MANAGER;
GRANT CONNECT, RESOURCE TO CASHIER;
GRANT CONNECT, RESOURCE TO BARISTA;
GRANT CONNECT, RESOURCE TO INVENTORY_MANAGER;
GRANT CONNECT, RESOURCE TO ORDER_DELIVERY_EMP;

*/

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
  DBMS_OUTPUT.PUT_LINE('ALL TABLES DROPPED');
  END;
  
END;
/

CREATE TABLE CUSTOMER (
    CUSTOMER_ID INT PRIMARY KEY,
    CUSTOMER_FNAME VARCHAR2(30) NOT NULL,
    CUSTOMER_LNAME VARCHAR2(30) NOT NULL,
    CITY varchar(30) NOT NULL,
    STATE_NAME varchar2(20) NOT NULL,
    PHONE_NUMBER INT NOT NULL,
    CUSTOMER_CREATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE COFFEE_SHOP (
    COFFEE_SHOP_ID INT PRIMARY KEY,
    PHONE_NUMBER INT NOT NULL,
    STREET VARCHAR2(50) NOT NULL,
    CITY VARCHAR2(30) NOT NULL,
    STATE_NAME VARCHAR2(20) NOT NULL,
    ZIP_CODE INT NOT NULL
);


CREATE TABLE EMPLOYEE (
    EMPLOYEE_ID INT PRIMARY KEY,
    EMPLOYEE_NAME varchar2(20) NOT NULL,
    EMPLOYEE_ROLE VARCHAR2(20) NOT NULL,
    PHONE_NUMBER INT NOT NULL,
    STREET VARCHAR2(50) NOT NULL,
    CITY VARCHAR2(30) NOT NULL,
    STATE_NAME VARCHAR2(20) NOT NULL,
    ZIP_CODE INT NOT NULL,
    EMP_WAGE DECIMAL(10,2) NOT NULL,
    coffee_shop_id int references coffee_shop(coffee_shop_id)
);

CREATE TABLE ORDERS (
    ORDER_ID INT PRIMARY KEY,
    CUSTOMER_ID INT NOT NULL REFERENCES CUSTOMER(CUSTOMER_ID),
    ORDER_TYPE VARCHAR2(10) NOT NULL,
    ORDER_INITIATION_DATE_TIME DATE DEFAULT SYSTIMESTAMP,
    ORDER_STATUS VARCHAR2(20) NOT NULL,
    ORDER_COMPLETION_DATE_TIME DATE DEFAULT (SYSTIMESTAMP + INTERVAL '1' HOUR),
    ORDER_DELIVERY_DATE_TIME DATE DEFAULT (SYSTIMESTAMP + INTERVAL '1' HOUR),
    TOTAL_AMOUNT DECIMAL(10,2) NOT NULL,
    coffee_shop_id int references coffee_shop(coffee_shop_id)
);


CREATE TABLE MENU_ITEM (
    ITEM_ID INT PRIMARY KEY,
    ITEM_NAME varchar(25) NOT NULL,    
    ITEM_DESC VARCHAR2(200) NOT NULL,
    ITEM_PRICE DECIMAL(10,2) NOT NULL,
    coffee_shop_id int references coffee_shop(coffee_shop_id)

);


CREATE TABLE INVENTORY (
    INVENTORY_ID INT PRIMARY KEY,
    INVENTORY_NAME VARCHAR2(20) NOT NULL,
    INVENTORY_QTY DECIMAL(10,2) NOT NULL,
    INVENTORY_STATUS VARCHAR(40) NOT NULL,
    INVENTORY_TYPE VARCHAR2(30) NOT NULL,
    UNIT_OF_MEASUREMENT VARCHAR2(10) NOT NULL,
    coffee_shop_id int references coffee_shop(coffee_shop_id)

);

CREATE TABLE ITEM_PREP_REQ (
    ITEM_INVENTORY_BRIDGE_ID INT PRIMARY KEY,
    ITEM_ID INT REFERENCES MENU_ITEM(ITEM_ID), 
    INVENTORY_ID INT REFERENCES INVENTORY(INVENTORY_ID),
    QTY_REQUIRED DECIMAL(10,2) NOT NULL
);

CREATE TABLE ORDER_EMPLOYEE (
  ORDER_EMPLOYEE_ID INT PRIMARY KEY,
  ORDER_ID REFERENCES ORDERS(ORDER_ID),
  EMPLOYEE_ID REFERENCES EMPLOYEE(EMPLOYEE_ID)
);

CREATE TABLE EMPLOYEE_INVENTORY (
    EMPLOYEE_INVENTORY_ID INT PRIMARY KEY,
    EMPLOYEE_ID REFERENCES EMPLOYEE(EMPLOYEE_ID),
    INVENTORY_ID REFERENCES INVENTORY(INVENTORY_ID)
);

CREATE TABLE ITEM_ORDER_BRIDGE (
    ITEM_ORDER_BRIDGE_ID INT PRIMARY KEY,
    ORDER_ID REFERENCES ORDERS(ORDER_ID),
    ITEM_ID REFERENCES MENU_ITEM(ITEM_ID),
    QTY_ORDERED INT DEFAULT 1
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
           v_coffee_shop_id IN inventory.coffee_shop_id%TYPE
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
    v_qty_required IN item_prep_req.qty_required%TYPE
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
           v_coffee_shop_id IN inventory.coffee_shop_id%TYPE
    )
    IS
    BEGIN
      INSERT INTO inventory(inventory_id, inventory_name, inventory_qty, inventory_status, inventory_type, unit_of_measurement,coffee_shop_id) 
      VALUES (v_inventory_id, v_inventory_name, v_inventory_qty, v_inventory_status, v_inventory_type, v_unit_of_measurement,v_coffee_shop_id);
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
    v_qty_required IN item_prep_req.qty_required%TYPE
)
IS 
BEGIN
INSERT INTO ITEM_PREP_REQ(item_inventory_bridge_id, item_id, inventory_id, qty_required)
values(v_item_inventory_bridge_id, v_item_id, v_inventory_id, v_qty_required);
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
--grant execute on INSERT_DATA to StoreManager;
/*
grant EXECUTE on INSERT_DATA.INSERT_CUSTOMER_PROC to Harry;
grant EXECUTE on INSERT_DATA.insert_coffee_shop to Harry;
grant EXECUTE on INSERT_DATA.insert_employee to Harry;
grant EXECUTE on INSERT_DATA.insert_employee_inventory to Harry;
grant EXECUTE on INSERT_DATA.insert_order_employee to Harry;
grant EXECUTE on INSERT_DATA.insert_inventory to Harry;
grant EXECUTE on INSERT_DATA.insert_menu_item to Harry;
grant EXECUTE on INSERT_DATA.insert_orders to Harry;
grant EXECUTE on INSERT_DATA.INSERT_ITEM_PREP_REQ to Harry;
grant EXECUTE on INSERT_DATA.INSERT_ITEM_ORDER_BRIDGE to Harry;
*/

--- start inserting data here -----


EXEC INSERT_DATA.insert_coffee_shop(2, 6178282828, '120 SouthBay', 'Boston', 'Massachusetts', 02107);
EXEC INSERT_DATA.insert_coffee_shop(3, 6178282838, '88 North Station', 'Boston', 'Massachusetts', 02121);


EXEC INSERT_DATA.INSERT_CUSTOMER_PROC(188, 'Kelly', 'Key', 'BOSTON', 'MASSACHUSETTS', 8678978743, SYSTIMESTAMP);
EXEC INSERT_DATA.INSERT_CUSTOMER_PROC(243, 'Clark', 'Schroeder', 'CAMBRIDGE', 'MASSACHUSETTS', 8678543563, SYSTIMESTAMP);
EXEC INSERT_DATA.INSERT_CUSTOMER_PROC(256, 'Elvis ', 'Cardenas', 'BOSTON', 'MASSACHUSETTS', 8678976098, SYSTIMESTAMP);
EXEC INSERT_DATA.INSERT_CUSTOMER_PROC(322, 'Rafael ', 'Estes', 'BOSTON', 'MASSACHUSETTS', 8678434563, SYSTIMESTAMP);
EXEC INSERT_DATA.INSERT_CUSTOMER_PROC(210, 'Colin ', 'Lynn', 'LOWELL', 'MASSACHUSETTS', 8678900063, SYSTIMESTAMP);
EXEC INSERT_DATA.INSERT_CUSTOMER_PROC(222, 'JACK', 'SPARROW', 'BOSTON', 'MASSACHUSETTS', 8678976563, SYSTIMESTAMP);


EXEC INSERT_DATA.insert_orders(268, 222, 'IN-STORE', SYSTIMESTAMP,'Ready for Pickup', SYSTIMESTAMP, SYSTIMESTAMP, 9.95,2);
EXEC INSERT_DATA.insert_orders(876, 188, 'IN-STORE', SYSTIMESTAMP,'In Progress', SYSTIMESTAMP, SYSTIMESTAMP, 19.95,2);
EXEC INSERT_DATA.insert_orders(234, 243, 'IN-STORE', SYSTIMESTAMP,'Delivered', SYSTIMESTAMP, SYSTIMESTAMP, 7.95,3);
EXEC INSERT_DATA.insert_orders(123, 256, 'ONLINE', SYSTIMESTAMP,'In Progress', SYSTIMESTAMP, SYSTIMESTAMP, 29.95,2);
EXEC INSERT_DATA.insert_orders(898, 322, 'ONLINE', SYSTIMESTAMP,'Ready for Pickup', SYSTIMESTAMP, SYSTIMESTAMP, 9.95,3);
EXEC INSERT_DATA.insert_orders(548, 210, 'IN-STORE', SYSTIMESTAMP,'Ready for Pickup', SYSTIMESTAMP, SYSTIMESTAMP, 10.95,3);


EXEC INSERT_DATA.insert_employee(921, 'Sue Tindale', 'Store_Manager', 8578765439, '3 Mass Ave', 'Boston', 'Massachusetts', 02115, 34,2);
EXEC INSERT_DATA.insert_employee(724, 'Marny Hermione', 'Barista', 6178889345, '75 huntington Ave', 'Boston', 'Massachusetts', 02113, 26,3);
EXEC INSERT_DATA.insert_employee(650, 'Chelsea Claudia', 'Cashier', 8576633442, '6 Brooks Ave', 'Cambridge', 'Massachusetts', 02111, 20,3);
EXEC INSERT_DATA.insert_employee(934, 'Kelsey Cameron', 'Inventory_Manager', 8579876543, '43 Alphonsus Street', 'Boston', 'Massachusetts', 02121, 30,2);
EXEC INSERT_DATA.insert_employee(811, 'Caldwell Veda', 'Order_Delivery_Emp', 6172563748, '369 Hunter Street', 'Boston', 'Massachusetts', 02120, 20,2);
EXEC INSERT_DATA.insert_employee(744, 'Peter Paloma', 'Barista', 8577755210, '1641 Washington Street', 'Boston', 'Massachusetts', 02118, 24,3);

EXEC INSERT_DATA.insert_menu_item(15, 'Nitro Cold Brew', 'Exotic Cold Brew along with Fresh Almond Milk', 8.95, 2);
EXEC INSERT_DATA.insert_menu_item(12, 'Pumpkin Spice Latte', 'Latte in Fresh Whole Milk with 3 Pumpkin Spice Pumps', 8.95, 2);
EXEC INSERT_DATA.insert_menu_item(16, 'Caffé Mocha', 'Simply the Best Mocha ever', 9.45, 2);
EXEC INSERT_DATA.insert_menu_item(11, 'Caffé Americano', 'If American accent has a taste...', 4.50, 2);
EXEC INSERT_DATA.insert_menu_item(14, 'Java Chip Frappuccino', 'Freshly made Java Chip Frappuccino', 8.95, 2);
EXEC INSERT_DATA.insert_menu_item(13, 'Signature Hot Chocolate', 'Hot Chocolate in Winter keeps you warm', 7.95, 2);


EXEC INSERT_DATA.insert_inventory(69, 'Whole Milk', 32.00, 'Available', 'Perishable', 'Gallon',2);
EXEC INSERT_DATA.insert_inventory(70, 'Almond Milk', 22.00, 'Available', 'Perishable', 'Gallon',2);
EXEC INSERT_DATA.insert_inventory(85, 'Hazelnut Syrup', 45.00, 'Available', 'Perishable', 'Oz',2);
EXEC INSERT_DATA.insert_inventory(86, 'Vanilla Syrup', 42.00, 'Available', 'Perishable', 'Oz',2);
EXEC INSERT_DATA.insert_inventory(23, 'Cups', 200.00, 'Available', 'Non-Perishable', 'Pieces',2);
EXEC INSERT_DATA.insert_inventory(24, 'Stirrer', 300.00, 'Available', 'Non-Perishable', 'Pieces',2);
EXEC INSERT_DATA.insert_inventory(87, 'Pumpkin Spice Syrup', 52.00, 'Available', 'Perishable', 'Oz',2);
EXEC INSERT_DATA.insert_inventory(20, 'Espresso Coffee', 100.00, 'Available', 'Perishable', 'Gallon',3);


EXEC INSERT_DATA.insert_employee_inventory(1001, 934, 69);
EXEC INSERT_DATA.insert_employee_inventory(1002, 934, 70);
EXEC INSERT_DATA.insert_employee_inventory(1003, 934, 85);
EXEC INSERT_DATA.insert_employee_inventory(1004, 934, 86);
EXEC INSERT_DATA.insert_employee_inventory(1005, 934, 24);
EXEC INSERT_DATA.insert_employee_inventory(1008, 934, 23);



EXEC INSERT_DATA.insert_order_employee(2001, 268, 921);
EXEC INSERT_DATA.insert_order_employee(1001, 876, 744);
EXEC INSERT_DATA.insert_order_employee(1002, 234, 724);
EXEC INSERT_DATA.insert_order_employee(2002, 123, 934);
EXEC INSERT_DATA.insert_order_employee(1011, 898, 811);
EXEC INSERT_DATA.insert_order_employee(2010, 548, 650);

EXEC INSERT_DATA.INSERT_ITEM_PREP_REQ(50001, 12, 69, 0.1);
EXEC INSERT_DATA.INSERT_ITEM_PREP_REQ(50002, 12, 87, 8);
EXEC INSERT_DATA.INSERT_ITEM_PREP_REQ(50000, 12, 20, 0.2);
EXEC INSERT_DATA.INSERT_ITEM_PREP_REQ(50004, 15, 70, 0.1);
EXEC INSERT_DATA.INSERT_ITEM_PREP_REQ(50006, 15, 20, 0.2);
EXEC INSERT_DATA.INSERT_ITEM_PREP_REQ(50009, 15, 86, 8);

EXEC INSERT_DATA.INSERT_ITEM_ORDER_BRIDGE(1118, 15, 268, 1);
EXEC INSERT_DATA.INSERT_ITEM_ORDER_BRIDGE(1119, 12, 876, 2);
EXEC INSERT_DATA.INSERT_ITEM_ORDER_BRIDGE(1112, 15, 234, 1);
EXEC INSERT_DATA.INSERT_ITEM_ORDER_BRIDGE(1113, 12, 123, 3);
EXEC INSERT_DATA.INSERT_ITEM_ORDER_BRIDGE(1115, 15, 898, 1);
EXEC INSERT_DATA.INSERT_ITEM_ORDER_BRIDGE(1111, 12, 548, 1);


create view current_inventory_status as
select INVENTORY_NAME ,
    INVENTORY_QTY ,
    INVENTORY_STATUS ,
    INVENTORY_TYPE ,
    UNIT_OF_MEASUREMENT from INVENTORY;


create view current_orders as
select oe.order_id, oe.employee_id from ORDER_EMPLOYEE oe, orders o
where o.order_id = oe.order_id and o.order_status = 'In Progress';

create view order_online_instore as 
select order_id, order_type from orders o
where ORDER_INITIATION_DATE_TIME = sysdate;


DROP VIEW current_inventory_status;
DROP VIEW current_orders;
DROP VIEW order_online_instore;

------------------------------------
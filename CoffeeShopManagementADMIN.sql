
DECLARE
   user_existance_admin number;
   user_existance_customer number;
BEGIN
  select count(*)
  into user_existance_admin from all_users where username='HARRY';
  
  select count(*) 
  into user_existance_customer from all_users where username = 'Customer';
  
  if(user_existance_admin > 0) THEN EXECUTE IMMEDIATE 'drop user Harry cascade'; END IF;
  
  if (user_existance_customer > 0) then execute immediate 'drop user Customer cascade'; end if;
  
  BEGIN
  DBMS_OUTPUT.PUT_LINE('ALL Users DROPPED');
  END;
  
END;
/


create user Harry identified by CoffeeStaff#123;        --Harry is the user who takes up the role of StoreManager or store Admin
create user Customer identified by CoffeeCustomer#123;        --Customer has access to only menu_item table
grant connect, resource to Harry;
grant connect, resource to Customer;


grant UNLIMITED TABLESPACE to Harry;

grant drop any table, drop any view to Harry;
grant create view to Harry;
grant create session, create table, create procedure to Harry;

grant select on menu_item_view to Customer ; -- create this view.

Commit;

BEGIN
EXECUTE IMMEDIATE 'CREATE role STORE_MANAGER';
EXECUTE IMMEDIATE 'CREATE role CASHIER';   
EXECUTE IMMEDIATE 'CREATE role BARISTA';
EXECUTE IMMEDIATE 'CREATE role INVENTORY_MANAGER';
EXECUTE IMMEDIATE 'CREATE role ORDER_DELIVERY_EMP';
EXECUTE IMMEDIATE 'GRANT CONNECT, RESOURCE TO STORE_MANAGER';
EXECUTE IMMEDIATE 'GRANT CONNECT, RESOURCE TO CASHIER';
EXECUTE IMMEDIATE 'GRANT CONNECT, RESOURCE TO BARISTA';
EXECUTE IMMEDIATE 'GRANT CONNECT, RESOURCE TO INVENTORY_MANAGER';
EXECUTE IMMEDIATE 'GRANT CONNECT, RESOURCE TO ORDER_DELIVERY_EMP';

EXCEPTION
WHEN OTHERS THEN
   NULL;
END;



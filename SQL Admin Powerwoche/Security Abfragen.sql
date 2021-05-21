select * from sys.fn_my_permissions(NULL, 'Database')

SELECT HAS_PERMS_BY_NAME(db_name(), 'DATABASE', 'ANY');

SELECT HAS_PERMS_BY_NAME
  (QUOTENAME(SCHEMA_NAME(schema_id)) + '.' + QUOTENAME(name), 
      'OBJECT', 'SELECT') AS have_select, * FROM sys.tables


Execute as User ='SUSI'
SELECT name AS column_name, 
    HAS_PERMS_BY_NAME('T', 'OBJECT', 'SELECT', name, 'COLUMN') 
    AS can_select 
    FROM sys.columns AS c 
    WHERE c.object_id=object_id('Orders');
Revert
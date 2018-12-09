-- For SQLServer
-- This query is useful to help identify possible Foreign Key in the model,
-- systems developed by a team without a database design is common find this problem.

SELECT qPK.table_name AS TableRef ,
       qPK.column_name AS ColumnRef ,
       qPK.constraint_name AS ConstraintRef ,
       c.table_name ,
       c.column_name ,
       t.constraint_name ,
       c.is_nullable AS Null
FROM INFORMATION_SCHEMA.COLUMNS c
LEFT OUTER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE k ON (c.column_name=k.column_name AND k.table_name=c.table_name)
LEFT OUTER JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS t ON (t.constraint_name=k.constraint_name),
  (SELECT c.table_name,
          c.column_name,
          t.constraint_name
   FROM INFORMATION_SCHEMA.COLUMNS c
   LEFT OUTER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE k ON (c.column_name=k.column_name AND k.table_name=c.table_name)
   LEFT OUTER JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS t ON (t.constraint_name=k.constraint_name)
   WHERE t.constraint_type='PRIMARY KEY') AS qPK
WHERE (qPK.table_name!=c.table_name
       AND c.column_name=qPK.column_name)
ORDER BY qPK.table_name,
         qPK.column_name;

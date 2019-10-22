
SET LINESIZE 200

PROMPT
PROMPT >> install tables
PROMPT
@./table/tab.sql

PROMPT
PROMPT >> install rowsets
PROMPT
@./type/tuple/t_dept_row_tps.sql
@./type/tuple/t_dept_row_tpb.sql
@./type/tuple/t_dept_rowset.sql

@./type/tuple/t_emp_row_tps.sql
@./type/tuple/t_emp_row_tpb.sql
@./type/tuple/t_emp_rowset.sql

PROMPT
PROMPT >> install domain
PROMPT
@./type/t_employee_tps.sql
@./type/t_employee_tpb.sql

@./type/t_department_tps.sql
@./type/t_department_tpb.sql

PROMPT
PROMPT >> Objects that remain invalid after install..
PROMPT

SELECT object_name, object_type, status FROM user_objects WHERE status <> 'VALID';

PROMPT
PROMPT >> Install tests..
PROMPT
@../test/ut_test_data_builder_pks
@../test/ut_test_data_builder_pkb

PROMPT
PROMPT >> Run tests..
PROMPT

BEGIN
  ut.run();
END;
/

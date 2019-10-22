
DROP TYPE t_department;
DROP TYPE t_employee; 

DROP TYPE t_emp_rowset;
DROP TYPE t_emp_row;

DROP TYPE t_dept_rowset;
DROP TYPE t_dept_row;

DROP TABLE emp;
DROP TABLE dept;

drop package ut_test_data_builder;

PROMPT
PROMPT >> remaining users objects:
PROMPT
SELECT object_name, object_type, status FROM user_objects; 


CREATE OR REPLACE TYPE t_dept_row AS OBJECT (
   deptno   NUMBER(2),
   dname    VARCHAR2(14),
   loc      VARCHAR2(13), 
 CONSTRUCTOR FUNCTION t_dept_row RETURN SELF AS RESULT
);
/
SHOW ERRORS
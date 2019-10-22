
CREATE OR REPLACE TYPE t_emp_row AS OBJECT (
    empno NUMBER(4,0),
    ename VARCHAR2(10 BYTE), 
    job VARCHAR2(9 BYTE), 
    mgr NUMBER(4,0), 
    hiredate DATE, 
    sal NUMBER(7,2), 
    comm NUMBER(7,2), 
    deptno NUMBER(2,0),
  CONSTRUCTOR FUNCTION t_emp_row RETURN SELF AS RESULT
);
/
SHOW ERRORS
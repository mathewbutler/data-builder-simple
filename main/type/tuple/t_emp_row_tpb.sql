
CREATE OR REPLACE TYPE BODY t_emp_row AS

  CONSTRUCTOR FUNCTION t_emp_row RETURN SELF AS RESULT 
  IS
  BEGIN
    empno := NULL;
    ename := NULL;
    job  := NULL;
    mgr := NULL;
    hiredate  := NULL;
    sal  := NULL;
    comm  := NULL;
    deptno  := NULL;
    
    RETURN;
  END;

END;
/
SHOW ERRORS

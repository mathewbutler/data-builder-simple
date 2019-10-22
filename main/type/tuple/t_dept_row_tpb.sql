
CREATE OR REPLACE TYPE BODY t_dept_row AS 

  CONSTRUCTOR FUNCTION t_dept_row RETURN SELF AS RESULT
  IS
  BEGIN
    deptno := NULL;
    dname  := NULL;
    loc    := NULL;

    RETURN;
  END;
    
END;
/
SHOW ERRORS

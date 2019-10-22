
CREATE OR REPLACE TYPE BODY t_department AS 

  /**
   *  Construct an "empty" department. Here "empty" means all attributes initialised to null.
   *  Implementation note:
   *    Default initialisation in the main block produces: PLS-00330: invalid use of type name or subtype name 
   */
  CONSTRUCTOR FUNCTION t_department RETURN SELF AS RESULT
  IS
    l_dept_rowset t_dept_rowset := t_dept_rowset();
    l_employees t_employee := t_employee();
  BEGIN
    l_dept_rowset.EXTEND;
    l_dept_rowset(1) := t_dept_row(NULL,NULL,NULL);    
    dept_rowset := l_dept_rowset;
    
    employees := l_employees;
    
    RETURN;
  END;

  MEMBER PROCEDURE print 
  IS
    l_output VARCHAR2(32000);
  BEGIN
    DBMS_OUTPUT.PUT_LINE(' ');
    DBMS_OUTPUT.PUT_LINE('DEPT( records: '||TO_CHAR(dept_rowset.count)||' ):');
    DBMS_OUTPUT.PUT_LINE('--------');
    FOR i IN 1..dept_rowset.count LOOP
      DBMS_OUTPUT.PUT_LINE(NVL(TO_CHAR(dept_rowset(1).deptno),'null')||' '||
        NVL(TO_CHAR(dept_rowset(1).dname),'null')||' '||
        NVL(TO_CHAR(dept_rowset(1).loc),'null')
      );
    END LOOP;

    DBMS_OUTPUT.PUT_LINE(' ');
    DBMS_OUTPUT.PUT_LINE('EMP( records: '||TO_CHAR(get_employee_count)||' ):');
    DBMS_OUTPUT.PUT_LINE('-------');
    
    employees.print;   
    
    DBMS_OUTPUT.PUT_LINE(' ');
  END;

  MEMBER FUNCTION get_department RETURN t_dept_rowset
  IS 
  BEGIN
    RETURN dept_rowset;
  END;
  
  MEMBER FUNCTION get_deptno RETURN NUMBER
  IS
  BEGIN
    RETURN dept_rowset(1).deptno;
  END;

  MEMBER FUNCTION get_dname RETURN VARCHAR2
  IS 
  BEGIN
    RETURN dept_rowset(1).dname;
  END;
  
  MEMBER FUNCTION get_loc RETURN VARCHAR2
  IS
  BEGIN
    RETURN dept_rowset(1).loc;
  END;

  MEMBER FUNCTION get_employee_count RETURN NUMBER
  IS
  BEGIN
    RETURN employees.get_employee_count;
  END;

  MEMBER FUNCTION get_employees RETURN t_emp_rowset
  IS
  BEGIN
    RETURN employees.get_employees;
  END;
  
  MEMBER FUNCTION get_empno ( p_pos NUMBER DEFAULT 1 ) RETURN NUMBER
  IS
  BEGIN
    IF get_employee_count = 0 THEN
      raise_application_error( -20002,'No attribute to retreive');    
    END IF;
    RETURN employees.get_empno( p_pos => get_empno.p_pos );
  END;

  MEMBER FUNCTION get_ename ( p_pos NUMBER DEFAULT 1 ) RETURN VARCHAR2
  IS
  BEGIN
    IF get_employee_count = 0 THEN
      raise_application_error( -20002,'No attribute to retreive');    
    END IF;
    
    RETURN employees.get_ename( p_pos => get_ename.p_pos );
  END;   

  MEMBER FUNCTION get_job  ( p_pos NUMBER DEFAULT 1 ) RETURN VARCHAR2
  IS
  BEGIN
    IF get_employee_count = 0 THEN
      raise_application_error( -20002,'No attribute to retreive');     
    END IF;
    RETURN employees.get_job( p_pos => get_job.p_pos );
  END;     
 
  MEMBER FUNCTION get_mgr ( p_pos NUMBER DEFAULT 1 )  RETURN NUMBER
  IS
  BEGIN
    IF get_employee_count = 0 THEN
      raise_application_error( -20002,'No attribute to retreive');     
    END IF;
    RETURN employees.get_mgr( p_pos => get_mgr.p_pos );
  END;   
  
  MEMBER FUNCTION get_hiredate ( p_pos NUMBER DEFAULT 1 )  RETURN DATE
  IS
  BEGIN
    IF get_employee_count = 0 THEN
      raise_application_error( -20002,'No attribute to retrieve');     
    END IF;
    RETURN employees.get_hiredate( p_pos => get_hiredate.p_pos );
  END;   
  
  MEMBER FUNCTION get_sal ( p_pos NUMBER DEFAULT 1 )  RETURN NUMBER
  IS
  BEGIN
    IF get_employee_count = 0 THEN
      raise_application_error( -20002,'No attribute to retreive');     
    END IF;
    RETURN employees.get_sal( p_pos => get_sal.p_pos );
  END;   
  
  MEMBER FUNCTION get_comm ( p_pos NUMBER DEFAULT 1 )  RETURN NUMBER
  IS
  BEGIN
    IF get_employee_count = 0 THEN
      raise_application_error( -20002,'No attribute to retreive');     
    END IF;
    RETURN employees.get_comm( p_pos => get_comm.p_pos );
  END;   
      
  -- PLS-00363: expression 'SELF.EMP_REC' cannot be used as an assignment target
  MEMBER FUNCTION with_deptno (p_deptno IN NUMBER) RETURN t_department
  IS
    l_result T_department := SELF; -- require local reference as no language support for direct SELF assignment (PLS-00363)
  BEGIN
    IF l_result.dept_rowset(1).deptno IS NOT NULL THEN
      raise_application_error(-20001, 'Already set this attribute, and only one dept row may be configured, before calling build().');
    END IF;
  
    l_result.dept_rowset(1).deptno := p_deptno;
    RETURN l_result;
  END;

  MEMBER FUNCTION with_dname (p_dname IN VARCHAR2) RETURN t_department
  IS
    l_result t_department := SELF;
  BEGIN
    IF l_result.dept_rowset(1).dname IS NOT NULL THEN
      raise_application_error(-20001, 'Already set this attribute, and only one dept row may be configured, before calling build().');
    END IF;

    l_result.dept_rowset(1).dname := p_dname;
    RETURN l_result;
  END;

  MEMBER FUNCTION with_loc (p_loc IN VARCHAR2) RETURN t_department
  IS
    l_result t_department := SELF;
  BEGIN
    IF l_result.dept_rowset(1).loc IS NOT NULL THEN
      raise_application_error(-20001, 'Already set this attribute, and only one dept row may be configured, before calling build().');
    END IF; 
    
    l_result.dept_rowset(1).loc := p_loc;
    RETURN l_result;
  END;
  
  ----

  MEMBER FUNCTION with_empno ( p_empno IN NUMBER ) RETURN t_department
  IS
    l_result t_department := SELF;
    l_employees t_employee := l_result.employees;
  BEGIN
    l_employees := l_employees.with_empno( with_empno.p_empno );
    
    IF l_result.dept_rowset(1).deptno IS NOT NULL THEN
      l_employees := l_employees.with_deptno( l_result.dept_rowset(1).deptno );
    END IF;
    
    l_result.employees := l_employees;
 
    RETURN l_result;
  END;

  MEMBER FUNCTION with_ename ( p_ename IN VARCHAR2 ) RETURN t_department
  IS
    l_result t_department := SELF;
    l_employees t_employee := l_result.employees;    
  BEGIN
    l_employees := l_employees.with_ename ( with_ename.p_ename );
    
    IF l_result.dept_rowset(1).deptno IS NOT NULL THEN
      l_employees := l_employees.with_deptno( l_result.dept_rowset(1).deptno );
    END IF;   
    
    l_result.employees := l_employees;
    
    RETURN l_result;
  END;

  MEMBER FUNCTION with_job ( p_job IN VARCHAR2 ) RETURN t_department
  IS
    l_result t_department := SELF;
    l_employees t_employee := l_result.employees;        
  BEGIN
    l_employees := l_employees.with_job ( with_job.p_job );
    
    IF l_result.dept_rowset(1).deptno IS NOT NULL THEN
      l_employees := l_employees.with_deptno( l_result.dept_rowset(1).deptno );
    END IF;    
    
    l_result.employees := l_employees;
    
    RETURN l_result;
  END;

  MEMBER FUNCTION with_mgr ( p_mgr IN NUMBER ) RETURN t_department
  IS
    l_result t_department := SELF;
    l_employees t_employee := l_result.employees;        
  BEGIN
    l_employees := l_employees.with_mgr ( with_mgr.p_mgr );
    
    IF l_result.dept_rowset(1).deptno IS NOT NULL THEN
      l_employees := l_employees.with_deptno( l_result.dept_rowset(1).deptno );
    END IF;    
    
    l_result.employees := l_employees;
    
    RETURN l_result;
  END;  
  
  MEMBER FUNCTION with_hiredate ( p_hiredate IN DATE ) RETURN t_department
  IS
    l_result t_department := SELF;
    l_employees t_employee := l_result.employees;        
  BEGIN
    l_employees := l_employees.with_hiredate ( with_hiredate.p_hiredate );
    
    IF l_result.dept_rowset(1).deptno IS NOT NULL THEN
      l_employees := l_employees.with_deptno( l_result.dept_rowset(1).deptno );
    END IF;   
    
    l_result.employees := l_employees;
    
    RETURN l_result;
  END;   
  
  MEMBER FUNCTION with_sal ( p_sal IN NUMBER ) RETURN t_department
  IS
    l_result t_department := SELF;
    l_employees t_employee := l_result.employees;        
  BEGIN
    l_employees := l_employees.with_sal ( with_sal.p_sal );
    
    IF l_result.dept_rowset(1).deptno IS NOT NULL THEN
      l_employees := l_employees.with_deptno( l_result.dept_rowset(1).deptno );
    END IF;    
    
    l_result.employees := l_employees;
    
    RETURN l_result;
  END;     
  
  MEMBER FUNCTION with_comm ( p_comm IN NUMBER ) RETURN t_department
  IS
    l_result t_department := SELF;
    l_employees t_employee := l_result.employees;        
  BEGIN
    l_employees := l_employees.with_comm ( with_comm.p_comm );
    
    IF l_result.dept_rowset(1).deptno IS NOT NULL THEN
      l_employees := l_employees.with_deptno( l_result.dept_rowset(1).deptno );
    END IF;    
    
    l_result.employees := l_employees;
    
    RETURN l_result;
  END;    

  MEMBER FUNCTION build RETURN t_department
  IS
     l_department t_department := SELF;
  BEGIN

    INSERT INTO dept ( deptno, dname,loc ) 
      VALUES ( dept_rowset(1).deptno, dept_rowset(1).dname, dept_rowset(1).loc );

    -- TODO: Unable to use employees.get_employees here without compile error, so breaking encapasulation. Should really delegate to employees.build().
    INSERT INTO emp ( empno, ename, job, mgr, hiredate, sal, comm, deptno )
      SELECT empno, ename, job, mgr, hiredate, sal, comm, deptno 
        FROM TABLE(l_department.employees.emp_rowset);    
    
    RETURN l_department;
  END;

END;
/
SHOW ERRORS


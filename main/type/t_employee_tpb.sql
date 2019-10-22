
CREATE OR REPLACE TYPE BODY t_employee AS 
  
  CONSTRUCTOR FUNCTION t_employee RETURN SELF AS RESULT
  IS
    l_emp_rowset  t_emp_rowset  := t_emp_rowset();
  BEGIN
    emp_rowset := l_emp_rowset;
    RETURN;
  END;  

  MEMBER PROCEDURE print
  IS
  BEGIN
    FOR i IN 1..emp_rowset.count LOOP
      DBMS_OUTPUT.PUT_LINE(NVL(TO_CHAR(emp_rowset(i).empno),'null')||' '||
         TO_CHAR(emp_rowset(i).ename)||' '||   
         TO_CHAR(emp_rowset(i).job)
      );   
    END LOOP;   
  END;

  MEMBER FUNCTION get_employee_count RETURN NUMBER
  IS
  BEGIN
    RETURN SELF.emp_rowset.COUNT;
  END;

  MEMBER FUNCTION get_employees RETURN t_emp_rowset
  IS
  BEGIN
    RETURN SELF.emp_rowset;
  END;

  MEMBER FUNCTION get_empno ( p_pos NUMBER DEFAULT 1 ) RETURN NUMBER
  IS
  BEGIN
    RETURN SELF.emp_rowset(p_pos).empno;
  END;

  MEMBER FUNCTION get_ename ( p_pos NUMBER DEFAULT 1 ) RETURN VARCHAR
  IS
  BEGIN
    RETURN SELF.emp_rowset(p_pos).ename;
  END;
  
  MEMBER FUNCTION get_job ( p_pos NUMBER DEFAULT 1 ) RETURN VARCHAR
  IS
  BEGIN
    RETURN SELF.emp_rowset(p_pos).job;
  END;  

  MEMBER FUNCTION get_mgr ( p_pos NUMBER DEFAULT 1 ) RETURN NUMBER
  IS
  BEGIN
    RETURN SELF.emp_rowset(p_pos).mgr;
  END;
  
  MEMBER FUNCTION get_hiredate ( p_pos NUMBER DEFAULT 1 ) RETURN DATE
  IS
  BEGIN
    RETURN SELF.emp_rowset(p_pos).hiredate;
  END;
  
  MEMBER FUNCTION get_sal ( p_pos NUMBER DEFAULT 1 ) RETURN NUMBER
  IS
  BEGIN
    RETURN SELF.emp_rowset(p_pos).sal;
  END;
  
  MEMBER FUNCTION get_comm ( p_pos NUMBER DEFAULT 1 ) RETURN NUMBER
  IS
  BEGIN
    RETURN SELF.emp_rowset(p_pos).comm; 
  END;
  
  MEMBER FUNCTION get_deptno ( p_pos NUMBER DEFAULT 1 ) RETURN NUMBER
  IS
  BEGIN
    RETURN SELF.emp_rowset(p_pos).deptno; 
  END;  

  MEMBER FUNCTION accumulate_emp_row ( p_empno IN NUMBER DEFAULT NULL
                                      ,p_ename IN VARCHAR2 DEFAULT NULL                                  
                                      ,p_job IN VARCHAR2 DEFAULT NULL
                                      ,p_mgr IN NUMBER DEFAULT NULL
                                      ,p_hiredate IN DATE DEFAULT NULL                                      
                                      ,p_sal IN NUMBER DEFAULT NULL                                      
                                      ,p_comm IN NUMBER DEFAULT NULL                                      
                                      ,p_deptno IN NUMBER DEFAULT NULL ) 
  RETURN t_emp_row
  IS
    l_emp_row t_emp_row;
  BEGIN
    IF SELF.emp_rowset.last IS NULL THEN
      l_emp_row := t_emp_row( p_empno
                             ,p_ename      
                             ,p_job
                             ,p_mgr
                             ,p_hiredate                          
                             ,p_sal                     
                             ,p_comm                  
                             ,p_deptno );
                           
    ELSE
      l_emp_row := t_emp_row( NVL(p_empno,SELF.emp_rowset(SELF.emp_rowset.last).empno)
                             ,NVL(p_ename,SELF.emp_rowset(SELF.emp_rowset.last).ename)      
                             ,NVL(p_job,SELF.emp_rowset(SELF.emp_rowset.last).job)    
                             ,NVL(p_mgr,SELF.emp_rowset(SELF.emp_rowset.last).mgr)
                             ,NVL(p_hiredate,SELF.emp_rowset(SELF.emp_rowset.last).hiredate)                           
                             ,NVL(p_sal,SELF.emp_rowset(SELF.emp_rowset.last).sal)                          
                             ,NVL(p_comm,SELF.emp_rowset(SELF.emp_rowset.last).comm)                          
                             ,NVL(p_deptno,SELF.emp_rowset(SELF.emp_rowset.last).deptno) ); 
    END IF;
    
    RETURN l_emp_row;
  END;


  MEMBER FUNCTION with_empno ( p_empno IN NUMBER ) RETURN t_employee
  IS
    l_result t_employee := SELF;
  BEGIN
    IF l_result.emp_rowset.count >= 0 THEN
      l_result.emp_rowset.extend;
    END IF;
    
    l_result.emp_rowset(l_result.emp_rowset.last) := accumulate_emp_row ( p_empno => with_empno.p_empno );
 
    RETURN l_result;
  END;
  
  MEMBER FUNCTION with_ename ( p_ename IN VARCHAR2 ) RETURN t_employee
  IS
    l_result t_employee := SELF;
  BEGIN
    IF l_result.emp_rowset.count = 0 THEN
      l_result.emp_rowset.extend;
    END IF;
    
    l_result.emp_rowset(l_result.emp_rowset.last) := accumulate_emp_row ( p_ename => with_ename.p_ename );
    
    RETURN l_result;
  END;

  MEMBER FUNCTION with_job ( p_job IN VARCHAR2 ) RETURN t_employee
  IS
    l_result t_employee := SELF;
  BEGIN
   IF l_result.emp_rowset.count = 0 THEN
      l_result.emp_rowset.extend;
    END IF;
    
    l_result.emp_rowset(l_result.emp_rowset.last) := accumulate_emp_row ( p_job => with_job.p_job );
    
    RETURN l_result;
  END;

  MEMBER FUNCTION with_mgr ( p_mgr IN NUMBER ) RETURN t_employee
  IS
    l_result t_employee := SELF;
  BEGIN
   IF l_result.emp_rowset.count = 0 THEN
      l_result.emp_rowset.extend;
    END IF;
    
    l_result.emp_rowset(l_result.emp_rowset.last) := accumulate_emp_row ( p_mgr => with_mgr.p_mgr );
    
    RETURN l_result;
  END;  

  MEMBER FUNCTION with_hiredate ( p_hiredate IN DATE ) RETURN t_employee
  IS
    l_result t_employee := SELF;
  BEGIN
   IF l_result.emp_rowset.count = 0 THEN
      l_result.emp_rowset.extend;
    END IF;
    
    l_result.emp_rowset(l_result.emp_rowset.last) := accumulate_emp_row ( p_hiredate => with_hiredate.p_hiredate );
    
    RETURN l_result;
  END;    
  
  MEMBER FUNCTION with_sal ( p_sal IN NUMBER ) RETURN t_employee
  IS
    l_result t_employee := SELF;
  BEGIN
   IF l_result.emp_rowset.count = 0 THEN
      l_result.emp_rowset.extend;
    END IF;
    
    l_result.emp_rowset(l_result.emp_rowset.last) := accumulate_emp_row ( p_sal => with_sal.p_sal );
    
    RETURN l_result;
  END;   
  
  MEMBER FUNCTION with_comm ( p_comm IN NUMBER ) RETURN t_employee
  IS
    l_result t_employee := SELF;
  BEGIN
   IF l_result.emp_rowset.count = 0 THEN
      l_result.emp_rowset.extend;
    END IF;
    
    l_result.emp_rowset(l_result.emp_rowset.last) := accumulate_emp_row ( p_comm => with_comm.p_comm );
    
    RETURN l_result;
  END;     
  
  MEMBER FUNCTION with_deptno ( p_deptno IN NUMBER ) RETURN t_employee
  IS
    l_result t_employee := SELF;
  BEGIN
   IF l_result.emp_rowset.count = 0 THEN
      l_result.emp_rowset.extend;
    END IF;
    
    l_result.emp_rowset(l_result.emp_rowset.last) := accumulate_emp_row ( p_deptno => with_deptno.p_deptno );
    
    RETURN l_result;
  END;    
    
END;
/
SHOW ERRORS


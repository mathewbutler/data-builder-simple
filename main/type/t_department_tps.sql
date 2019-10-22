
CREATE OR REPLACE TYPE t_department AS OBJECT (
   
  dept_rowset t_dept_rowset, 
  employees t_employee,
  
  CONSTRUCTOR FUNCTION t_department RETURN SELF AS RESULT,
  
  MEMBER PROCEDURE print,
  
  MEMBER FUNCTION get_department RETURN t_dept_rowset,

  -- anchored return type gives: PLS-00201: identifier 'DEPT.DEPTNO' must be declared
  MEMBER FUNCTION get_deptno RETURN NUMBER,
  MEMBER FUNCTION get_dname RETURN VARCHAR2,
  MEMBER FUNCTION get_loc RETURN VARCHAR2,

  MEMBER FUNCTION get_employee_count RETURN NUMBER,
  MEMBER FUNCTION get_employees RETURN t_emp_rowset, 
  
  MEMBER FUNCTION get_empno    ( p_pos NUMBER DEFAULT 1 ) RETURN NUMBER,
  MEMBER FUNCTION get_ename    ( p_pos NUMBER DEFAULT 1 ) RETURN VARCHAR2,
  MEMBER FUNCTION get_job      ( p_pos NUMBER DEFAULT 1 )  RETURN VARCHAR2,
  MEMBER FUNCTION get_mgr      ( p_pos NUMBER DEFAULT 1 )  RETURN NUMBER,
  MEMBER FUNCTION get_hiredate ( p_pos NUMBER DEFAULT 1 )  RETURN DATE,
  MEMBER FUNCTION get_sal      ( p_pos NUMBER DEFAULT 1 )  RETURN NUMBER,
  MEMBER FUNCTION get_comm     ( p_pos NUMBER DEFAULT 1 )  RETURN NUMBER,
        
  MEMBER FUNCTION with_deptno ( p_deptno IN NUMBER   ) RETURN t_department,
  MEMBER FUNCTION with_dname  ( p_dname  IN VARCHAR2 ) RETURN t_department,  
  MEMBER FUNCTION with_loc    ( p_loc    IN VARCHAR2 ) RETURN t_department,  

  MEMBER FUNCTION with_empno ( p_empno IN NUMBER   ) RETURN t_department,
  MEMBER FUNCTION with_ename ( p_ename IN VARCHAR2 ) RETURN t_department,
  MEMBER FUNCTION with_job   ( p_job IN VARCHAR2 ) RETURN t_department,
  MEMBER FUNCTION with_mgr ( p_mgr IN NUMBER ) RETURN t_department, 
  MEMBER FUNCTION with_hiredate ( p_hiredate IN DATE ) RETURN t_department, 
  MEMBER FUNCTION with_sal ( p_sal IN NUMBER ) RETURN t_department, 
  MEMBER FUNCTION with_comm ( p_comm IN NUMBER ) RETURN t_department, 
  
  MEMBER FUNCTION build RETURN t_department
  
);
/
SHOW ERRORS
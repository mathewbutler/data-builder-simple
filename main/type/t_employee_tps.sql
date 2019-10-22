
CREATE OR REPLACE TYPE t_employee AS OBJECT (

  emp_rowset  t_emp_rowset,
  
  CONSTRUCTOR FUNCTION t_employee RETURN SELF AS RESULT,

  MEMBER PROCEDURE print,

  MEMBER FUNCTION get_employees RETURN t_emp_rowset,  
  MEMBER FUNCTION get_employee_count RETURN NUMBER,

  MEMBER FUNCTION get_empno ( p_pos NUMBER DEFAULT 1 ) RETURN NUMBER,
  MEMBER FUNCTION get_ename ( p_pos NUMBER DEFAULT 1 ) RETURN VARCHAR,
  MEMBER FUNCTION get_job ( p_pos NUMBER DEFAULT 1 ) RETURN VARCHAR,  
  MEMBER FUNCTION get_mgr ( p_pos NUMBER DEFAULT 1 ) RETURN NUMBER,
  MEMBER FUNCTION get_hiredate ( p_pos NUMBER DEFAULT 1 ) RETURN DATE,  
  MEMBER FUNCTION get_sal ( p_pos NUMBER DEFAULT 1 ) RETURN NUMBER,  
  MEMBER FUNCTION get_comm ( p_pos NUMBER DEFAULT 1 ) RETURN NUMBER,  
  MEMBER FUNCTION get_deptno ( p_pos NUMBER DEFAULT 1 ) RETURN NUMBER,

  MEMBER FUNCTION accumulate_emp_row ( p_empno IN NUMBER DEFAULT NULL
                                      ,p_ename IN VARCHAR2 DEFAULT NULL                                  
                                      ,p_job IN VARCHAR2 DEFAULT NULL
                                      ,p_mgr IN NUMBER DEFAULT NULL
                                      ,p_hiredate IN DATE DEFAULT NULL                                      
                                      ,p_sal IN NUMBER DEFAULT NULL                                      
                                      ,p_comm IN NUMBER DEFAULT NULL                                      
                                      ,p_deptno IN NUMBER DEFAULT NULL ) RETURN t_emp_row,

  MEMBER FUNCTION with_empno ( p_empno IN NUMBER ) RETURN t_employee,
  MEMBER FUNCTION with_ename ( p_ename IN VARCHAR2 ) RETURN t_employee, 
  MEMBER FUNCTION with_job ( p_job IN VARCHAR2 ) RETURN t_employee,  
  MEMBER FUNCTION with_mgr ( p_mgr IN NUMBER ) RETURN t_employee, 
  MEMBER FUNCTION with_hiredate ( p_hiredate IN DATE ) RETURN t_employee, 
  MEMBER FUNCTION with_sal ( p_sal IN NUMBER ) RETURN t_employee, 
  MEMBER FUNCTION with_comm ( p_comm IN NUMBER ) RETURN t_employee, 
  MEMBER FUNCTION with_deptno ( p_deptno IN NUMBER ) RETURN t_employee

);
/
SHOW ERRORS

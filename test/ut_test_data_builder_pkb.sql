CREATE OR REPLACE PACKAGE BODY ut_test_data_builder AS

  -- ( WHEN configure a department THEN can examine the departments configured values )
  PROCEDURE dept_configure_default_success IS
    l_department t_department := t_department(); 
  BEGIN
    ut.expect( l_department.get_deptno ).to_be_null();
    ut.expect( l_department.get_dname  ).to_be_null();  
    ut.expect( l_department.get_loc    ).to_be_null();  
  END;

  -- ( WHEN configure a department with specific values THEN can examine the departments configured values )
  PROCEDURE dept_configure_specific_success IS
    l_department t_department := t_department(); 
  BEGIN
    l_department := l_department.with_deptno( 1 ).with_dname( 'Test' ).with_loc( 'UK' );
  
    ut.expect( l_department.get_deptno ).to_equal( 1 );
    ut.expect( l_department.get_dname  ).to_equal( 'Test' );
    ut.expect( l_department.get_loc    ).to_equal( 'UK' );
  END;

  -- ( WHEN configure more that one department when deptno set THEN this raises exception )
  PROCEDURE dept_configure_multiple_with_deptno_failure IS
    l_department t_department := t_department(); 
  BEGIN
    l_department := l_department.with_deptno( 1 ).with_dname( 'Test' ).with_loc( 'UK' )
                                .with_deptno( 2 );
  END;

  -- ( WHEN configure more that one department when dname set THEN this raises exception )
  PROCEDURE dept_configure_multiple_with_dname_failure IS
    l_department t_department := t_department(); 
  BEGIN
    l_department := l_department.with_deptno( 1 ).with_dname( 'Test' ).with_loc( 'UK' )
                                .with_dname( 'Test2' );
  END;

  -- ( WHEN configure more that one department when loc set THEN this raises exception )
  PROCEDURE dept_configure_multiple_with_loc_failure IS
    l_department t_department := t_department(); 
  BEGIN
    l_department := l_department.with_deptno( 1 ).with_dname( 'Test' ).with_loc( 'UK' )
                                .with_loc( 'US' );
  END;

  ----

  -- ( WHEN configure a dept and associate an emp THEN can examine configured values )
  PROCEDURE dept_with_one_emp_success IS
    l_department t_department := t_department(); 
  BEGIN
    l_department := l_department.with_deptno( 1 ).with_dname( 'Test' ).with_loc( 'UK' )
                                .with_empno( 10 ).with_ename( 'Josephine' ).with_job( 'MANAGER' ).with_mgr( NULL ).with_hiredate( TO_DATE('01/01/2019','DD/MM/YYYY') ).with_sal ( 999 ). with_comm( 999 );
  
    ut.expect( l_department.get_empno ).to_equal( 10 ); 
    ut.expect( l_department.get_ename ).to_equal( 'Josephine' );  
    ut.expect( l_department.get_job   ).to_equal( 'MANAGER' );
    ut.expect( l_department.get_mgr   ).to_be_null;
    ut.expect( l_department.get_hiredate ).to_equal( TO_DATE('01/01/2019','DD/MM/YYYY') );
    ut.expect( l_department.get_sal   ).to_equal( 999 );
    ut.expect( l_department.get_comm  ).to_equal( 999 );
  END;

  -- ( WHEN configure a dept and associate two emp THEN can examine configured values )
  PROCEDURE dept_with_two_emp_success IS
    l_department t_department := t_department();
  BEGIN
    l_department := l_department.with_deptno( 1 ).with_dname( 'Test' ).with_loc( 'UK' )
                                .with_empno( 10 ).with_ename( 'Josephine' ).with_job( 'MANAGER' ).with_mgr( NULL ).with_hiredate( TO_DATE('01/01/2019','DD/MM/YYYY') ).with_sal ( 999 ). with_comm( 999 )
                                .with_empno( 20 ).with_ename( 'Joe' ).with_job( 'SALES' ).with_mgr( 10 ).with_hiredate( TO_DATE('02/01/2019','DD/MM/YYYY') ).with_sal ( 9999 ). with_comm( 9999 );

    ut.expect( l_department.get_employee_count ).to_equal( 2 ); 

    ut.expect( l_department.get_deptno ).to_equal( 1 ); 
    ut.expect( l_department.get_dname  ).to_equal( 'Test' );  
    ut.expect( l_department.get_loc    ).to_equal( 'UK' );

    ut.expect( l_department.get_empno ).to_equal( 10 ); 
    ut.expect( l_department.get_ename ).to_equal( 'Josephine' );  
    ut.expect( l_department.get_job   ).to_equal( 'MANAGER' );
    ut.expect( l_department.get_mgr   ).to_be_null;
    ut.expect( l_department.get_hiredate ).to_equal( TO_DATE('01/01/2019','DD/MM/YYYY') );
    ut.expect( l_department.get_sal   ).to_equal( 999 );
    ut.expect( l_department.get_comm  ).to_equal( 999 );
    
    ut.expect( l_department.get_empno(2) ).to_equal( 20 ); 
    ut.expect( l_department.get_ename(2) ).to_equal( 'Joe' );  
    ut.expect( l_department.get_job(2)   ).to_equal( 'SALES' );
    ut.expect( l_department.get_mgr(2)   ).to_equal( 10 );
    ut.expect( l_department.get_hiredate(2) ).to_equal( TO_DATE('02/01/2019','DD/MM/YYYY') );
    ut.expect( l_department.get_sal(2)   ).to_equal( 9999 );
    ut.expect( l_department.get_comm(2)  ).to_equal( 9999 );

  END;  
  
  ----
  
  -- ( WHEN configure a dept and associate one emp and build THEN values are stored )
  PROCEDURE dept_with_one_emp_build_success IS
    l_department t_department := t_department();
    
    l_dept t_dept_rowset;    
    l_dept_expected SYS_REFCURSOR;
    l_dept_actual SYS_REFCURSOR;

    l_emp t_emp_rowset;    
    l_emp_expected SYS_REFCURSOR;
    l_emp_actual SYS_REFCURSOR;
  BEGIN
    l_department := l_department.with_deptno( 1 ).with_dname( 'Test' ).with_loc( 'UK' )
                                .with_empno( 10 ).with_ename( 'Josephine' ).with_job( 'MANAGER' ).with_mgr( NULL ).with_hiredate( TO_DATE('01/01/2019','DD/MM/YYYY') ).with_sal ( 999 ). with_comm( 999 )
                                .build();

    l_dept := l_department.get_department;
    OPEN l_dept_expected FOR SELECT deptno, dname, loc FROM TABLE(l_dept);
    OPEN l_dept_actual FOR SELECT deptno, dname, loc FROM dept;
    
    ut.expect( l_dept_actual ).to_equal( l_dept_expected );
      
    l_emp := l_department.get_employees;   
    OPEN l_emp_expected FOR SELECT empno, ename, job, mgr, hiredate, sal, comm, deptno FROM TABLE(l_emp);
    OPEN l_emp_actual FOR SELECT empno, ename, job, mgr, hiredate, sal, comm, deptno FROM emp;
    
    ut.expect( l_emp_actual ).to_equal( l_emp_expected );       
  END;    

  --%test( WHEN configure a dept and associate many emp and build THEN values are stored)
  PROCEDURE dept_with_many_emp_build_success IS
    l_department t_department := t_department();
    
    l_dept t_dept_rowset;    
    l_dept_expected SYS_REFCURSOR;
    l_dept_actual SYS_REFCURSOR;

    l_emp t_emp_rowset;    
    l_emp_expected SYS_REFCURSOR;
    l_emp_actual SYS_REFCURSOR;
  BEGIN
    l_department := l_department.with_deptno( 1 ).with_dname( 'Test' ).with_loc( 'UK' )
                                .with_empno( 10 ).with_ename( 'Josephine' ).with_job( 'MANAGER' ).with_mgr( NULL ).with_hiredate( TO_DATE('01/01/2019','DD/MM/YYYY') ).with_sal ( 99999 ). with_comm( 99999 )
                                .with_empno( 30 ).with_ename( 'Stephanie' ).with_job( 'ACCOUNTS' ).with_mgr( 10 ).with_hiredate( TO_DATE('02/01/2019','DD/MM/YYYY') ).with_sal ( 999 ). with_comm( 999 )
                                .with_empno( 40 ).with_ename( 'Steve' ).with_job( 'JUNIOR' ).with_mgr( 10 ).with_hiredate( TO_DATE('03/01/2019','DD/MM/YYYY') ).with_sal ( 99 ). with_comm( 99 )                               
                                .build();


    l_dept := l_department.get_department;
    OPEN l_dept_expected FOR SELECT deptno, dname, loc FROM TABLE(l_dept);
    OPEN l_dept_actual FOR SELECT deptno, dname, loc FROM dept;
    
    ut.expect( l_dept_actual ).to_equal( l_dept_expected );
      
    l_emp := l_department.get_employees;   
    OPEN l_emp_expected FOR SELECT empno, ename, job, mgr, hiredate, sal, comm, deptno FROM TABLE(l_emp);
    OPEN l_emp_actual FOR SELECT empno, ename, job, mgr, hiredate, sal, comm, deptno FROM emp;
    
    ut.expect( l_emp_actual ).to_equal( l_emp_expected );       
  END; 


END ut_test_data_builder;
/
SHOW ERRORS

CREATE OR REPLACE PACKAGE ut_test_data_builder AS
  --%suite(Test Data Builder)
  
  --%test( WHEN configure a department with default values THEN can examine the departments configured values)
  PROCEDURE dept_configure_default_success;

  --%test( WHEN configure a department with specific values THEN can examine the departments configured values)
  PROCEDURE dept_configure_specific_success;

  --%test( WHEN configure more that one department when deptno set THEN this raises exception)
  --%throws( -20001 )
  PROCEDURE dept_configure_multiple_with_deptno_failure;

  --%test( WHEN configure more that one department when dname set THEN this raises exception)
  --%throws( -20001 )
  PROCEDURE dept_configure_multiple_with_dname_failure;

  --%test( WHEN configure more that one department when loc set THEN this raises exception)
  --%throws( -20001 )
  PROCEDURE dept_configure_multiple_with_loc_failure;

  ----

  --%test( WHEN configure a dept and associate an emp THEN can examine configured values)
  PROCEDURE dept_with_one_emp_success;

  --%test( WHEN configure a dept and associate two emp THEN can examine configured values)
  PROCEDURE dept_with_two_emp_success;  

  ----

  --%test( WHEN configure a dept and associate one emp and build THEN values are stored)
  PROCEDURE dept_with_one_emp_build_success;  

  --%test( WHEN configure a dept and associate many emp and build THEN values are stored)
  PROCEDURE dept_with_many_emp_build_success;  

-- Additional tests...
--   verify order of with calls doesn't affect results
--   ...
--
END ut_test_data_builder;
/
SHOW ERRORS
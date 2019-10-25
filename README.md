# data-builder-simple
A demo of the builder pattern for test data creation in PLSQL

### Introduction
The builder pattern provides an API that simplifies the specification and creation of persistent data. This implementation provides an example based on the EMP/DEPT schema provdied by the Oracle RDBMS. 

One use of this pattern is in test suites. Without a data creation API, data creation can involve long sections of code unrelated to the item under test. Understanding tests with lengthy data setup, and which aspects of the implementation are directly relevent to the test scope becomes challenging.

A data API creates a terse means of configuring any data pre-requisites. Investing in a standard means of configuring data that appears in all tests, means that developers become familiar with this style of data configuration and can immediately undertstand the intended outcome of the data setup.

#### Example

Here's an example that configures a department with pre-defined values and associates an employee with the same depatment. The build() call then persists the configuration to the data model. A test framework like utPLSQL allow for data creation to take place, with data cleanup occurring via a ROLLBACK that is handled by the test framework implicitly;

```sql
  PROCEDURE dept_with_two_emp_success IS
    l_department t_department := t_department();
  BEGIN
    l_department := l_department.with_deptno( 1 ).with_dname( 'Test' ).with_loc( 'UK' )
                      .with_empno( 10 ).with_ename( 'Josephine' ).with_job( 'MANAGER' ).with_mgr( NULL ).with_hiredate( TO_DATE('01/01/2019','DD/MM/YYYY') ).with_sal ( 999 ). with_comm( 999 )
                      .build();

    -- take an action against the item under test
    
    -- assert on the outcome
    
  END;  
```
#### Extensions

* Use of default values for fields avoid the need to specify all values
* Use of standard data configurations can be created and re-used in tests. This works very well for more complicated domains where it is useful to hide the complicated data configuration where this is not relevant to the test. So, creating a new wrapper API to only expose the data details relevent to the test can be useful
* When creating a set of standard data configurations, it can be useful for this API to return the key data for the data created. Especially where the key data is a surrogate populated by a sequence (meaning each invocation produces a different key identifier)

### Inspiration

There are two main sources for the inspiration behind the idea of a data API:

1. Working Effectively with Unit Tests, by Jay Fields
2. Growing Object-Oriented Software, Guided by Tests, by Steve Freeman and Nat Pryce

Plus a blog post by Nat Pryce [on the same subject.](http://www.natpryce.com/articles/000714.html)

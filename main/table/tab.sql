
CREATE TABLE dept (
   deptno   NUMBER(2)     CONSTRAINT pk_dept PRIMARY KEY,
   dname    VARCHAR2(14),
   loc      VARCHAR2(13) 
);

CREATE TABLE emp (
   empno    NUMBER(4)     CONSTRAINT pk_emp PRIMARY KEY,
   ename    VARCHAR2(10),
   job      VARCHAR2(9),
   mgr      NUMBER(4),
   hiredate DATE,
   sal      NUMBER(7,2),
   comm     NUMBER(7,2),
   deptno   NUMBER(2)     CONSTRAINT fk_deptno REFERENCES dept
);

ALTER TABLE emp MODIFY (
   deptno NOT NULL
);

ALTER TABLE emp ADD (
   constraint fk_mgr FOREIGN KEY (mgr) references emp 
);



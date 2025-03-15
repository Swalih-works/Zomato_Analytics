create database DeptAnalysis;

CREATE TABLE `empanyl` (
  `empno` integer primary key,
  `ename` varchar(20) DEFAULT NULL,
   `job` varchar(20) DEFAULT NULL,
  `mgr` decimal(6,0) NULL,
  `HIRE_DATE` date NOT NULL,
  `sal` decimal(8,2) DEFAULT NULL,
  `comm` decimal(6,2) DEFAULT NULL,
  `deptno` integer ,foreign key (deptno) references deptabl(deptno));

select *from empanyl;

CREATE TABLE `deptabl` (
  `deptno` integer primary key,
  `dname` varchar(20) DEFAULT NULL,
   `loc` varchar(20) DEFAULT NULL
   );

select *from deptabl;



CREATE TABLE `jobgrades` (
  `grade` varchar(3) NOT NULL,
  `lowest_sal` decimal(6,0) NOT NULL DEFAULT 0,
  `highest_sal` decimal(6,0) NOT NULL DEFAULT 0
   );
   
   SELECT *from jobgrades;

INSERT INTO `empanyl` VALUES (7369,'SMITH','CLERK',7902,'1890-12-17',800.00,null,20),
 (7499,'ALLEN','SALESMAN',7698,'1981-02-20',1600.00,300.00,30),
(7521,'WARD','SALESMAN',7698,'1981-02-22',1250.00,500.00,30),
(7566,'JONES','MANAGER',7839,'1981-04-02',2975.00,null,20),
(7654,'MARTIN','SALESMAN',7698,'1981-09-28',1250.00,1400.00,30),
 (7698,'BLAKE','MANAGER',7839,'1981-05-01',2850.00,null,30),
 (7782,'CLARK','MANAGER',7839,'1981-06-09',2450.00,null,10),
 (7788,'SCOTT','ANALYST',7566,'1987-04-19',3000.00,null,20),
 (7839,'KING','PRESIDENT',null,'1981-11-17',5000.00,null,10),
 (7844,'TURNER','SALESMAN',7698,'1981-09-08',1500.00,0.00,30),
 (7876,'ADAMS','CLERK',7788,'1987-05-23',1100.00,null,20),
 (7900,'JAMES','CLERK',7698,'1981-12-03',950.00,null,30),
(7902,'FORD','ANALYST',7566,'1981-12-03',3000.00,null,20),
(7934,'MILLER','CLERK',7782,'1982-01-23',1300.00,null,10);

insert into deptabl values (10,'OPERATIONS','BOSTON'),
 (20,'RESEARCH','DALLAS'),
 (30,'SALES','CHICAGO'),
 (40,'ACCOUNTING','NEWYORK');


insert into jobgrades values ('A','0','999'),
('B','1000','1999'),
('C','2000','2999'),
('D','3000','3999'),
('E','4000','5000');


#	3. List the Names and salary of the employee whose salary is greater than 1000

select ename, sal
from empanyl
where sal>1000;


# 4. List the details of the employees who have joined before end of September 81.

select *
from empanyl
where HIRE_DATE <('1981-09-30');


# 5. List Employee Names having I as second character.

select ename
from empanyl
where ename LIKE '_I%';

# 6. List Employee Name, Salary, Allowances (40% of Sal), P.F. (10 % of Sal) and Net Salary. Also assign the alias name for the columns


Select ename as "Employee Name",
    sal as "Salary",
    (sal * 0.4) as "Allowances",
    (sal * 0.1) as "PF",
    (sal + (sal * 0.4) - (sal * 0.1)) AS "Net Salary"
from empanyl;


# 7. List Employee Names with designations who does not report to anybody

select ename as "Employee Name", 
       job as "Designation"
       from empanyl
       where mgr is null;

# 8.	List Empno, Ename and Salary in the ascending order of salary.

select empno as "Employee Num",
       ename as "Employee Name",
       sal as "Salary"
       from empanyl
       order by sal asc;

# 9	How many jobs are available in the Organization

select count(distinct job) as "Number of Unique Jobs"
from empanyl;

select distinct job
from empanyl;


# 10  Determine total payable salary of salesman category


select Sum(sal) as "Total Payable Salary"
from empanyl
where job ='SALESMAN';


# 11  List average monthly salary for each job within each department   

select  deptno as "Department Number",
    job as "Job Title",
    AVG(sal) as "Average Monthly Salary"
    from empanyl
    group by deptno, job
    order by deptno, job;
    
    
# 12 Use the Same EMP and DEPT table used in the Case study to Display EMPNAME, SALARY and DEPTNAME in which the employee is working. 
    
	select e.ename AS "Employee Name",
           e.sal AS "Salary",
           d.dname AS "Department Name"
		   from empanyl e
		   JOIN deptabl d
		   ON e.deptno = d.deptno;
           
# 14 Display the last name, salary and  Corresponding Grade.         
  

  select e.ename,e.sal,
  case when e.sal between 0 and 999 then 'A'
       when e.sal between 1000 and 1999 then 'B'
       when e.sal between 2000 and 2999 then 'C'
       when e.sal between 3000 and 3999 then 'D'
       when e.sal between 4000 and 5000 then 'E'
	   end as grade
       from empanyl e;
  
select ename,sal,
  case when sal between 0 and 999 then 'A'
       when sal between 1000 and 1999 then 'B'
       when sal between 2000 and 2999 then 'C'
       when sal between 3000 and 3999 then 'D'
       when sal between 4000 and 5000 then 'E'
	   end as grade
       from empanyl ;
       
       
# 15  Display the Emp name and the Manager name under whom the Employee works in the below format .

# Emp Report to Mgr.


select e1.ename as "ename", e2.mgr as "mgr"
from empanyl e1
join empanyl e2 on e1.mgr = e2.ename;

       
# 16  Display Empname and Total sal where Total Sal (sal + Comm)

select ename as EmpName,
(sal + COALESCE(comm, 0)) as TotalSal
from empanyl;



# 17 Display Empname and Sal whose empno is a odd number

select ename, Sal
from empanyl
where mod(empno,2) = 1;


# 18 Display Empname , Rank of sal in Organisation , Rank of Sal in their department

select ename,sal,
rank() over (order by sal desc) as OrgRank,
rank() over (partition by deptno order by sal desc) as DeptRank
from empanyl
order by deptno,OrgRank;

select ename,sal,
dense_rank() over (order by sal desc) as OrgRank,
dense_rank() over (partition by deptno order by sal desc) as DeptRank
from empanyl
order by deptno,OrgRank;



# 19 Display Top 3 Empnames based on their Salary

select ename, sal
from empanyl
order by sal desc
limit 3;

with S as (select empno,ename,sal,
   DENSE_RANK() over(order by sal desc) as RNK from empanyl)
   select *from S where RNK in(1,2,3);
   

# 20 Display Empname who has highest Salary in Each Department.

select ename, deptno, sal
from empanyl e
where sal = ( select MAX(sal)
    from empanyl
    where deptno = e.deptno)
order by deptno;


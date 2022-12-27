DROP TABLE IF EXISTS job_titles CASCADE;
DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS departments CASCADE;
DROP TABLE IF EXISTS department_employees;
DROP TABLE IF EXISTS department_manager;
DROP TABLE IF EXISTS salaries;


-- Create new tables to import data
CREATE TABLE job_titles (
	title_id VARCHAR(255) NOT NULL,
	title VARCHAR(255),
	PRIMARY KEY (title_id)
	);
	
CREATE TABLE employees (
	emp_no INT NOT NULL,
	emp_title_id VARCHAR(255) NOT NULL,
	birth_date DATE,
	first_name VARCHAR(255),
	last_name VARCHAR(255),
	sex VARCHAR(255),
	hire_date DATE,
	PRIMARY KEY (emp_no),
	FOREIGN KEY (emp_title_id) REFERENCES job_titles(title_id)		
	);
	
CREATE TABLE departments (
	dept_no VARCHAR(255) NOT NULL,
	dept_name VARCHAR(255),
	PRIMARY KEY (dept_no)
	);

CREATE TABLE department_employees (
	emp_no INT NOT NULL,
	dept_no VARCHAR(255) NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
	);
	
CREATE TABLE department_manager (
	dept_no VARCHAR(255) NOT NULL,
	emp_no INT NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)		
	);
	
CREATE TABLE salaries (
	emp_no INT NOT NULL,
	salary INT,	
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)	
	);
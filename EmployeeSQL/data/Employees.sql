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


-- Data Analysis
-- 1. List the employee number, last name, first name, sex, and salary of each employee.
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary 
FROM employees 
LEFT JOIN salaries
ON salaries.emp_no = employees.emp_no;


-- 2. List the first name, last name, and hire date for the employees who were hired in 1986.
-- SELECT first_name, last_name, hire_date FROM employees WHERE hire_date LIKE '1986%';
SELECT first_name, last_name, hire_date FROM employees WHERE (date_part ('year', hire_date) = 1986);


-- 3. List the manager of each department along with their department number, department name, 
-- employee number, last name, and first name.
SELECT departments.dept_no, departments.dept_name, department_manager.emp_no, employees.last_name, employees.first_name
FROM departments
LEFT JOIN department_manager
ON department_manager.dept_no = departments.dept_no
LEFT JOIN employees
ON department_manager.emp_no = employees.emp_no;


-- 4. List the department number for each employee along with that employee’s employee number, 
-- last name, first name, and department name.
SELECT departments.dept_no, employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
LEFT JOIN department_employees
ON department_employees.emp_no = employees.emp_no
LEFT JOIN departments
ON departments.dept_no = department_employees.dept_no;


-- 5. List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%'


-- 6. List each employee in the Sales department, including their employee number, last name, and first name.
SELECT emp_no, last_name, first_name
FROM employees
WHERE emp_no in 
	(SELECT emp_no FROM department_employees
	 WHERE dept_no = 'd007');


-- 7. List each employee in the Sales and Development departments, including their 
-- employee number, last name, first name, and department name.
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
LEFT JOIN department_employees
ON employees.emp_no = department_employees.emp_no
LEFT JOIN departments
ON department_employees.dept_no = departments.dept_no
WHERE employees.emp_no in 
	(SELECT emp_no FROM department_employees
	 WHERE dept_no = 'd007' OR dept_no = 'd005');


-- 8. List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT last_name, COUNT(emp_no) AS "Frequency Counts"
FROM employees
GROUP BY last_name
ORDER BY "Frequency Counts" DESC;
CREATE TABLE employees(
	emp_no INT PRIMARY KEY,
	birth_date DATE,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	gender VARCHAR(10),
	hire_date DATE
);

CREATE TABLE departments(
	dept_no VARCHAR(4),
	dept_name VARCHAR(30)
);

CREATE TABLE dept_employees(
	emp_no INT,
	dept_no VARCHAR(4),
	from_date DATE,
	to_date DATE,
	FOREIGN KEY(emp_no) REFERENCES employees(emp_no)
);
 
CREATE TABLE dept_manager(
	dept_no VARCHAR(4),
	emp_no INT,
	from_date DATE,
	to_date DATE,
	FOREIGN KEY(emp_no) REFERENCES employees(emp_no)
);

CREATE TABLE salaries(
	emp_no INT,
	salary INT,
	from_date DATE,
	to_date DATE,
	FOREIGN KEY(emp_no) REFERENCES employees(emp_no)
);

CREATE TABLE titles(
	emp_no INT,
	title VARCHAR(35),
	from_date DATE,
	to_date DATE,
	FOREIGN KEY(emp_no) REFERENCES employees(emp_no)
);

-- List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.gender, salaries.salary
FROM employees
JOIN salaries
	ON employees.emp_no=salaries.emp_no;

-- List employees who were hired in 1986.
SELECT * FROM employees
WHERE extract(year from hire_date) = 1986;

-- List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
SELECT dept_manager.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name, dept_manager.from_date, dept_manager.to_date
FROM dept_manager
JOIN departments ON departments.dept_no = dept_manager.dept_no 
JOIN employees ON employees.emp_no = dept_manager.emp_no;

-- List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, depart.dept_name
FROM dept_employees de
JOIN employees e ON e.emp_no = de.emp_no
JOIN departments depart ON depart.dept_no = de.dept_no;
-- List all employees whose first name is "Hercules" and last names begin with "B."
SELECT * FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%'

-- List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, depart.dept_name
FROM dept_employees de
JOIN employees e ON e.emp_no = de.emp_no
JOIN departments depart ON depart.dept_no = de.dept_no
WHERE dept_name = 'Sales';

-- List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, depart.dept_name
FROM dept_employees de
JOIN employees e ON e.emp_no = de.emp_no
JOIN departments depart ON depart.dept_no = de.dept_no
WHERE dept_name = 'Sales' OR dept_name = 'Development';

-- In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, COUNT(last_name) FROM employees
GROUP BY last_name
ORDER BY COUNT(last_name) DESC;


--Create retirement titles list with join on titles and employees
SELECT e.emp_no, 
	e.first_name, 
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM titles as t
RIGHT JOIN employees as e
ON e.emp_no = t.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no
--Print list and mannaully save CSV
SELECT *
FROM retirement_titles


-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
WHERE (to_date='9999-01-01')
ORDER BY emp_no, to_date DESC;
--Print list and manually save CSV
SELECT *
FROM unique_titles

--Create retiring count by title
SELECT title, COUNT(title)
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;

SELECT * 
FROM retiring_titles

--Create Mentorship Eligibilty table 
SELECT DISTINCT ON (emp_no) e.emp_no, 
	e.first_name, 
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibilty
FROM employees as e
	INNER JOIN dept_emp AS de
		ON (e.emp_no=de.emp_no)
	INNER JOIN titles AS t
		ON (e.emp_no = t.emp_no)
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31') AND (de.to_date='9999-01-01')
ORDER BY emp_no

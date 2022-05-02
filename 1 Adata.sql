CREATE TABLE employees (
employee_id INT NOT NULL auto_increment,
name VARCHAR(15),
surname VARCHAR(15), 
birth_date DATE,
hire_date DATE, 
PRIMARY KEY(employee_id));

CREATE TABLE departments (
department_id INT NOT NULL auto_increment,
dep_name VARCHAR(30),
PRIMARY KEY(department_id));

CREATE TABLE positions (
position_id INT NOT NULL auto_increment,
position_name VARCHAR(30),
PRIMARY KEY(position_id));

CREATE TABLE staff (
employee_id INT,
department_id INT, 
position_id INT,
from_date DATE,
to_date DATE, 
foreign key (employee_id) REFERENCES employees(employee_id),
foreign key (department_id) REFERENCES departments(department_id),
foreign key (position_id) REFERENCES positions(position_id));

CREATE TABLE salaries (
employee_id INT,
salary INT,
from_date DATE,
to_date DATE, 
foreign key (employee_id) REFERENCES employees(employee_id));

INSERT INTO employees(name, surname, birth_date, hire_date)
VALUES ('Султан', 'Султанов', '1995-01-01', '2019-05-11'), 
('Екатерина', 'Иванова', '2000-05-09', '2020-07-25'),
( 'Давид', 'Манукян',  '1999-12-01', '2022-01-01'),
('Николай', 'Петров', '2002-05-02',  '2021-05-25'),
('Давид', 'Микеланджело', '1990-02-02', '2019-01-01'),
('Динара', 'Нурланова', '1996-08-02', '2020-02-01'),
('Нуржан', 'Нуржанов', '1995-10-16', '2019-01-01');

insert into departments (dep_name)
VALUES ('Снабжение'), 
('Разработка'),
('Аналитика'),
('Продажи'),
('Маркетинг');

insert into positions (position_name)
VALUES ('Менеджер'), 
('Дизайнер'),
('Аналитик'),
('Маркетолог'),
('Руководитель Департамента'), 
('Заместитель Руководителя');

INSERT INTO staff(employee_id, department_id, position_id, from_date, to_date)
VALUES (1,1,1,'2019-05-11', '9999-01-01'), 
(2,2,3,'2020-07-25', '9999-01-01'), 
(3,1,1,'2022-01-01', '9999-01-01'), 
(4,1,1,'2021-05-25', '2022-01-01'), 
(4,1,6,'2022-01-02', '9999-01-01'), 
(5,1,1,'2019-01-01', '9999-01-01'), 
(6,3,6,'2020-02-01', '9999-01-01'), 
(7,2,1,'2019-01-01', '9999-01-01');

INSERT INTO salaries(employee_id, salary, from_date, to_date)
VALUES (1, 200000,'2019-05-11', '9999-01-01'), 
(2,350000,'2020-07-25', '9999-01-01'), 
(3,800000,'2022-01-01', '9999-01-01'), 
(4,280000,'2021-05-25', '2022-01-01'), 
(4,950000,'2022-01-02', '9999-01-01'), 
(5,380000,'2019-01-01', '9999-01-01'), 
(6,800000,'2020-02-01', '9999-01-01'), 
(7,500000,'2019-01-01', '9999-01-01');

SELECT e.name, e.surname, s.salary, p.position_name
FROM employees e 
LEFT JOIN staff st ON st.employee_id = e.employee_id
LEFT JOIN departments d ON d.department_id = st.department_id
LEFT JOIN positions p ON p.position_id = st.position_id
LEFT JOIN salaries s ON s.employee_id = e.employee_id
WHERE e.name = 'Давид' and d.dep_name = 'Снабжение';

SELECT d.dep_name, AVG(s.salary) as Средняя_заработная_плата
FROM staff st 
LEFT JOIN departments d ON d.department_id = st.department_id
LEFT JOIN salaries s ON s.employee_id = st.employee_id
GROUP BY d.dep_name;

SELECT p.position_name, AVG(s.salary) as Средняя_заработная_плата, 
CASE WHEN AVG(s.salary)>(SELECT avg(salary) from salaries) 
THEN 'Да'
else 'Нет'
END as 'Больше ли общей средней ЗП'
FROM staff st 
LEFT JOIN positions p ON p.position_id = st.position_id
LEFT JOIN salaries s ON s.employee_id = st.employee_id
GROUP BY p.position_name;



-- validar si hay referencias adicionales de category_id y confirmar si alguna otra tabla necesita ajustes


SELECT
    a.table_name AS tabla_referencia,
    a.column_name AS columna_foranea,
    c.constraint_name AS nombre_constraint,
    c_pk.table_name AS tabla_referenciada,
    c_pk.column_name AS columna_primaria
FROM
    all_cons_columns a
JOIN
    all_constraints c ON a.constraint_name = c.constraint_name
JOIN
    all_cons_columns c_pk ON c.r_constraint_name = c_pk.constraint_name
WHERE
    c.constraint_type = 'R'
    AND c_pk.table_name = 'CATEGORIES'
    AND c_pk.column_name = 'CATEGORY_ID'
ORDER BY
    a.table_name;



--NECESITAMOS CREAR 20 INSERTS PARA ESTA TABLA TODO RELACIONADO CON LO ANTERIOR CREADO
--Desactivar Variables de Sustituci�n
SET DEFINE OFF;
SET DEFINE ON;
--1. Creaci�n de Tablas Principales
CREATE TABLE categories (
    category_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    description VARCHAR2(255)
);

--Tabla de Productos (products)

CREATE TABLE products (
    product_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    description VARCHAR2(255),
    price NUMBER(10, 2) NOT NULL,
    stock_quantity NUMBER NOT NULL,
    category_id NUMBER,
    CONSTRAINT fk_category FOREIGN KEY (category_id)
    REFERENCES categories(category_id)
);

--Tabla de Clientes (customers)
CREATE TABLE customers (
    customer_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    email VARCHAR2(100),
    phone_number VARCHAR2(20),
    address VARCHAR2(255)
);

--Tabla de Departamentos (departments)
CREATE TABLE departments (
    department_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name VARCHAR2(100) NOT NULL
);

--Tabla de Empleados (employees)

CREATE TABLE employees (
    employee_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    position VARCHAR2(50),
    hire_date DATE,
    salary NUMBER(10, 2),
    department_id NUMBER,
    CONSTRAINT fk_department FOREIGN KEY (department_id)
    REFERENCES departments(department_id)
);

--Tabla de Proveedores (suppliers)
CREATE TABLE suppliers (
    supplier_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    contact_name VARCHAR2(100),
    phone_number VARCHAR2(20),
    email VARCHAR2(100)
);

--2. Creaci�n de Tablas Dependientes
--Tabla de �rdenes (orders)

CREATE TABLE orders (
    order_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    order_date DATE NOT NULL,
    customer_id NUMBER,
    employee_id NUMBER,
    CONSTRAINT fk_customer FOREIGN KEY (customer_id)
    REFERENCES customers(customer_id),
    CONSTRAINT fk_employee FOREIGN KEY (employee_id)
    REFERENCES employees(employee_id)
);

--Tabla de Detalles de la Orden (order_details)
CREATE TABLE order_details (
    order_detail_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    order_id NUMBER,
    product_id NUMBER,
    quantity NUMBER NOT NULL,
    unit_price NUMBER(10, 2) NOT NULL,
    CONSTRAINT fk_order FOREIGN KEY (order_id)
    REFERENCES orders(order_id),
    CONSTRAINT fk_product FOREIGN KEY (product_id)
    REFERENCES products(product_id)
);


--Tabla de Compras a Proveedores (supplier_orders)
CREATE TABLE supplier_orders (
    supplier_order_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    supplier_id NUMBER,
    order_date DATE NOT NULL,
    total_amount NUMBER(10, 2),
    CONSTRAINT fk_supplier FOREIGN KEY (supplier_id)
    REFERENCES suppliers(supplier_id)
);
--Tabla de Detalle de Compras a Proveedores (supplier_order_details)

CREATE TABLE supplier_order_details (
    supplier_order_detail_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    supplier_order_id NUMBER,
    product_id NUMBER,
    quantity NUMBER NOT NULL,
    unit_price NUMBER(10, 2) NOT NULL,
    CONSTRAINT fk_supplier_order FOREIGN KEY (supplier_order_id)
    REFERENCES supplier_orders(supplier_order_id),
    CONSTRAINT fk_supplier_product FOREIGN KEY (product_id)
    REFERENCES products(product_id)
);


------------------------------------
--A PARTIR DE AQUI NO SE HA HECHO
------------------------------------


--Creaci�n de Consultas de Soporte 

--Consulta de inventario para productos con bajo stock:
SELECT name, stock_quantity 
FROM products 
WHERE stock_quantity < 10;

--Reporte de ventas mensuales:
SELECT TO_CHAR(order_date, 'YYYY-MM') AS month, 
       SUM(unit_price * quantity) AS total_sales 
FROM orders o 
JOIN order_details od ON o.order_id = od.order_id 
GROUP BY TO_CHAR(order_date, 'YYYY-MM');








--1. Creaci�n de Roles
--Rol de Administrador
--Este rol tendr� permisos completos para realizar todas las operaciones de gesti�n, incluyendo la administraci�n de productos, categor�as, clientes, empleados, �rdenes, y proveedores.


-- Crear el rol de administrador
CREATE ROLE rol_admin;

-- Otorgar permisos al rol de administrador
GRANT CREATE SESSION TO rol_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON products TO rol_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON categories TO rol_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON customers TO rol_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON employees TO rol_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON departments TO rol_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON orders TO rol_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON order_details TO rol_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON suppliers TO rol_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON supplier_orders TO rol_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON supplier_order_details TO rol_admin;


--Rol de Operador
--Este rol tendr� permisos limitados, especialmente para realizar consultas y registrar nuevas �rdenes, pero sin acceso a operaciones de administraci�n como la modificaci�n de productos o categor�as.
-- Crear el rol de operador
CREATE ROLE rol_operador;

-- Otorgar permisos al rol de operador
GRANT CREATE SESSION TO rol_operador;
GRANT SELECT ON products TO rol_operador;
GRANT SELECT ON categories TO rol_operador;
GRANT SELECT, INSERT ON customers TO rol_operador;
GRANT SELECT, INSERT ON orders TO rol_operador;
GRANT SELECT, INSERT ON order_details TO rol_operador;
GRANT SELECT ON employees TO rol_operador;

--2. Asignaci�n de Roles a Usuarios
--Con estos roles creados, puedes asign�rselos a diferentes usuarios para que tengan acceso seg�n sus funciones. Por ejemplo:

-- Crear usuario de administrador y asignarle rol
CREATE USER admin_user IDENTIFIED BY admin_password;
GRANT rol_admin TO admin_user;

-- Crear usuario de operador y asignarle rol
CREATE USER operador_user IDENTIFIED BY operador_password;
GRANT rol_operador TO operador_user;


--3. Revisi�n y Prueba de Permisos
--Inicia sesi�n con cada uno de los usuarios (admin_user y operador_user) para verificar que cada uno tiene acceso �nicamente a las operaciones que corresponden a su rol:

---admin_user deber�a poder realizar cualquier operaci�n en todas las tablas.
--operador_user deber�a poder consultar datos y registrar �rdenes y clientes, pero sin permisos para modificar o eliminar productos y categor�as.
--4. Configuraci�n Adicional (Opcional)
--Si en el futuro se necesitan ajustes, puedes revocar o otorgar permisos adicionales a los roles mediante:

-- Revocar un permiso espec�fico
REVOKE DELETE ON products FROM rol_operador;

-- Otorgar un nuevo permiso espec�fico
GRANT UPDATE ON customers TO rol_operador;
Este esquema permite administrar de forma flexible los permisos de los usuarios y cumplir con los requerimientos de seguridad y control del sistema del supermercado.



--categories.
DELETE FROM categories;


INSERT INTO categories (category_id, name, description) VALUES (1, 'Bebidas', 'Refrescos, jugos, agua y otras bebidas.');
INSERT INTO categories (category_id, name, description) VALUES (2, 'L�cteos', 'Productos como leche, yogures y quesos.');
INSERT INTO categories (category_id, name, description) VALUES (3, 'Carnes', 'Productos de carnes rojas, pollo y pescado.');
INSERT INTO categories (category_id, name, description) VALUES (4, 'Panader�a', 'Pan, galletas y productos horneados.');
INSERT INTO categories (category_id, name, description) VALUES (5, 'Frutas', 'Frutas frescas de temporada.');
INSERT INTO categories (category_id, name, description) VALUES (6, 'Verduras', 'Verduras y hortalizas frescas.');
INSERT INTO categories (category_id, name, description) VALUES (7, 'Granos', 'Granos y legumbres.');
INSERT INTO categories (category_id, name, description) VALUES (8, 'Snacks', 'Botanas y bocadillos.');
INSERT INTO categories (category_id, name, description) VALUES (9, 'Dulces', 'Caramelos, chocolates y postres.');
INSERT INTO categories (category_id, name, description) VALUES (10, 'Cereales', 'Cereales para desayuno y granolas.');
INSERT INTO categories (category_id, name, description) VALUES (11, 'Condimentos', 'Salsas, especias y condimentos.');
INSERT INTO categories (category_id, name, description) VALUES (12, 'Pastas', 'Pasta y productos relacionados.');
INSERT INTO categories (category_id, name, description) VALUES (13, 'Aceites', 'Aceites de cocina y otros.');
INSERT INTO categories (category_id, name, description) VALUES (14, 'Congelados', 'Productos congelados.');
INSERT INTO categories (category_id, name, description) VALUES (15, 'Beb�s', 'Productos para cuidado de beb�s.');
INSERT INTO categories (category_id, name, description) VALUES (16, 'Aseo personal', 'Productos de higiene personal.');
INSERT INTO categories (category_id, name, description) VALUES (17, 'Limpieza', 'Art�culos de limpieza y desinfecci�n.');
INSERT INTO categories (category_id, name, description) VALUES (18, 'Mascotas', 'Alimentos y productos para mascotas.');
INSERT INTO categories (category_id, name, description) VALUES (19, 'Electr�nica', 'Peque�os electrodom�sticos y electr�nica.');
INSERT INTO categories (category_id, name, description) VALUES (20, 'Ropa', 'Ropa y textiles.');



SELECT * FROM categories;
SELECT * FROM employees;

--products, utilizando las categor�as que creaste anteriormente:


-- Ajuste de los datos en la tabla products para que coincidan con los nuevos category_id

-- Ajuste de los datos en la tabla products para que coincidan con los nuevos category_id

INSERT INTO products (name, description, price, stock_quantity, category_id) VALUES ('Coca Cola', 'Refresco de cola en lata', 1.50, 100, 1);
INSERT INTO products (name, description, price, stock_quantity, category_id) VALUES ('Yogur Natural', 'Yogur bajo en grasa', 0.99, 50, 2);
INSERT INTO products (name, description, price, stock_quantity, category_id) VALUES ('Pechuga de Pollo', 'Pechuga de pollo fresco', 5.99, 30, 3);
INSERT INTO products (name, description, price, stock_quantity, category_id) VALUES ('Pan Integral', 'Pan integral para tostadas', 2.00, 75, 4);
INSERT INTO products (name, description, price, stock_quantity, category_id) VALUES ('Manzanas', 'Frutas frescas y crujientes', 0.50, 200, 5);
INSERT INTO products (name, description, price, stock_quantity, category_id) VALUES ('Lechuga', 'Lechuga fresca para ensaladas', 1.20, 150, 6);
INSERT INTO products (name, description, price, stock_quantity, category_id) VALUES ('Arroz', 'Arroz de grano largo', 1.75, 100, 7);
INSERT INTO products (name, description, price, stock_quantity, category_id) VALUES ('Tortilla de Ma�z', 'Tortillas frescas de ma�z', 2.50, 60, 8);
INSERT INTO products (name, description, price, stock_quantity, category_id) VALUES ('Chocolate', 'Tableta de chocolate negro', 1.25, 80, 9);
INSERT INTO products (name, description, price, stock_quantity, category_id) VALUES ('Cereal de Avena', 'Cereal de avena integral', 3.00, 90, 10);
INSERT INTO products (name, description, price, stock_quantity, category_id) VALUES ('Ketchup', 'Salsa de tomate para hamburguesas', 1.00, 120, 11);
INSERT INTO products (name, description, price, stock_quantity, category_id) VALUES ('Pasta', 'Pasta para cocinar', 1.80, 70, 12);
INSERT INTO products (name, description, price, stock_quantity, category_id) VALUES ('Aceite de Oliva', 'Aceite de oliva virgen extra', 4.50, 40, 13);
INSERT INTO products (name, description, price, stock_quantity, category_id) VALUES ('Helado de Vainilla', 'Helado cremoso de vainilla', 3.50, 30, 14);
INSERT INTO products (name, description, price, stock_quantity, category_id) VALUES ('Galletas', 'Galletas de chocolate', 2.20, 85, 15);
INSERT INTO products (name, description, price, stock_quantity, category_id) VALUES ('Desodorante', 'Desodorante en spray', 3.00, 50, 16);
INSERT INTO products (name, description, price, stock_quantity, category_id) VALUES ('Limpiador Multiuso', 'Limpiador multiuso para superficies', 2.75, 40, 17);
INSERT INTO products (name, description, price, stock_quantity, category_id) VALUES ('Alimento para Perros', 'Croquetas para perros', 20.00, 25, 18);
INSERT INTO products (name, description, price, stock_quantity, category_id) VALUES ('Televisor LED', 'Televisor LED de 40 pulgadas', 300.00, 10, 19);
INSERT INTO products (name, description, price, stock_quantity, category_id) VALUES ('Camiseta', 'Camiseta de algod�n', 15.00, 50, 20);


SELECT * FROM products;

--customers.
INSERT INTO customers (first_name, last_name, email, phone_number, address) VALUES ('Juan', 'P�rez', 'juan.perez@example.com', '555-1234', 'Calle Falsa 123, Ciudad');
INSERT INTO customers (first_name, last_name, email, phone_number, address) VALUES ('Mar�a', 'G�mez', 'maria.gomez@example.com', '555-5678', 'Av. Siempre Viva 456, Ciudad');
INSERT INTO customers (first_name, last_name, email, phone_number, address) VALUES ('Carlos', 'L�pez', 'carlos.lopez@example.com', '555-8765', 'Calle 7 789, Ciudad');
INSERT INTO customers (first_name, last_name, email, phone_number, address) VALUES ('Ana', 'Torres', 'ana.torres@example.com', '555-4321', 'Calle 5 101, Ciudad');
INSERT INTO customers (first_name, last_name, email, phone_number, address) VALUES ('Luis', 'Mart�nez', 'luis.martinez@example.com', '555-2468', 'Calle 10 202, Ciudad');
INSERT INTO customers (first_name, last_name, email, phone_number, address) VALUES ('Laura', 'S�nchez', 'laura.sanchez@example.com', '555-1357', 'Av. Libertad 303, Ciudad');
INSERT INTO customers (first_name, last_name, email, phone_number, address) VALUES ('Jos�', 'Ram�rez', 'jose.ramirez@example.com', '555-8642', 'Calle 2 404, Ciudad');
INSERT INTO customers (first_name, last_name, email, phone_number, address) VALUES ('Claudia', 'Reyes', 'claudia.reyes@example.com', '555-7531', 'Calle 4 505, Ciudad');
INSERT INTO customers (first_name, last_name, email, phone_number, address) VALUES ('Fernando', 'Hern�ndez', 'fernando.hernandez@example.com', '555-1597', 'Av. del Sol 606, Ciudad');
INSERT INTO customers (first_name, last_name, email, phone_number, address) VALUES ('Sof�a', 'Jim�nez', 'sofia.jimenez@example.com', '555-9513', 'Calle 6 707, Ciudad');
INSERT INTO customers (first_name, last_name, email, phone_number, address) VALUES ('Andr�s', 'V�squez', 'andres.vasquez@example.com', '555-7534', 'Calle 8 808, Ciudad');
INSERT INTO customers (first_name, last_name, email, phone_number, address) VALUES ('Luc�a', 'Morales', 'lucia.morales@example.com', '555-2469', 'Av. del R�o 909, Ciudad');
INSERT INTO customers (first_name, last_name, email, phone_number, address) VALUES ('Javier', 'Cruz', 'javier.cruz@example.com', '555-3571', 'Calle 9 1010, Ciudad');
INSERT INTO customers (first_name, last_name, email, phone_number, address) VALUES ('Patricia', 'Ortiz', 'patricia.ortiz@example.com', '555-9632', 'Calle 11 1111, Ciudad');
INSERT INTO customers (first_name, last_name, email, phone_number, address) VALUES ('Mario', 'Castillo', 'mario.castillo@example.com', '555-1478', 'Calle 12 1212, Ciudad');
INSERT INTO customers (first_name, last_name, email, phone_number, address) VALUES ('Isabel', 'Salazar', 'isabel.salazar@example.com', '555-2589', 'Av. de la Paz 1313, Ciudad');
INSERT INTO customers (first_name, last_name, email, phone_number, address) VALUES ('Diego', 'Mendoza', 'diego.mendoza@example.com', '555-3690', 'Calle 14 1414, Ciudad');
INSERT INTO customers (first_name, last_name, email, phone_number, address) VALUES ('Mariana', 'Rojas', 'mariana.rojas@example.com', '555-4701', 'Calle 15 1515, Ciudad');
INSERT INTO customers (first_name, last_name, email, phone_number, address) VALUES ('Esteban', 'Ponce', 'esteban.ponce@example.com', '555-5812', 'Calle 16 1616, Ciudad');
INSERT INTO customers (first_name, last_name, email, phone_number, address) VALUES ('Nadia', 'Fuentes', 'nadia.fuentes@example.com', '555-6923', 'Calle 17 1717, Ciudad');

SELECT * FROM customers;


--departments.
INSERT INTO departments (department_id, name) VALUES (1, 'Electr�nica');
INSERT INTO departments (department_id, name) VALUES (2, 'Alimentos');
INSERT INTO departments (department_id, name) VALUES (3, 'Limpieza');
INSERT INTO departments (department_id, name) VALUES (4, 'Ropa');
INSERT INTO departments (department_id, name) VALUES (5, 'Hogar');
INSERT INTO departments (department_id, name) VALUES (6, 'Belleza');
INSERT INTO departments (department_id, name) VALUES (7, 'Deportes');
INSERT INTO departments (department_id, name) VALUES (8, 'Juguetes');
INSERT INTO departments (department_id, name) VALUES (9, 'Mascotas');
INSERT INTO departments (department_id, name) VALUES (10, 'Farmacia');
INSERT INTO departments (department_id, name) VALUES (11, 'Muebles');
INSERT INTO departments (department_id, name) VALUES (12, 'Tecnolog�a');
INSERT INTO departments (department_id, name) VALUES (13, 'Automotriz');
INSERT INTO departments (department_id, name) VALUES (14, 'Papeler�a');
INSERT INTO departments (department_id, name) VALUES (15, 'Electrodom�sticos');
INSERT INTO departments (department_id, name) VALUES (16, 'Ferreter�a');
INSERT INTO departments (department_id, name) VALUES (17, 'Bebidas');
INSERT INTO departments (department_id, name) VALUES (18, 'Cuidado Personal');
INSERT INTO departments (department_id, name) VALUES (19, 'Art�culos para el hogar');
INSERT INTO departments (department_id, name) VALUES (20, 'Moda');

DESCRIBE departments;

DELETE FROM departments;
COMMIT;

SELECT * FROM departments;

SELECT department_id FROM departments;


--employees
INSERT INTO employees (first_name, last_name, position, hire_date, salary, department_id) VALUES ('Carlos', 'P�rez', 'Gerente', TO_DATE('2020-01-15', 'YYYY-MM-DD'), 50000.00, 1);
INSERT INTO employees (first_name, last_name, position, hire_date, salary, department_id) VALUES ('Mar�a', 'G�mez', 'Cajera', TO_DATE('2021-02-20', 'YYYY-MM-DD'), 25000.00, 2);
INSERT INTO employees (first_name, last_name, position, hire_date, salary, department_id) VALUES ('Juan', 'L�pez', 'Reponedor', TO_DATE('2022-03-05', 'YYYY-MM-DD'), 22000.00, 3);
INSERT INTO employees (first_name, last_name, position, hire_date, salary, department_id) VALUES ('Ana', 'Torres', 'Gerente de Ventas', TO_DATE('2020-04-10', 'YYYY-MM-DD'), 60000.00, 4);
INSERT INTO employees (first_name, last_name, position, hire_date, salary, department_id) VALUES ('Luis', 'Mart�nez', 'Cajero', TO_DATE('2021-05-15', 'YYYY-MM-DD'), 23000.00, 2);
INSERT INTO employees (first_name, last_name, position, hire_date, salary, department_id) VALUES ('Claudia', 'Reyes', 'Gerente de Almac�n', TO_DATE('2019-06-20', 'YYYY-MM-DD'), 55000.00, 5);
INSERT INTO employees (first_name, last_name, position, hire_date, salary, department_id) VALUES ('Fernando', 'Hern�ndez', 'Reponedor', TO_DATE('2022-07-25', 'YYYY-MM-DD'), 21000.00, 3);
INSERT INTO employees (first_name, last_name, position, hire_date, salary, department_id) VALUES ('Sof�a', 'Jim�nez', 'Asistente de Ventas', TO_DATE('2023-08-30', 'YYYY-MM-DD'), 24000.00, 4);
INSERT INTO employees (first_name, last_name, position, hire_date, salary, department_id) VALUES ('Andr�s', 'V�squez', 'Cajero', TO_DATE('2021-09-05', 'YYYY-MM-DD'), 23500.00, 2);
INSERT INTO employees (first_name, last_name, position, hire_date, salary, department_id) VALUES ('Luc�a', 'Morales', 'Supervisor', TO_DATE('2020-10-10', 'YYYY-MM-DD'), 40000.00, 1);
INSERT INTO employees (first_name, last_name, position, hire_date, salary, department_id) VALUES ('Javier', 'Cruz', 'Reponedor', TO_DATE('2023-11-15', 'YYYY-MM-DD'), 21500.00, 3);
INSERT INTO employees (first_name, last_name, position, hire_date, salary, department_id) VALUES ('Patricia', 'Ortiz', 'Cajera', TO_DATE('2022-12-20', 'YYYY-MM-DD'), 22500.00, 2);
INSERT INTO employees (first_name, last_name, position, hire_date, salary, department_id) VALUES ('Mario', 'Castillo', 'Gerente de Compras', TO_DATE('2020-01-25', 'YYYY-MM-DD'), 58000.00, 6);
INSERT INTO employees (first_name, last_name, position, hire_date, salary, department_id) VALUES ('Isabel', 'Salazar', 'Reponedor', TO_DATE('2023-02-15', 'YYYY-MM-DD'), 22000.00, 3);
INSERT INTO employees (first_name, last_name, position, hire_date, salary, department_id) VALUES ('Diego', 'Mendoza', 'Asistente de Almac�n', TO_DATE('2021-03-10', 'YYYY-MM-DD'), 23000.00, 5);
INSERT INTO employees (first_name, last_name, position, hire_date, salary, department_id) VALUES ('Mariana', 'Rojas', 'Gerente de Recursos Humanos', TO_DATE('2018-04-05', 'YYYY-MM-DD'), 62000.00, 7);
INSERT INTO employees (first_name, last_name, position, hire_date, salary, department_id) VALUES ('Esteban', 'Ponce', 'Cajero', TO_DATE('2022-05-01', 'YYYY-MM-DD'), 24000.00, 2);
INSERT INTO employees (first_name, last_name, position, hire_date, salary, department_id) VALUES ('Nadia', 'Fuentes', 'Cajera', TO_DATE('2023-06-20', 'YYYY-MM-DD'), 22500.00, 2);
SELECT * FROM employees;



--suppliers.


INSERT INTO suppliers (name, contact_name, phone_number, email) VALUES ('Fresh Produce Co.', 'Luis Mart�nez', '555-1234', 'luis@freshproduce.com');
INSERT INTO suppliers (name, contact_name, phone_number, email) VALUES ('Tech Supplies Inc.', 'Laura Garc�a', '555-5678', 'laura@techsupplies.com');
INSERT INTO suppliers (name, contact_name, phone_number, email) VALUES ('Daily Dairy', 'Marta L�pez', '555-9101', 'marta@dailydairy.com');
INSERT INTO suppliers (name, contact_name, phone_number, email) VALUES ('Home Essentials Ltd.', 'Carlos Jim�nez', '555-1122', 'carlos@homeessentials.com');
INSERT INTO suppliers (name, contact_name, phone_number, email) VALUES ('Pet Paradise', 'Luc�a Fern�ndez', '555-1314', 'lucia@petparadise.com');
INSERT INTO suppliers (name, contact_name, phone_number, email) VALUES ('Fitness World', 'Andr�s S�nchez', '555-1516', 'andres@fitnessworld.com');
INSERT INTO suppliers (name, contact_name, phone_number, email) VALUES ('Gourmet Goods', 'Ana Torres', '555-1718', 'ana@gourmetgoods.com');
INSERT INTO suppliers (name, contact_name, phone_number, email) VALUES ('Kids Toys Co.', 'Rosa Morales', '555-1920', 'rosa@kidstoys.com');
INSERT INTO suppliers (name, contact_name, phone_number, email) VALUES ('Pharma Plus', 'Pedro Mart�nez', '555-2122', 'pedro@pharmaplus.com');
INSERT INTO suppliers (name, contact_name, phone_number, email) VALUES ('Paper Supplies Inc.', 'Mar�a Herrera', '555-2324', 'maria@papersupplies.com');
INSERT INTO suppliers (name, contact_name, phone_number, email) VALUES ('Auto Parts Ltd.', 'Esteban Delgado', '555-2526', 'esteban@autopartsltd.com');
INSERT INTO suppliers (name, contact_name, phone_number, email) VALUES ('Eco Cleaning', 'Claudia P�rez', '555-2728', 'claudia@ecocleaning.com');
INSERT INTO suppliers (name, contact_name, phone_number, email) VALUES ('Fresh Seafood', 'Juan Vega', '555-2930', 'juan@freshseafood.com');
INSERT INTO suppliers (name, contact_name, phone_number, email) VALUES ('Outdoor Gear', 'Sof�a Rivera', '555-3132', 'sofia@outdoorgear.com');
INSERT INTO suppliers (name, contact_name, phone_number, email) VALUES ('Furniture Mart', 'Manuel R�os', '555-3334', 'manuel@furnituremart.com');
INSERT INTO suppliers (name, contact_name, phone_number, email) VALUES ('Beverage Distributors', 'Teresa Castro', '555-3536', 'teresa@beveragedistributors.com');
INSERT INTO suppliers (name, contact_name, phone_number, email) VALUES ('Fashion Hub', 'Pablo D�az', '555-3738', 'pablo@fashionhub.com');
INSERT INTO suppliers (name, contact_name, phone_number, email) VALUES ('Tech Innovations', 'Julio Navarro', '555-3940', 'julio@techinnovations.com');
INSERT INTO suppliers (name, contact_name, phone_number, email) VALUES ('Organic Farmers', 'Mariana Cruz', '555-4142', 'mariana@organicfarmers.com');
INSERT INTO suppliers (name, contact_name, phone_number, email) VALUES ('Beauty & Care', 'Elena G�mez', '555-4344', 'elena@beautyandcare.com');

--Crear la Secuencia
--La secuencia se encargar� de generar valores incrementales para SUPPLIER_ID.

CREATE SEQUENCE suppliers_seq
START WITH 1 -- Inicia desde el valor 1, o el n�mero que prefieras
INCREMENT BY 1; -- Incrementa en 1 cada vez

-- Crear un Disparador para la Inserci�n Autom�tica del SUPPLIER_ID
--Para asegurarte de que el SUPPLIER_ID se llene autom�ticamente con el siguiente valor de la secuencia cada vez que insertes un nuevo registro, crea un disparador (trigger) que se active antes de cada inserci�n:
CREATE OR REPLACE TRIGGER suppliers_id_trigger
BEFORE INSERT ON suppliers
FOR EACH ROW
BEGIN
  IF :NEW.SUPPLIER_ID IS NULL THEN
    :NEW.SUPPLIER_ID := suppliers_seq.NEXTVAL;
  END IF;
END;

-- FUNCIONES 

--1. Obtener el precio total de un producto por cantidad

CREATE OR REPLACE FUNCTION get_total_price(
    p_product_id IN INT,
    p_quantity IN INT
) RETURN DECIMAL IS
    v_price DECIMAL(10, 2);
BEGIN
    SELECT price INTO v_price FROM products WHERE product_id = p_product_id;
    RETURN v_price * p_quantity;
END;

--2. Calcular el stock restante después de una venta

CREATE OR REPLACE FUNCTION calculate_stock_after_sale(
    p_product_id IN INT,
    p_quantity_sold IN INT
) RETURN INT IS
    v_stock INT;
BEGIN
    SELECT stock_quantity INTO v_stock FROM products WHERE product_id = p_product_id;
    RETURN v_stock - p_quantity_sold;
END;



--3. Obtener el nombre del proveedor de un producto

CREATE OR REPLACE FUNCTION get_supplier_name(
    p_product_id IN INT
) RETURN VARCHAR IS
    v_supplier_name VARCHAR(255);
BEGIN
    SELECT s.name
    INTO v_supplier_name
    FROM suppliers s
    JOIN supplier_products sp ON s.supplier_id = sp.supplier_id
    WHERE sp.product_id = p_product_id;
    RETURN v_supplier_name;
END;



--4. Calcular el total de una orden

CREATE OR REPLACE FUNCTION calculate_order_total(
    p_order_id IN INT
) RETURN DECIMAL IS
    v_total DECIMAL(10, 2);
BEGIN
    SELECT SUM(quantity * unit_price)
    INTO v_total
    FROM order_details
    WHERE order_id = p_order_id;
    RETURN v_total;
END;

--5. Determinar si un producto está en stock

CREATE OR REPLACE FUNCTION is_product_in_stock(
    p_product_id IN INT
) RETURN VARCHAR IS
    v_stock INT;
BEGIN
    SELECT stock_quantity INTO v_stock FROM products WHERE product_id = p_product_id;
    RETURN CASE WHEN v_stock > 0 THEN 'Yes' ELSE 'No' END;
END;

--6. Obtener el descuento aplicable para un producto

CREATE OR REPLACE FUNCTION get_discount(
    p_product_id IN INT
) RETURN DECIMAL IS
    v_discount DECIMAL(10, 2);
BEGIN
    -- Supongamos que el descuento se define en una tabla llamada discounts
    SELECT COALESCE(discount_percentage, 0)
    INTO v_discount
    FROM discounts
    WHERE product_id = p_product_id;
    RETURN v_discount;
END;

--7. Contar productos en una categoría específica

CREATE OR REPLACE FUNCTION count_products_by_category(
    p_category_id IN INT
) RETURN INT IS
    v_count INT;
BEGIN
    SELECT COUNT(*) INTO v_count FROM products WHERE category_id = p_category_id;
    RETURN v_count;
END;

--8. Obtener la fecha del último pedido de un cliente

CREATE OR REPLACE FUNCTION get_last_order_date(
    p_customer_id IN INT
) RETURN DATE IS
    v_last_date DATE;
BEGIN
    SELECT MAX(order_date) INTO v_last_date FROM orders WHERE customer_id = p_customer_id;
    RETURN v_last_date;
END;

--9. Calcular el total de ventas de un empleado

CREATE OR REPLACE FUNCTION calculate_employee_sales(
    p_employee_id IN INT
) RETURN DECIMAL IS
    v_sales_total DECIMAL(10, 2);
BEGIN
    SELECT SUM(o.total_amount)
    INTO v_sales_total
    FROM orders o
    WHERE o.employee_id = p_employee_id;
    RETURN v_sales_total;
END;

--10. Obtener la cantidad de pedidos de un cliente

CREATE OR REPLACE FUNCTION count_orders_by_customer(
    p_customer_id IN INT
) RETURN INT IS
    v_order_count INT;
BEGIN
    SELECT COUNT(*) INTO v_order_count FROM orders WHERE customer_id = p_customer_id;
    RETURN v_order_count;
END;

--11. Calcular el total gastado por un cliente

CREATE OR REPLACE FUNCTION calculate_customer_total_spent(
    p_customer_id IN INT
) RETURN DECIMAL IS
    v_total_spent DECIMAL(10, 2);
BEGIN
    SELECT SUM(o.total_amount)
    INTO v_total_spent
    FROM orders o
    WHERE o.customer_id = p_customer_id;
    RETURN v_total_spent;
END;

--12. Obtener el nombre completo de un cliente

CREATE OR REPLACE FUNCTION get_customer_name(
    p_customer_id IN INT
) RETURN VARCHAR IS
    v_name VARCHAR(255);
BEGIN
    SELECT CONCAT(first_name, ' ', last_name)
    INTO v_name
    FROM customers
    WHERE customer_id = p_customer_id;
    RETURN v_name;
END;

--13. Calcular el promedio de precio de los productos en una categoría

CREATE OR REPLACE FUNCTION calculate_avg_price_by_category(
    p_category_id IN INT
) RETURN DECIMAL IS
    v_avg_price DECIMAL(10, 2);
BEGIN
    SELECT AVG(price)
    INTO v_avg_price
    FROM products
    WHERE category_id = p_category_id;
    RETURN v_avg_price;
END;

--14. Obtener el producto con mayor stock

CREATE OR REPLACE FUNCTION get_product_with_highest_stock RETURN VARCHAR IS
    v_product_name VARCHAR(255);
BEGIN
    SELECT name
    INTO v_product_name
    FROM products
    WHERE stock_quantity = (SELECT MAX(stock_quantity) FROM products);
    RETURN v_product_name;
END;

--15. Calcular el total de órdenes de un proveedor específico

CREATE OR REPLACE FUNCTION calculate_supplier_orders_total(
    p_supplier_id IN INT
) RETURN DECIMAL IS
    v_total DECIMAL(10, 2);
BEGIN
    SELECT SUM(total_amount)
    INTO v_total
    FROM supplier_orders
    WHERE supplier_id = p_supplier_id;
    RETURN v_total;
END;
/


--16. Obtener la cantidad de productos suministrados por un proveedor

CREATE OR REPLACE FUNCTION count_products_by_supplier(
    p_supplier_id IN INT
) RETURN INT IS
    v_count INT;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM supplier_products
    WHERE supplier_id = p_supplier_id;
    RETURN v_count;
END;



--17. Obtener la fecha del primer pedido de un cliente

CREATE OR REPLACE FUNCTION get_first_order_date(
    p_customer_id IN INT
) RETURN DATE IS
    v_first_date DATE;
BEGIN
    SELECT MIN(order_date)
    INTO v_first_date
    FROM orders
    WHERE customer_id = p_customer_id;
    RETURN v_first_date;
END;
/


--18. Calcular el total de stock en el inventario

CREATE OR REPLACE FUNCTION calculate_total_stock RETURN INT IS
    v_total_stock INT;
BEGIN
    SELECT SUM(stock_quantity)
    INTO v_total_stock
    FROM products;
    RETURN v_total_stock;
END;

--19. Obtener el nombre de la categoría de un producto

CREATE OR REPLACE FUNCTION get_category_name(
    p_product_id IN INT
) RETURN VARCHAR IS
    v_category_name VARCHAR(255);
BEGIN
    SELECT c.name
    INTO v_category_name
    FROM categories c
    JOIN products p ON c.category_id = p.category_id
    WHERE p.product_id = p_product_id;
    RETURN v_category_name;
END;

--20. Calcular el precio total de un pedido a proveedores

CREATE OR REPLACE FUNCTION calculate_supplier_order_total(
    p_supplier_order_id IN INT
) RETURN DECIMAL IS
    v_total DECIMAL(10, 2);
BEGIN
    SELECT SUM(quantity * unit_price)
    INTO v_total
    FROM supplier_order_details
    WHERE supplier_order_id = p_supplier_order_id;
    RETURN v_total;
END;

--21. Determinar si un cliente es frecuente (más de 5 pedidos)

CREATE OR REPLACE FUNCTION is_frequent_customer(
    p_customer_id IN INT
) RETURN VARCHAR IS
    v_order_count INT;
BEGIN
    SELECT COUNT(*)
    INTO v_order_count
    FROM orders
    WHERE customer_id = p_customer_id;
    RETURN CASE WHEN v_order_count > 5 THEN 'Yes' ELSE 'No' END;
END;

--22. Obtener el producto más caro de una categoría

CREATE OR REPLACE FUNCTION get_most_expensive_product_in_category(
    p_category_id IN INT
) RETURN VARCHAR IS
    v_product_name VARCHAR(255);
BEGIN
    SELECT name
    INTO v_product_name
    FROM products
    WHERE category_id = p_category_id
    AND price = (SELECT MAX(price) FROM products WHERE category_id = p_category_id);
    RETURN v_product_name;
END;

--23. Calcular el monto total de ventas en un período

CREATE OR REPLACE FUNCTION calculate_sales_in_period(
    p_start_date IN DATE,
    p_end_date IN DATE
) RETURN DECIMAL IS
    v_sales_total DECIMAL(10, 2);
BEGIN
    SELECT SUM(total_amount)
    INTO v_sales_total
    FROM orders
    WHERE order_date BETWEEN p_start_date AND p_end_date;
    RETURN v_sales_total;
END;

--24. Obtener la cantidad de productos con bajo stock

CREATE OR REPLACE FUNCTION count_low_stock_products(
    p_min_stock IN INT
) RETURN INT IS
    v_count INT;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM products
    WHERE stock_quantity < p_min_stock;
    RETURN v_count;
END;

--25. Obtener el proveedor más frecuente de pedidos

CREATE OR REPLACE FUNCTION get_most_frequent_supplier RETURN VARCHAR IS
    v_supplier_name VARCHAR(255);
BEGIN
    SELECT s.name
    INTO v_supplier_name
    FROM suppliers s
    JOIN supplier_orders so ON s.supplier_id = so.supplier_id
    GROUP BY s.name
    ORDER BY COUNT(so.supplier_order_id) DESC
    FETCH FIRST 1 ROWS ONLY;
    RETURN v_supplier_name;
END;




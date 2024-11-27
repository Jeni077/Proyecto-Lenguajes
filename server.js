const express = require('express');
const cors = require('cors');
require('dotenv').config(); // Cargar las variables de entorno
const db = require('./dbconfig'); // Importar la configuración de la base de datos

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());

// Rutas para interactuar con la base de datos

// Obtener todas las categorías
app.get('/api/categories', async (req, res) => {
  try {
    const [rows] = await db.query('SELECT * FROM categories');
    res.json(rows);
  } catch (err) {
    console.error('Error al obtener categorías:', err.message);
    res.status(500).json({ error: 'Error al obtener categorías', details: err.message });
  }
});

// Obtener todos los productos
app.get('/api/products', async (req, res) => {
  try {
    const [rows] = await db.query('SELECT * FROM products');
    res.json(rows);
  } catch (err) {
    console.error('Error al obtener productos:', err.message);
    res.status(500).json({ error: 'Error al obtener productos', details: err.message });
  }
});

// Obtener todos los empleados
app.get('/api/employees', async (req, res) => {
  try {
    const [rows] = await db.query('SELECT * FROM employees');
    res.json(rows);
  } catch (err) {
    console.error('Error al obtener empleados:', err.message);
    res.status(500).json({ error: 'Error al obtener empleados', details: err.message });
  }
});

// Obtener todas las órdenes
app.get('/api/orders', async (req, res) => {
  try {
    const [rows] = await db.query('SELECT * FROM orders');
    res.json(rows);
  } catch (err) {
    console.error('Error al obtener órdenes:', err.message);
    res.status(500).json({ error: 'Error al obtener órdenes', details: err.message });
  }
});

// Obtener todos los detalles de las órdenes
app.get('/api/order_details', async (req, res) => {
  try {
    const [rows] = await db.query('SELECT * FROM order_details');
    res.json(rows);
  } catch (err) {
    console.error('Error al obtener detalles de órdenes:', err.message);
    res.status(500).json({ error: 'Error al obtener detalles de órdenes', details: err.message });
  }
});

// Obtener todos los proveedores
app.get('/api/suppliers', async (req, res) => {
  try {
    const [rows] = await db.query('SELECT * FROM suppliers');
    res.json(rows);
  } catch (err) {
    console.error('Error al obtener proveedores:', err.message);
    res.status(500).json({ error: 'Error al obtener proveedores', details: err.message });
  }
});

// Obtener todas las órdenes de proveedores
app.get('/api/supplier_orders', async (req, res) => {
  try {
    const [rows] = await db.query('SELECT * FROM supplier_orders');
    res.json(rows);
  } catch (err) {
    console.error('Error al obtener órdenes de proveedores:', err.message);
    res.status(500).json({ error: 'Error al obtener órdenes de proveedores', details: err.message });
  }
});

// Obtener todos los detalles de las órdenes de proveedores
app.get('/api/supplier_order_details', async (req, res) => {
  try {
    const [rows] = await db.query('SELECT * FROM supplier_order_details');
    res.json(rows);
  } catch (err) {
    console.error('Error al obtener detalles de órdenes de proveedores:', err.message);
    res.status(500).json({ error: 'Error al obtener detalles de órdenes de proveedores', details: err.message });
  }
});

// Obtener todos los productos suministrados por proveedores
app.get('/api/supplier_products', async (req, res) => {
  try {
    const [rows] = await db.query('SELECT * FROM supplier_products');
    res.json(rows);
  } catch (err) {
    console.error('Error al obtener productos suministrados por proveedores:', err.message);
    res.status(500).json({ error: 'Error al obtener productos suministrados por proveedores', details: err.message });
  }
});

// Agregar un nuevo producto
app.post('/api/products', async (req, res) => {
  const { name, description, price, stock_quantity, category_id } = req.body;
  try {
    const result = await db.query(
      'INSERT INTO products (name, description, price, stock_quantity, category_id) VALUES (?, ?, ?, ?, ?)',
      [name, description, price, stock_quantity, category_id]
    );
    res.status(201).json({ message: 'Producto agregado exitosamente', product_id: result[0].insertId });
  } catch (err) {
    console.error('Error al agregar producto:', err.message);
    res.status(500).json({ error: 'Error al agregar producto', details: err.message });
  }
});


// Agregar un nuevo proveedor
app.post('/api/suppliers', async (req, res) => {
  const { name, contact_name, contact_email, phone, address } = req.body;
  try {
    const result = await db.query(
      'INSERT INTO suppliers (name, contact_name, contact_email, phone, address) VALUES (?, ?, ?, ?, ?)',
      [name, contact_name, contact_email, phone, address]
    );
    res.status(201).json({ message: 'Proveedor agregado exitosamente', supplier_id: result[0].insertId });
  } catch (err) {
    console.error('Error al agregar proveedor:', err.message);
    res.status(500).json({ error: 'Error al agregar proveedor', details: err.message });
  }
});

// Agregar una nueva orden
app.post('/api/orders', async (req, res) => {
  const { customer_id, employee_id, order_date, total_amount } = req.body;
  try {
    const result = await db.query(
      'INSERT INTO orders (customer_id, employee_id, order_date, total_amount) VALUES (?, ?, ?, ?)',
      [customer_id, employee_id, order_date, total_amount]
    );
    res.status(201).json({ message: 'Orden agregada exitosamente', order_id: result[0].insertId });
  } catch (err) {
    console.error('Error al agregar orden:', err.message);
    res.status(500).json({ error: 'Error al agregar orden', details: err.message });
  }
});

// Agregar un detalle de orden
app.post('/api/order_details', async (req, res) => {
  const { order_id, product_id, quantity, unit_price } = req.body;
  try {
    const result = await db.query(
      'INSERT INTO order_details (order_id, product_id, quantity, unit_price) VALUES (?, ?, ?, ?)',
      [order_id, product_id, quantity, unit_price]
    );
    res.status(201).json({ message: 'Detalle de orden agregado exitosamente', order_detail_id: result[0].insertId });
  } catch (err) {
    console.error('Error al agregar detalle de orden:', err.message);
    res.status(500).json({ error: 'Error al agregar detalle de orden', details: err.message });
  }
});

// Agregar una nueva orden de proveedor
app.post('/api/supplier_orders', async (req, res) => {
  const { supplier_id, order_date, total_amount } = req.body;
  try {
    const result = await db.query(
      'INSERT INTO supplier_orders (supplier_id, order_date, total_amount) VALUES (?, ?, ?)',
      [supplier_id, order_date, total_amount]
    );
    res.status(201).json({ message: 'Orden de proveedor agregada exitosamente', supplier_order_id: result[0].insertId });
  } catch (err) {
    console.error('Error al agregar orden de proveedor:', err.message);
    res.status(500).json({ error: 'Error al agregar orden de proveedor', details: err.message });
  }
});

// Agregar un detalle de orden de proveedor
app.post('/api/supplier_order_details', async (req, res) => {
  const { supplier_order_id, product_id, quantity, unit_price } = req.body;
  try {
    const result = await db.query(
      'INSERT INTO supplier_order_details (supplier_order_id, product_id, quantity, unit_price) VALUES (?, ?, ?, ?)',
      [supplier_order_id, product_id, quantity, unit_price]
    );
    res.status(201).json({ message: 'Detalle de orden de proveedor agregado exitosamente', supplier_order_detail_id: result[0].insertId });
  } catch (err) {
    console.error('Error al agregar detalle de orden de proveedor:', err.message);
    res.status(500).json({ error: 'Error al agregar detalle de orden de proveedor', details: err.message });
  }
});

// Agregar productos suministrados por un proveedor
app.post('/api/supplier_products', async (req, res) => {
  const { supplier_id, product_id } = req.body;
  try {
    const result = await db.query(
      'INSERT INTO supplier_products (supplier_id, product_id) VALUES (?, ?)',
      [supplier_id, product_id]
    );
    res.status(201).json({ message: 'Producto suministrado por proveedor agregado exitosamente', supplier_product_id: result[0].insertId });
  } catch (err) {
    console.error('Error al agregar producto suministrado por proveedor:', err.message);
    res.status(500).json({ error: 'Error al agregar producto suministrado por proveedor', details: err.message });
  }
});

// Actualizar un producto
app.put('/api/products/:id', async (req, res) => {
  const { id } = req.params;
  const { name, description, price, stock_quantity, category_id } = req.body;
  try {
    await db.query(
      'UPDATE products SET name = ?, description = ?, price = ?, stock_quantity = ?, category_id = ? WHERE product_id = ?',
      [name, description, price, stock_quantity, category_id, id]
    );
    res.json({ message: 'Producto actualizado exitosamente' });
  } catch (err) {
    console.error('Error al actualizar producto:', err.message);
    res.status(500).json({ error: 'Error al actualizar producto', details: err.message });
  }
});

// Eliminar un producto
app.delete('/api/products/:id', async (req, res) => {
  const { id } = req.params;
  try {
    await db.query('DELETE FROM products WHERE product_id = ?', [id]);
    res.json({ message: 'Producto eliminado exitosamente' });
  } catch (err) {
    console.error('Error al eliminar producto:', err.message);
    res.status(500).json({ error: 'Error al eliminar producto', details: err.message });
  }
});

// Eliminar un proveedor
app.delete('/api/suppliers/:id', async (req, res) => {
  const { id } = req.params;
  try {
    await db.query('DELETE FROM suppliers WHERE supplier_id = ?', [id]);
    res.json({ message: 'Proveedor eliminado exitosamente' });
  } catch (err) {
    console.error('Error al eliminar proveedor:', err.message);
    res.status(500).json({ error: 'Error al eliminar proveedor', details: err.message });
  }
});

// Eliminar una orden
app.delete('/api/orders/:id', async (req, res) => {
  const { id } = req.params;
  try {
    await db.query('DELETE FROM orders WHERE order_id = ?', [id]);
    res.json({ message: 'Orden eliminada exitosamente' });
  } catch (err) {
    console.error('Error al eliminar orden:', err.message);
    res.status(500).json({ error: 'Error al eliminar orden', details: err.message });
  }
});

// Eliminar un detalle de orden
app.delete('/api/order_details/:id', async (req, res) => {
  const { id } = req.params;
  try {
    await db.query('DELETE FROM order_details WHERE order_detail_id = ?', [id]);
    res.json({ message: 'Detalle de orden eliminado exitosamente' });
  } catch (err) {
    console.error('Error al eliminar detalle de orden:', err.message);
    res.status(500).json({ error: 'Error al eliminar detalle de orden', details: err.message });
  }
});

// Iniciar el servidor
app.listen(PORT, () => {
  console.log(`Servidor corriendo en el puerto ${PORT}`);
});

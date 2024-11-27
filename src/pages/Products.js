import React, { useState, useEffect } from 'react';
import axios from 'axios';

const Products = () => {
  const [products, setProducts] = useState([]);
  const [newProduct, setNewProduct] = useState({ name: '', price: '', stockQuantity: '' });
  const threshold = 20;

  // useEffect para obtener los productos de la base de datos a través de la API
  useEffect(() => {
    fetchProducts();
  }, []);

  // Función para obtener productos del backend
  const fetchProducts = () => {
    axios.get('http://localhost:3000/api/products')
      .then(response => setProducts(response.data))
      .catch(error => console.error('Error al obtener los productos:', error));
  };

  // Manejador para cambiar el estado cuando se agregan nuevos productos
  const handleChange = (e) => {
    const { name, value } = e.target;
    setNewProduct({ ...newProduct, [name]: value });
  };

  // Manejador para agregar un nuevo producto (ahora envía al backend)
  const handleSubmit = (e) => {
    e.preventDefault();
    // Realizar la solicitud POST al backend
    axios.post('http://localhost:3000/api/products', {
      name: newProduct.name,
      price: parseFloat(newProduct.price),
      stockQuantity: parseInt(newProduct.stockQuantity)
    })
    .then(response => {
      // Agregar el producto al estado local después de que se haya añadido al backend
      setProducts([...products, response.data]);
      setNewProduct({ name: '', price: '', stockQuantity: '' });
    })
    .catch(error => console.error('Error al agregar el producto:', error));
  };

  // Filtra productos con stock bajo según el umbral
  const lowStockProducts = products.filter(product => product.stockQuantity < threshold);

  return (
    <div className="container">
      <h1>Productos Disponibles</h1>

      <form onSubmit={handleSubmit} style={{ marginBottom: '20px' }}>
        <div>
          <label htmlFor="name">Nombre del Producto</label>
          <input
            type="text"
            name="name"
            id="name"
            placeholder="Nombre del Producto"
            value={newProduct.name}
            onChange={handleChange}
            required
          />
        </div>
        <div>
          <label htmlFor="price">Precio</label>
          <input
            type="number"
            name="price"
            id="price"
            placeholder="Precio"
            value={newProduct.price}
            onChange={handleChange}
            required
          />
        </div>
        <div>
          <label htmlFor="stockQuantity">Cantidad en Stock</label>
          <input
            type="number"
            name="stockQuantity"
            id="stockQuantity"
            placeholder="Cantidad en Stock"
            value={newProduct.stockQuantity}
            onChange={handleChange}
            required
          />
        </div>
        <button type="submit" aria-label="Agregar Producto">Agregar Producto</button>
      </form>

      {products.length > 0 ? (
        <table style={{ width: '100%', borderCollapse: 'collapse' }}>
          <thead>
            <tr>
              <th>ID</th>
              <th>Nombre</th>
              <th>Precio</th>
              <th>Cantidad en Stock</th>
            </tr>
          </thead>
          <tbody>
            {products.map((product) => (
              <tr key={product.id} style={{ backgroundColor: product.stockQuantity < threshold ? 'lightcoral' : 'white' }}>
                <td>{product.id}</td>
                <td>{product.name}</td>
                <td>${product.price.toFixed(2)}</td>
                <td>{product.stockQuantity}</td>
              </tr>
            ))}
          </tbody>
        </table>
      ) : (
        <p>No hay productos disponibles.</p>
      )}

      {lowStockProducts.length > 0 && (
        <div style={{ color: 'red', marginTop: '20px' }}>
          <strong>¡Alerta de Stock Bajo!</strong> {lowStockProducts.length} producto(s) tienen bajo stock.
        </div>
      )}
    </div>
  );
};

export default Products;

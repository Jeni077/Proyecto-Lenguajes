import React, { useState, useEffect } from 'react';
import axios from 'axios';

const Suppliers = () => {
  const [suppliers, setSuppliers] = useState([]);
  const [newSupplier, setNewSupplier] = useState({ name: '', contact: '' });

  // useEffect para obtener los proveedores desde la API
  useEffect(() => {
    fetchSuppliers();
  }, []);

  // Función para obtener proveedores desde el backend
  const fetchSuppliers = () => {
    axios.get('http://localhost:3000/api/suppliers')
      .then(response => setSuppliers(response.data))
      .catch(error => console.error('Error al obtener los proveedores:', error));
  };

  // Manejador para actualizar el estado cuando se cambia el formulario
  const handleChange = (e) => {
    const { name, value } = e.target;
    setNewSupplier({ ...newSupplier, [name]: value });
  };

  // Manejador para agregar un nuevo proveedor (envía al backend)
  const handleSubmit = (e) => {
    e.preventDefault();
    axios.post('http://localhost:3000/api/suppliers', newSupplier)
      .then(response => {
        setSuppliers([...suppliers, response.data]);  // Actualiza el estado local
        setNewSupplier({ name: '', contact: '' });  // Limpia el formulario
      })
      .catch(error => console.error('Error al agregar el proveedor:', error));
  };

  return (
    <div className="container">
      <h1>Proveedores</h1>

      <form onSubmit={handleSubmit} style={{ marginBottom: '20px' }}>
        <div>
          <label htmlFor="name">Nombre del Proveedor</label>
          <input
            type="text"
            name="name"
            id="name"
            placeholder="Nombre del Proveedor"
            value={newSupplier.name}
            onChange={handleChange}
            required
          />
        </div>
        <div>
          <label htmlFor="contact">Contacto</label>
          <input
            type="text"
            name="contact"
            id="contact"
            placeholder="Contacto"
            value={newSupplier.contact}
            onChange={handleChange}
            required
          />
        </div>
        <button type="submit" aria-label="Agregar Proveedor">Agregar Proveedor</button>
      </form>

      {suppliers.length > 0 ? (
        <table style={{ width: '100%', borderCollapse: 'collapse' }}>
          <thead>
            <tr>
              <th>ID</th>
              <th>Nombre</th>
              <th>Contacto</th>
            </tr>
          </thead>
          <tbody>
            {suppliers.map((supplier) => (
              <tr key={supplier.id}>
                <td>{supplier.id}</td>
                <td>{supplier.name}</td>
                <td>{supplier.contact}</td>
              </tr>
            ))}
          </tbody>
        </table>
      ) : (
        <p>No hay proveedores disponibles.</p>
      )}
    </div>
  );
};

export default Suppliers;

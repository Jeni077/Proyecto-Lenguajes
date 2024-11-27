import React, { useState } from 'react';

const AddProduct = () => {
  const [product, setProduct] = useState({
    name: '',
    description: '',
    price: '',
    stockQuantity: '',
    categoryId: '',
  });

  const handleChange = (e) => {
    const { name, value } = e.target;
    setProduct({ ...product, [name]: value });
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    // Aquí podrías enviar el producto a tu API o manejarlo como necesites
    console.log('Producto agregado:', product);
    // Limpiar el formulario
    setProduct({
      name: '',
      description: '',
      price: '',
      stockQuantity: '',
      categoryId: '',
    });
  };

  return (
    <div>
      <h2>Agregar Producto</h2>
      <form onSubmit={handleSubmit}>
        <div>
          <label htmlFor="name">Nombre</label>
          <input
            type="text"
            name="name"
            id="name" // Añadir ID para la etiqueta
            placeholder="Nombre"
            value={product.name}
            onChange={handleChange}
            required
          />
        </div>
        <div>
          <label htmlFor="description">Descripción</label>
          <textarea
            name="description"
            id="description" // Añadir ID para la etiqueta
            placeholder="Descripción"
            value={product.description}
            onChange={handleChange}
            required
          />
        </div>
        <div>
          <label htmlFor="price">Precio</label>
          <input
            type="number"
            name="price"
            id="price" // Añadir ID para la etiqueta
            placeholder="Precio"
            value={product.price}
            onChange={handleChange}
            required
          />
        </div>
        <div>
          <label htmlFor="stockQuantity">Cantidad en Stock</label>
          <input
            type="number"
            name="stockQuantity"
            id="stockQuantity" // Añadir ID para la etiqueta
            placeholder="Cantidad en Stock"
            value={product.stockQuantity}
            onChange={handleChange}
            required
          />
        </div>
        <div>
          <label htmlFor="categoryId">ID de Categoría</label>
          <input
            type="number"
            name="categoryId"
            id="categoryId" // Añadir ID para la etiqueta
            placeholder="ID de Categoría"
            value={product.categoryId}
            onChange={handleChange}
            required
          />
        </div>
        <button type="submit" aria-label="Agregar Producto">
          Agregar Producto
        </button>
      </form>
    </div>
  );
};

export default AddProduct;

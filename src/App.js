import React from 'react';
import { BrowserRouter, Route, Routes, Link } from 'react-router-dom';
import Home from './pages/Home';
import Products from './pages/Products';
import Suppliers from './pages/Suppliers';
import './App.css';

function App() {
  return (
    <BrowserRouter>
      <header>
        <nav>
          <ul>
            <li>
              <Link to="/">Inicio</Link>
            </li>
            <li>
              <Link to="/products">Productos</Link>
            </li>
            <li>
              <Link to="/suppliers">Proveedores</Link>
            </li>
          </ul>
        </nav>
      </header>
      <main>
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/products" element={<Products />} />
          <Route path="/suppliers" element={<Suppliers />} />
        </Routes>
      </main>
    </BrowserRouter>
  );
}

export default App;

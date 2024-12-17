<?php
require_once __DIR__ . '/Database.php';

class Product
{
        private $db;
        private $conn;
    
        // Constructor: Inicializa la conexión a la base de datos
        public function __construct() {
            $this->db = new Database();
            $this->conn = $this->db->connect();
        }

    // Otros métodos CRUD (getAllProducts, addProduct, etc.)


    // Obtener todos los productos
    public function getAllProducts()
    {
        $query = "SELECT * FROM products";
        $stmt = oci_parse($this->conn, $query);
        oci_execute($stmt);

        $products = [];
        while ($row = oci_fetch_assoc($stmt)) {
            $products[] = $row;
        }
        return $products;
    }

    // Agregar un nuevo producto
    public function addProduct($name, $description, $price, $stock_quantity, $category_id)
    {
        $query = "INSERT INTO products (name, description, price, stock_quantity, category_id)
                  VALUES (:name, :description, :price, :stock_quantity, :category_id)";
        $stmt = oci_parse($this->conn, $query);

        oci_bind_by_name($stmt, ":name", $name);
        oci_bind_by_name($stmt, ":description", $description);
        oci_bind_by_name($stmt, ":price", $price);
        oci_bind_by_name($stmt, ":stock_quantity", $stock_quantity);
        oci_bind_by_name($stmt, ":category_id", $category_id);

        oci_execute($stmt);
    }

    // Actualizar un producto existente
    public function updateProduct($id, $name, $description, $price, $stock_quantity, $category_id)
    {
        $query = "UPDATE products 
                  SET name = :name, description = :description, price = :price, 
                      stock_quantity = :stock_quantity, category_id = :category_id 
                  WHERE product_id = :id";
        $stmt = oci_parse($this->conn, $query);

        oci_bind_by_name($stmt, ":id", $id);
        oci_bind_by_name($stmt, ":name", $name);
        oci_bind_by_name($stmt, ":description", $description);
        oci_bind_by_name($stmt, ":price", $price);
        oci_bind_by_name($stmt, ":stock_quantity", $stock_quantity);
        oci_bind_by_name($stmt, ":category_id", $category_id);

        oci_execute($stmt);
    }

    // Eliminar un producto
    public function deleteProduct($id)
    {
        $query = "DELETE FROM products WHERE product_id = :id";
        $stmt = oci_parse($this->conn, $query);

        oci_bind_by_name($stmt, ":id", $id);
        oci_execute($stmt);
    }
}

<?php
require_once __DIR__ . '/Database.php';

class Category {
    private $db;
    private $conn;

    // Constructor: Inicializa la conexión a la base de datos
    public function __construct() {
        $this->db = new Database();
        $this->conn = $this->db->connect();
    }

    // Obtener todas las categorías (READ)
    public function getAllCategories() {
        $query = "SELECT category_id, name, description FROM categories";
        $stmt = oci_parse($this->conn, $query);

        if (!oci_execute($stmt)) {
            $error = oci_error($stmt);
            die("Error al obtener categorías: " . $error['message']);
        }

        $categories = [];
        while (($row = oci_fetch_assoc($stmt)) != false) {
            $categories[] = $row;
        }

        return $categories;
    }

    // Agregar una nueva categoría (CREATE)
    public function addCategory($name, $description) {
        $query = "INSERT INTO categories (name, description) VALUES (:name, :description)";
        $stmt = oci_parse($this->conn, $query);

        oci_bind_by_name($stmt, ":name", $name);
        oci_bind_by_name($stmt, ":description", $description);

        if (!oci_execute($stmt)) {
            $error = oci_error($stmt);
            die("Error al agregar categoría: " . $error['message']);
        }

        echo "Categoría agregada correctamente.";
    }

    // Modificar una categoría existente (UPDATE)
    public function updateCategory($id, $name, $description) {
        $query = "UPDATE categories SET name = :name, description = :description WHERE category_id = :id";
        $stmt = oci_parse($this->conn, $query);

        oci_bind_by_name($stmt, ":id", $id);
        oci_bind_by_name($stmt, ":name", $name);
        oci_bind_by_name($stmt, ":description", $description);

        if (!oci_execute($stmt)) {
            $error = oci_error($stmt);
            die("Error al modificar categoría: " . $error['message']);
        }

        echo "Categoría actualizada correctamente.";
    }

    // Eliminar una categoría (DELETE)
    public function deleteCategory($id) {
        $query = "DELETE FROM categories WHERE category_id = :id";
        $stmt = oci_parse($this->conn, $query);

        oci_bind_by_name($stmt, ":id", $id);

        if (!oci_execute($stmt)) {
            $error = oci_error($stmt);
            die("Error al eliminar categoría: " . $error['message']);
        }

        echo "Categoría eliminada correctamente.";
    }

    // Destructor: Cierra la conexión
    public function __destruct() {
        $this->db->close();
    }
}
?>



<?php
require_once __DIR__ . '/Database.php';

class Category {
    private $db;
    private $conn;

    public function __construct() {
        $this->db = new Database();
        $this->conn = $this->db->connect();
    }

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

    public function addCategory($name, $description) {
        try {
            $query = "
                BEGIN
                    INSERT INTO categories (name, description)
                    VALUES (:name, :description);
                END;
            ";
            $stmt = oci_parse($this->conn, $query);
    
            oci_bind_by_name($stmt, ":name", $name);
            oci_bind_by_name($stmt, ":description", $description);
    
            if (!oci_execute($stmt, OCI_COMMIT_ON_SUCCESS)) {
                $error = oci_error($stmt);
                throw new Exception("Error al agregar categoría: " . $error['message']);
            }
    
            echo "Categoría agregada correctamente.";
        } catch (Exception $e) {
            echo "No se pudo agregar la categoría. Detalles: " . $e->getMessage();
        }
    }
    

    public function updateCategory($id, $name, $description) {
        try {
            $query = "
                BEGIN
                    UPDATE categories
                    SET name = :name, description = :description
                    WHERE category_id = :id;
                END;
            ";
            $stmt = oci_parse($this->conn, $query);
    
            oci_bind_by_name($stmt, ":id", $id);
            oci_bind_by_name($stmt, ":name", $name);
            oci_bind_by_name($stmt, ":description", $description);
    
            if (!oci_execute($stmt, OCI_COMMIT_ON_SUCCESS)) {
                $error = oci_error($stmt);
                throw new Exception("Error al modificar categoría: " . $error['message']);
            }
    
            echo "Categoría actualizada correctamente.";
        } catch (Exception $e) {
            echo "No se pudo actualizar la categoría. Detalles: " . $e->getMessage();
        }
    }
    

    public function deleteCategory($id) {
        try {
            $query = "
                BEGIN
                    DELETE FROM categories
                    WHERE category_id = :id;
                END;
            ";
            $stmt = oci_parse($this->conn, $query);
    
            oci_bind_by_name($stmt, ":id", $id);
    
            if (!oci_execute($stmt, OCI_COMMIT_ON_SUCCESS)) {
                $error = oci_error($stmt);
                throw new Exception("Error al eliminar categoría: " . $error['message']);
            }
    
            echo "Categoría eliminada correctamente.";
        } catch (Exception $e) {
            echo "No se pudo eliminar la categoría. Detalles: " . $e->getMessage();
        }
    }
    
    public function __destruct() {
        oci_close($this->conn);
    }
    
}
?>



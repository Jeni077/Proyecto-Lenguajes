<?php
require_once __DIR__ . '/Database.php';

class Supplier
{
    private $db;
        private $conn;
    
        // Constructor: Inicializa la conexión a la base de datos
        public function __construct() {
            $this->db = new Database();
            $this->conn = $this->db->connect();
        }

    // Obtener todos los proveedores
    public function getAllSuppliers()
    {
        $query = "SELECT * FROM suppliers";
        $stmt = oci_parse($this->conn, $query);
        oci_execute($stmt);

        $suppliers = [];
        while ($row = oci_fetch_assoc($stmt)) {
            $suppliers[] = $row;
        }
        return $suppliers;
    }

    // Agregar un nuevo proveedor
    public function addSupplier($name, $contactName, $phoneNumber, $email)
    {
        $query = "INSERT INTO suppliers (name, contact_name, phone_number, email) 
                  VALUES (:name, :contactName, :phoneNumber, :email)";
        $stmt = oci_parse($this->conn, $query);

        oci_bind_by_name($stmt, ":name", $name);
        oci_bind_by_name($stmt, ":contactName", $contactName);
        oci_bind_by_name($stmt, ":phoneNumber", $phoneNumber);
        oci_bind_by_name($stmt, ":email", $email);

        oci_execute($stmt);
    }

    // Actualizar un proveedor existente
    public function updateSupplier($id, $name, $contactName, $phoneNumber, $email)
    {
        $query = "UPDATE suppliers SET 
                    name = :name, 
                    contact_name = :contactName, 
                    phone_number = :phoneNumber, 
                    email = :email 
                  WHERE supplier_id = :id";
        $stmt = oci_parse($this->conn, $query);

        oci_bind_by_name($stmt, ":id", $id);
        oci_bind_by_name($stmt, ":name", $name);
        oci_bind_by_name($stmt, ":contactName", $contactName);
        oci_bind_by_name($stmt, ":phoneNumber", $phoneNumber);
        oci_bind_by_name($stmt, ":email", $email);

        oci_execute($stmt);
    }

    // Eliminar un proveedor
    public function deleteSupplier($id)
    {
        $query = "DELETE FROM suppliers WHERE supplier_id = :id";
        $stmt = oci_parse($this->conn, $query);

        oci_bind_by_name($stmt, ":id", $id);
        oci_execute($stmt);
    }
}

<?php
require_once __DIR__ . '/Database.php';

class Customer
{
    private $db;
        private $conn;
    
        // Constructor: Inicializa la conexión a la base de datos
        public function __construct() {
            $this->db = new Database();
            $this->conn = $this->db->connect();
        }

    // Obtener todos los clientes
    public function getAllCustomers()
    {
        $query = "SELECT * FROM customers";
        $stmt = oci_parse($this->conn, $query);
        oci_execute($stmt);

        $customers = [];
        while ($row = oci_fetch_assoc($stmt)) {
            $customers[] = $row;
        }
        return $customers;
    }

    // Agregar un nuevo cliente
    public function addCustomer($first_name, $last_name, $email, $phone_number, $address)
    {
        $query = "INSERT INTO customers (first_name, last_name, email, phone_number, address)
                  VALUES (:first_name, :last_name, :email, :phone_number, :address)";
        $stmt = oci_parse($this->conn, $query);

        oci_bind_by_name($stmt, ":first_name", $first_name);
        oci_bind_by_name($stmt, ":last_name", $last_name);
        oci_bind_by_name($stmt, ":email", $email);
        oci_bind_by_name($stmt, ":phone_number", $phone_number);
        oci_bind_by_name($stmt, ":address", $address);

        oci_execute($stmt);
    }

    // Actualizar un cliente existente
    public function updateCustomer($id, $first_name, $last_name, $email, $phone_number, $address)
    {
        $query = "UPDATE customers 
                  SET first_name = :first_name, last_name = :last_name, email = :email,
                      phone_number = :phone_number, address = :address 
                  WHERE customer_id = :id";
        $stmt = oci_parse($this->conn, $query);

        oci_bind_by_name($stmt, ":id", $id);
        oci_bind_by_name($stmt, ":first_name", $first_name);
        oci_bind_by_name($stmt, ":last_name", $last_name);
        oci_bind_by_name($stmt, ":email", $email);
        oci_bind_by_name($stmt, ":phone_number", $phone_number);
        oci_bind_by_name($stmt, ":address", $address);

        oci_execute($stmt);
    }

    // Eliminar un cliente
    public function deleteCustomer($id)
    {
        $query = "DELETE FROM customers WHERE customer_id = :id";
        $stmt = oci_parse($this->conn, $query);

        oci_bind_by_name($stmt, ":id", $id);
        oci_execute($stmt);
    }
}

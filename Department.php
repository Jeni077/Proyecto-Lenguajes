<?php
require_once __DIR__ . '/Database.php';

class Department
{
    private $db;
        private $conn;
    
        // Constructor: Inicializa la conexión a la base de datos
        public function __construct() {
            $this->db = new Database();
            $this->conn = $this->db->connect();
        }

    // Obtener todos los departamentos
    public function getAllDepartments()
    {
        $query = "SELECT * FROM departments";
        $stmt = oci_parse($this->conn, $query);
        oci_execute($stmt);

        $departments = [];
        while ($row = oci_fetch_assoc($stmt)) {
            $departments[] = $row;
        }
        return $departments;
    }

    // Agregar un nuevo departamento
    public function addDepartment($name)
    {
        $query = "INSERT INTO departments (name) VALUES (:name)";
        $stmt = oci_parse($this->conn, $query);

        oci_bind_by_name($stmt, ":name", $name);
        oci_execute($stmt);
    }

    // Actualizar un departamento existente
    public function updateDepartment($id, $name)
    {
        $query = "UPDATE departments SET name = :name WHERE department_id = :id";
        $stmt = oci_parse($this->conn, $query);

        oci_bind_by_name($stmt, ":id", $id);
        oci_bind_by_name($stmt, ":name", $name);

        oci_execute($stmt);
    }

    // Eliminar un departamento
    public function deleteDepartment($id)
    {
        $query = "DELETE FROM departments WHERE department_id = :id";
        $stmt = oci_parse($this->conn, $query);

        oci_bind_by_name($stmt, ":id", $id);
        oci_execute($stmt);
    }
}

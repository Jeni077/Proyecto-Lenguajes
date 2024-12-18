<?php
require_once __DIR__ . '/Database.php';

class Employee
{
    private $db;
        private $conn;
    
        // Constructor: Inicializa la conexión a la base de datos
        public function __construct() {
            $this->db = new Database();
            $this->conn = $this->db->connect();
        }


    // Obtener todos los empleados
    public function getAllEmployees()
    {
        $query = "SELECT * FROM employees";
        $stmt = oci_parse($this->conn, $query);
        oci_execute($stmt);

        $employees = [];
        while ($row = oci_fetch_assoc($stmt)) {
            $employees[] = $row;
        }
        return $employees;
    }

    // Agregar un nuevo empleado
    public function addEmployee($firstName, $lastName, $position, $hireDate, $salary, $departmentId)
    {
        $query = "INSERT INTO employees (first_name, last_name, position, hire_date, salary, department_id) 
                  VALUES (:firstName, :lastName, :position, TO_DATE(:hireDate, 'YYYY-MM-DD'), :salary, :departmentId)";
        $stmt = oci_parse($this->conn, $query);

        oci_bind_by_name($stmt, ":firstName", $firstName);
        oci_bind_by_name($stmt, ":lastName", $lastName);
        oci_bind_by_name($stmt, ":position", $position);
        oci_bind_by_name($stmt, ":hireDate", $hireDate);
        oci_bind_by_name($stmt, ":salary", $salary);
        oci_bind_by_name($stmt, ":departmentId", $departmentId);

        oci_execute($stmt);
    }

    // Actualizar un empleado existente
    public function updateEmployee($id, $firstName, $lastName, $position, $hireDate, $salary, $departmentId)
    {
        $query = "UPDATE employees SET 
                    first_name = :firstName, 
                    last_name = :lastName, 
                    position = :position, 
                    hire_date = TO_DATE(:hireDate, 'YYYY-MM-DD'), 
                    salary = :salary, 
                    department_id = :departmentId 
                  WHERE employee_id = :id";
        $stmt = oci_parse($this->conn, $query);

        oci_bind_by_name($stmt, ":id", $id);
        oci_bind_by_name($stmt, ":firstName", $firstName);
        oci_bind_by_name($stmt, ":lastName", $lastName);
        oci_bind_by_name($stmt, ":position", $position);
        oci_bind_by_name($stmt, ":hireDate", $hireDate);
        oci_bind_by_name($stmt, ":salary", $salary);
        oci_bind_by_name($stmt, ":departmentId", $departmentId);

        oci_execute($stmt);
    }

    // Eliminar un empleado
    public function deleteEmployee($id)
    {
        $query = "DELETE FROM employees WHERE employee_id = :id";
        $stmt = oci_parse($this->conn, $query);

        oci_bind_by_name($stmt, ":id", $id);
        oci_execute($stmt);
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
}

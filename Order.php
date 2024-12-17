<?php
require_once __DIR__ . '/Database.php';

class Order
{
    private $db;
    private $conn;

    // Constructor: Inicializa la conexión a la base de datos
    public function __construct() {
        $this->db = new Database();
        $this->conn = $this->db->connect();
    }

    // Obtener todas las órdenes
    public function getAllOrders()
    {
        $query = "SELECT * FROM orders";
        $stmt = oci_parse($this->conn, $query);
        oci_execute($stmt);

        $orders = [];
        while ($row = oci_fetch_assoc($stmt)) {
            $orders[] = $row;
        }
        return $orders;
    }

    // Agregar una nueva orden
    public function addOrder($orderDate, $customerId, $employeeId)
    {
        try {
            // Convertir la fecha en 'YYYY-MM-DD'
            $formattedDate = date('Y-m-d', strtotime($orderDate));
    
            $query = "INSERT INTO orders (order_date, customer_id, employee_id) 
                      VALUES (TO_DATE(:formattedDate, 'YYYY-MM-DD'), :customerId, :employeeId)";
            $stmt = oci_parse($this->conn, $query);
    
            oci_bind_by_name($stmt, ":formattedDate", $formattedDate);
            oci_bind_by_name($stmt, ":customerId", $customerId);
            oci_bind_by_name($stmt, ":employeeId", $employeeId);
    
            if (oci_execute($stmt) === false) {
                $error = oci_error($stmt);
                throw new Exception("Error al agregar la orden: " . $error['message']);
            }
        } catch (Exception $e) {
            throw new Exception("Error al agregar la orden: " . $e->getMessage());
        }
    }
    

    // Actualizar una orden existente
    public function updateOrder($id, $orderDate, $customerId, $employeeId)
    {
        // Formatear la fecha en 'YYYY-MM-DD'
        $formattedDate = date('Y-m-d', strtotime($orderDate));

        $query = "UPDATE orders SET 
                    order_date = :orderDate, 
                    customer_id = :customerId, 
                    employee_id = :employeeId 
                  WHERE order_id = :id";
        $stmt = oci_parse($this->conn, $query);

        oci_bind_by_name($stmt, ":id", $id);
        oci_bind_by_name($stmt, ":orderDate", $formattedDate);
        oci_bind_by_name($stmt, ":customerId", $customerId);
        oci_bind_by_name($stmt, ":employeeId", $employeeId);

        oci_execute($stmt);
    }

    // Eliminar una orden
    public function deleteOrder($id)
    {
        $query = "DELETE FROM orders WHERE order_id = :id";
        $stmt = oci_parse($this->conn, $query);

        oci_bind_by_name($stmt, ":id", $id);
        oci_execute($stmt);
    }
}
?>

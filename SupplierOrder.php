<?php
require_once __DIR__ . '/Database.php';

class SupplierOrder {
    private $db;
    private $conn;

    // Constructor: Inicializa la conexión a la base de datos
    public function __construct() {
        $this->db = new Database();
        $this->conn = $this->db->connect();
    }

    public function addSupplierOrder($supplierId, $orderDate, $totalAmount) {
        try {
            $formattedDate = date('Y-m-d', strtotime($orderDate)); 

            $query = "INSERT INTO supplier_orders (supplier_id, order_date, total_amount)
                      VALUES (:supplierId, TO_DATE(:formattedDate, 'YYYY-MM-DD'), :totalAmount)";
            $stmt = oci_parse($this->conn, $query);

            oci_bind_by_name($stmt, ":supplierId", $supplierId);
            oci_bind_by_name($stmt, ":formattedDate", $formattedDate);
            oci_bind_by_name($stmt, ":totalAmount", $totalAmount);

            if (oci_execute($stmt) === false) {
                $error = oci_error($stmt);
                throw new Exception("Error al agregar la orden de proveedor: " . $error['message']);
            }
        } catch (Exception $e) {
            throw new Exception("Error al agregar la orden de proveedor: " . $e->getMessage());
        }
    }

    public function getAllSupplierOrders() {
        $query = "SELECT * FROM supplier_orders";
        $stmt = oci_parse($this->conn, $query);
        oci_execute($stmt);

        $supplierOrders = [];
        while (($row = oci_fetch_assoc($stmt)) != false) {
            $supplierOrders[] = $row;
        }
        return $supplierOrders;
    }

    public function deleteSupplierOrder($supplierOrderId) {
        try {
            $query = "DELETE FROM supplier_orders WHERE supplier_order_id = :supplierOrderId";
            $stmt = oci_parse($this->conn, $query);

            oci_bind_by_name($stmt, ":supplierOrderId", $supplierOrderId);

            if (oci_execute($stmt) === false) {
                $error = oci_error($stmt);
                throw new Exception("Error al eliminar la orden de proveedor: " . $error['message']);
            }
        } catch (Exception $e) {
            throw new Exception("Error al eliminar la orden de proveedor: " . $e->getMessage());
        }
    }
}
?>


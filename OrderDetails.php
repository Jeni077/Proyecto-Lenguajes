<?php
require_once __DIR__ . '/Database.php';

class OrderDetails {
    private $db;
    private $conn;

    public function __construct() {
        $this->db = new Database();
        $this->conn = $this->db->connect();
    }

    public function addOrderDetail($orderId, $productId, $quantity, $unitPrice) {
        $query = "INSERT INTO order_details (order_id, product_id, quantity, unit_price)
                  VALUES (:orderId, :productId, :quantity, :unitPrice)";
        $stmt = oci_parse($this->conn, $query);

        oci_bind_by_name($stmt, ":orderId", $orderId);
        oci_bind_by_name($stmt, ":productId", $productId);
        oci_bind_by_name($stmt, ":quantity", $quantity);
        oci_bind_by_name($stmt, ":unitPrice", $unitPrice);

        oci_execute($stmt);
    }

    public function updateOrderDetail($orderDetailId, $orderId, $productId, $quantity, $unitPrice) {
        $query = "UPDATE order_details SET 
                    order_id = :orderId, 
                    product_id = :productId, 
                    quantity = :quantity, 
                    unit_price = :unitPrice 
                  WHERE order_detail_id = :orderDetailId";
        $stmt = oci_parse($this->conn, $query);

        oci_bind_by_name($stmt, ":orderDetailId", $orderDetailId);
        oci_bind_by_name($stmt, ":orderId", $orderId);
        oci_bind_by_name($stmt, ":productId", $productId);
        oci_bind_by_name($stmt, ":quantity", $quantity);
        oci_bind_by_name($stmt, ":unitPrice", $unitPrice);

        oci_execute($stmt);
    }

    public function deleteOrderDetail($orderDetailId) {
        $query = "DELETE FROM order_details WHERE order_detail_id = :orderDetailId";
        $stmt = oci_parse($this->conn, $query);

        oci_bind_by_name($stmt, ":orderDetailId", $orderDetailId);
        oci_execute($stmt);
    }

    public function getAllOrderDetails() {
        $query = "SELECT * FROM order_details";
        $stmt = oci_parse($this->conn, $query);
        oci_execute($stmt);

        $orderDetails = [];
        while (($row = oci_fetch_assoc($stmt)) != false) {
            $orderDetails[] = $row;
        }
        return $orderDetails;
    }
}
?>

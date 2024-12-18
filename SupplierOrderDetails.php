<?php
require_once __DIR__ . '/Database.php';

class SupplierOrderDetails {
    private $db;
    private $conn;

    public function __construct() {
        $this->db = new Database();
        $this->conn = $this->db->connect();
    }

    public function addSupplierOrderDetail($supplierOrderId, $productId, $quantity, $unitPrice) {
        $query = "INSERT INTO supplier_order_details (supplier_order_id, product_id, quantity, unit_price)
                  VALUES (:supplierOrderId, :productId, :quantity, :unitPrice)";
        $stmt = oci_parse($this->conn, $query);

        oci_bind_by_name($stmt, ":supplierOrderId", $supplierOrderId);
        oci_bind_by_name($stmt, ":productId", $productId);
        oci_bind_by_name($stmt, ":quantity", $quantity);
        oci_bind_by_name($stmt, ":unitPrice", $unitPrice);

        oci_execute($stmt);
    }

    public function updateSupplierOrderDetail($supplierOrderDetailId, $supplierOrderId, $productId, $quantity, $unitPrice) {
        $query = "UPDATE supplier_order_details SET 
                    supplier_order_id = :supplierOrderId, 
                    product_id = :productId, 
                    quantity = :quantity, 
                    unit_price = :unitPrice 
                  WHERE supplier_order_detail_id = :supplierOrderDetailId";
        $stmt = oci_parse($this->conn, $query);

        oci_bind_by_name($stmt, ":supplierOrderDetailId", $supplierOrderDetailId);
        oci_bind_by_name($stmt, ":supplierOrderId", $supplierOrderId);
        oci_bind_by_name($stmt, ":productId", $productId);
        oci_bind_by_name($stmt, ":quantity", $quantity);
        oci_bind_by_name($stmt, ":unitPrice", $unitPrice);

        oci_execute($stmt);
    }

    public function deleteSupplierOrderDetail($supplierOrderDetailId) {
        $query = "DELETE FROM supplier_order_details WHERE supplier_order_detail_id = :supplierOrderDetailId";
        $stmt = oci_parse($this->conn, $query);

        oci_bind_by_name($stmt, ":supplierOrderDetailId", $supplierOrderDetailId);
        oci_execute($stmt);
    }

    public function getAllSupplierOrderDetails() {
        $query = "SELECT * FROM supplier_order_details";
        $stmt = oci_parse($this->conn, $query);
        oci_execute($stmt);

        $supplierOrderDetails = [];
        while (($row = oci_fetch_assoc($stmt)) != false) {
            $supplierOrderDetails[] = $row;
        }
        return $supplierOrderDetails;
    }
}
?>

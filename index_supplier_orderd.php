<?php
require_once __DIR__ . '/SupplierOrderDetails.php';

$supplierOrderDetailsObj = new SupplierOrderDetails();
$message = "";

// Process user requests
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    try {
        if (isset($_POST['action'])) {
            $action = $_POST['action'];

            switch ($action) {
                case 'add':
                    $supplierOrderId = $_POST['supplier_order_id'];
                    $productId = $_POST['product_id'];
                    $quantity = $_POST['quantity'];
                    $unitPrice = $_POST['unit_price'];
                    $supplierOrderDetailsObj->addSupplierOrderDetail($supplierOrderId, $productId, $quantity, $unitPrice);
                    $message = "Supplier order detail added successfully.";
                    break;

                case 'update':
                    $supplierOrderDetailId = $_POST['supplier_order_detail_id'];
                    $supplierOrderId = $_POST['supplier_order_id'];
                    $productId = $_POST['product_id'];
                    $quantity = $_POST['quantity'];
                    $unitPrice = $_POST['unit_price'];
                    $supplierOrderDetailsObj->updateSupplierOrderDetail($supplierOrderDetailId, $supplierOrderId, $productId, $quantity, $unitPrice);
                    $message = "Supplier order detail updated successfully.";
                    break;

                case 'delete':
                    $supplierOrderDetailId = $_POST['supplier_order_detail_id'];
                    $supplierOrderDetailsObj->deleteSupplierOrderDetail($supplierOrderDetailId);
                    $message = "Supplier order detail deleted successfully.";
                    break;

                default:
                    $message = "Invalid action.";
            }
        }
    } catch (Exception $e) {
        $message = "Error: " . $e->getMessage();
    }
}

// Get all supplier order details after each operation
$supplierOrderDetails = $supplierOrderDetailsObj->getAllSupplierOrderDetails();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Supplier Order Details CRUD</title>
</head>
<body>
    <h1>Supplier Order Details Management</h1>

    <?php if ($message): ?>
        <p style="color: green;"><?php echo $message; ?></p>
    <?php endif; ?>

    <!-- Form for adding/updating supplier order details -->
    <h2>Add/Update Supplier Order Detail</h2>
    <form method="POST" action="">
        <label for="supplier_order_detail_id">ID (for update):</label>
        <input type="number" name="supplier_order_detail_id" id="supplier_order_detail_id" placeholder="Only for update"><br><br>
        <label for="supplier_order_id">Supplier Order ID:</label>
        <input type="number" name="supplier_order_id" id="supplier_order_id" required><br><br>
        <label for="product_id">Product ID:</label>
        <input type="number" name="product_id" id="product_id" required><br><br>
        <label for="quantity">Quantity:</label>
        <input type="number" name="quantity" id="quantity" required><br><br>
        <label for="unit_price">Unit Price:</label>
        <input type="number" name="unit_price" id="unit_price" step="0.01" required><br><br>
        <button type="submit" name="action" value="add">Add</button>
        <button type="submit" name="action" value="update">Update</button>
    </form>

    <!-- Form for deleting a supplier order detail -->
    <h2>Delete Supplier Order Detail</h2>
    <form method="POST" action="">
        <label for="delete_supplier_order_detail_id">ID of the Supplier Order Detail to delete:</label>
        <input type="number" name="supplier_order_detail_id" id="delete_supplier_order_detail_id" required><br><br>
        <button type="submit" name="action" value="delete">Delete</button>
    </form>

    <!-- Show all supplier order details -->
    <h2>List of Supplier Order Details</h2>
    <table border="1" cellspacing="0" cellpadding="5">
        <tr>
            <th>ID</th>
            <th>Supplier Order ID</th>
            <th>Product ID</th>
            <th>Quantity</th>
            <th>Unit Price</th>
        </tr>
        <?php foreach ($supplierOrderDetails as $row): ?>
            <tr>
                <td><?php echo htmlspecialchars($row['SUPPLIER_ORDER_DETAIL_ID']); ?></td>
                <td><?php echo htmlspecialchars($row['SUPPLIER_ORDER_ID']); ?></td>
                <td><?php echo htmlspecialchars($row['PRODUCT_ID']); ?></td>
                <td><?php echo htmlspecialchars($row['QUANTITY']); ?></td>
                <td><?php echo htmlspecialchars($row['UNIT_PRICE']); ?></td>
            </tr>
        <?php endforeach; ?>
    </table>
</body>
</html>

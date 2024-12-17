<?php
require_once __DIR__ . '/OrderDetails.php';

$orderDetailsObj = new OrderDetails();
$message = "";

// Process user requests
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    try {
        if (isset($_POST['action'])) {
            $action = $_POST['action'];

            switch ($action) {
                case 'add':
                    $orderId = $_POST['order_id'];
                    $productId = $_POST['product_id'];
                    $quantity = $_POST['quantity'];
                    $unitPrice = $_POST['unit_price'];
                    $orderDetailsObj->addOrderDetail($orderId, $productId, $quantity, $unitPrice);
                    $message = "Order detail added successfully.";
                    break;

                case 'update':
                    $orderDetailId = $_POST['order_detail_id'];
                    $orderId = $_POST['order_id'];
                    $productId = $_POST['product_id'];
                    $quantity = $_POST['quantity'];
                    $unitPrice = $_POST['unit_price'];
                    $orderDetailsObj->updateOrderDetail($orderDetailId, $orderId, $productId, $quantity, $unitPrice);
                    $message = "Order detail updated successfully.";
                    break;

                case 'delete':
                    $orderDetailId = $_POST['order_detail_id'];
                    $orderDetailsObj->deleteOrderDetail($orderDetailId);
                    $message = "Order detail deleted successfully.";
                    break;

                default:
                    $message = "Invalid action.";
            }
        }
    } catch (Exception $e) {
        $message = "Error: " . $e->getMessage();
    }
}

// Get all order details after each operation
$orderDetails = $orderDetailsObj->getAllOrderDetails();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Order Details CRUD</title>
</head>
<body>
    <h1>Order Details Management</h1>

    <?php if ($message): ?>
        <p style="color: green;"><?php echo $message; ?></p>
    <?php endif; ?>

    <!-- Form for adding/updating order details -->
    <h2>Add/Update Order Detail</h2>
    <form method="POST" action="">
        <label for="order_detail_id">ID (for update):</label>
        <input type="number" name="order_detail_id" id="order_detail_id" placeholder="Only for update"><br><br>
        <label for="order_id">Order ID:</label>
        <input type="number" name="order_id" id="order_id" required><br><br>
        <label for="product_id">Product ID:</label>
        <input type="number" name="product_id" id="product_id" required><br><br>
        <label for="quantity">Quantity:</label>
        <input type="number" name="quantity" id="quantity" required><br><br>
        <label for="unit_price">Unit Price:</label>
        <input type="number" name="unit_price" id="unit_price" step="0.01" required><br><br>
        <button type="submit" name="action" value="add">Add</button>
        <button type="submit" name="action" value="update">Update</button>
    </form>

    <!-- Form for deleting an order detail -->
    <h2>Delete Order Detail</h2>
    <form method="POST" action="">
        <label for="delete_order_detail_id">ID of the Order Detail to delete:</label>
        <input type="number" name="order_detail_id" id="delete_order_detail_id" required><br><br>
        <button type="submit" name="action" value="delete">Delete</button>
    </form>

    <!-- Show all order details -->
    <h2>List of Order Details</h2>
    <table border="1" cellspacing="0" cellpadding="5">
        <tr>
            <th>ID</th>
            <th>Order ID</th>
            <th>Product ID</th>
            <th>Quantity</th>
            <th>Unit Price</th>
        </tr>
        <?php foreach ($orderDetails as $row): ?>
            <tr>
                <td><?php echo htmlspecialchars($row['ORDER_DETAIL_ID']); ?></td>
                <td><?php echo htmlspecialchars($row['ORDER_ID']); ?></td>
                <td><?php echo htmlspecialchars($row['PRODUCT_ID']); ?></td>
                <td><?php echo htmlspecialchars($row['QUANTITY']); ?></td>
                <td><?php echo htmlspecialchars($row['UNIT_PRICE']); ?></td>
            </tr>
        <?php endforeach; ?>
    </table>
</body>
</html>

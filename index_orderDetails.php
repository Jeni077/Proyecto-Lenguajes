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
<html>
<head>
    <title>Super</title>
    <meta charset="UTF-8">
    <link href="css/estilos.css" rel="stylesheet" type="text/css"/>
</head>
<body style="background-color: #F5EEDC; background-size: cover;">



    <header>
        <h1>Super Grupo#4 CR</h1>
        <nav>
            <ul>
                <li><a href="index.php">Inicio</a></li>
                <li><a href="index_category.php">Categorias</a></li>
                <li><a href="index_customer.php">Clientes</a></li>
                <li><a href="index_departments.php">Departamentos</a></li>
                <li><a href="index_employees.php">Empleado</a></li> 
                <li><a href="index_orderDetails.php">Orden con detalles</a></li>  
                <li><a href="index_orders.php"><Obj>Ordenes</Obj></a></li>              
                <li><a href="index_products.php">Productos</a></li>              
                <li><a href="index_supplier_orderd.php">Orden de Proovedores con detalle</a></li>              
                <li><a href="index_suppliers_orders.php">Orden de Proovedores</a></li>              
                <li><a href="index_suppliers.php">Proovedores</a></li>              

             
            </ul>
        </nav>
    </header>

<body>
    <h1>Gestion de detalles de ordenes</h1>

    <?php if ($message): ?>
        <p style="color: green;"><?php echo $message; ?></p>
    <?php endif; ?>

    <!-- Form for adding/updating order details -->
    <h2>Agregar orden detalle</h2>
    <form method="POST" action="">
        <label for="order_detail_id">ID (para actualizar):</label>
        <input type="number" name="order_detail_id" id="order_detail_id" placeholder="Only for update"><br><br>
        <label for="order_id">Orden ID:</label>
        <input type="number" name="order_id" id="order_id" required><br><br>
        <label for="product_id">Producto ID:</label>
        <input type="number" name="product_id" id="product_id" required><br><br>
        <label for="quantity">Cantidad:</label>
        <input type="number" name="quantity" id="quantity" required><br><br>
        <label for="unit_price">Precio:</label>
        <input type="number" name="unit_price" id="unit_price" step="0.01" required><br><br>
        <button type="submit" name="action" value="add">agregar</button>
        <button type="submit" name="action" value="update">actualizar</button>
    </form>

    <!-- Form for deleting an order detail -->
    <h2>Eliminar orden detalle</h2>
    <form method="POST" action="">
        <label for="delete_order_detail_id">ID Orden Detaille para eliminar:</label>
        <input type="number" name="order_detail_id" id="delete_order_detail_id" required><br><br>
        <button type="submit" name="action" value="delete">Delete</button>
    </form>

    <!-- Show all order details -->
    <h2>Lista orden detalle</h2>
    <table border="1" cellspacing="0" cellpadding="5">
        <tr>
            <th>ID</th>
            <th>Orden ID</th>
            <th>Producto ID</th>
            <th>Cantidad</th>
            <th>Precio</th>
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

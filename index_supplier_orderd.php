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
    <h1>Gestion de ordenes detalle de proveedor </h1>

    <?php if ($message): ?>
        <p style="color: green;"><?php echo $message; ?></p>
    <?php endif; ?>

    <!-- Form for adding/updating supplier order details -->
    <h2>Agregar/actualizar orden de proovedor </h2>
    <form method="POST" action="">
        <label for="supplier_order_detail_id">ID (para actualizar):</label>
        <input type="number" name="supplier_order_detail_id" id="supplier_order_detail_id" placeholder="Only for update"><br><br>
        <label for="supplier_order_id">Proveedor Order ID:</label>
        <input type="number" name="supplier_order_id" id="supplier_order_id" required><br><br>
        <label for="product_id">Producto ID:</label>
        <input type="number" name="product_id" id="product_id" required><br><br>
        <label for="quantity">Cantidad:</label>
        <input type="number" name="quantity" id="quantity" required><br><br>
        <label for="unit_price"> Precio:</label>
        <input type="number" name="unit_price" id="unit_price" step="0.01" required><br><br>
        <button type="submit" name="action" value="add">agregar</button>
        <button type="submit" name="action" value="update">actualizar</button>
    </form>

    <!-- Form for deleting a supplier order detail -->
    <h2>Borrar  orden detalle proveedor </h2>
    <form method="POST" action="">
        <label for="delete_supplier_order_detail_id">ID proveedor Orden Detaille para eliminar:</label>
        <input type="number" name="supplier_order_detail_id" id="delete_supplier_order_detail_id" required><br><br>
        <button type="submit" name="action" value="delete">Delete</button>
    </form>

    <!-- Show all supplier order details -->
    <h2> Lista orden de proovedor </h2>
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

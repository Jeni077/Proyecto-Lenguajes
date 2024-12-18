<?php
require_once __DIR__ . '/SupplierOrder.php';

// Crear una instancia de la clase SupplierOrder
$supplierOrderObj = new SupplierOrder();

// Verificar la acción solicitada
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    try {
        switch ($_POST['action']) {
            case 'add':
                $supplierOrderObj->addSupplierOrder($_POST['supplier_id'], $_POST['order_date'], $_POST['total_amount']);
                echo "Orden de proveedor agregada con éxito.";
                break;
            case 'update':
                $supplierOrderObj->updateSupplierOrder($_POST['supplier_order_id'], $_POST['supplier_id'], $_POST['order_date'], $_POST['total_amount']);
                echo "Orden de proveedor actualizada con éxito.";
                break;
            case 'delete':
                $supplierOrderObj->deleteSupplierOrder($_POST['supplier_order_id']);
                echo "Orden de proveedor eliminada con éxito.";
                break;
            default:
                throw new Exception("Acción desconocida.");
        }
    } catch (Exception $e) {
        echo "Error: " . $e->getMessage();
    }
}

// Obtener todas las órdenes de proveedores
$supplierOrders = $supplierOrderObj->getAllSupplierOrders();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Órdenes de Proveedores</title>
</head>
<body>

<h1>Gestión de Órdenes de Proveedores</h1>

<h2>Lista de Órdenes de Proveedores</h2>
<table border="1">
    <tr>
        <th>Supplier Order ID</th>
        <th>Supplier ID</th>
        <th>Order Date</th>
        <th>Total Amount</th>
        <th>Acciones</th>
    </tr>
    <?php if ($supplierOrders) : ?>
        <?php foreach ($supplierOrders as $supplierOrder) : ?>
            <tr>
                <td><?php echo $supplierOrder['SUPPLIER_ORDER_ID']; ?></td>
                <td><?php echo $supplierOrder['SUPPLIER_ID']; ?></td>
                <td><?php echo date('Y-m-d', strtotime($supplierOrder['ORDER_DATE'])); ?></td> <!-- Convertir la fecha a 'YYYY-MM-DD' -->
                <td><?php echo $supplierOrder['TOTAL_AMOUNT']; ?></td>
                <td>
                    <form action="" method="post" style="display:inline;">
                        <input type="hidden" name="supplier_order_id" value="<?php echo $supplierOrder['SUPPLIER_ORDER_ID']; ?>">
                        <input type="hidden" name="action" value="delete">
                        <button type="submit">Eliminar</button>
                    </form>
                    <form action="" method="post" style="display:inline;">
                        <input type="hidden" name="supplier_order_id" value="<?php echo $supplierOrder['SUPPLIER_ORDER_ID']; ?>">
                        <input type="date" name="order_date" value="<?php echo date('Y-m-d', strtotime($supplierOrder['ORDER_DATE'])); ?>" required><br><br> <!-- Campo de fecha en 'YYYY-MM-DD' -->
                        <input type="number" name="supplier_id" value="<?php echo $supplierOrder['SUPPLIER_ID']; ?>" required><br><br>
                        <input type="number" name="total_amount" value="<?php echo $supplierOrder['TOTAL_AMOUNT']; ?>" required><br><br>
                        <input type="hidden" name="action" value="update">
                        <button type="submit">Actualizar</button>
                    </form>
                </td>
            </tr>
        <?php endforeach; ?>
    <?php else : ?>
        <tr>
            <td colspan="5">No hay órdenes de proveedores registradas.</td>
        </tr>
    <?php endif; ?>
</table>

<h2>Agregar Orden de Proveedor</h2>
<form method="post" action="">
    <label for="supplier_id">ID del Proveedor:</label>
    <input type="number" name="supplier_id" required><br><br>
    <input type="date" name="order_date" required><br><br> <!-- Campo de fecha en 'YYYY-MM-DD' -->
    <input type="number" name="total_amount" required><br><br>
    <button type="submit" name="action" value="add">Agregar Orden de Proveedor</button>
</form>

</body>
</html>


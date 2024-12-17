<?php
require_once __DIR__ . '/Supplier.php';

$supplier = new Supplier();
$message = "";

// Procesar solicitudes del usuario
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    try {
        if (isset($_POST['action'])) {
            $action = $_POST['action'];

            switch ($action) {
                case 'add':
                    $name = $_POST['name'];
                    $contactName = $_POST['contact_name'];
                    $phoneNumber = $_POST['phone_number'];
                    $email = $_POST['email'];
                    $supplier->addSupplier($name, $contactName, $phoneNumber, $email);
                    $message = "Proveedor agregado correctamente.";
                    break;

                case 'update':
                    $id = $_POST['id'];
                    $name = $_POST['name'];
                    $contactName = $_POST['contact_name'];
                    $phoneNumber = $_POST['phone_number'];
                    $email = $_POST['email'];
                    $supplier->updateSupplier($id, $name, $contactName, $phoneNumber, $email);
                    $message = "Proveedor actualizado correctamente.";
                    break;

                case 'delete':
                    $id = $_POST['id'];
                    $supplier->deleteSupplier($id);
                    $message = "Proveedor eliminado correctamente.";
                    break;

                default:
                    $message = "Acción no válida.";
            }
        }
    } catch (Exception $e) {
        $message = "Error: " . $e->getMessage();
    }
}

// Obtener todos los proveedores después de cada operación
$suppliers = $supplier->getAllSuppliers();

?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>CRUD Proveedores</title>
</head>
<body>
    <h1>Administración de Proveedores</h1>

    <?php if ($message): ?>
        <p style="color: green;"><?php echo $message; ?></p>
    <?php endif; ?>

    <!-- Formulario para agregar/modificar un proveedor -->
    <h2>Agregar/Actualizar Proveedor</h2>
    <form method="POST" action="">
        <label for="id">ID (para actualizar):</label>
        <input type="number" name="id" id="id" placeholder="Solo para actualizar"><br><br>
        <label for="name">Nombre:</label>
        <input type="text" name="name" id="name" required><br><br>
        <label for="contact_name">Nombre de Contacto:</label>
        <input type="text" name="contact_name" id="contact_name"><br><br>
        <label for="phone_number">Número de Teléfono:</label>
        <input type="text" name="phone_number" id="phone_number"><br><br>
        <label for="email">Correo Electrónico:</label>
        <input type="email" name="email" id="email"><br><br>
        <button type="submit" name="action" value="add">Agregar</button>
        <button type="submit" name="action" value="update">Actualizar</button>
    </form>

    <!-- Formulario para eliminar un proveedor -->
    <h2>Eliminar Proveedor</h2>
    <form method="POST" action="">
        <label for="delete_id">ID del Proveedor a eliminar:</label>
        <input type="number" name="id" id="delete_id" required><br><br>
        <button type="submit" name="action" value="delete">Eliminar</button>
    </form>

    <!-- Mostrar todos los proveedores -->
    <h2>Lista de Proveedores</h2>
    <table border="1" cellspacing="0" cellpadding="5">
        <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Nombre de Contacto</th>
            <th>Número de Teléfono</th>
            <th>Correo Electrónico</th>
        </tr>
        <?php foreach ($suppliers as $row): ?>
            <tr>
                <td><?php echo htmlspecialchars($row['SUPPLIER_ID']); ?></td>
                <td><?php echo htmlspecialchars($row['NAME']); ?></td>
                <td><?php echo htmlspecialchars($row['CONTACT_NAME']); ?></td>
                <td><?php echo htmlspecialchars($row['PHONE_NUMBER']); ?></td>
                <td><?php echo htmlspecialchars($row['EMAIL']); ?></td>
            </tr>
        <?php endforeach; ?>
    </table>
</body>
</html>

<?php
require_once __DIR__ . '/Customer.php';

$customer = new Customer();
$message = "";

// Procesar solicitudes del usuario
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    try {
        if (isset($_POST['action'])) {
            $action = $_POST['action'];

            switch ($action) {
                case 'add':
                    $first_name = $_POST['first_name'];
                    $last_name = $_POST['last_name'];
                    $email = $_POST['email'];
                    $phone_number = $_POST['phone_number'];
                    $address = $_POST['address'];
                    $customer->addCustomer($first_name, $last_name, $email, $phone_number, $address);
                    $message = "Cliente agregado correctamente.";
                    break;

                case 'update':
                    $id = $_POST['id'];
                    $first_name = $_POST['first_name'];
                    $last_name = $_POST['last_name'];
                    $email = $_POST['email'];
                    $phone_number = $_POST['phone_number'];
                    $address = $_POST['address'];
                    $customer->updateCustomer($id, $first_name, $last_name, $email, $phone_number, $address);
                    $message = "Cliente actualizado correctamente.";
                    break;

                case 'delete':
                    $id = $_POST['id'];
                    $customer->deleteCustomer($id);
                    $message = "Cliente eliminado correctamente.";
                    break;

                default:
                    $message = "Acción no válida.";
            }
        }
    } catch (Exception $e) {
        $message = "Error: " . $e->getMessage();
    }
}

// Obtener todos los clientes después de cada operación
$customers = $customer->getAllCustomers();
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
    <h1>Administración de Clientes</h1>

    <?php if ($message): ?>
        <p style="color: green;"><?php echo $message; ?></p>
    <?php endif; ?>

    <!-- Formulario para agregar/modificar un cliente -->
    <h2>Agregar/Actualizar Cliente</h2>
    <form method="POST" action="">
        <label for="id">ID (para actualizar):</label>
        <input type="number" name="id" id="id" placeholder="Solo para actualizar"><br><br>
        <label for="first_name">Nombre:</label>
        <input type="text" name="first_name" id="first_name" required><br><br>
        <label for="last_name">Apellido:</label>
        <input type="text" name="last_name" id="last_name" required><br><br>
        <label for="email">Correo:</label>
        <input type="email" name="email" id="email"><br><br>
        <label for="phone_number">Teléfono:</label>
        <input type="text" name="phone_number" id="phone_number"><br><br>
        <label for="address">Dirección:</label>
        <input type="text" name="address" id="address"><br><br>
        <button type="submit" name="action" value="add">Agregar</button>
        <button type="submit" name="action" value="update">Actualizar</button>
    </form>

    <!-- Formulario para eliminar un cliente -->
    <h2>Eliminar Cliente</h2>
    <form method="POST" action="">
        <label for="delete_id">ID del Cliente a eliminar:</label>
        <input type="number" name="id" id="delete_id" required><br><br>
        <button type="submit" name="action" value="delete">Eliminar</button>
    </form>

    <!-- Mostrar todos los clientes -->
    <h2>Lista de Clientes</h2>
    <table border="1" cellspacing="0" cellpadding="5">
        <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Apellido</th>
            <th>Correo</th>
            <th>Teléfono</th>
            <th>Dirección</th>
        </tr>
        <?php foreach ($customers as $row): ?>
            <tr>
                <td><?php echo htmlspecialchars($row['CUSTOMER_ID']); ?></td>
                <td><?php echo htmlspecialchars($row['FIRST_NAME']); ?></td>
                <td><?php echo htmlspecialchars($row['LAST_NAME']); ?></td>
                <td><?php echo htmlspecialchars($row['EMAIL']); ?></td>
                <td><?php echo htmlspecialchars($row['PHONE_NUMBER']); ?></td>
                <td><?php echo htmlspecialchars($row['ADDRESS']); ?></td>
            </tr>
        <?php endforeach; ?>
    </table>
</body>
</html>

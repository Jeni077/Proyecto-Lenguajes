<?php
require_once __DIR__ . '/Order.php';
require_once __DIR__ . '/Customer.php'; // Asegúrate de que este archivo esté presente y tenga la lógica para recuperar los datos de los clientes.
require_once __DIR__ . '/Employee.php'; // Asegúrate de que este archivo esté presente y tenga la lógica para recuperar los datos de los empleados.

$order = new Order();
$message = "";

// Procesar solicitudes del usuario
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    try {
        if (isset($_POST['action'])) {
            $action = $_POST['action'];

            switch ($action) {
                case 'add':
                    $orderDate = $_POST['order_date'];
                    $customerId = $_POST['customer_id'];
                    $employeeId = $_POST['employee_id'];
                    // Convertir la fecha en 'YYYY-MM-DD'
                    $formattedDate = date('Y-m-d', strtotime($orderDate));
                    $order->addOrder($formattedDate, $customerId, $employeeId);
                    $message = "Orden agregada correctamente.";
                    break;

                case 'update':
                    $id = $_POST['id'];
                    $orderDate = $_POST['order_date'];
                    $customerId = $_POST['customer_id'];
                    $employeeId = $_POST['employee_id'];
                    // Convertir la fecha en 'YYYY-MM-DD'
                    $formattedDate = date('Y-m-d', strtotime($orderDate));
                    $order->updateOrder($id, $formattedDate, $customerId, $employeeId);
                    $message = "Orden actualizada correctamente.";
                    break;

                case 'delete':
                    $id = $_POST['id'];
                    $order->deleteOrder($id);
                    $message = "Orden eliminada correctamente.";
                    break;

                default:
                    $message = "Acción no válida.";
            }
        }
    } catch (Exception $e) {
        $message = "Error: " . $e->getMessage();
    }
}

// Obtener todos los clientes y empleados para los select de la orden
$customer = new Customer();
$customers = $customer->getAllCustomers();

$employee = new Employee();
$employees = $employee->getAllEmployees();

// Obtener todas las órdenes después de cada operación
$orders = $order->getAllOrders();
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
    <h1>Administración de Órdenes</h1>

    <?php if ($message): ?>
        <p style="color: green;"><?php echo $message; ?></p>
    <?php endif; ?>

    <!-- Formulario para agregar/modificar una orden -->
    <h2>Agregar/Actualizar Orden</h2>
    <form method="POST" action="">
        <label for="id">ID (para actualizar):</label>
        <input type="number" name="id" id="id" placeholder="Solo para actualizar"><br><br>
        <label for="order_date">Fecha de Orden:</label>
        <input type="date" name="order_date" id="order_date" required><br><br>
        <label for="customer_id">ID del Cliente:</label>
        <select name="customer_id" id="customer_id" required>
            <?php foreach ($customers as $row): ?>
                <option value="<?php echo htmlspecialchars($row['CUSTOMER_ID']); ?>">
                    <?php echo htmlspecialchars($row['FIRST_NAME']) . " " . htmlspecialchars($row['LAST_NAME']); ?>
                </option>
            <?php endforeach; ?>
        </select><br><br>
        <label for="employee_id">ID del Empleado:</label>
        <select name="employee_id" id="employee_id" required>
            <?php foreach ($employees as $row): ?>
                <option value="<?php echo htmlspecialchars($row['EMPLOYEE_ID']); ?>">
                    <?php echo htmlspecialchars($row['FIRST_NAME']) . " " . htmlspecialchars($row['LAST_NAME']); ?>
                </option>
            <?php endforeach; ?>
        </select><br><br>
        <button type="submit" name="action" value="add">Agregar</button>
        <button type="submit" name="action" value="update">Actualizar</button>
    </form>

    <!-- Formulario para eliminar una orden -->
    <h2>Eliminar Orden</h2>
    <form method="POST" action="">
        <label for="delete_id">ID de la Orden a eliminar:</label>
        <input type="number" name="id" id="delete_id" required><br><br>
        <button type="submit" name="action" value="delete">Eliminar</button>
    </form>

    <!-- Mostrar todas las órdenes -->
    <h2>Lista de Órdenes</h2>
    <table border="1" cellspacing="0" cellpadding="5">
        <tr>
            <th>ID</th>
            <th>Fecha de Orden</th>
            <th>Cliente</th>
            <th>Empleado</th>
        </tr>
        <?php foreach ($orders as $row): ?>
            <tr>
                <td><?php echo htmlspecialchars($row['ORDER_ID']); ?></td>
                <td><?php echo htmlspecialchars($row['ORDER_DATE']); ?></td>
                <td><?php echo htmlspecialchars($row['CUSTOMER_ID']); ?></td>
                <td><?php echo htmlspecialchars($row['EMPLOYEE_ID']); ?></td>
            </tr>
        <?php endforeach; ?>
    </table>
</body>
</html>


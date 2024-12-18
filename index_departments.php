<?php
require_once __DIR__ . '/Department.php';

$department = new Department();
$message = "";

// Procesar solicitudes del usuario
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    try {
        if (isset($_POST['action'])) {
            $action = $_POST['action'];

            switch ($action) {
                case 'add':
                    $name = $_POST['name'];
                    $department->addDepartment($name);
                    $message = "Departamento agregado correctamente.";
                    break;

                case 'update':
                    $id = $_POST['id'];
                    $name = $_POST['name'];
                    $department->updateDepartment($id, $name);
                    $message = "Departamento actualizado correctamente.";
                    break;

                case 'delete':
                    $id = $_POST['id'];
                    $department->deleteDepartment($id);
                    $message = "Departamento eliminado correctamente.";
                    break;

                default:
                    $message = "Acción no válida.";
            }
        }
    } catch (Exception $e) {
        $message = "Error: " . $e->getMessage();
    }
}

// Obtener todos los departamentos después de cada operación
$departments = $department->getAllDepartments();
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
    <h1>Administración de Departamentos</h1>

    <?php if ($message): ?>
        <p style="color: green;"><?php echo $message; ?></p>
    <?php endif; ?>

    <!-- Formulario para agregar/modificar un departamento -->
    <h2>Agregar/Actualizar Departamento</h2>
    <form method="POST" action="">
        <label for="id">ID (para actualizar):</label>
        <input type="number" name="id" id="id" placeholder="Solo para actualizar"><br><br>
        <label for="name">Nombre del Departamento:</label>
        <input type="text" name="name" id="name" required><br><br>
        <button type="submit" name="action" value="add">Agregar</button>
        <button type="submit" name="action" value="update">Actualizar</button>
    </form>

    <!-- Formulario para eliminar un departamento -->
    <h2>Eliminar Departamento</h2>
    <form method="POST" action="">
        <label for="delete_id">ID del Departamento a eliminar:</label>
        <input type="number" name="id" id="delete_id" required><br><br>
        <button type="submit" name="action" value="delete">Eliminar</button>
    </form>

    <!-- Mostrar todos los departamentos -->
    <h2>Lista de Departamentos</h2>
    <table border="1" cellspacing="0" cellpadding="5">
        <tr>
            <th>ID</th>
            <th>Nombre</th>
        </tr>
        <?php foreach ($departments as $row): ?>
            <tr>
                <td><?php echo htmlspecialchars($row['DEPARTMENT_ID']); ?></td>
                <td><?php echo htmlspecialchars($row['NAME']); ?></td>
            </tr>
        <?php endforeach; ?>
    </table>
</body>
</html>

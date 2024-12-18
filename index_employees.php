<?php
require_once __DIR__ . '/Employee.php';

$employee = new Employee();
$message = "";

// Procesar solicitudes del usuario
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    try {
        if (isset($_POST['action'])) {
            $action = $_POST['action'];

            switch ($action) {
                case 'add':
                    $firstName = $_POST['first_name'];
                    $lastName = $_POST['last_name'];
                    $position = $_POST['position'];
                    $hireDate = $_POST['hire_date'];
                    $salary = $_POST['salary'];
                    $departmentId = $_POST['department_id'];
                    $employee->addEmployee($firstName, $lastName, $position, $hireDate, $salary, $departmentId);
                    $message = "Empleado agregado correctamente.";
                    break;

                case 'update':
                    $id = $_POST['id'];
                    $firstName = $_POST['first_name'];
                    $lastName = $_POST['last_name'];
                    $position = $_POST['position'];
                    $hireDate = $_POST['hire_date'];
                    $salary = $_POST['salary'];
                    $departmentId = $_POST['department_id'];
                    $employee->updateEmployee($id, $firstName, $lastName, $position, $hireDate, $salary, $departmentId);
                    $message = "Empleado actualizado correctamente.";
                    break;

                case 'delete':
                    $id = $_POST['id'];
                    $employee->deleteEmployee($id);
                    $message = "Empleado eliminado correctamente.";
                    break;

                default:
                    $message = "Acción no válida.";
            }
        }
    } catch (Exception $e) {
        $message = "Error: " . $e->getMessage();
    }
}

// Obtener todos los empleados después de cada operación
$employees = $employee->getAllEmployees();
$departments = $employee->getAllDepartments(); // Función que ahora se define correctamente

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
    <h1>Administración de Empleados</h1>

    <?php if ($message): ?>
        <p style="color: green;"><?php echo $message; ?></p>
    <?php endif; ?>

    <!-- Formulario para agregar/modificar un empleado -->
    <h2>Agregar/Actualizar Empleado</h2>
    <form method="POST" action="">
        <label for="id">ID (para actualizar):</label>
        <input type="number" name="id" id="id" placeholder="Solo para actualizar"><br><br>
        <label for="first_name">Nombre:</label>
        <input type="text" name="first_name" id="first_name" required><br><br>
        <label for="last_name">Apellido:</label>
        <input type="text" name="last_name" id="last_name" required><br><br>
        <label for="position">Puesto:</label>
        <input type="text" name="position" id="position"><br><br>
        <label for="hire_date">Fecha de contratación (YYYY-MM-DD):</label>
        <input type="date" name="hire_date" id="hire_date" required><br><br>
        <label for="salary">Salario:</label>
        <input type="number" name="salary" id="salary" step="0.01" required><br><br>
        <label for="department_id">ID del Departamento:</label>
        <select name="department_id" id="department_id" required>
            <?php foreach ($departments as $department): ?>
                <option value="<?php echo $department['DEPARTMENT_ID']; ?>">
                    <?php echo htmlspecialchars($department['NAME']); ?>
                </option>
            <?php endforeach; ?>
        </select><br><br>
        <button type="submit" name="action" value="add">Agregar</button>
        <button type="submit" name="action" value="update">Actualizar</button>
    </form>

    <!-- Formulario para eliminar un empleado -->
    <h2>Eliminar Empleado</h2>
    <form method="POST" action="">
        <label for="delete_id">ID del Empleado a eliminar:</label>
        <input type="number" name="id" id="delete_id" required><br><br>
        <button type="submit" name="action" value="delete">Eliminar</button>
    </form>

    <!-- Mostrar todos los empleados -->
    <h2>Lista de Empleados</h2>
    <table border="1" cellspacing="0" cellpadding="5">
        <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Apellido</th>
            <th>Puesto</th>
            <th>Fecha de Contratación</th>
            <th>Salario</th>
            <th>ID Departamento</th>
        </tr>
        <?php foreach ($employees as $row): ?>
            <tr>
                <td><?php echo htmlspecialchars($row['EMPLOYEE_ID']); ?></td>
                <td><?php echo htmlspecialchars($row['FIRST_NAME']); ?></td>
                <td><?php echo htmlspecialchars($row['LAST_NAME']); ?></td>
                <td><?php echo htmlspecialchars($row['POSITION']); ?></td>
                <td><?php echo htmlspecialchars($row['HIRE_DATE']); ?></td>
                <td><?php echo htmlspecialchars($row['SALARY']); ?></td>
                <td><?php echo htmlspecialchars($row['DEPARTMENT_ID']); ?></td>
            </tr>
        <?php endforeach; ?>
    </table>
</body>
</html>

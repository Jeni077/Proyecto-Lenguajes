<?php
require_once __DIR__ . '/Category.php';

$category = new Category();
$message = "";

// Procesar las solicitudes del usuario
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    try {
        if (isset($_POST['action'])) {
            $action = $_POST['action'];

            switch ($action) {
                case 'add':
                    $name = $_POST['name'];
                    $description = $_POST['description'];
                    $category->addCategory($name, $description);
                    $message = "Categoría agregada correctamente.";
                    break;

                case 'update':
                    $id = $_POST['id'];
                    $name = $_POST['name'];
                    $description = $_POST['description'];
                    $category->updateCategory($id, $name, $description);
                    $message = "Categoría actualizada correctamente.";
                    break;

                case 'delete':
                    $id = $_POST['id'];
                    $category->deleteCategory($id);
                    $message = "Categoría eliminada correctamente.";
                    break;

                default:
                    $message = "Acción no válida.";
            }
        }
    } catch (Exception $e) {
        $message = "Error: " . $e->getMessage();
    }
}

// Obtener todas las categorías después de cada operación
$categories = $category->getAllCategories();
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
    <h1>Administración de Categorías</h1>

    <?php if ($message): ?>
        <p style="color: green;"><?php echo $message; ?></p>
    <?php endif; ?>

    <h2>Agregar/Actualizar Categoría</h2>
    <form method="POST" action="">
        <input type="hidden" name="action" value="add">
        <label for="id">ID (para actualizar):</label>
        <input type="number" name="id" id="id" placeholder="Solo para actualizar"><br><br>
        <label for="name">Nombre:</label>
        <input type="text" name="name" id="name" required><br><br>
        <label for="description">Descripción:</label>
        <input type="text" name="description" id="description" required><br><br>
        <button type="submit" name="action" value="add">Agregar</button>
        <button type="submit" name="action" value="update">Actualizar</button>
    </form>

    <h2>Eliminar Categoría</h2>
    <form method="POST" action="">
        <input type="hidden" name="action" value="delete">
        <label for="delete_id">ID de la Categoría a eliminar:</label>
        <input type="number" name="id" id="delete_id" required><br><br>
        <button type="submit">Eliminar</button>
    </form>

    <!-- Mostrar todas las categorías -->
    <h2>Lista de Categorías</h2>
    <table border="1" cellspacing="0" cellpadding="5">
        <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Descripción</th>
        </tr>
        <?php foreach ($categories as $row): ?>
            <tr>
                <td><?php echo htmlspecialchars($row['CATEGORY_ID']); ?></td>
                <td><?php echo htmlspecialchars($row['NAME']); ?></td>
                <td><?php echo htmlspecialchars($row['DESCRIPTION']); ?></td>
            </tr>
        <?php endforeach; ?>
    </table>
</body>
</html>


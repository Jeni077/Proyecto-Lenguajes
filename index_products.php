<?php
require_once __DIR__ . '/Product.php';

$product = new Product();
$message = "";

// Procesar solicitudes del usuario
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    try {
        if (isset($_POST['action'])) {
            $action = $_POST['action'];

            switch ($action) {
                case 'add':
                    $name = $_POST['name'];
                    $description = $_POST['description'];
                    $price = $_POST['price'];
                    $stock_quantity = $_POST['stock_quantity'];
                    $category_id = $_POST['category_id'];
                    $product->addProduct($name, $description, $price, $stock_quantity, $category_id);
                    $message = "Producto agregado correctamente.";
                    break;

                case 'update':
                    $id = $_POST['id'];
                    $name = $_POST['name'];
                    $description = $_POST['description'];
                    $price = $_POST['price'];
                    $stock_quantity = $_POST['stock_quantity'];
                    $category_id = $_POST['category_id'];
                    $product->updateProduct($id, $name, $description, $price, $stock_quantity, $category_id);
                    $message = "Producto actualizado correctamente.";
                    break;

                case 'delete':
                    $id = $_POST['id'];
                    $product->deleteProduct($id);
                    $message = "Producto eliminado correctamente.";
                    break;

                default:
                    $message = "Acción no válida.";
            }
        }
    } catch (Exception $e) {
        $message = "Error: " . $e->getMessage();
    }
}

// Obtener todos los productos después de cada operación
$products = $product->getAllProducts();
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
    <h1>Administración de Productos</h1>

    <?php if ($message): ?>
        <p style="color: green;"><?php echo $message; ?></p>
    <?php endif; ?>

    <!-- Formulario para agregar/modificar un producto -->
    <h2>Agregar/Actualizar Producto</h2>
    <form method="POST" action="">
        <label for="id">ID (para actualizar):</label>
        <input type="number" name="id" id="id" placeholder="Solo para actualizar"><br><br>
        <label for="name">Nombre:</label>
        <input type="text" name="name" id="name" required><br><br>
        <label for="description">Descripción:</label>
        <input type="text" name="description" id="description"><br><br>
        <label for="price">Precio:</label>
        <input type="number" step="0.01" name="price" id="price" required><br><br>
        <label for="stock_quantity">Cantidad en Stock:</label>
        <input type="number" name="stock_quantity" id="stock_quantity" required><br><br>
        <label for="category_id">ID de Categoría:</label>
        <input type="number" name="category_id" id="category_id" required><br><br>
        <button type="submit" name="action" value="add">Agregar</button>
        <button type="submit" name="action" value="update">Actualizar</button>
    </form>

    <!-- Formulario para eliminar un producto -->
    <h2>Eliminar Producto</h2>
    <form method="POST" action="">
        <label for="delete_id">ID del Producto a eliminar:</label>
        <input type="number" name="id" id="delete_id" required><br><br>
        <button type="submit" name="action" value="delete">Eliminar</button>
    </form>

    <!-- Mostrar todos los productos -->
    <h2>Lista de Productos</h2>
    <table border="1" cellspacing="0" cellpadding="5">
        <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Descripción</th>
            <th>Precio</th>
            <th>Stock</th>
            <th>ID Categoría</th>
        </tr>
        <?php foreach ($products as $row): ?>
            <tr>
                <td><?php echo htmlspecialchars($row['PRODUCT_ID']); ?></td>
                <td><?php echo htmlspecialchars($row['NAME']); ?></td>
                <td><?php echo htmlspecialchars($row['DESCRIPTION']); ?></td>
                <td><?php echo htmlspecialchars($row['PRICE']); ?></td>
                <td><?php echo htmlspecialchars($row['STOCK_QUANTITY']); ?></td>
                <td><?php echo htmlspecialchars($row['CATEGORY_ID']); ?></td>
            </tr>
        <?php endforeach; ?>
    </table>
</body>
</html>

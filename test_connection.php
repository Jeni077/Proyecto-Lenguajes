<?php
$host = "database-2.c12y84q8crsw.us-east-2.rds.amazonaws.com";
$port = "1521";
$sid = "DATABASE"; // SID o Service Name correcto
$username = "admin";
$password = "fabisavu";

$connectionString = "(DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = {$host})(PORT = {$port}))
    (CONNECT_DATA = (SID = {$sid}))
)";

$conn = oci_connect($username, $password, $connectionString);

if (!$conn) {
    $error = oci_error();
    die("Error de conexión: " . $error['message']);
} else {
    echo "Conexión exitosa.<br>";

    // Ejecutar una prueba de consulta
    $query = "SELECT * FROM categories";
    $stmt = oci_parse($conn, $query);

    if (oci_execute($stmt)) {
        echo "Consulta ejecutada correctamente.<br>";

        while (($row = oci_fetch_assoc($stmt)) != false) {
            echo "ID: " . $row['CATEGORY_ID'] . ", Nombre: " . $row['NAME'] . ", Descripción: " . $row['DESCRIPTION'] . "<br>";
        }
    } else {
        $error = oci_error($stmt);
        echo "Error en la consulta: " . $error['message'];
    }

    oci_close($conn);
}
?>

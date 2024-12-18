<?php
class Database {
    private $host = "database-2.c12y84q8crsw.us-east-2.rds.amazonaws.com";
    private $port = "1521";
    private $sid = "DATABASE";
    private $username = "admin";
    private $password = "fabisavu";
    private $connection;

    public function connect() {
        $connectionString = "(DESCRIPTION =
            (ADDRESS = (PROTOCOL = TCP)(HOST = {$this->host})(PORT = {$this->port}))
            (CONNECT_DATA = (SID = {$this->sid}))
        )";

        try {
            $this->connection = oci_connect($this->username, $this->password, $connectionString);
            if (!$this->connection) {
                $error = oci_error();
                throw new Exception("Error al conectar: " . $error['message']);
            }
            return $this->connection;
        } catch (Exception $e) {
            die("Error en la conexión: " . $e->getMessage());
        }
    }

    public function close() {
        if ($this->connection) {
            oci_close($this->connection);
        }
    }
}
?>

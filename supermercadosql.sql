CREATE DATABASE  IF NOT EXISTS `supermercado` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `supermercado`;
-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: supermercado
-- ------------------------------------------------------
-- Server version	8.0.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Alimentos','Productos comestibles como cereales, enlatados y productos frescos'),(2,'Bebidas','Todo tipo de bebidas como refrescos, jugos y cervezas'),(3,'Limpieza','Productos de limpieza para el hogar y cuidado personal'),(4,'Hogar','Artículos diversos para el hogar, incluyendo utensilios de cocina'),(5,'Cuidado Personal','Productos para la higiene personal y cosméticos'),(6,'Electrónicos','Dispositivos electrónicos como teléfonos y electrodomésticos'),(7,'Ropa','Prendas de vestir para hombres, mujeres y niños'),(8,'Juguetes','Artículos para el entretenimiento de los niños'),(9,'Oficina','Material de oficina, incluyendo papel y útiles escolares'),(10,'Mascotas','Productos para el cuidado y alimentación de mascotas');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `address` text,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'Ricardo','Martínez','ricardo.martinez@example.com','555-1001','Calle Falsa 123, Ciudad'),(2,'Lucía','González','lucia.gonzalez@example.com','555-1002','Calle Real 456, Ciudad'),(3,'Sofía','López','sofia.lopez@example.com','555-1003','Calle Mayor 789, Ciudad'),(4,'Andrés','Pérez','andres.perez@example.com','555-1004','Calle Nueva 321, Ciudad'),(5,'Laura','Sánchez','laura.sanchez@example.com','555-1005','Calle Vieja 654, Ciudad'),(6,'David','Hernández','david.hernandez@example.com','555-1006','Calle Azul 987, Ciudad'),(7,'Paola','Ramírez','paola.ramirez@example.com','555-1007','Calle Verde 159, Ciudad'),(8,'Juan','Martín','juan.martin@example.com','555-1008','Calle Amarilla 753, Ciudad'),(9,'Fernanda','Salazar','fernanda.salazar@example.com','555-1009','Calle Rosa 258, Ciudad'),(10,'Carmen','Díaz','carmen.diaz@example.com','555-1010','Calle Naranja 369, Ciudad'),(11,'Oscar','Lara','oscar.lara@example.com','555-1011','Calle Cielo 963, Ciudad'),(12,'Bárbara','Cruz','barbara.cruz@example.com','555-1012','Calle Tierra 147, Ciudad'),(13,'Emilio','Soto','emilio.soto@example.com','555-1013','Calle Sol 258, Ciudad'),(14,'Verónica','Mora','veronica.mora@example.com','555-1014','Calle Luna 951, Ciudad'),(15,'Hugo','Vega','hugo.vega@example.com','555-1015','Calle Estrella 753, Ciudad'),(16,'Silvia','Salinas','silvia.salinas@example.com','555-1016','Calle Cielo 852, Ciudad'),(17,'Esteban','Navarro','esteban.navarro@example.com','555-1017','Calle Océano 654, Ciudad'),(18,'Ana','Serrano','ana.serrano@example.com','555-1018','Calle Río 123, Ciudad'),(19,'Marcelo','Gómez','marcelo.gomez@example.com','555-1019','Calle Mar 789, Ciudad'),(20,'Lilian','Cáceres','lilian.caceres@example.com','555-1020','Calle Lago 456, Ciudad');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departments` (
  `department_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`department_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` VALUES (1,'Ventas'),(2,'Almacén'),(3,'Cuidado al Cliente'),(4,'Administración'),(5,'Contabilidad'),(6,'Recursos Humanos'),(7,'Marketing'),(8,'Logística'),(9,'Tecnologías de la Información'),(10,'Desarrollo de Productos');
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employees` (
  `employee_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `position` varchar(255) DEFAULT NULL,
  `hire_date` date DEFAULT NULL,
  `salary` decimal(10,2) DEFAULT NULL,
  `department_id` int DEFAULT NULL,
  PRIMARY KEY (`employee_id`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (1,'Pedro','Pérez','Gerente de Tienda','2022-01-15',5000.00,1),(2,'Ana','Martínez','Vendedora','2022-02-20',2000.00,1),(3,'Luis','González','Encargado de Almacén','2022-03-12',2500.00,2),(4,'María','Sánchez','Atención al Cliente','2022-04-01',1800.00,3),(5,'José','Ramírez','Contador','2022-05-05',3000.00,4),(6,'Laura','Hernández','Recursos Humanos','2022-06-10',3200.00,5),(7,'Carlos','López','Analista de Marketing','2022-07-15',2700.00,6),(8,'Sofía','Torres','Logística','2022-08-20',2200.00,7),(9,'Javier','Rojas','Desarrollador de TI','2022-09-25',3500.00,8),(10,'Fernanda','Salazar','Diseñadora','2022-10-30',2900.00,9),(11,'Diego','Morales','Vendedor','2022-11-15',2100.00,1),(12,'Patricia','Vélez','Asistente Administrativo','2022-12-05',1900.00,4),(13,'Felipe','Cáceres','Analista de TI','2022-01-20',3400.00,8),(14,'Gabriela','Pinto','Gerente de Ventas','2022-02-25',4000.00,1),(15,'Andrés','Maldonado','Promotor','2022-03-30',1800.00,1),(16,'Cristina','Martín','Analista de Datos','2022-04-15',2500.00,8),(17,'Roberto','Salinas','Encargado de Cuidado al Cliente','2022-06-25',2000.00,3),(18,'Sergio','Aguirre','Cajero','2022-07-30',1600.00,1),(19,'Natalia','Cifuentes','Auxiliar de Almacén','2022-08-05',1500.00,2),(20,'Victoria','Escobar','Gerente de Producto','2022-09-12',4000.00,10);
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_details`
--

DROP TABLE IF EXISTS `order_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_details` (
  `order_detail_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `unit_price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`order_detail_id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `order_details_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  CONSTRAINT `order_details_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_details`
--

LOCK TABLES `order_details` WRITE;
/*!40000 ALTER TABLE `order_details` DISABLE KEYS */;
INSERT INTO `order_details` VALUES (43,1,1,2,3.50),(44,1,2,1,1.99),(45,1,3,1,4.00),(46,2,2,3,1.99),(47,2,4,2,2.50),(48,2,5,1,5.99),(49,3,1,1,3.50),(50,3,2,2,1.99),(51,3,3,1,4.00),(52,4,4,2,2.50),(53,4,1,3,3.50),(54,4,5,1,5.99),(55,5,2,5,1.99),(56,5,1,1,3.50),(57,5,3,2,4.00),(58,6,4,3,2.50),(59,6,5,2,5.99),(60,7,1,4,3.50),(61,7,2,1,1.99),(62,8,3,3,4.00),(63,8,4,2,2.50);
/*!40000 ALTER TABLE `order_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `order_date` date DEFAULT NULL,
  `customer_id` int DEFAULT NULL,
  `employee_id` int DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `customer_id` (`customer_id`),
  KEY `employee_id` (`employee_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'2024-01-15',1,1,'Completado'),(2,'2024-01-16',2,2,'Completado'),(3,'2024-01-17',3,3,'Pendiente'),(4,'2024-01-18',4,4,'Completado'),(5,'2024-01-19',5,5,'Cancelado'),(6,'2024-01-20',6,6,'Completado'),(7,'2024-01-21',7,7,'Pendiente'),(8,'2024-01-22',8,8,'Completado'),(9,'2024-01-23',9,9,'Completado'),(10,'2024-01-24',10,10,'Pendiente'),(11,'2024-01-25',11,1,'Completado'),(12,'2024-01-26',12,2,'Completado'),(13,'2024-01-27',13,3,'Pendiente'),(14,'2024-01-28',14,4,'Completado'),(15,'2024-01-29',15,5,'Cancelado'),(16,'2024-01-30',16,6,'Completado'),(17,'2024-01-31',17,7,'Pendiente'),(18,'2024-02-01',18,8,'Completado'),(19,'2024-02-02',19,9,'Completado'),(20,'2024-02-03',20,10,'Pendiente');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permissions` (
  `permission_id` int NOT NULL AUTO_INCREMENT,
  `permission_name` varchar(100) NOT NULL,
  PRIMARY KEY (`permission_id`),
  UNIQUE KEY `permission_name` (`permission_name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES (2,'Actualizar Salarios'),(1,'Agregar Proveedores'),(3,'Consultar Reportes'),(4,'Modificar Inventario');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text,
  `price` decimal(10,2) DEFAULT NULL,
  `stock_quantity` int DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `min_stock` int DEFAULT '15',
  `max_stock` int DEFAULT '200',
  PRIMARY KEY (`product_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Arroz Basmati','Arroz de grano largo, ideal para platos exóticos',3.50,150,1,15,200),(2,'Frijoles Negros','Frijoles seleccionados, ricos en proteínas',1.99,200,1,15,200),(3,'Cerveza Artesanal','Cerveza de producción local',4.00,100,2,15,200),(4,'Jugo de Naranja Natural','Jugo fresco de naranjas seleccionadas',2.50,180,2,15,200),(5,'Detergente Líquido','Detergente para ropa con aroma a flores',5.99,75,3,15,200),(6,'Esponja Multiuso','Esponja para limpieza del hogar',1.50,250,3,15,200),(7,'Cuchara de Cocina','Cuchara de acero inoxidable',2.20,80,4,15,200),(8,'Olla de Acero Inoxidable','Olla durable y resistente',30.00,50,4,15,200),(9,'Champú Hidratante','Champú para todo tipo de cabello',4.50,200,5,15,200),(10,'Crema Hidratante','Crema para el cuidado de la piel',6.00,150,5,15,200),(11,'Smartphone Modelo X','Smartphone de última generación',699.00,30,6,15,200),(12,'Televisor 50 pulgadas','Televisor LED con resolución 4K',899.00,25,6,15,200),(13,'Camiseta de Algodón','Camiseta cómoda y ligera',15.00,200,7,15,200),(14,'Pantalones de Mezclilla','Pantalones de mezclilla clásicos',30.00,150,7,15,200),(15,'Juguete de Construcción','Juego de bloques para construir',25.00,100,8,15,200),(16,'Muñeca de Peluche','Muñeca suave y acogedora',20.00,80,8,15,200),(17,'Papelería Variada','Conjunto de materiales de oficina',10.00,200,9,15,200),(18,'Cuaderno de Notas','Cuaderno con tapas duras',5.00,300,9,15,200),(19,'Comida para Perros','Alimento completo para perros adultos',30.00,60,10,15,200),(20,'Arena para Gatos','Arena absorbente para gatos',10.00,70,10,15,200),(21,'Arroz Integral','Arroz integral saludable y nutritivo',3.00,120,1,15,200),(22,'Lentejas Rojas','Lentejas rojas ricas en nutrientes',2.50,180,1,15,200),(23,'Vino Tinto Reserva','Vino tinto de alta calidad',12.00,50,2,15,200),(24,'Jugo de Manzana Orgánico','Jugo de manzana sin aditivos',3.00,150,2,15,200),(25,'Detergente en Polvo','Detergente en polvo para ropa',4.50,100,3,15,200),(26,'Limpiador Multiusos','Limpiador efectivo para superficies',2.00,200,3,15,200),(27,'Cuchillo Chef','Cuchillo de cocina de alta calidad',15.00,75,4,15,200),(28,'Cacerola de Cerámica','Cacerola para cocinar a fuego lento',25.00,60,4,15,200),(29,'Acondicionador Nutritivo','Acondicionador para cabello seco',5.50,150,5,15,200),(30,'Gel de Baño Hidratante','Gel de baño con ingredientes naturales',7.00,100,5,15,200),(31,'Tablet Modelo Y','Tablet con pantalla táctil y gran rendimiento',499.00,40,6,15,200),(32,'Proyector Portátil','Proyector compacto con alta definición',349.00,30,6,15,200),(33,'Chaqueta de Invierno','Chaqueta abrigada para clima frío',60.00,100,7,15,200),(34,'Vestido de Verano','Vestido ligero para días soleados',35.00,80,7,15,200),(35,'Rompecabezas de 1000 Piezas','Desafiante rompecabezas para toda la familia',20.00,90,8,15,200),(36,'Muñeca Interactiva','Muñeca que responde a las voces',45.00,50,8,15,200),(37,'Material de Dibujo','Conjunto completo de útiles de dibujo',15.00,150,9,15,200),(38,'Agenda Semanal','Agenda para organizar tus tareas',12.00,200,9,15,200),(39,'Alimento para Gatos','Comida especializada para gatos',25.00,70,10,15,200),(40,'Arena Vegetal para Mascotas','Arena biodegradable y natural',8.00,60,10,15,200);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_permissions`
--

DROP TABLE IF EXISTS `role_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_permissions` (
  `role_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`role_id`,`permission_id`),
  KEY `permission_id` (`permission_id`),
  CONSTRAINT `role_permissions_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`),
  CONSTRAINT `role_permissions_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_permissions`
--

LOCK TABLES `role_permissions` WRITE;
/*!40000 ALTER TABLE `role_permissions` DISABLE KEYS */;
INSERT INTO `role_permissions` VALUES (1,1),(1,2),(1,3),(2,3),(1,4);
/*!40000 ALTER TABLE `role_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `role_id` int NOT NULL AUTO_INCREMENT,
  `role_name` varchar(50) NOT NULL,
  PRIMARY KEY (`role_id`),
  UNIQUE KEY `role_name` (`role_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'admin'),(2,'consulta');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supplier_order_details`
--

DROP TABLE IF EXISTS `supplier_order_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `supplier_order_details` (
  `supplier_order_detail_id` int NOT NULL AUTO_INCREMENT,
  `supplier_order_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `unit_price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`supplier_order_detail_id`),
  KEY `supplier_order_id` (`supplier_order_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `supplier_order_details_ibfk_1` FOREIGN KEY (`supplier_order_id`) REFERENCES `supplier_orders` (`supplier_order_id`),
  CONSTRAINT `supplier_order_details_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplier_order_details`
--

LOCK TABLES `supplier_order_details` WRITE;
/*!40000 ALTER TABLE `supplier_order_details` DISABLE KEYS */;
INSERT INTO `supplier_order_details` VALUES (1,1,1,2,3.50),(2,1,2,1,1.99),(3,1,3,3,4.00),(4,1,4,2,2.50),(5,2,1,1,3.50),(6,2,5,1,5.99),(7,2,6,3,1.50),(8,3,2,5,1.99),(9,3,3,2,4.00),(10,3,7,1,2.20),(11,4,4,3,2.50),(12,4,5,1,5.99),(13,4,8,2,30.00),(14,5,6,4,1.50),(15,5,9,1,4.50),(16,5,10,2,6.00),(17,6,2,3,1.99),(18,6,3,1,4.00),(19,6,11,1,699.00),(20,7,4,2,2.50),(21,7,12,1,899.00);
/*!40000 ALTER TABLE `supplier_order_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supplier_orders`
--

DROP TABLE IF EXISTS `supplier_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `supplier_orders` (
  `supplier_order_id` int NOT NULL AUTO_INCREMENT,
  `supplier_id` int DEFAULT NULL,
  `order_date` date DEFAULT NULL,
  `total_amount` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`supplier_order_id`),
  KEY `supplier_id` (`supplier_id`),
  CONSTRAINT `supplier_orders_ibfk_1` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`supplier_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplier_orders`
--

LOCK TABLES `supplier_orders` WRITE;
/*!40000 ALTER TABLE `supplier_orders` DISABLE KEYS */;
INSERT INTO `supplier_orders` VALUES (1,1,'2024-01-10',12.99),(2,2,'2024-01-12',16.96),(3,3,'2024-01-14',11.48),(4,4,'2024-01-16',21.49),(5,5,'2024-01-18',21.45),(6,6,'2024-01-20',19.48),(7,7,'2024-01-22',15.99),(8,8,'2024-01-24',17.00),(9,9,'2024-01-26',NULL),(10,10,'2024-01-28',NULL),(11,1,'2024-01-30',NULL),(12,2,'2024-02-01',NULL),(13,3,'2024-02-03',NULL),(14,4,'2024-02-05',NULL),(15,5,'2024-02-07',NULL),(16,6,'2024-02-09',NULL),(17,7,'2024-02-11',NULL),(18,8,'2024-02-13',NULL),(19,9,'2024-02-15',NULL),(20,10,'2024-02-17',NULL);
/*!40000 ALTER TABLE `supplier_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supplier_products`
--

DROP TABLE IF EXISTS `supplier_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `supplier_products` (
  `supplier_product_id` int NOT NULL AUTO_INCREMENT,
  `supplier_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  PRIMARY KEY (`supplier_product_id`),
  KEY `supplier_id` (`supplier_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `supplier_products_ibfk_1` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`supplier_id`),
  CONSTRAINT `supplier_products_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplier_products`
--

LOCK TABLES `supplier_products` WRITE;
/*!40000 ALTER TABLE `supplier_products` DISABLE KEYS */;
INSERT INTO `supplier_products` VALUES (21,1,1),(22,1,2),(23,2,3),(24,2,4),(25,3,5),(26,4,6),(27,5,7),(28,6,8),(29,7,9),(30,8,10),(31,1,11),(32,2,12),(33,3,13),(34,4,14),(35,5,15),(36,6,16),(37,7,17),(38,8,18),(39,1,19),(40,2,20);
/*!40000 ALTER TABLE `supplier_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suppliers`
--

DROP TABLE IF EXISTS `suppliers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `suppliers` (
  `supplier_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `contact_name` varchar(255) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`supplier_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suppliers`
--

LOCK TABLES `suppliers` WRITE;
/*!40000 ALTER TABLE `suppliers` DISABLE KEYS */;
INSERT INTO `suppliers` VALUES (1,'Proveedores Unidos','Juan Pérez','555-001','contacto@proveedoresunidos.com'),(2,'Bebidas Frescas S.A.','Ana López','555-002','info@bebidasfrescas.com'),(3,'Alimentos Naturales','Luis González','555-003','ventas@alimentosnaturales.com'),(4,'Limpieza Total','Marta Sánchez','555-004','marta@limpiezatotal.com'),(5,'Electrodomésticos S.A.','Carlos Rodríguez','555-005','ventas@electrodomesticos.com'),(6,'Ropa y Estilo','Laura Martínez','555-006','contacto@ropayestilo.com'),(7,'Juguetes Diversión','Diego Ruiz','555-007','info@juguetesdiversion.com'),(8,'Oficina Fácil','Julia Herrera','555-008','contacto@oficina-facil.com'),(9,'Mascotas Felices','Ricardo Torres','555-009','ventas@mascotasfelices.com'),(10,'Productos de Cuidado Personal','Verónica Castro','555-010','info@cuidado-personal.com');
/*!40000 ALTER TABLE `suppliers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_roles` (
  `user_id` int NOT NULL,
  `role_id` int NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `user_roles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_roles_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_roles`
--

LOCK TABLES `user_roles` WRITE;
/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'usuario1','440247d9c3d4073ce94b318aff5f4d3a0ceffe1518d3e94a2eab5e2b607c8ce7');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-05 23:36:19
-- Dump completed on 2024-11-05 23:36:19



-- FUNCIONES 

--1. Obtener el precio total de un producto por cantidad

CREATE OR REPLACE FUNCTION get_total_price(
    p_product_id IN INT,
    p_quantity IN INT
) RETURN DECIMAL IS
    v_price DECIMAL(10, 2);
BEGIN
    SELECT price INTO v_price FROM products WHERE product_id = p_product_id;
    RETURN v_price * p_quantity;
END;

--2. Calcular el stock restante después de una venta

CREATE OR REPLACE FUNCTION calculate_stock_after_sale(
    p_product_id IN INT,
    p_quantity_sold IN INT
) RETURN INT IS
    v_stock INT;
BEGIN
    SELECT stock_quantity INTO v_stock FROM products WHERE product_id = p_product_id;
    RETURN v_stock - p_quantity_sold;
END;



--3. Obtener el nombre del proveedor de un producto

CREATE OR REPLACE FUNCTION get_supplier_name(
    p_product_id IN INT
) RETURN VARCHAR IS
    v_supplier_name VARCHAR(255);
BEGIN
    SELECT s.name
    INTO v_supplier_name
    FROM suppliers s
    JOIN supplier_products sp ON s.supplier_id = sp.supplier_id
    WHERE sp.product_id = p_product_id;
    RETURN v_supplier_name;
END;



--4. Calcular el total de una orden

CREATE OR REPLACE FUNCTION calculate_order_total(
    p_order_id IN INT
) RETURN DECIMAL IS
    v_total DECIMAL(10, 2);
BEGIN
    SELECT SUM(quantity * unit_price)
    INTO v_total
    FROM order_details
    WHERE order_id = p_order_id;
    RETURN v_total;
END;

--5. Determinar si un producto está en stock

CREATE OR REPLACE FUNCTION is_product_in_stock(
    p_product_id IN INT
) RETURN VARCHAR IS
    v_stock INT;
BEGIN
    SELECT stock_quantity INTO v_stock FROM products WHERE product_id = p_product_id;
    RETURN CASE WHEN v_stock > 0 THEN 'Yes' ELSE 'No' END;
END;

--6. Obtener el descuento aplicable para un producto

CREATE OR REPLACE FUNCTION get_discount(
    p_product_id IN INT
) RETURN DECIMAL IS
    v_discount DECIMAL(10, 2);
BEGIN
    -- Supongamos que el descuento se define en una tabla llamada discounts
    SELECT COALESCE(discount_percentage, 0)
    INTO v_discount
    FROM discounts
    WHERE product_id = p_product_id;
    RETURN v_discount;
END;

--7. Contar productos en una categoría específica

CREATE OR REPLACE FUNCTION count_products_by_category(
    p_category_id IN INT
) RETURN INT IS
    v_count INT;
BEGIN
    SELECT COUNT(*) INTO v_count FROM products WHERE category_id = p_category_id;
    RETURN v_count;
END;

--8. Obtener la fecha del último pedido de un cliente

CREATE OR REPLACE FUNCTION get_last_order_date(
    p_customer_id IN INT
) RETURN DATE IS
    v_last_date DATE;
BEGIN
    SELECT MAX(order_date) INTO v_last_date FROM orders WHERE customer_id = p_customer_id;
    RETURN v_last_date;
END;

--9. Calcular el total de ventas de un empleado

CREATE OR REPLACE FUNCTION calculate_employee_sales(
    p_employee_id IN INT
) RETURN DECIMAL IS
    v_sales_total DECIMAL(10, 2);
BEGIN
    SELECT SUM(o.total_amount)
    INTO v_sales_total
    FROM orders o
    WHERE o.employee_id = p_employee_id;
    RETURN v_sales_total;
END;

--10. Obtener la cantidad de pedidos de un cliente

CREATE OR REPLACE FUNCTION count_orders_by_customer(
    p_customer_id IN INT
) RETURN INT IS
    v_order_count INT;
BEGIN
    SELECT COUNT(*) INTO v_order_count FROM orders WHERE customer_id = p_customer_id;
    RETURN v_order_count;
END;

--11. Calcular el total gastado por un cliente

CREATE OR REPLACE FUNCTION calculate_customer_total_spent(
    p_customer_id IN INT
) RETURN DECIMAL IS
    v_total_spent DECIMAL(10, 2);
BEGIN
    SELECT SUM(o.total_amount)
    INTO v_total_spent
    FROM orders o
    WHERE o.customer_id = p_customer_id;
    RETURN v_total_spent;
END;

--12. Obtener el nombre completo de un cliente

CREATE OR REPLACE FUNCTION get_customer_name(
    p_customer_id IN INT
) RETURN VARCHAR IS
    v_name VARCHAR(255);
BEGIN
    SELECT CONCAT(first_name, ' ', last_name)
    INTO v_name
    FROM customers
    WHERE customer_id = p_customer_id;
    RETURN v_name;
END;

--13. Calcular el promedio de precio de los productos en una categoría

CREATE OR REPLACE FUNCTION calculate_avg_price_by_category(
    p_category_id IN INT
) RETURN DECIMAL IS
    v_avg_price DECIMAL(10, 2);
BEGIN
    SELECT AVG(price)
    INTO v_avg_price
    FROM products
    WHERE category_id = p_category_id;
    RETURN v_avg_price;
END;

14. Obtener el producto con mayor stock
sql
Copiar código
CREATE OR REPLACE FUNCTION get_product_with_highest_stock RETURN VARCHAR IS
    v_product_name VARCHAR(255);
BEGIN
    SELECT name
    INTO v_product_name
    FROM products
    WHERE stock_quantity = (SELECT MAX(stock_quantity) FROM products);
    RETURN v_product_name;
END;
/


15. Calcular el total de órdenes de un proveedor específico
sql
Copiar código
CREATE OR REPLACE FUNCTION calculate_supplier_orders_total(
    p_supplier_id IN INT
) RETURN DECIMAL IS
    v_total DECIMAL(10, 2);
BEGIN
    SELECT SUM(total_amount)
    INTO v_total
    FROM supplier_orders
    WHERE supplier_id = p_supplier_id;
    RETURN v_total;
END;
/


16. Obtener la cantidad de productos suministrados por un proveedor
sql
Copiar código
CREATE OR REPLACE FUNCTION count_products_by_supplier(
    p_supplier_id IN INT
) RETURN INT IS
    v_count INT;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM supplier_products
    WHERE supplier_id = p_supplier_id;
    RETURN v_count;
END;
/


17. Obtener la fecha del primer pedido de un cliente
sql
Copiar código
CREATE OR REPLACE FUNCTION get_first_order_date(
    p_customer_id IN INT
) RETURN DATE IS
    v_first_date DATE;
BEGIN
    SELECT MIN(order_date)
    INTO v_first_date
    FROM orders
    WHERE customer_id = p_customer_id;
    RETURN v_first_date;
END;
/


18. Calcular el total de stock en el inventario
sql
Copiar código
CREATE OR REPLACE FUNCTION calculate_total_stock RETURN INT IS
    v_total_stock INT;
BEGIN
    SELECT SUM(stock_quantity)
    INTO v_total_stock
    FROM products;
    RETURN v_total_stock;
END;
/


19. Obtener el nombre de la categoría de un producto
sql
Copiar código
CREATE OR REPLACE FUNCTION get_category_name(
    p_product_id IN INT
) RETURN VARCHAR IS
    v_category_name VARCHAR(255);
BEGIN
    SELECT c.name
    INTO v_category_name
    FROM categories c
    JOIN products p ON c.category_id = p.category_id
    WHERE p.product_id = p_product_id;
    RETURN v_category_name;
END;
/


20. Calcular el precio total de un pedido a proveedores
sql
Copiar código
CREATE OR REPLACE FUNCTION calculate_supplier_order_total(
    p_supplier_order_id IN INT
) RETURN DECIMAL IS
    v_total DECIMAL(10, 2);
BEGIN
    SELECT SUM(quantity * unit_price)
    INTO v_total
    FROM supplier_order_details
    WHERE supplier_order_id = p_supplier_order_id;
    RETURN v_total;
END;
/


21. Determinar si un cliente es frecuente (más de 5 pedidos)
sql
Copiar código
CREATE OR REPLACE FUNCTION is_frequent_customer(
    p_customer_id IN INT
) RETURN VARCHAR IS
    v_order_count INT;
BEGIN
    SELECT COUNT(*)
    INTO v_order_count
    FROM orders
    WHERE customer_id = p_customer_id;
    RETURN CASE WHEN v_order_count > 5 THEN 'Yes' ELSE 'No' END;
END;
/


22. Obtener el producto más caro de una categoría
sql
Copiar código
CREATE OR REPLACE FUNCTION get_most_expensive_product_in_category(
    p_category_id IN INT
) RETURN VARCHAR IS
    v_product_name VARCHAR(255);
BEGIN
    SELECT name
    INTO v_product_name
    FROM products
    WHERE category_id = p_category_id
    AND price = (SELECT MAX(price) FROM products WHERE category_id = p_category_id);
    RETURN v_product_name;
END;
/


23. Calcular el monto total de ventas en un período
sql
Copiar código
CREATE OR REPLACE FUNCTION calculate_sales_in_period(
    p_start_date IN DATE,
    p_end_date IN DATE
) RETURN DECIMAL IS
    v_sales_total DECIMAL(10, 2);
BEGIN
    SELECT SUM(total_amount)
    INTO v_sales_total
    FROM orders
    WHERE order_date BETWEEN p_start_date AND p_end_date;
    RETURN v_sales_total;
END;
/


24. Obtener la cantidad de productos con bajo stock
sql
Copiar código
CREATE OR REPLACE FUNCTION count_low_stock_products(
    p_min_stock IN INT
) RETURN INT IS
    v_count INT;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM products
    WHERE stock_quantity < p_min_stock;
    RETURN v_count;
END;
/


25. Obtener el proveedor más frecuente de pedidos
sql
Copiar código
CREATE OR REPLACE FUNCTION get_most_frequent_supplier RETURN VARCHAR IS
    v_supplier_name VARCHAR(255);
BEGIN
    SELECT s.name
    INTO v_supplier_name
    FROM suppliers s
    JOIN supplier_orders so ON s.supplier_id = so.supplier_id
    GROUP BY s.name
    ORDER BY COUNT(so.supplier_order_id) DESC
    FETCH FIRST 1 ROWS ONLY;
    RETURN v_supplier_name;
END;
/

Sí, todas estas funciones están escritas en PL/SQL, el lenguaje de programación que utiliza Oracle, por lo que deberían funcionar perfectamente en tu base de datos de Oracle. Sin embargo, hay algunos detalles que podrías necesitar verificar o ajustar dependiendo de tu configuración específica:

Aspectos a revisar:
Estructura de las tablas:
Asegúrate de que las tablas y columnas mencionadas en las funciones coincidan con las de tu base de datos.
Por ejemplo, revisa que los nombres de las tablas (products, orders, etc.) y columnas (price, stock_quantity, etc.) sean exactamente como se describen en tu proyecto.
Tipos de datos:
Los tipos de datos como DECIMAL y VARCHAR son compatibles con Oracle, pero Oracle generalmente usa:
NUMBER en lugar de DECIMAL.
VARCHAR2 en lugar de VARCHAR.
Puedes reemplazarlos si tu base de datos requiere estos tipos de datos.
Ejemplo:
sql
Copiar código
RETURN NUMBER IS


Manejo de claves foráneas:
Asegúrate de que las relaciones entre tablas, como claves foráneas y referencias, estén bien definidas para evitar errores en las consultas dentro de las funciones.
Compatibilidad de consultas:
Las funciones como FETCH FIRST 1 ROWS ONLY (utilizada en la función 25) requieren Oracle 12c o superior. Si estás usando una versión anterior, puedes reemplazarla por:
sql
Copiar código
AND ROWNUM = 1



Prueba de las funciones:
Recomendación: Antes de implementar todas las funciones, prueba cada una por separado para verificar que se ejecuten correctamente en tu entorno.
Usa un bloque BEGIN para ejecutar y depurar:
sql
Copiar código
BEGIN
    DBMS_OUTPUT.PUT_LINE(get_total_price(1, 10));
END;
/

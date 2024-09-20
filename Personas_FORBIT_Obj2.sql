DROP DATABASE IF EXISTS Personas_db;
CREATE DATABASE IF NOT EXISTS Personas_db;
USE Personas_db; 

CREATE TABLE IF NOT EXISTS Estados (
   Id_Estado INT PRIMARY KEY,  -- Identificador único del estado
    Descripcion VARCHAR(50) NOT NULL           -- Descripción del estado (Ej.: Activo, Inactivo)
);

  -- ejemplo insertar valores 
INSERT INTO Estados (Id_Estado, Descripcion) 
VALUES (1, 'Activo'), (2, 'Inactivo');


CREATE TABLE IF NOT EXISTS Personas (
    Id INT AUTO_INCREMENT PRIMARY KEY,            
    Apellido VARCHAR(50) NOT NULL,                
    Nombres VARCHAR(50) NOT NULL,                 
    DNI VARCHAR(20) NOT NULL UNIQUE,              
    Domicilio VARCHAR(100),                       
    Telefono VARCHAR(20),                         
    Id_Estado INT NOT NULL,                       
    FecHora_Registros DATETIME NOT NULL,          
    FecHora_Modificacion DATETIME,                
    FOREIGN KEY (Id_Estado) REFERENCES Estados(Id_Estado)  -- Relación con la tabla Estados
);

-- Crear  Procedimiento almacenados  para registrar una persona
DELIMITER //

CREATE PROCEDURE SP_RegistroPersona (
    IN p_Apellido VARCHAR(50),
    IN p_Nombres VARCHAR(50),
    IN p_DNI VARCHAR(20),
    IN p_Domicilio VARCHAR(100),
    IN p_Telefono VARCHAR(20),
    IN p_Id_Estado INT
)
BEGIN
    INSERT INTO Personas (Apellido, Nombres, DNI, Domicilio, Telefono, Id_Estado, FecHora_Registros)
    VALUES ('Molina', 'Cristina', '98765432', 'Calle 123', '1122334455', 1, NOW());
END //

DELIMITER ;

-- Probar los procedimientos almacenados:
CALL SP_RegistroPersona('Molina', 'Cristina', '98765432', 'Calle 123', '1122334455', 1);



SHOW PROCEDURE STATUS WHERE Db = 'Personas_db';


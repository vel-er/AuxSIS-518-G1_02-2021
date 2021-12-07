USE master;

CREATE DATABASE test_db;

GO 

USE test_db;

GO

CREATE TABLE cliente (
    ci          INT,
    nombres     VARCHAR(50),
    apellidos   VARCHAR(50),
    fecha_nac   DATE, -- '1999-01-25'
    fecha_reg   DATETIME, -- 'yy-mm-dd hh:mm:ss.ms'
    direccion   VARCHAR(100),
)
GO

SELECT * FROM cliente;

INSERT INTO cliente (ci, nombres, apellidos, fecha_nac, direccion) VALUES
    (55557777, 'Juan', 'Perez Rodriguez', '1990-12-01', 'Calle Oruro #30'),
    (10101010, 'Alondra', 'Jimenez', '1995-10-10', NULL)

INSERT cliente VALUES
    (20202020, 'Martín', 'Castro', '1978-01-30', GETDATE(), 'Av. Independencia #50')

GO

SELECT nombres, apellidos FROM cliente;
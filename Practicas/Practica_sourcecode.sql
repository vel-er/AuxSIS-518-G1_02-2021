USE master;
GO
CREATE DATABASE practicas;
GO
USE practicas;
GO

CREATE TABLE cliente (
    ci          INT,
    nombres     VARCHAR(50),
    apellidos   VARCHAR(50),
    fecha_nac   DATE,
    fecha_reg   DATETIME,
    direccion   VARCHAR(100),
)
GO

INSERT INTO cliente (ci, nombres, apellidos, fecha_nac, direccion) VALUES
    (55557777, 'Juan', 'Perez Rodriguez', '1990-12-01', 'Calle Oruro #30'),
    (10101010, 'Alondra', 'Jimenez', '1995-10-10', NULL)
GO
INSERT cliente VALUES
    (20202020, 'Martín', 'Castro', '1978-01-30', GETDATE(), 'Av. Independencia #50')
GO
CREATE TABLE agencia(
    id_agencia  INT PRIMARY KEY,
    direccion   VARCHAR(100),
)
CREATE TABLE garaje (
    id_garaje INT,
    direccion VARCHAR(100),
    capacidad SMALLINT,
    PRIMARY KEY (id_garaje),
)
GO

CREATE TABLE coche (
    id_coche    INT,
    id_garaje   INT,
    matricula   VARCHAR(12),
    modelo      VARCHAR(32),
    color       VARCHAR(16),
    tipo        VARCHAR(16),
    CONSTRAINT PK_coche PRIMARY KEY (id_coche),
    CONSTRAINT FK_garaje_coche FOREIGN KEY (id_garaje) REFERENCES garaje(id_garaje),
)
GO

INSERT agencia VALUES
    (2201, 'Av. Tinkuy #100'),
    (2202, 'Calle La Paz #85')
INSERT garaje VALUES
    (3301, 'Calle La Paz #86', 50),
    (3302, 'Av. Sevilla #23', 45),
    (3303, 'Av. Murillo # 300', 60)
GO

INSERT coche VALUES
    (101, 3302, '1010-ABC', '2011', 'blanco', 'bagoneta'),
    (102, 3301, '2020-QWE', '2019', 'negro', 'camioneta'),
    (103, 3302, '1122-ASD', '1999', 'verde', 'camión'),
    (104, 3303, '1617-UOP', '2005', 'rojo', 'camioneta'),
    (105, 3301, '3802-RUI', '2009', 'blanco', 'minibus')
GO
INSERT cliente VALUES
    (40404040, 'Jorge', 'Calvo', '1986-03-20', GETDATE(), 'Av. América #64'),
    (50505050, 'Mariana', 'Soliz', '2001-07-12', GETDATE(), 'Calle Junin #77'),
    (8460030, 'Ronald', 'Zarate Navarro', '1989-05-27', GETDATE(), 'Calle La Paz #165')
GO
INSERT cliente VALUES (9510020, 'Jesús', 'Rodriguez Subieta', '2000-02-29', GETDATE(), 'Calle Ecuador #98');
GO
INSERT cliente VALUES (50708090, 'Mariano', 'Jimenez', '2000-09-04', GETDATE(), 'Av. América #64');
GO
UPDATE cliente
SET fecha_reg = '20210227 15:10'
WHERE ci = 55557777;
GO

UPDATE cliente
SET fecha_reg = '20201230 17:25:12', direccion = 'Av. Italia #68'
WHERE ci = (SELECT ci FROM cliente WHERE nombres = 'Alondra' AND apellidos = 'Jimenez');
GO

CREATE TABLE reserva (
    id_reserva  INT PRIMARY KEY,
    id_agencia  INT FOREIGN KEY REFERENCES agencia(id_agencia),
    id_cliente  INT,
)
GO

ALTER TABLE cliente ALTER COLUMN ci INT NOT NULL;
GO
ALTER TABLE cliente ADD CONSTRAINT PK_cliente PRIMARY KEY (ci);
GO
ALTER TABLE reserva ADD CONSTRAINT FK_cliente_reserva FOREIGN KEY (id_cliente) REFERENCES cliente(ci);
GO
ALTER TABLE reserva ADD
    id_coche INT FOREIGN KEY REFERENCES coche(id_coche),
    fecha_hora_ini DATETIME,
    fecha_hora_fin DATETIME;
GO

UPDATE cliente SET fecha_nac = '19901230' WHERE ci = 55557777;
GO

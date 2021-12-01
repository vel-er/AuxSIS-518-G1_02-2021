USE test_db;
GO
SELECT * FROM cliente;

-- Mostrar el ci y fecha_nac de los clientes
SELECT ci, fecha_nac FROM cliente;

CREATE TABLE agencia(
    id_agencia  INT PRIMARY KEY,
    direccion   VARCHAR(100),
)

CREATE TABLE garaje (
    id_garaje INT,              -- -2^31 < INT < 2^31  = -2,147,483,648 < INT < 2,147,483,648
    direccion VARCHAR(100),     -- -2^15 < SMALLINT < 2^15 = -32,768 < SMALLINT < 32,768
    capacidad SMALLINT,         -- 0 < TINYINT < 255
    PRIMARY KEY (id_garaje),
)
GO

CREATE TABLE coche (
    id_coche    INT,
    id_garaje   INT,-- FOREIGN KEY REFERENCES garaje(id_garaje) -- Alternativa,
    matricula   VARCHAR(12),
    modelo      VARCHAR(32),
    color       VARCHAR(16),
    tipo        VARCHAR(16),
    CONSTRAINT PK_coche PRIMARY KEY (id_coche),
    --FOREIGN KEY (id_garaje) REFERENCES garaje(id_garaje) -- Alternativa,
    CONSTRAINT FK_garaje_coche FOREIGN KEY (id_garaje) REFERENCES garaje(id_garaje),
)
GO

SELECT * FROM cliente;
SELECT * FROM agencia;
SELECT * FROM garaje;
SELECT * FROM coche;


-- Insertando datos en la tabla Agencia
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

SELECT * FROM coche;
SELECT id_coche, modelo, color FROM coche;

SELECT * FROM coche;
SELECT * FROM coche WHERE id_garaje = 3302;


-- Mostrar los coches de color blanco
SELECT * FROM coche WHERE color = 'blanco';

SELECT * FROM coche WHERE color LIKE 'blanco';

SELECT * FROM cliente;
SELECT * FROM agencia;
SELECT * FROM garaje;
SELECT * FROM coche;


-- Atualizar la fecha de registro de Juan Perez a '2021-02-28 15:10'

UPDATE cliente
SET fecha_reg = '20210227 15:10'
WHERE ci = 55557777;


-- Actualizar la fecha de registro de Alondra Jimenez a '2020-12-30 17:25:12' y la direccion a Av. Italia #68
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
SELECT * FROM reserva;

-- Añadir una llave primaria en la tabla cliente
--  ALTER TABLE [nombre_tabla]
--      | ALTER COLUMN [nombre_columna]
--      | ADD [<constraint>] nombre_columna | nombre_constraint
--      | DROP [<column>, <constraint>] nombre_columna | nombre_constraint

    -- Paso 1, modificar la columna ci para que no acepte valores nulos
ALTER TABLE cliente ALTER COLUMN ci INT NOT NULL;
GO
    -- Paso 2, convertir la columna en llave primaria
ALTER TABLE cliente ADD CONSTRAINT PK_cliente PRIMARY KEY (ci);
GO

-- Modificar la columna de id_cliente de la tabla reserva a la llave foranea correspondiente
ALTER TABLE reserva ADD CONSTRAINT FK_cliente_reserva FOREIGN KEY (id_cliente) REFERENCES cliente(ci);
GO

-- Añadir las columnas faltantes a la tabla reserva

ALTER TABLE reserva ADD
    id_coche INT FOREIGN KEY REFERENCES coche(id_coche),
    fecha_hora_ini DATETIME,
    fecha_hora_fin DATETIME;
GO

    --Añadiendo una columna innecesaria para ser borrada
ALTER TABLE reserva ADD columna_innecesaria CHAR NOT NULL;
GO

-- Eliminando esa columna
ALTER TABLE reserva DROP COLUMN columna_innecesaria;
GO
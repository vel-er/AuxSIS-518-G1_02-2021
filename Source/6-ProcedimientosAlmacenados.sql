SELECT * FROM agencia;
SELECT * FROM cliente;
SELECT * FROM coche;
SELECT * FROM garaje;
SELECT * FROM reserva;
GO
-- PROCEDIMIENTOS ALMACENADOS
--  CREATE [PROCEDURE | PROC]
--  ALTER [PROCEDURE | PROC]
--  CREATE OR ALTER [PROCEDURE | PROC]

-- Crear un PA que se encargue del registro de clientes, controlando que este sea mayor de edad
CREATE OR ALTER PROC usp_registro_cliente
@ci INT, @nombres VARCHAR(50), @apellidos VARCHAR(50), @fecha_nac DATE,     -- Parametros del PA
@fecha_reg DATETIME = NULL, @dir VARCHAR(100)
AS              -- Empieza la definicion del PA
BEGIN
    IF (SELECT dbo.ufn_calcular_edad(@fecha_nac) ) >= 18
    BEGIN
        IF @fecha_reg IS NULL
        BEGIN
            INSERT cliente VALUES (@ci, @nombres, @apellidos, @fecha_nac, GETDATE(), @dir)
            PRINT 'Cliente registrado con la fecha actual.';
        END
        ELSE
        BEGIN
            INSERT cliente VALUES (@ci, @nombres, @apellidos, @fecha_nac, @fecha_reg, @dir)
            PRINT 'Cliente registrado.'
        END
    END
    ELSE
        PRINT 'El cliente no cumple con la mayoria de edad.';
END
GO

-- Ejecutar el PA
-- [EXECUTE | EXEC] nombre_pa param1, param2, ..., paramN
-- [EXECUTE | EXEC] nombre_pa @param2 = valor, @param1 = valor
EXECUTE usp_registro_cliente 22, 'cli1', 'cli ente', '1993-01-01', '20200320', 'dir1';

EXEC usp_registro_cliente 33, 'cli3', 'ente cli', '1989-04-12', NULL, 'dir3';

DELETE FROM cliente WHERE ci IN (22, 33);

SELECT * FROM cliente;
SELECT * FROM cliente;
SELECT * FROM agencia;
SELECT * FROM coche;
SELECT * FROM garaje;
SELECT * FROM reserva;
GO
-- TRIGGERS
-- Trigger = disparador, desencadenador

-- CREATE TRIGGER
-- ALTER TRIGGER
-- CREATE OR ALTER [nombre_trigger]

CREATE OR ALTER TRIGGER tr_cliente_insert
ON cliente      -- define a que tabla se va a aplicar
FOR INSERT      -- [FOR | AFTER | INSTEAD OF] [INSERT | DELETE | UPDATE]
AS
    PRINT 'Datos insertados en la tabla cliente';
GO
INSERT cliente (ci, nombres) VALUES (1012, 'Pancho');
GO

-- Revertir eliminacion de registros en la tabla coche

CREATE OR ALTER TRIGGER tr_coche_no_delete
ON coche
INSTEAD OF DELETE
AS
    RAISERROR('No se pueden eliminar datos de esta tabla', 16, 1);
    ROLLBACK TRANSACTION;
GO

SELECT * FROM coche;

DELETE FROM coche WHERE id_coche = 105;
GO

-- Evitar que se actualicen los datos de los coches que se encuentran en el garaje de la Av. Sevilla
CREATE OR ALTER TRIGGER tr_coche_updt
ON coche
FOR UPDATE
AS
    DECLARE @id_garaje INT = (SELECT id_garaje FROM garaje
                            WHERE direccion LIKE 'Av. Sevilla%');

    IF EXISTS (SELECT * FROM inserted WHERE id_garaje = @id_garaje)
    BEGIN
        PRINT 'No se pueden modificar los datos de los coches de la AV sevilla.'
        ROLLBACK TRANSACTION;
    END
GO

SELECT * FROM coche;

UPDATE coche SET color = 'Azul' WHERE id_coche = 101;
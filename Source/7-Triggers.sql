SELECT * FROM cliente;
SELECT * FROM agencia;
SELECT * FROM coche;
SELECT * FROM garaje;
SELECT * FROM reserva;
GO
-- TRIGGERS
-- Trigger = disparador, desencadenador

-- CREATE TRIGGER [nombre_trigger]  - para crear un trigger
-- ALTER TRIGGER [nombre_trigger]   - para actualizar o redefinir un trigger
-- CREATE OR ALTER [nombre_trigger] - para crear o redefinir un trigger si ya está creado

-- Trigger que muestre un pequeño mensaje al insertar datos en la tabla cliente
CREATE OR ALTER TRIGGER tr_cliente_insert
ON cliente      -- define a qué tabla se va a aplicar
FOR INSERT      -- [FOR | AFTER | INSTEAD OF] [INSERT | DELETE | UPDATE]    - indicamos con qué acción se desencadenará el trigger 
AS      -- empieza la deinición del trigger
    PRINT 'Datos insertados en la tabla cliente';
GO      -- termina la definición del trigger

-- Hacemos la prueba insertando un registro en la tabla cliente
INSERT cliente (ci, nombres) VALUES (1012, 'Pancho');
GO


-- Revertir eliminacion de registros en la tabla coche

CREATE OR ALTER TRIGGER tr_coche_no_delete
ON coche
INSTEAD OF DELETE   -- INSTEAD OF DELETE - En lugar de eliminar, el trigger relizara las acciones de abajo en lugar de eliminar algun registro de la tabla coche 
AS
    RAISERROR('No se pueden eliminar datos de esta tabla', 16, 1);  -- Mostramos un mensaje de error
    ROLLBACK TRANSACTION;       -- Revertimos la transacción o petición SQL, en este caso la de eliminar (DELETE)
GO

SELECT * FROM coche;

-- Hacemos la prueba tratando de eliminar un coche
DELETE FROM coche WHERE id_coche = 105;
GO

-- Evitar que se actualicen los datos de los coches que se encuentran en el garaje de la Av. Sevilla
CREATE OR ALTER TRIGGER tr_coche_updt
ON coche
FOR UPDATE      -- FOR UPDATE - Dispara las acciones de abajo cuando se detecte que se quieren actualizar datos de la tabla coche
AS
    DECLARE @id_garaje INT = (SELECT id_garaje FROM garaje  -- declaramos una variable que almacene el id de garaje que se encuentra en la Av. Sevilla
                            WHERE direccion LIKE 'Av. Sevilla%');

    IF EXISTS (SELECT * FROM inserted WHERE id_garaje = @id_garaje)     -- comprobamos si existen datos que se quieran insertar o actualizar (tabla inserted)
                                                                        -- y que tengan como id de garaje el de la Av. Sevilla
    BEGIN                                                               
        PRINT 'No se pueden modificar los datos de los coches de la Av. Sevilla.'   -- Mostramos un pequeño mensaje.
        ROLLBACK TRANSACTION;           -- Revertimos la transacción o petición SQL, en este caso la de actualizar o modificar (UPDATE)
    END
GO

SELECT * FROM coche;

-- Intentamos modificar el color del coche 101 que se encuentra asignado al garaje de la Av. Sevilla
UPDATE coche SET color = 'Azul' WHERE id_coche = 101;
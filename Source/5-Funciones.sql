SELECT * FROM cliente;
SELECT * FROM agencia;
SELECT * FROM garaje;
SELECT * FROM coche;
SELECT * FROM reserva;
GO

-- Funciones

--  CREATE FUNCTION             - Crear una funcion
--  ALTER FUNCTION              - Modificar o redefinir una funcion
--  CREATE OR ALTER FUNCTION    - Crear o redefinir si ya esta creada

CREATE OR ALTER FUNCTION ufn_calcular_edad
(@fecha_nac DATE)       -- Parametros de la funcion
RETURNS INT             -- El tipo de objeto o dato que va a retornar la funcion
AS                      -- Empieza la definicion de la funcion
BEGIN
    DECLARE @edad INT;
    SELECT @edad = DATEDIFF(YEAR, @fecha_nac, GETDATE());

    IF DATEADD(YEAR, @edad, @fecha_nac) > GETDATE()
    BEGIN
        SET @edad = @edad - 1;
    END

    RETURN @edad;
END
GO

SELECT dbo.ufn_calcular_edad('2000-12-30');
GO

-- Modificar la funcion para que dado un ci calcule la edad del cliente

CREATE OR ALTER FUNCTION ufn_calcular_edad_cliente
(@id INT)
RETURNS INT
AS
BEGIN
    DECLARE @edad INT;
    DECLARE @fecha_nac DATE = (SELECT fecha_nac FROM cliente WHERE @id = ci);

    SET @edad = DATEDIFF(YEAR, @fecha_nac, GETDATE());

    IF DATEADD(YEAR, @edad, @fecha_nac) > GETDATE()
    BEGIN
        SET @edad = @edad - 1;
    END

    RETURN @edad;
END
GO

UPDATE cliente SET fecha_nac = '19901230' WHERE ci = 55557777;
SELECT * FROM cliente;
GO

SELECT dbo.ufn_calcular_edad(55557777) AS Edad;
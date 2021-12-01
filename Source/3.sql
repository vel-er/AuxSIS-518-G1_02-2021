SELECT * FROM cliente;
SELECT * FROM agencia;
SELECT * FROM garaje;
SELECT * FROM coche;

INSERT cliente VALUES
    (40404040, 'Jorge', 'Calvo', '1986-03-20', GETDATE(), 'Av. América #64'),
    (50505050, 'Mariana', 'Soliz', '2001-07-12', GETDATE(), 'Calle Junin #77'),
    (8460030, 'Ronald', 'Zarate Navarro', '1989-05-27', GETDATE(), 'Calle La Paz #165')
GO

INSERT cliente VALUES (9510020, 'Jesús', 'Rodriguez Subieta', '2000-02-29', GETDATE(), 'Calle Ecuador #98');
GO
INSERT cliente VALUES (50708090, 'Mariano', 'Jimenez', '2000-09-04', GETDATE(), 'Av. América #64');
GO

-- Mostrar la dirección de los garajes con capacidad mayor o igual a 50 vehículos

SELECT direccion FROM garaje
WHERE capacidad >= 50;

-- Mostrar el tipo, modelo, matrícula y color de los coches que esten designados
-- en garajes con capacidad mayor o igual a 50

SELECT coche.tipo, coche.modelo, coche.matricula, coche.color FROM garaje, coche
WHERE garaje.capacidad >= 50 AND garaje.id_garaje = coche.id_garaje;

SELECT c.tipo, c.modelo, c.matricula, c.color FROM garaje AS g, coche c
WHERE g.capacidad >= 50 AND g.id_garaje = c.id_garaje;


SELECT tipo, modelo, matricula, color FROM coche
WHERE id_garaje IN (SELECT id_garaje FROM garaje WHERE capacidad >= 50)


-- Mostrar los nombres y apellidos de los clientes que hayan nacido entre los años 1990 y 2000

SELECT nombres, apellidos, fecha_nac FROM cliente
WHERE fecha_nac >= '1990-01-01' AND fecha_nac < '2000-01-01';

SELECT nombres, apellidos, fecha_nac FROM cliente
WHERE fecha_nac BETWEEN '1990' AND '2000';


 /* LIKE    -> %   = Cero o mas caracteres cualquiera
            -> _   = Un caracter cualquiera
            -> []  = Un caracter cualquiera entre un grupo o rango
                    [0-9], [a-z], [A-Z], [axcvb]
            -> [^] = Un caracter cualquiera que no este entre un grupo o rango
                    [^0-9], [^a-z], [^A-Z], [^axcvb]
 */
-- Mostrar los clientes que tengan la letra 'o' en su nombre
SELECT nombres, apellidos FROM cliente
WHERE nombres LIKE '%o%'

-- Mostrar los clientes de los que su nombre empiece con 'J'
SELECT nombres, apellidos FROM cliente
WHERE nombres LIKE 'J%'

-- Mostrar los clientes de los que su nombre empiece con 'J' y tenga una 'e'
SELECT nombres, apellidos FROM cliente
WHERE nombres LIKE 'J%e%'

-- Mostrar a los clientes que se llamen Mariana o Mariano
SELECT nombres, apellidos FROM cliente
WHERE nombres = 'Mariana' OR nombres = 'Mariano'

SELECT nombres, apellidos FROM cliente
WHERE nombres LIKE 'Marian_'

SELECT nombres, apellidos FROM cliente
WHERE nombres LIKE 'Marian[ao]'

-- Mostar los clientes que tengan dos apellidos
SELECT nombres, apellidos FROM cliente
WHERE apellidos LIKE '%[ ]%';

-- Mostrar los nombres y apellidos de los clientes que hayan nacido entre los años 1990 y 1999
SELECT nombres, apellidos, fecha_nac FROM cliente
WHERE fecha_nac LIKE '199[0-9]%'
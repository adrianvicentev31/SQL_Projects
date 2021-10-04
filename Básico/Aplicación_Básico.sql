USE [APLICACI�N]
GO

/* 1. Script: Resumen de ventas mensual por local [Nombre] */
SELECT		L.NOMBRE AS [Local],
			V.A�O AS [A�o],
			MES	AS [Mes],
			CAST(SUM(VENTAS) AS MONEY) AS [Ventas Totales]
FROM		dbo.VENTAS AS V
LEFT JOIN	dbo.LOCALES AS L
ON			L.ID_LOCAL = V.ID_LOCAL
GROUP BY	V.A�O, L.NOMBRE, V.MES
ORDER BY	L.NOMBRE, V.MES, V.A�O 
GO

SELECT		L.NOMBRE AS [Local],
			V.A�O AS [A�o],
			CASE
				WHEN V.MES = 1 THEN 'Enero'
				WHEN V.MES = 2 THEN 'Febrero'
				WHEN V.MES = 3 THEN 'Marzo'
				WHEN V.MES = 4 THEN 'Abril'
				WHEN V.MES = 5 THEN 'Mayo'
				WHEN V.MES = 6 THEN 'Junio'
				WHEN V.MES = 7 THEN 'Julio'
				WHEN V.MES = 8 THEN 'Agosto'
				WHEN V.MES = 9 THEN 'Septiembre'
				WHEN V.MES = 10 THEN 'Octubre'
				WHEN V.MES = 11 THEN 'Noviembre'
				ELSE 'Diciembre'
			END AS [Mes],
			CAST(SUM(VENTAS) AS MONEY) AS [Ventas Totales]
FROM		VENTAS AS V
INNER JOIN	LOCALES AS L
ON			L.ID_LOCAL = V.ID_LOCAL
GROUP BY	V.A�O, L.NOMBRE, V.MES
ORDER BY	L.NOMBRE, V.MES, V.A�O 
GO

/* 2. Script: Resumen de ventas por clientes [Nombre y Apellido] */
SELECT		C.ID_CLIENTE AS [ID Cliente],
			CONCAT(C.NOMBRE,' ', C.APELLIDO) AS [Cliente],
			CAST(SUM(V.VENTAS) AS MONEY) AS [Ventas Totales]
FROM		dbo.VENTAS AS V
LEFT JOIN	dbo.CLIENTES AS C
ON			C.ID_CLIENTE = V.ID_CLIENTE
GROUP BY	C.ID_CLIENTE, CONCAT(C.NOMBRE,' ', C.APELLIDO)
ORDER BY	[Ventas Totales] DESC
GO

/* 3. Script: Resumen de ventas de Lucero Blasquez a nivel Local [Nombre] */
SELECT		L.NOMBRE AS [Local], 
			CAST(SUM(V.VENTAS) AS MONEY) AS [Venta Total]
FROM		dbo.VENTAS AS V
LEFT JOIN	dbo.LOCALES AS L 
ON			L.ID_LOCAL = V.ID_LOCAL
WHERE		V.ID_VENDEDOR = 'V02'
GROUP BY	L.NOMBRE
ORDER BY	[Venta Total] DESC;
GO

SELECT		CONCAT(S.NOMBRE, ' ', S.APELLIDO) AS [Vendedor],
			L.NOMBRE AS [Local], 
			CAST(SUM(V.VENTAS) AS MONEY) AS [Venta Total]
FROM		dbo.VENTAS AS V
LEFT JOIN	dbo.LOCALES AS L 
ON			L.ID_LOCAL = V.ID_LOCAL
LEFT JOIN	dbo.VENDEDORES AS S
ON			S.ID_VENDEDOR = V.ID_VENDEDOR
WHERE		V.ID_VENDEDOR = 'V02'
GROUP BY	CONCAT(S.NOMBRE, ' ', S.APELLIDO), L.NOMBRE
ORDER BY	[Venta Total] DESC;
GO

/* 4. Script: Resumen de unidades vendidas a Luis Vega a nivel Articulo [Nombre]. */
SELECT		A.NOMBRE AS [Art�culo], 
			COUNT(V.ARTICULO) AS [Cantd. Art�culo],
			CAST(SUM(V.VENTAS) AS MONEY) AS [Ventas Totales]
FROM		dbo.VENTAS AS V
LEFT JOIN	dbo.ART�CULOS AS A 
ON			A.ID_ARTICULO = V.ARTICULO
LEFT JOIN	dbo.CLIENTES AS C 
ON			C.ID_CLIENTE = V.ID_CLIENTE
WHERE		V.ID_CLIENTE = 'C03'
GROUP BY	A.NOMBRE
ORDER BY	A.NOMBRE;
GO

/* 5. En PL/SQL, despu�s de terminar una transacci�n, se debe ejecutar la sentencia: */

-- Creamos una copia de la tabla "VENTAS" en la misma DATABASE.
SELECT	*
INTO	APLICACI�N.dbo.VENTAS2
FROM	APLICACI�N.dbo.VENTAS
GO

-- Verificamos la tabla "VENTAS2"
SELECT	*
FROM	APLICACI�N.dbo.VENTAS2
GO

-- Hacemos una "TRANSACTION" de ejemplo.
BEGIN TRANSACTION;   
	DELETE FROM APLICACI�N.dbo.VENTAS2
	WHERE		ARTICULO = 'CPU2';   
COMMIT TRANSACTION; -- Respuesta
GO

-- Eliminamos la tabla "VENTAS2"
DROP TABLE APLICACI�N.dbo.VENTAS2
GO

/* 6. Script: Eliminar el contenido de VENTAS pero conservar la tabla */

-- Creamos una copia de la tabla "VENTAS" en la misma DATABASE.
SELECT	*
INTO	APLICACI�N.dbo.VENTAS2
FROM	APLICACI�N.dbo.VENTAS
GO

-- Verificamos la tabla "VENTAS2"
SELECT	*
FROM	APLICACI�N.dbo.VENTAS2
GO

-- Eliminamos la tabla "VENTAS2"
DROP TABLE APLICACI�N.dbo.VENTAS2
GO

/* Respuestas */

-- M�s eficiente (No se puede usar WHERE)
TRUNCATE TABLE APLICACI�N.dbo.VENTAS2
GO

SELECT	*
FROM	APLICACI�N.dbo.VENTAS2
GO

-- Menos eficiente (Se puede usar WHERE)*/
DELETE	
FROM	APLICACI�N.dbo.VENTAS2
GO

SELECT	*
FROM	APLICACI�N.dbo.VENTAS2
GO
CREATE DATABASE JSanchezConsiss
USE JSanchezConsiss
GO

CREATE TABLE Producto(
	IdProducto INT IDENTITY(1,1) PRIMARY KEY,
	Descripcion VARCHAR(50),
	PrecioUnitario DECIMAL(5,2)
)
GO

CREATE TABLE Proveedor(
	IdProveedor INT IDENTITY(1,1) PRIMARY KEY,
	RazonSocial VARCHAR(50),
	Direccion VARCHAR(50),
	Telefono VARCHAR(10)
)
GO

CREATE TABLE Factura(
	IdFactura INT IDENTITY(100,1) PRIMARY KEY,
	Fecha DATE,
	IdProveedor INT
	CONSTRAINT fk_FacturaProveedor FOREIGN KEY (IdProveedor) REFERENCES Proveedor(IdProveedor)
)
GO

CREATE TABLE DetalleFactura(
	IdDetalleFactura INT IDENTITY(1,1) PRIMARY KEY,
	IdFactura INT,
	IdProducto INT,
	Cantidad INT
	CONSTRAINT fk_DetalleFacturaFolioFactura FOREIGN KEY (IdFactura) REFERENCES Factura(IdFactura),
	CONSTRAINT fk_DetalleFacturaProducto FOREIGN KEY (IdProducto) REFERENCES Producto(IdProducto)
)
GO

INSERT INTO Producto(Descripcion,PrecioUnitario)VALUES('Galletas',12.5)
INSERT INTO Proveedor(RazonSocial,Direccion,Telefono)VALUES('Tia Rosa','Calle siempre viva','0987654321')
INSERT INTO Factura(Fecha,IdProveedor)VALUES('12-10-2023',1)
INSERT INTO DetalleFactura(IdFactura,IdProducto,Cantidad)VALUES(100,1,100)
GO
SELECT * FROM Factura
SELECT * FROM Producto
SELECT * FROM Proveedor
SELECT * FROM DetalleFactura
GO

--a) Fecha, Razon social, Direccion, Telefono de las facturas cuyos Folios estan entre 100 y 105
SELECT Factura.IdFactura,Factura.Fecha, Proveedor.RazonSocial, Proveedor.Direccion, Proveedor.Telefono FROM Factura
INNER JOIN Proveedor ON Factura.IdProveedor = Proveedor.IdProveedor
WHERE Factura.IdFactura >= 100 AND Factura.IdFactura <=105
GO

--b) Cantidad, Descrpcion, Precio unitario e importe de las partidad incluidas en la factura con el folio 120
SELECT DetalleFactura.Cantidad,
	   Producto.Descripcion,
	   Producto.PrecioUnitario,
	   (Producto.PrecioUnitario * DetalleFactura.Cantidad) AS Importe 
	   FROM DetalleFactura
INNER JOIN Producto ON DetalleFactura.IdProducto = Producto.IdProducto
WHERE DetalleFactura.IdFactura = 120
GO

--c) Importe total de las facturas con folios 200 y 250
SELECT SUM(DetalleFactura.Cantidad * Producto.PrecioUnitario) AS ImporteTotal FROM DetalleFactura
INNER JOIN Producto ON DetalleFactura.IdProducto = Producto.IdProducto
INNER JOIN Factura ON DetalleFactura.IdFactura = Factura.IdFactura
WHERE Factura.IdFactura >= 200 AND Factura.IdFactura <= 250
GO
--d) IdProveedor, Razon social y pago promedio que hacen los proveedores por factura
SELECT Proveedor.IdProveedor,
	   Proveedor.RazonSocial,
	   AVG(DetalleFactura.Cantidad * Producto.PrecioUnitario)
	   FROM Proveedor
INNER JOIN Factura On Proveedor.IdProveedor = Factura.IdProveedor
INNER JOIN DetalleFactura ON Factura.IdFactura = DetalleFactura.IdFactura
INNER JOIN Producto ON DetalleFactura.IdProducto = Producto.IdProducto
GROUP BY Proveedor.IdProveedor, Proveedor.RazonSocial
GO

CREATE TABLE Persona(
	IdPersona INT IDENTITY(1,1) PRIMARY KEY,
	Nombre VARCHAR(250),
	Direccion VARCHAR(250),
	Edad INT,
	Correo VARCHAR(50),
	Habilidades VARCHAR(250),
	IdTipo INT
)
GO

SELECT * FROM Persona
GO
--SP Persona en uno solo
CREATE PROCEDURE Principal --Principal 'Modificar',1,'Luis','Calle Siempre Viva 10',20,'lperez@gmail.com','Principal'
						   --Principal 'Agregar',0,'Jose','Calle Siempre Viva 30',50,'jsanchez@gmail.com','Principal'
						   --Principal 'Eliminar',1,'','',0,'',''
						   --Principal 'dsf',0,'','',0,'',''
@Accion VARCHAR(20),
@IdPersona INT,
@Nombre VARCHAR(250),
@Direccion VARCHAR(250),
@Edad INT,
@Correo VARCHAR(50),
@Habilidades VARCHAR(250)
AS
IF (@Accion = 'Modificar')
	IF(@Edad < 30)
		UPDATE Persona
		SET
		Nombre = @Nombre,
		Direccion = @Direccion,
		Edad = @Edad,
		Correo = @Correo,
		Habilidades = @Habilidades,
		IdTipo = 1
		WHERE IdPersona=@IdPersona
	ELSE IF (@Edad >= 30 AND @Edad < 60)
		UPDATE Persona
		SET
		Nombre = @Nombre,
		Direccion = @Direccion,
		Edad = @Edad,
		Correo = @Correo,
		Habilidades = @Habilidades,
		IdTipo = 2
		WHERE IdPersona=@IdPersona
	ELSE
		UPDATE Persona
		SET
		Nombre = @Nombre,
		Direccion = @Direccion,
		Edad = @Edad,
		Correo = @Correo,
		Habilidades = @Habilidades,
		IdTipo = 3
		WHERE IdPersona=@IdPersona
ELSE IF(@Accion = 'Eliminar')
	DELETE FROM Persona WHERE IdPersona=@IdPersona
ELSE IF(@Accion = 'Agregar')
	IF (@Edad < 30)
		INSERT INTO Persona(Nombre,Direccion,Edad,Correo,Habilidades,IdTipo)VALUES(@Nombre,@Direccion,@Edad,@Correo,@Habilidades,1)
	ELSE IF (@Edad >= 30 AND @Edad < 60)
		INSERT INTO Persona(Nombre,Direccion,Edad,Correo,Habilidades,IdTipo)VALUES(@Nombre,@Direccion,@Edad,@Correo,@Habilidades,2)
	ELSE
		INSERT INTO Persona(Nombre,Direccion,Edad,Correo,Habilidades,IdTipo)VALUES(@Nombre,@Direccion,@Edad,@Correo,@Habilidades,3)
	ELSE
		PRINT('Opcion incorrecta, escriba correctamente el SP')
GO

---SP aparte------------

CREATE PROCEDURE PersonaAdd --'Jose','Calle siempre viva',12,'jsanchz@digis.com','Principal',1
@Nombre VARCHAR(250),
@Direccion VARCHAR(250),
@Edad INT,
@Correo VARCHAR(50),
@Habilidades VARCHAR(250),
@IdTipo INT
AS
INSERT INTO Persona(Nombre,Direccion,Edad,Correo,Habilidades,IdTipo)VALUES(@Nombre,@Direccion,@Edad,@Correo,@Habilidades,@IdTipo)
GO

CREATE PROCEDURE PersonaUpdate --1,'Luis','Calle Siempre Viva 10',60,'lperez@gmail.com','Secundaria'
@IdPersona INT,
@Nombre VARCHAR(250),
@Direccion VARCHAR(250),
@Edad INT,
@Correo VARCHAR(50),
@Habilidades VARCHAR(250)
AS
IF(@Edad < 30)
UPDATE Persona
SET
Nombre = @Nombre,
Direccion = @Direccion,
Edad = @Edad,
Correo = @Correo,
Habilidades = @Habilidades,
IdTipo = 1
WHERE IdPersona=@IdPersona
ELSE IF (@Edad >= 30 AND @Edad < 60)
UPDATE Persona
SET
Nombre = @Nombre,
Direccion = @Direccion,
Edad = @Edad,
Correo = @Correo,
Habilidades = @Habilidades,
IdTipo = 2
WHERE IdPersona=@IdPersona
ELSE
UPDATE Persona
SET
Nombre = @Nombre,
Direccion = @Direccion,
Edad = @Edad,
Correo = @Correo,
Habilidades = @Habilidades,
IdTipo = 3
WHERE IdPersona=@IdPersona
GO

CREATE PROCEDURE PersonaDelete
@IdPersona INT
AS
DELETE FROM Persona WHERE IdPersona=@IdPersona
GO

CREATE PROCEDURE PersonaAddMenor
@Nombre VARCHAR(250),
@Direccion VARCHAR(250),
@Edad INT,
@Correo VARCHAR(50),
@Habilidades VARCHAR(250)
AS
IF (@Edad <=30)
INSERT INTO Persona(Nombre,Direccion,Edad,Correo,Habilidades,IdTipo)VALUES(@Nombre,@Direccion,@Edad,@Correo,@Habilidades,1)
GO

CREATE PROCEDURE PersonaAddMayor
@Nombre VARCHAR(250),
@Direccion VARCHAR(250),
@Edad INT,
@Correo VARCHAR(50),
@Habilidades VARCHAR(250)
AS
IF (@Edad >=60)
INSERT INTO Persona(Nombre,Direccion,Edad,Correo,Habilidades,IdTipo)VALUES(@Nombre,@Direccion,@Edad,@Correo,@Habilidades,3)
GO

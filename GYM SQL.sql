CREATE DATABASE GYM; --Gimnasio
GO

USE GYM
GO 

CREATE TABLE Miembros(
IDMiembro INT PRIMARY KEY IDENTITY(1,1),
Nombre NVARCHAR(50) NOT NULL, -- es de 50 porque jaja hay gente con nombre largo
Apellido NVARCHAR(50) NOT NULL,
Correo NVARCHAR(100) UNIQUE NOT NULL,
Telefono NVARCHAR(20),
FechaNacimiento DATE,
FechaRegistro DATE DEFAULT GETDATE(),
ContactoEmergencia NVARCHAR(100),  -- por si se le cae una pesa en un pie
TelefonoEmergencia NVARCHAR(20));

CREATE TABLE TipoMembresia(
IDTipoMembresia INT PRIMARY KEY IDENTITY(1,1),
Nombre NVARCHAR(50) UNIQUE NOT NULL, --"Mensual", "TRIMESTAL", "Anual"
DuracionDia INT NOT NULL, -- 30, 90, 365
Precio DECIMAL(10,2) NOT NULL, 
Descripcion NVARCHAR(200));

CREATE TABLE Membresias(
IDMembresia INT PRIMARY KEY IDENTITY(1,1),
IDMiembro INT NOT NULL,
IDTipoMembresia INT NOT NULL,
FechaInicio DATE DEFAULT GETDATE(), 
FechaVencimiento DATE NOT NULL, 
Estado NVARCHAR(15) CHECK (Estado IN ('ACTIVA', 'VENCIDA', 'CANCELADA')),
CostoTotal DECIMAL(10,2) NOT NULL, 


FOREIGN KEY (IDMiembro) REFERENCES Miembros(IDMiembro),
FOREIGN KEY (IDTipoMembresia) REFERENCES TipoMembresia(IDTipoMembresia));

CREATE TABLE Pagos(
IDPago INT PRIMARY KEY IDENTITY(1,1),
IDMembresia INT NOT NULL,
FechaPago DATE DEFAULT GETDATE(),
Monto DECIMAL(10,2) NOT NULL,
MetodoPago NVARCHAR(20) CHECK (MetodoPago IN ('EFECTIVO', 'TARJETA', 'TRANSFERENCIA')),
Estado NVARCHAR(15) CHECK (Estado IN ('COMPLETADO', 'PENDIENTE', 'RECHAZADO')),

FOREIGN KEY (IDMembresia) REFERENCES Membresias(IDMembresia));

CREATE TABLE Entrenadores(
IDEntrenador INT PRIMARY KEY IDENTITY(1,1),
Nombre NVARCHAR(50) NOT NULL,
Apellido NVARCHAR(50) NOT NULL,
Especialidad NVARCHAR(100), -- "Cardio", "Pesas", "Yoga"
Telefono NVARCHAR(20),
Correo NVARCHAR(100) UNIQUE NOT NULL, 
FechaContratacion DATE DEFAULT GETDATE(),
Salario DECIMAL(10,2));

CREATE TABLE ClasesGrupales(
IDClases INT PRIMARY KEY IDENTITY(1,1),
NombreClase NVARCHAR(70), --("Yoga Relajacion" , "Aerobicos", "Pilates"
IDEntrenador INT NOT NULL,
FOREIGN KEY (IDEntrenador) REFERENCES Entrenadores(IDEntrenador), 
DiaSemana NVARCHAR(15) NOT NULL,
HoraInicio TIME NOT NULL,
DuracionMin INT NOT NULL,
CupoMax INT CHECK (CupoMax > 0 AND CupoMax <=30),
Descripcion NVARCHAR(200));

CREATE TABLE SeguimientoMiembros(
IDSeguimiento INT PRIMARY KEY IDENTITY(1,1),
IDMiembro INT NOT NULL,
FechaRegistro DATE DEFAULT GETDATE(),
Peso DECIMAL(5,2) NOT NULL,
Altura DECIMAL(3,2),
PorcentajeGrasa DECIMAL(4,2),
MasaMuscular DECIMAL(5,2)

FOREIGN KEY (IDMiembro) REFERENCES Miembros(IDMiembro));


 















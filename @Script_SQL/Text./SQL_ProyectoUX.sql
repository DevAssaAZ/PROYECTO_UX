﻿USE [master]
GO
/****** Object:  Database [PROYECTO_UX]    Script Date: 3/8/2024 22:30:26 ******/
CREATE DATABASE [PROYECTO_UX]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PROYECTO_UX', FILENAME = N'C:\SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\PROYECTO_UX.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'PROYECTO_UX_log', FILENAME = N'C:\SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\PROYECTO_UX_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [PROYECTO_UX] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PROYECTO_UX].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PROYECTO_UX] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PROYECTO_UX] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PROYECTO_UX] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PROYECTO_UX] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PROYECTO_UX] SET ARITHABORT OFF 
GO
ALTER DATABASE [PROYECTO_UX] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [PROYECTO_UX] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PROYECTO_UX] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PROYECTO_UX] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PROYECTO_UX] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PROYECTO_UX] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PROYECTO_UX] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PROYECTO_UX] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PROYECTO_UX] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PROYECTO_UX] SET  ENABLE_BROKER 
GO
ALTER DATABASE [PROYECTO_UX] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PROYECTO_UX] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PROYECTO_UX] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PROYECTO_UX] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PROYECTO_UX] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PROYECTO_UX] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PROYECTO_UX] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PROYECTO_UX] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [PROYECTO_UX] SET  MULTI_USER 
GO
ALTER DATABASE [PROYECTO_UX] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PROYECTO_UX] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PROYECTO_UX] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PROYECTO_UX] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [PROYECTO_UX] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [PROYECTO_UX] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [PROYECTO_UX] SET QUERY_STORE = ON
GO
ALTER DATABASE [PROYECTO_UX] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [PROYECTO_UX]
GO
/****** Object:  Table [dbo].[CALIFICACIONES]    Script Date: 3/8/2024 22:30:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CALIFICACIONES](
	[Id_calificacion] [int] IDENTITY(1,1) NOT NULL,
	[Curso] [varchar](20) NULL,
	[Id_curso] [int] NULL,
	[Estudiante] [varchar](100) NULL,
	[Parcial_1] [decimal](5, 2) NULL,
	[Parcial_2] [decimal](5, 2) NULL,
	[Examen] [decimal](5, 2) NULL,
	[Fecha_registro] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_calificacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CURSOS]    Script Date: 3/8/2024 22:30:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CURSOS](
	[Id_curso] [int] IDENTITY(1,1) NOT NULL,
	[Nombre_curso] [varchar](20) NULL,
	[Fecha_inicio] [date] NULL,
	[Fecha_fin] [date] NULL,
	[Duracion] [int] NULL,
	[Nivel] [int] NULL,
	[Estado] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_curso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ESTUDIANTES]    Script Date: 3/8/2024 22:30:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ESTUDIANTES](
	[Id_estudiante] [int] IDENTITY(1,1) NOT NULL,
	[cedula] [varchar](20) NULL,
	[Estudiante] [varchar](100) NULL,
	[fecha_nacimiento] [date] NULL,
	[Telefono] [varchar](20) NULL,
	[Gratuidad] [varchar](5) NOT NULL,
	[Fecha_inscripcion] [date] NULL,
	[Id_curso] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_estudiante] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PROFESORES]    Script Date: 3/8/2024 22:30:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PROFESORES](
	[Id_profesor] [int] IDENTITY(1,1) NOT NULL,
	[cedula] [varchar](20) NULL,
	[Profesor] [varchar](100) NULL,
	[Profesion] [varchar](50) NULL,
	[Apellidos_profesor] [varchar](50) NULL,
	[Nombre_profesor] [varchar](50) NULL,
	[Estado] [varchar](50) NOT NULL,
	[Id_curso] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_profesor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SECRETARIO]    Script Date: 3/8/2024 22:30:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SECRETARIO](
	[Id_secretario] [int] IDENTITY(1,1) NOT NULL,
	[Secretario] [varchar](100) NULL,
	[Cedula] [varchar](20) NULL,
	[Correo] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_secretario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[CALIFICACIONES] ON 

INSERT [dbo].[CALIFICACIONES] ([Id_calificacion], [Curso], [Id_curso], [Estudiante], [Parcial_1], [Parcial_2], [Examen], [Fecha_registro]) VALUES (3, N'SOF-ING-1-3', 2, N'1', CAST(10.00 AS Decimal(5, 2)), CAST(9.90 AS Decimal(5, 2)), CAST(10.00 AS Decimal(5, 2)), CAST(N'2024-08-03' AS Date))
SET IDENTITY_INSERT [dbo].[CALIFICACIONES] OFF
GO
SET IDENTITY_INSERT [dbo].[CURSOS] ON 

INSERT [dbo].[CURSOS] ([Id_curso], [Nombre_curso], [Fecha_inicio], [Fecha_fin], [Duracion], [Nivel], [Estado]) VALUES (1, N'SOF-ING-1-2', CAST(N'2024-07-24' AS Date), CAST(N'2024-09-12' AS Date), 50, 1, N'Activo')
INSERT [dbo].[CURSOS] ([Id_curso], [Nombre_curso], [Fecha_inicio], [Fecha_fin], [Duracion], [Nivel], [Estado]) VALUES (2, N'SOF-ING-1-3', CAST(N'2024-07-24' AS Date), CAST(N'2024-08-15' AS Date), 50, 1, N'Activo')
SET IDENTITY_INSERT [dbo].[CURSOS] OFF
GO
SET IDENTITY_INSERT [dbo].[ESTUDIANTES] ON 

INSERT [dbo].[ESTUDIANTES] ([Id_estudiante], [cedula], [Estudiante], [fecha_nacimiento], [Telefono], [Gratuidad], [Fecha_inscripcion], [Id_curso]) VALUES (1, N'0955675020', N'Peñafiel Rosario Gabriel Alejandro', CAST(N'2003-09-05' AS Date), N'232', N'Si', CAST(N'2024-07-24' AS Date), 2)
SET IDENTITY_INSERT [dbo].[ESTUDIANTES] OFF
GO
SET IDENTITY_INSERT [dbo].[PROFESORES] ON 

INSERT [dbo].[PROFESORES] ([Id_profesor], [cedula], [Profesor], [Profesion], [Apellidos_profesor], [Nombre_profesor], [Estado], [Id_curso]) VALUES (1, N'0955675020', N'R DRAPG', N'Ingeniero en Software', N'R', N'DRAPG', N'Activo', 2)
SET IDENTITY_INSERT [dbo].[PROFESORES] OFF
GO
SET IDENTITY_INSERT [dbo].[SECRETARIO] ON 

INSERT [dbo].[SECRETARIO] ([Id_secretario], [Secretario], [Cedula], [Correo]) VALUES (2, N'Peñafiel Del Rosario', N'0000000000', N'secretario@ug.edu')
SET IDENTITY_INSERT [dbo].[SECRETARIO] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__ESTUDIAN__415B7BE51440BA58]    Script Date: 3/8/2024 22:30:29 ******/
ALTER TABLE [dbo].[ESTUDIANTES] ADD UNIQUE NONCLUSTERED 
(
	[cedula] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__PROFESOR__415B7BE55121F1E1]    Script Date: 3/8/2024 22:30:29 ******/
ALTER TABLE [dbo].[PROFESORES] ADD UNIQUE NONCLUSTERED 
(
	[cedula] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CURSOS] ADD  DEFAULT ('Activo') FOR [Estado]
GO
ALTER TABLE [dbo].[ESTUDIANTES] ADD  DEFAULT ('Si') FOR [Gratuidad]
GO
ALTER TABLE [dbo].[PROFESORES] ADD  DEFAULT ('Activo') FOR [Estado]
GO
ALTER TABLE [dbo].[CALIFICACIONES]  WITH CHECK ADD FOREIGN KEY([Id_curso])
REFERENCES [dbo].[CURSOS] ([Id_curso])
GO
ALTER TABLE [dbo].[ESTUDIANTES]  WITH CHECK ADD FOREIGN KEY([Id_curso])
REFERENCES [dbo].[CURSOS] ([Id_curso])
GO
ALTER TABLE [dbo].[PROFESORES]  WITH CHECK ADD FOREIGN KEY([Id_curso])
REFERENCES [dbo].[CURSOS] ([Id_curso])
GO
/****** Object:  StoredProcedure [dbo].[SP_Actualizar]    Script Date: 3/8/2024 22:30:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Actualizar]
@Id int,
@Nombre_curso varchar(20),
@Fecha_inicio date,
@Fecha_fin date,
@Duracion int,
@Nivel int,
@Estado VARCHAR(50)
as begin
UPDATE CURSOS SET Nombre_curso = @Nombre_curso, Fecha_inicio = @Fecha_inicio, Fecha_fin = @Fecha_fin, Duracion = @Duracion, Nivel = @Nivel, Estado = @Estado
Where Id_curso = @Id
end
GO
/****** Object:  StoredProcedure [dbo].[SP_Actualizar_calificaciones]    Script Date: 3/8/2024 22:30:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Actualizar_calificaciones]
@Id int,
@Curso varchar(20),
@Id_curso int,
@Estudiante varchar(100),
@Parcial_1 decimal(5,2),
@Parcial_2 decimal(5,2),
@Examen decimal(5,2)
as begin
UPDATE CALIFICACIONES SET Curso = @Curso, Id_curso = @Id_curso, Estudiante = @Estudiante, Parcial_1 = @Parcial_1, Parcial_2 = @Parcial_2,Examen = @Examen, Fecha_registro = CURRENT_TIMESTAMP
Where Id_calificacion = @Id
end
GO
/****** Object:  StoredProcedure [dbo].[SP_Actualizar_estudiante]    Script Date: 3/8/2024 22:30:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Actualizar_estudiante]
@Id int,
@Cedula varchar(20),
@Apellido varchar(50),
@Nombre varchar(50),
@Fecha_nacimiento date,
@Telefono varchar(20),
@Gratuidad varchar(5),
@IdCurso int
as begin
UPDATE ESTUDIANTES SET cedula = @Cedula, Estudiante = @Apellido+' '+@Nombre, fecha_nacimiento = @Fecha_nacimiento, Telefono = @Telefono, Gratuidad = @Gratuidad, Fecha_inscripcion = CURRENT_TIMESTAMP, Id_curso = @IdCurso
Where Id_estudiante = @Id
end
GO
/****** Object:  StoredProcedure [dbo].[SP_Actualizar_profesor]    Script Date: 3/8/2024 22:30:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Actualizar_profesor]
@Id int,
@Cedula varchar(20),
@Profesion varchar(50),
@Apellidos_profesor varchar(50),
@Nombre_profesor varchar(50),
@Estado VARCHAR(50),
@IdCurso int
as begin
UPDATE PROFESORES SET cedula = @Cedula, Profesor = @Apellidos_profesor+' '+@Nombre_profesor, Profesion = @Profesion, Apellidos_profesor = @Apellidos_profesor, Nombre_profesor = @Nombre_profesor, Estado = @Estado, Id_curso = @IdCurso
Where Id_profesor = @Id
end
GO
/****** Object:  StoredProcedure [dbo].[SP_Crear]    Script Date: 3/8/2024 22:30:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Crear]
@Nombre_curso varchar(20),
@Fecha_inicio date,
@Fecha_fin date,
@Duracion int,
@Nivel int,
@Estado VARCHAR(50)
as begin
INSERT INTO CURSOS VALUES(@Nombre_curso, @Fecha_inicio, @Fecha_fin, @Duracion, @Nivel, @Estado)
end
GO
/****** Object:  StoredProcedure [dbo].[SP_Crear_calificaciones]    Script Date: 3/8/2024 22:30:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Crear_calificaciones]
@Curso varchar(20),
@Id_curso int,
@Estudiante varchar(100),
@Parcial_1 decimal(5,2),
@Parcial_2 decimal(5,2),
@Examen decimal(5,2)
as begin
INSERT INTO CALIFICACIONES VALUES(@Curso,@Id_curso, @Estudiante,@Parcial_1,@Parcial_2,@Examen,CURRENT_TIMESTAMP)
end
GO
/****** Object:  StoredProcedure [dbo].[SP_Crear_estudiante]    Script Date: 3/8/2024 22:30:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Crear_estudiante]
@Cedula varchar(20),
@Apellido varchar(50),
@Nombre varchar(50),
@Fecha_nacimiento date,
@Telefono varchar(20),
@Gratuidad varchar(5),
@IdCurso int
as begin
INSERT INTO ESTUDIANTES VALUES(@Cedula,@Apellido+' '+@Nombre,@Fecha_nacimiento,@Telefono,@Gratuidad,CURRENT_TIMESTAMP, @IdCurso)
end
GO
/****** Object:  StoredProcedure [dbo].[SP_Crear_profesor]    Script Date: 3/8/2024 22:30:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Crear_profesor]
@Cedula varchar(20),
@Profesion varchar(50),
@Apellidos_profesor varchar(50),
@Nombre_profesor varchar(50),
@Estado VARCHAR(50),
@IdCurso int
as begin
INSERT INTO PROFESORES VALUES(@Cedula,@Apellidos_profesor+' '+@Nombre_profesor,@Profesion,@Apellidos_profesor,@Nombre_profesor,@Estado, @IdCurso)
end
GO
/****** Object:  StoredProcedure [dbo].[SP_Eliminar]    Script Date: 3/8/2024 22:30:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Eliminar]
@Id INT 
as begin
DELETE FROM CURSOS WHERE Id_curso = @Id
end
GO
/****** Object:  StoredProcedure [dbo].[SP_Eliminar_calificaciones]    Script Date: 3/8/2024 22:30:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Eliminar_calificaciones]
@Id INT 
as begin
DELETE FROM CALIFICACIONES WHERE Id_calificacion = @Id
end
GO
/****** Object:  StoredProcedure [dbo].[SP_Eliminar_estudiante]    Script Date: 3/8/2024 22:30:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Eliminar_estudiante]
@Id INT 
as begin
DELETE FROM ESTUDIANTES WHERE Id_estudiante = @Id
end
GO
/****** Object:  StoredProcedure [dbo].[SP_Eliminar_profesor]    Script Date: 3/8/2024 22:30:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Eliminar_profesor]
@Id INT 
as begin
DELETE FROM PROFESORES WHERE Id_profesor = @Id
end
GO
/****** Object:  StoredProcedure [dbo].[SP_Load]    Script Date: 3/8/2024 22:30:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE  [dbo].[SP_Load]
as begin
SELECT * FROM CURSOS
END
GO
/****** Object:  StoredProcedure [dbo].[SP_Load_calificaciones]    Script Date: 3/8/2024 22:30:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Load_calificaciones]
as begin
SELECT * FROM CALIFICACIONES
END
GO
/****** Object:  StoredProcedure [dbo].[SP_Load_estudiante]    Script Date: 3/8/2024 22:30:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Load_estudiante]
as begin
SELECT * FROM ESTUDIANTES
END
GO
/****** Object:  StoredProcedure [dbo].[SP_Load_profesor]    Script Date: 3/8/2024 22:30:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Load_profesor]
as begin
SELECT * FROM PROFESORES
END
GO
/****** Object:  StoredProcedure [dbo].[SP_Read]    Script Date: 3/8/2024 22:30:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Read]
@Id int
as begin
SELECT * FROM CURSOS WHERE Id_curso = @Id
end
GO
/****** Object:  StoredProcedure [dbo].[SP_Read_calificaciones]    Script Date: 3/8/2024 22:30:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Read_calificaciones]
@Id int
as begin
SELECT * FROM CALIFICACIONES WHERE Id_calificacion = @Id
end
GO
/****** Object:  StoredProcedure [dbo].[SP_Read_estudiante]    Script Date: 3/8/2024 22:30:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Read_estudiante]
@Id int
as begin
SELECT * FROM ESTUDIANTES WHERE Id_estudiante = @Id
end
GO
/****** Object:  StoredProcedure [dbo].[SP_Read_profesor]    Script Date: 3/8/2024 22:30:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Read_profesor]
@Id int
as begin
SELECT * FROM PROFESORES WHERE Id_profesor = @Id
end
GO
USE [master]
GO
ALTER DATABASE [PROYECTO_UX] SET  READ_WRITE 
GO

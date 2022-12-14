USE [DomZdravlja]
GO
ALTER TABLE [dbo].[Paket] DROP CONSTRAINT [FK_Paket_Firma]
GO
ALTER TABLE [dbo].[Pacijent] DROP CONSTRAINT [FK_Pacijent_Paket]
GO
/****** Object:  Table [dbo].[Paket]    Script Date: 11/30/2022 11:39:33 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Paket]') AND type in (N'U'))
DROP TABLE [dbo].[Paket]
GO
/****** Object:  Table [dbo].[Pacijent]    Script Date: 11/30/2022 11:39:33 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Pacijent]') AND type in (N'U'))
DROP TABLE [dbo].[Pacijent]
GO
/****** Object:  Table [dbo].[Firma]    Script Date: 11/30/2022 11:39:33 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Firma]') AND type in (N'U'))
DROP TABLE [dbo].[Firma]
GO
USE [master]
GO
/****** Object:  Database [DomZdravlja]    Script Date: 11/30/2022 11:39:33 AM ******/
DROP DATABASE [DomZdravlja]
GO
/****** Object:  Database [DomZdravlja]    Script Date: 11/30/2022 11:39:33 AM ******/
CREATE DATABASE [DomZdravlja]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DomZdravlja', FILENAME = N'D:\MSSQL\MSSQL15.MSSQLSERVER\MSSQL\DATA\DomZdravlja.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DomZdravlja_log', FILENAME = N'D:\MSSQL\MSSQL15.MSSQLSERVER\MSSQL\DATA\DomZdravlja_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [DomZdravlja] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DomZdravlja].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DomZdravlja] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DomZdravlja] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DomZdravlja] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DomZdravlja] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DomZdravlja] SET ARITHABORT OFF 
GO
ALTER DATABASE [DomZdravlja] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DomZdravlja] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DomZdravlja] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DomZdravlja] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DomZdravlja] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DomZdravlja] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DomZdravlja] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DomZdravlja] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DomZdravlja] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DomZdravlja] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DomZdravlja] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DomZdravlja] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DomZdravlja] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DomZdravlja] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DomZdravlja] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DomZdravlja] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DomZdravlja] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DomZdravlja] SET RECOVERY FULL 
GO
ALTER DATABASE [DomZdravlja] SET  MULTI_USER 
GO
ALTER DATABASE [DomZdravlja] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DomZdravlja] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DomZdravlja] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DomZdravlja] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DomZdravlja] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DomZdravlja] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'DomZdravlja', N'ON'
GO
ALTER DATABASE [DomZdravlja] SET QUERY_STORE = OFF
GO
USE [DomZdravlja]
GO
/****** Object:  Table [dbo].[Firma]    Script Date: 11/30/2022 11:39:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Firma](
	[FirmaID] [int] NOT NULL,
	[Naziv] [nvarchar](50) NOT NULL,
	[Sediste] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Firma] PRIMARY KEY CLUSTERED 
(
	[FirmaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pacijent]    Script Date: 11/30/2022 11:39:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pacijent](
	[PacijentID] [int] NOT NULL,
	[Ime] [nvarchar](50) NOT NULL,
	[Prezime] [nvarchar](50) NOT NULL,
	[DatumIzmene] [date] NOT NULL,
	[Popust] [float] NULL,
	[PaketID] [int] NOT NULL,
 CONSTRAINT [PK_Pacijent] PRIMARY KEY CLUSTERED 
(
	[PacijentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Paket]    Script Date: 11/30/2022 11:39:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Paket](
	[PaketID] [int] NOT NULL,
	[Naziv] [nvarchar](50) NOT NULL,
	[Cena] [money] NOT NULL,
	[FirmaID] [int] NOT NULL,
 CONSTRAINT [PK_Paket] PRIMARY KEY CLUSTERED 
(
	[PaketID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Firma] ([FirmaID], [Naziv], [Sediste]) VALUES (1, N'ITS', N'Zemun')
INSERT [dbo].[Firma] ([FirmaID], [Naziv], [Sediste]) VALUES (2, N'Microsoft', N'Novi Beograd')
INSERT [dbo].[Firma] ([FirmaID], [Naziv], [Sediste]) VALUES (3, N'Lav Auto', N'Cukarica')
GO
INSERT [dbo].[Pacijent] ([PacijentID], [Ime], [Prezime], [DatumIzmene], [Popust], [PaketID]) VALUES (1, N'Marko', N'Nikolic', CAST(N'2019-03-13' AS Date), 15, 1)
INSERT [dbo].[Pacijent] ([PacijentID], [Ime], [Prezime], [DatumIzmene], [Popust], [PaketID]) VALUES (2, N'Nikola', N'Markovic', CAST(N'2020-05-30' AS Date), 10, 1)
INSERT [dbo].[Pacijent] ([PacijentID], [Ime], [Prezime], [DatumIzmene], [Popust], [PaketID]) VALUES (3, N'Ilija', N'Garasanin', CAST(N'2021-01-27' AS Date), 20, 2)
INSERT [dbo].[Pacijent] ([PacijentID], [Ime], [Prezime], [DatumIzmene], [Popust], [PaketID]) VALUES (16, N'luka', N'Ilic', CAST(N'2022-11-30' AS Date), 50, 4)
INSERT [dbo].[Pacijent] ([PacijentID], [Ime], [Prezime], [DatumIzmene], [Popust], [PaketID]) VALUES (412, N'Marko', N'Djukic', CAST(N'2022-11-30' AS Date), 30, 2)
GO
INSERT [dbo].[Paket] ([PaketID], [Naziv], [Cena], [FirmaID]) VALUES (1, N'Osnovni', 2400.0000, 1)
INSERT [dbo].[Paket] ([PaketID], [Naziv], [Cena], [FirmaID]) VALUES (2, N'Napredni', 2600.0000, 1)
INSERT [dbo].[Paket] ([PaketID], [Naziv], [Cena], [FirmaID]) VALUES (3, N'Exclusive', 2800.0000, 1)
INSERT [dbo].[Paket] ([PaketID], [Naziv], [Cena], [FirmaID]) VALUES (4, N'Osnovni', 300.0000, 2)
INSERT [dbo].[Paket] ([PaketID], [Naziv], [Cena], [FirmaID]) VALUES (5, N'Ekskluzive', 500.0000, 2)
INSERT [dbo].[Paket] ([PaketID], [Naziv], [Cena], [FirmaID]) VALUES (6, N'Osnovni', 100.0000, 3)
INSERT [dbo].[Paket] ([PaketID], [Naziv], [Cena], [FirmaID]) VALUES (7, N'Zanatlija', 150.0000, 3)
INSERT [dbo].[Paket] ([PaketID], [Naziv], [Cena], [FirmaID]) VALUES (8, N'Profesional', 200.0000, 3)
GO
ALTER TABLE [dbo].[Pacijent]  WITH CHECK ADD  CONSTRAINT [FK_Pacijent_Paket] FOREIGN KEY([PaketID])
REFERENCES [dbo].[Paket] ([PaketID])
GO
ALTER TABLE [dbo].[Pacijent] CHECK CONSTRAINT [FK_Pacijent_Paket]
GO
ALTER TABLE [dbo].[Paket]  WITH CHECK ADD  CONSTRAINT [FK_Paket_Firma] FOREIGN KEY([FirmaID])
REFERENCES [dbo].[Firma] ([FirmaID])
GO
ALTER TABLE [dbo].[Paket] CHECK CONSTRAINT [FK_Paket_Firma]
GO
USE [master]
GO
ALTER DATABASE [DomZdravlja] SET  READ_WRITE 
GO

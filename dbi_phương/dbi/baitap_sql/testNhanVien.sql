USE [master]
GO
/****** Object:  Database [SE17D01Assigment]    Script Date: 10/28/2023 3:47:08 PM ******/
CREATE DATABASE [SE17D01Assigment]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SE17D01Assigment', FILENAME = N'G:\DBSQL2019\MSSQL15.SQL2019\MSSQL\DATA\SE17D01Assigment.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SE17D01Assigment_log', FILENAME = N'G:\DBSQL2019\MSSQL15.SQL2019\MSSQL\DATA\SE17D01Assigment_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [SE17D01Assigment] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SE17D01Assigment].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SE17D01Assigment] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SE17D01Assigment] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SE17D01Assigment] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SE17D01Assigment] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SE17D01Assigment] SET ARITHABORT OFF 
GO
ALTER DATABASE [SE17D01Assigment] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SE17D01Assigment] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SE17D01Assigment] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SE17D01Assigment] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SE17D01Assigment] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SE17D01Assigment] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SE17D01Assigment] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SE17D01Assigment] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SE17D01Assigment] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SE17D01Assigment] SET  ENABLE_BROKER 
GO
ALTER DATABASE [SE17D01Assigment] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SE17D01Assigment] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SE17D01Assigment] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SE17D01Assigment] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SE17D01Assigment] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SE17D01Assigment] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SE17D01Assigment] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SE17D01Assigment] SET RECOVERY FULL 
GO
ALTER DATABASE [SE17D01Assigment] SET  MULTI_USER 
GO
ALTER DATABASE [SE17D01Assigment] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SE17D01Assigment] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SE17D01Assigment] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SE17D01Assigment] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SE17D01Assigment] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SE17D01Assigment] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'SE17D01Assigment', N'ON'
GO
ALTER DATABASE [SE17D01Assigment] SET QUERY_STORE = OFF
GO
USE [SE17D01Assigment]
GO
/****** Object:  Table [dbo].[NhanVien]    Script Date: 10/28/2023 3:47:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhanVien](
	[MaNV] [varchar](50) NOT NULL,
	[HoLot] [nvarchar](50) NOT NULL,
	[Ten] [nvarchar](50) NOT NULL,
	[NgaySinh] [date] NOT NULL,
	[GioiTinh] [nvarchar](50) NOT NULL,
	[DiaChi] [nvarchar](100) NULL,
	[Luong] [decimal](18, 2) NOT NULL,
	[MaPhongBan] [int] NOT NULL,
	[MaNVQL] [varchar](50) NULL,
 CONSTRAINT [PK_NhanVien] PRIMARY KEY CLUSTERED 
(
	[MaNV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhongBan]    Script Date: 10/28/2023 3:47:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhongBan](
	[MaPhong] [int] IDENTITY(1,1) NOT NULL,
	[TenPB] [nvarchar](50) NULL,
	[MaTruongPhong] [varchar](50) NULL,
	[NgayNhanChuc] [date] NULL,
 CONSTRAINT [PK_PhongBan] PRIMARY KEY CLUSTERED 
(
	[MaPhong] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[NhanVien] ([MaNV], [HoLot], [Ten], [NgaySinh], [GioiTinh], [DiaChi], [Luong], [MaPhongBan], [MaNVQL]) VALUES (N'NV001', N'Nguyễn', N'Văn A', CAST(N'2000-01-01' AS Date), N'Nam', N'Hà Nội', CAST(1000.00 AS Decimal(18, 2)), 4, NULL)
INSERT [dbo].[NhanVien] ([MaNV], [HoLot], [Ten], [NgaySinh], [GioiTinh], [DiaChi], [Luong], [MaPhongBan], [MaNVQL]) VALUES (N'NV002', N'Trần', N'Thị B', CAST(N'2000-02-02' AS Date), N'Nữ', N'Hồ Chí Minh', CAST(2000.00 AS Decimal(18, 2)), 5, NULL)
INSERT [dbo].[NhanVien] ([MaNV], [HoLot], [Ten], [NgaySinh], [GioiTinh], [DiaChi], [Luong], [MaPhongBan], [MaNVQL]) VALUES (N'NV003', N'Lê Nguyễn Thanh', N'Thủy', CAST(N'2000-06-01' AS Date), N'Nữ', N'Hà Nội', CAST(2500.00 AS Decimal(18, 2)), 4, N'Nv002')
INSERT [dbo].[NhanVien] ([MaNV], [HoLot], [Ten], [NgaySinh], [GioiTinh], [DiaChi], [Luong], [MaPhongBan], [MaNVQL]) VALUES (N'NV004', N'Trần', N'Mai Phương', CAST(N'2000-02-02' AS Date), N'Nữ', N'Hồ Chí Minh', CAST(3000.00 AS Decimal(18, 2)), 2, N'NV001')
INSERT [dbo].[NhanVien] ([MaNV], [HoLot], [Ten], [NgaySinh], [GioiTinh], [DiaChi], [Luong], [MaPhongBan], [MaNVQL]) VALUES (N'NV005', N'Lê', N'Bảo Trung', CAST(N'1990-06-04' AS Date), N'Nam', N'TP HCM', CAST(4000.00 AS Decimal(18, 2)), 4, N'NV002')
INSERT [dbo].[NhanVien] ([MaNV], [HoLot], [Ten], [NgaySinh], [GioiTinh], [DiaChi], [Luong], [MaPhongBan], [MaNVQL]) VALUES (N'NV006', N'Trần', N'Tuấn Phúc', CAST(N'1995-04-05' AS Date), N'Nam', N'Hà Nội', CAST(3000.00 AS Decimal(18, 2)), 2, N'NV002')
INSERT [dbo].[NhanVien] ([MaNV], [HoLot], [Ten], [NgaySinh], [GioiTinh], [DiaChi], [Luong], [MaPhongBan], [MaNVQL]) VALUES (N'NV007', N'Trần', N'Thị Thủy', CAST(N'1995-04-05' AS Date), N'Nữ', N'Quảng Ngãi', CAST(9000.00 AS Decimal(18, 2)), 2, N'NV001')
INSERT [dbo].[NhanVien] ([MaNV], [HoLot], [Ten], [NgaySinh], [GioiTinh], [DiaChi], [Luong], [MaPhongBan], [MaNVQL]) VALUES (N'NV008', N'Nguyễn Trần', N'Bảo Nam', CAST(N'1995-06-01' AS Date), N'Nam', N'Quảng Nam', CAST(7000.00 AS Decimal(18, 2)), 2, N'NV004')
GO
SET IDENTITY_INSERT [dbo].[PhongBan] ON 

INSERT [dbo].[PhongBan] ([MaPhong], [TenPB], [MaTruongPhong], [NgayNhanChuc]) VALUES (2, N'Phòng Kế toán', N'NV001', NULL)
INSERT [dbo].[PhongBan] ([MaPhong], [TenPB], [MaTruongPhong], [NgayNhanChuc]) VALUES (4, N'Phòng Nhân sự', N'NV002', CAST(N'2020-12-10' AS Date))
INSERT [dbo].[PhongBan] ([MaPhong], [TenPB], [MaTruongPhong], [NgayNhanChuc]) VALUES (5, N'Phòng Kinh doanh', N'NV004', CAST(N'2020-06-10' AS Date))
INSERT [dbo].[PhongBan] ([MaPhong], [TenPB], [MaTruongPhong], [NgayNhanChuc]) VALUES (6, N'Phòng Giám đốc', N'NV003', CAST(N'2023-10-25' AS Date))
SET IDENTITY_INSERT [dbo].[PhongBan] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UC_TenPB]    Script Date: 10/28/2023 3:47:09 PM ******/
ALTER TABLE [dbo].[PhongBan] ADD  CONSTRAINT [UC_TenPB] UNIQUE NONCLUSTERED 
(
	[TenPB] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PhongBan] ADD  CONSTRAINT [DF_NgayNhanChuc]  DEFAULT (getdate()) FOR [NgayNhanChuc]
GO
ALTER TABLE [dbo].[PhongBan]  WITH CHECK ADD  CONSTRAINT [FK_NhanVien_MaTruongPhong] FOREIGN KEY([MaTruongPhong])
REFERENCES [dbo].[NhanVien] ([MaNV])
GO
ALTER TABLE [dbo].[PhongBan] CHECK CONSTRAINT [FK_NhanVien_MaTruongPhong]
GO
ALTER TABLE [dbo].[NhanVien]  WITH CHECK ADD  CONSTRAINT [CK_GioiTinhNhanVien] CHECK  (([GioiTinh]=N'Nữ' OR [GioiTinh]='Nam'))
GO
ALTER TABLE [dbo].[NhanVien] CHECK CONSTRAINT [CK_GioiTinhNhanVien]
GO
USE [master]
GO
ALTER DATABASE [SE17D01Assigment] SET  READ_WRITE 
GO

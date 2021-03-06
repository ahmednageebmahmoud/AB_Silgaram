USE [master]
GO
/****** Object:  Database [Silgaram]    Script Date: 9/24/2018 4:57:08 PM ******/
CREATE DATABASE [Silgaram]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Silgaram', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.AHMED\MSSQL\DATA\Silgaram.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Silgaram_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.AHMED\MSSQL\DATA\Silgaram_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Silgaram] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Silgaram].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Silgaram] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Silgaram] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Silgaram] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Silgaram] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Silgaram] SET ARITHABORT OFF 
GO
ALTER DATABASE [Silgaram] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Silgaram] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Silgaram] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Silgaram] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Silgaram] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Silgaram] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Silgaram] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Silgaram] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Silgaram] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Silgaram] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Silgaram] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Silgaram] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Silgaram] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Silgaram] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Silgaram] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Silgaram] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Silgaram] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Silgaram] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Silgaram] SET  MULTI_USER 
GO
ALTER DATABASE [Silgaram] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Silgaram] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Silgaram] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Silgaram] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Silgaram] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Silgaram] SET QUERY_STORE = OFF
GO
USE [Silgaram]
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [Silgaram]
GO
/****** Object:  Table [dbo].[Addresses]    Script Date: 9/24/2018 4:57:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Addresses](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Street] [nvarchar](50) NULL,
	[PostalCode] [nvarchar](10) NULL,
	[FKCountry_Id] [int] NULL,
	[FkCity_Id] [int] NULL,
 CONSTRAINT [PK_Addresses] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AdFavorites]    Script Date: 9/24/2018 4:57:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdFavorites](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DateTime] [datetime] NOT NULL,
	[FkUser_Id] [int] NULL,
	[FKAd_Id] [int] NOT NULL,
 CONSTRAINT [PK_AdFavorites] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ads]    Script Date: 9/24/2018 4:57:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ads](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](1000) NOT NULL,
	[StartDateTime] [datetime] NULL,
	[EndDateTime] [datetime] NULL,
	[Price] [decimal](8, 2) NOT NULL,
	[IsTop] [bit] NOT NULL,
	[IsStarted] [bit] NOT NULL,
	[IsApprove] [bit] NOT NULL,
	[FkSubCategory_Id] [int] NULL,
	[FkCategory_Id] [int] NOT NULL,
	[FkAlbum_Id] [int] NOT NULL,
	[FkLog_Id] [int] NOT NULL,
	[FkUser_Id] [int] NOT NULL,
 CONSTRAINT [PK_Ads] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AlbumFiles]    Script Date: 9/24/2018 4:57:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AlbumFiles](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FkAlbum_Id] [int] NOT NULL,
	[FkFile_Id] [int] NOT NULL,
 CONSTRAINT [PK_AlbumFiles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Albums]    Script Date: 9/24/2018 4:57:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Albums](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Notes] [nvarchar](50) NULL,
 CONSTRAINT [PK_Albums] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AppsInformation]    Script Date: 9/24/2018 4:57:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppsInformation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Link] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_AppInformation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 9/24/2018 4:57:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[NameAr] [nvarchar](50) NOT NULL,
	[NameEn] [nvarchar](50) NOT NULL,
	[FkLog_Id] [int] NOT NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cities]    Script Date: 9/24/2018 4:57:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cities](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[NameAr] [nvarchar](50) NOT NULL,
	[NameEn] [nvarchar](50) NOT NULL,
	[FKCountry_Id] [int] NOT NULL,
	[FkLog_Id] [int] NOT NULL,
 CONSTRAINT [PK_Cities] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Countries]    Script Date: 9/24/2018 4:57:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Countries](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[NameAr] [nvarchar](50) NOT NULL,
	[NameEn] [nvarchar](50) NOT NULL,
	[FkLog_Id] [int] NOT NULL,
 CONSTRAINT [PK_Countries] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Files]    Script Date: 9/24/2018 4:57:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Files](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FileUrl] [nvarchar](150) NOT NULL,
	[FKAppInformation_Id] [int] NOT NULL,
	[FkFileType_Id] [int] NOT NULL,
 CONSTRAINT [PK_Images] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FileTypes]    Script Date: 9/24/2018 4:57:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FileTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ResourceName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_FileTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Genders]    Script Date: 9/24/2018 4:57:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Genders](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ResourceName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Genders] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Histories]    Script Date: 9/24/2018 4:57:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Histories](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DateTime] [datetime] NOT NULL,
	[RedirectUrl] [nvarchar](500) NULL,
	[FkState_Id] [int] NOT NULL,
	[FkUser_Id] [int] NOT NULL,
	[FKPage_Id] [int] NOT NULL,
	[FkLog_Id] [int] NULL,
	[TitelEn] [nvarchar](50) NOT NULL,
	[TitleAr] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Histories] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HistoryDetails]    Script Date: 9/24/2018 4:57:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HistoryDetails](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ColumResourceName] [nvarchar](50) NOT NULL,
	[ColumOldContent] [nvarchar](4000) NULL,
	[ColumNewContent] [nvarchar](4000) NULL,
	[FkHistory_Id] [int] NOT NULL,
	[CoulmIsSingl] [bit] NOT NULL,
	[CoulmIsEn] [bit] NOT NULL,
 CONSTRAINT [PK_HistoryDetails] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Jobs]    Script Date: 9/24/2018 4:57:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Jobs](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[NameAr] [nvarchar](50) NOT NULL,
	[NameEn] [nvarchar](50) NOT NULL,
	[FkLog_Id] [int] NOT NULL,
 CONSTRAINT [PK_Jobs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Languages]    Script Date: 9/24/2018 4:57:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Languages](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Notes] [nvarchar](50) NULL,
 CONSTRAINT [PK_Languages] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LanguageTypes]    Script Date: 9/24/2018 4:57:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LanguageTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ResourceName] [nvarchar](50) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_LanguageTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LanguageUsing]    Script Date: 9/24/2018 4:57:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LanguageUsing](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IsDefault] [bit] NOT NULL,
	[FKLanguageType_Id] [int] NOT NULL,
	[FKLanguage_Id] [int] NOT NULL,
 CONSTRAINT [PK_LanguageUsing] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Logs]    Script Date: 9/24/2018 4:57:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Logs](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Notes] [nvarchar](50) NULL,
 CONSTRAINT [PK_Logs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Menus]    Script Date: 9/24/2018 4:57:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Menus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderNumber] [int] NOT NULL,
	[ClassIcon] [nvarchar](50) NOT NULL,
	[ResourceName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Menu] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Nationalities]    Script Date: 9/24/2018 4:57:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Nationalities](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[NameAr] [nvarchar](50) NOT NULL,
	[NameEn] [nvarchar](50) NOT NULL,
	[FkLog_Id] [int] NOT NULL,
 CONSTRAINT [PK_Nationalities] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NotificationsIsRead]    Script Date: 9/24/2018 4:57:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NotificationsIsRead](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FkHistory_Id] [int] NOT NULL,
	[FKUser_Id] [int] NOT NULL,
 CONSTRAINT [PK_NotificationsIsRead] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OfferFavorites]    Script Date: 9/24/2018 4:57:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OfferFavorites](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DateTime] [datetime] NOT NULL,
	[FkUser_Id] [int] NOT NULL,
	[FKOffer_Id] [int] NOT NULL,
 CONSTRAINT [PK_OfferFavorites] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Offers]    Script Date: 9/24/2018 4:57:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Offers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](1000) NOT NULL,
	[StartDateTime] [datetime] NOT NULL,
	[EndDateTime] [datetime] NOT NULL,
	[Price] [decimal](8, 2) NOT NULL,
	[IsTop] [bit] NOT NULL,
	[FkAlbum_Id] [int] NOT NULL,
	[FkLog_Id] [int] NOT NULL,
	[FkUser_Id] [int] NOT NULL,
 CONSTRAINT [PK_Offers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pages]    Script Date: 9/24/2018 4:57:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pages](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ResourceName] [nvarchar](50) NOT NULL,
	[IsControlPanel] [bit] NOT NULL,
	[IsFronEnd] [bit] NOT NULL,
	[Url] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Pages] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PagesAllow]    Script Date: 9/24/2018 4:57:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PagesAllow](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IsAllowNotify] [bit] NOT NULL,
	[IsAllowLog] [bit] NOT NULL,
	[FkLog_Id] [int] NOT NULL,
	[FkPage_Id] [int] NOT NULL,
 CONSTRAINT [PK_PagesAllow] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PagesRoles]    Script Date: 9/24/2018 4:57:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PagesRoles](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IsDisplay] [bit] NOT NULL,
	[IsCreate] [bit] NOT NULL,
	[IsUpdate] [bit] NOT NULL,
	[IsDelete] [bit] NOT NULL,
	[FkPage_Id] [int] NOT NULL,
	[FkRole_Id] [int] NOT NULL,
	[FkPageRoleTypes_Id] [int] NOT NULL,
	[FkLog_Id] [int] NOT NULL,
 CONSTRAINT [PK_PagesRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PagesRoleTypes]    Script Date: 9/24/2018 4:57:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PagesRoleTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ResourceName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_PagesRoleTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhoneNumbers]    Script Date: 9/24/2018 4:57:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhoneNumbers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Number] [nvarchar](12) NOT NULL,
	[FKPhone_Id] [int] NOT NULL,
	[FkPhoneType_Id] [int] NOT NULL,
 CONSTRAINT [PK_PhoneNumbers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Phones]    Script Date: 9/24/2018 4:57:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Phones](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Notes] [nvarchar](50) NULL,
 CONSTRAINT [PK_Phones] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhoneTypes]    Script Date: 9/24/2018 4:57:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhoneTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ResourceName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_PhoneTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 9/24/2018 4:57:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ResourceName] [nvarchar](50) NOT NULL,
	[Notes] [nvarchar](500) NULL,
	[IsControlPanel] [bit] NOT NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocialStatus]    Script Date: 9/24/2018 4:57:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocialStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ResourceName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_SocialStatuses] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[States]    Script Date: 9/24/2018 4:57:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[States](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ResourceName] [nvarchar](50) NOT NULL,
	[CssClassStyle] [nvarchar](50) NOT NULL,
	[CssClassIcon] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_States] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SubCategories]    Script Date: 9/24/2018 4:57:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubCategories](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[NameAr] [nvarchar](50) NOT NULL,
	[NameEn] [nvarchar](50) NOT NULL,
	[FkLog_Id] [int] NOT NULL,
	[FkCategory_Id] [int] NOT NULL,
 CONSTRAINT [PK_SubCategories] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SubMenus]    Script Date: 9/24/2018 4:57:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubMenus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderNumber] [int] NOT NULL,
	[ClassIcon] [nvarchar](50) NOT NULL,
	[FkMenu_Id] [int] NOT NULL,
	[FKPage_Id] [int] NOT NULL,
 CONSTRAINT [PK_SubMenu] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TechnicalSupport]    Script Date: 9/24/2018 4:57:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TechnicalSupport](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Phone] [nvarchar](12) NOT NULL,
	[Message] [nvarchar](500) NOT NULL,
	[CreateDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_TechnicalSupport] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TechnicalSupportRead]    Script Date: 9/24/2018 4:57:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TechnicalSupportRead](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FkTechnicalSupport_Id] [int] NOT NULL,
	[FkUser_Id] [int] NOT NULL,
 CONSTRAINT [PK_TechnicalSupportRead] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserInformation]    Script Date: 9/24/2018 4:57:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserInformation](
	[Id] [int] NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[MediumName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[NationalId] [nvarchar](50) NULL,
	[BirthDate] [date] NULL,
	[FkImage_Id] [int] NOT NULL,
	[FKAddress_Id] [int] NULL,
	[FkNationality_Id] [int] NULL,
	[FKGender_Id] [int] NULL,
	[FKSocialStatus_Id] [int] NULL,
	[FKJob_Id] [int] NULL,
	[FKLanguage_Id] [int] NULL,
	[FkPhone_Id] [int] NULL,
 CONSTRAINT [PK_UserInformation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserLogins]    Script Date: 9/24/2018 4:57:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserLogins](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LoginDate] [datetime] NOT NULL,
	[IsSuccess] [bit] NOT NULL,
	[FkUser_Id] [int] NOT NULL,
 CONSTRAINT [PK_UserLogins] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRoles]    Script Date: 9/24/2018 4:57:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRoles](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FkUser_Id] [int] NOT NULL,
	[FkRole_Id] [int] NOT NULL,
 CONSTRAINT [PK_UserRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 9/24/2018 4:57:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[IsBlocked] [bit] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[Serial] [nvarchar](300) NOT NULL,
	[FkLog_Id] [int] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ViewerAds]    Script Date: 9/24/2018 4:57:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ViewerAds](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CountViewer] [bigint] NOT NULL,
	[FkUser_Id] [int] NULL,
	[FKAd_Id] [int] NOT NULL,
 CONSTRAINT [PK_AdViewer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ViewerOffers]    Script Date: 9/24/2018 4:57:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ViewerOffers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CountViewer] [bigint] NOT NULL,
	[FkUser_Id] [int] NULL,
	[FKOffer_Id] [int] NOT NULL,
 CONSTRAINT [PK_ViewerOffers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Addresses] ON 

INSERT [dbo].[Addresses] ([Id], [Street], [PostalCode], [FKCountry_Id], [FkCity_Id]) VALUES (1, N'28 Street Hmadey new test', N'12', 1, 19)
INSERT [dbo].[Addresses] ([Id], [Street], [PostalCode], [FKCountry_Id], [FkCity_Id]) VALUES (2, NULL, N'645', 1, 1)
INSERT [dbo].[Addresses] ([Id], [Street], [PostalCode], [FKCountry_Id], [FkCity_Id]) VALUES (3, NULL, NULL, NULL, NULL)
INSERT [dbo].[Addresses] ([Id], [Street], [PostalCode], [FKCountry_Id], [FkCity_Id]) VALUES (4, NULL, NULL, NULL, NULL)
INSERT [dbo].[Addresses] ([Id], [Street], [PostalCode], [FKCountry_Id], [FkCity_Id]) VALUES (5, NULL, NULL, NULL, NULL)
INSERT [dbo].[Addresses] ([Id], [Street], [PostalCode], [FKCountry_Id], [FkCity_Id]) VALUES (6, NULL, NULL, 2, NULL)
SET IDENTITY_INSERT [dbo].[Addresses] OFF
SET IDENTITY_INSERT [dbo].[Ads] ON 

INSERT [dbo].[Ads] ([Id], [Title], [Description], [StartDateTime], [EndDateTime], [Price], [IsTop], [IsStarted], [IsApprove], [FkSubCategory_Id], [FkCategory_Id], [FkAlbum_Id], [FkLog_Id], [FkUser_Id]) VALUES (1, N'اعلان الدياسطى', N'ads ads', CAST(N'2020-02-01T00:00:00.000' AS DateTime), CAST(N'2020-02-02T00:00:00.000' AS DateTime), CAST(500.00 AS Decimal(8, 2)), 1, 1, 1, 3, 3, 1, 236, 3)
SET IDENTITY_INSERT [dbo].[Ads] OFF
SET IDENTITY_INSERT [dbo].[AlbumFiles] ON 

INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (1, 1, 1)
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (11, 4, 12)
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (12, 4, 13)
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (13, 4, 14)
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (14, 4, 15)
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (15, 4, 16)
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (17, 5, 18)
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (20, 5, 21)
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (21, 5, 22)
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (22, 5, 23)
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (23, 5, 24)
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (24, 5, 25)
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (25, 7, 26)
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (27, 9, 31)
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (28, 9, 32)
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (29, 9, 33)
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (30, 9, 34)
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (31, 8, 35)
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (32, 8, 36)
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (33, 8, 37)
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (34, 8, 38)
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (35, 8, 39)
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (36, 10, 44)
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (37, 10, 45)
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (38, 10, 46)
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (39, 11, 47)
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (40, 11, 48)
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (41, 11, 49)
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (42, 11, 50)
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (43, 12, 51)
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (44, 12, 52)
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (45, 12, 53)
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (46, 12, 54)
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (47, 12, 55)
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (48, 13, 56)
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (51, 16, 59)
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (52, 16, 60)
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (55, 17, 63)
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (56, 17, 64)
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (57, 17, 65)
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (58, 17, 66)
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (62, 18, 70)
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (63, 18, 71)
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (64, 18, 72)
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (65, 18, 73)
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (66, 18, 74)
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (67, 18, 75)
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (68, 18, 76)
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (69, 18, 77)
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (70, 18, 78)
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (71, 17, 79)
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (72, 17, 80)
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (73, 17, 81)
SET IDENTITY_INSERT [dbo].[AlbumFiles] OFF
SET IDENTITY_INSERT [dbo].[Albums] ON 

INSERT [dbo].[Albums] ([Id], [Notes]) VALUES (1, NULL)
INSERT [dbo].[Albums] ([Id], [Notes]) VALUES (4, NULL)
INSERT [dbo].[Albums] ([Id], [Notes]) VALUES (5, NULL)
INSERT [dbo].[Albums] ([Id], [Notes]) VALUES (6, NULL)
INSERT [dbo].[Albums] ([Id], [Notes]) VALUES (7, NULL)
INSERT [dbo].[Albums] ([Id], [Notes]) VALUES (8, NULL)
INSERT [dbo].[Albums] ([Id], [Notes]) VALUES (9, NULL)
INSERT [dbo].[Albums] ([Id], [Notes]) VALUES (10, NULL)
INSERT [dbo].[Albums] ([Id], [Notes]) VALUES (11, NULL)
INSERT [dbo].[Albums] ([Id], [Notes]) VALUES (12, NULL)
INSERT [dbo].[Albums] ([Id], [Notes]) VALUES (13, NULL)
INSERT [dbo].[Albums] ([Id], [Notes]) VALUES (16, NULL)
INSERT [dbo].[Albums] ([Id], [Notes]) VALUES (17, NULL)
INSERT [dbo].[Albums] ([Id], [Notes]) VALUES (18, NULL)
SET IDENTITY_INSERT [dbo].[Albums] OFF
SET IDENTITY_INSERT [dbo].[AppsInformation] ON 

INSERT [dbo].[AppsInformation] ([Id], [Name], [Link]) VALUES (1, N'ControllPanel', N'http://localhost:53913/')
INSERT [dbo].[AppsInformation] ([Id], [Name], [Link]) VALUES (2, N'Api', N'http://localhost:50353/')
SET IDENTITY_INSERT [dbo].[AppsInformation] OFF
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([Id], [NameAr], [NameEn], [FkLog_Id]) VALUES (1, N'ملابس', N'Clothes', 203)
INSERT [dbo].[Categories] ([Id], [NameAr], [NameEn], [FkLog_Id]) VALUES (3, N'عقارات', N'Real estate', 205)
INSERT [dbo].[Categories] ([Id], [NameAr], [NameEn], [FkLog_Id]) VALUES (4, N'مركبات', N'Vehicles', 218)
SET IDENTITY_INSERT [dbo].[Categories] OFF
SET IDENTITY_INSERT [dbo].[Cities] ON 

INSERT [dbo].[Cities] ([Id], [NameAr], [NameEn], [FKCountry_Id], [FkLog_Id]) VALUES (1, N'القاهرة', N'Cairo', 1, 2)
INSERT [dbo].[Cities] ([Id], [NameAr], [NameEn], [FKCountry_Id], [FkLog_Id]) VALUES (18, N'المنصورة', N'Mansoura', 1, 29)
INSERT [dbo].[Cities] ([Id], [NameAr], [NameEn], [FKCountry_Id], [FkLog_Id]) VALUES (19, N'الاسكندرية', N'Alx', 1, 30)
SET IDENTITY_INSERT [dbo].[Cities] OFF
SET IDENTITY_INSERT [dbo].[Countries] ON 

INSERT [dbo].[Countries] ([Id], [NameAr], [NameEn], [FkLog_Id]) VALUES (1, N'sd', N'sd5', 1)
INSERT [dbo].[Countries] ([Id], [NameAr], [NameEn], [FkLog_Id]) VALUES (2, N'الكوست', N'Kwit', 31)
SET IDENTITY_INSERT [dbo].[Countries] OFF
SET IDENTITY_INSERT [dbo].[Files] ON 

INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (1, N'/Files/Images/Users/Profile/Prifile2.png2001640584.png', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (2, N'/Files/Images/Users/Profile/2013-04-20-056.jpg1710883803.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (3, N'/Files/Images/Products12.jpg133553739.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (4, N'/Files/Images/Products2013-04-18-005.jpg1620502976.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (5, N'/Files/Images/Products2013-04-18-008.jpg676717047.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (6, N'/Files/Images/Products2013-04-18-031.jpg257561010.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (7, N'/Files/Images/Products2013-04-18-018.jpg1821788483.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (8, N'/Files/Images/Products2013-04-18-031.jpg1719321017.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (9, N'/Files/Images/Products309533_175924209157228_1171723283_n.jpg1719321017.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (10, N'/Files/Images/Products2013-04-19-049.jpg110481015.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (11, N'/Files/Images/Products574671_423296531086660_623817755_n.jpg461852906.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (12, N'/Files/Images/Products2013-04-18-038.jpg2131060694.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (13, N'/Files/Images/Products2013-04-20-057.jpg334948938.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (14, N'/Files/Images/Products2013-04-18-031.jpg334948938.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (15, N'/Files/Images/Products2013-04-18-037.jpg1711904657.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (16, N'/Files/Images/Products2013-04-18-032.jpg103064655.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (18, N'/Files/Images/Products531038_384620164954297_319905800_n.jpg39438179.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (21, N'/Files/Images/Products2013-04-19-045.jpg1861438131.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (22, N'/Files/Images/Products2013-04-18-038.jpg338174276.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (23, N'/Files/Images/Products2013-04-18-031.jpg338174276.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (24, N'/Files/Images/Products2013-04-18-037.jpg1715129995.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (25, N'/Files/Images/Products2013-04-18-032.jpg944602067.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (26, N'/Files/Images/Products2013-04-18-008.jpg1859443628.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (27, N'~/Files/Images/Users/Profile/userDefult.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (28, N'~/Files/Images/Users/Profile/userDefult.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (29, N'~/Files/Images/Users/Profile/userDefult.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (31, N'/Files/Images/Products2013-04-18-005.jpg123537471.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (32, N'/Files/Images/Products2013-04-18-008.jpg123537471.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (33, N'/Files/Images/Products2013-04-18-031.jpg310809225.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (34, N'/Files/Images/Products2013-04-18-032.jpg310809225.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (35, N'/Files/Images/Products5.jpg1182994235.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (36, N'/Files/Images/Products3.jpg1182994235.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (37, N'/Files/Images/Products4.jpg1534366126.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (38, N'/Files/Images/Products6.jpg1534366126.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (39, N'/Files/Images/Products7.jpg1534366126.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (43, N'~/Files/Images/Users/Profile/userDefult.jpg', 2, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (44, N'/Files/Images/Products1.jpg478824495.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (45, N'/Files/Images/Products2.jpg523437024.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (46, N'/Files/Images/Products3.jpg523437024.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (47, N'/Files/Images/Products1.jpg1109421782.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (48, N'/Files/Images/Products2.jpg1879949710.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (49, N'/Files/Images/Products4.jpg1879949710.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (50, N'/Files/Images/Products3.jpg1528577819.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (51, N'/Files/Images/Products9_1.jpg1242339042.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (52, N'/Files/Images/Products11_2.jpg1242339042.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (53, N'/Files/Images/Products12_1.jpg1242339042.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (54, N'/Files/Images/Products8-1.jpg2012866970.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (55, N'/Files/Images/Products10_2.jpg284539360.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (56, N'/Files/Images/Products3-المجاملات.jpg1134500806.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (59, N'/Files/Images/Products1_2.jpg1174746056.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (60, N'/Files/Images/Offers9.jpg88721010.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (63, N'/Files/Images/Offers05_5.jpg1520483526.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (64, N'/Files/Images/Offers01_8.jpg1649465224.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (65, N'/Files/Images/Offers7.jpg1298093333.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (66, N'/Files/Images/Offers5.jpg340293651.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (70, N'/Files/Images/Offers5.jpg2136419628.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (71, N'/Files/Images/Offers05_5.jpg408092018.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (72, N'/Files/Images/Offers07_5.jpg1949147874.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (73, N'/Files/Images/Offers13.jpg1949147874.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (74, N'/Files/Images/Offers23.jpg1597775983.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (75, N'/Files/Images/Offers12.jpg220820264.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (76, N'/Files/Images/Offers21.jpg639976301.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (77, N'/Files/Images/Offers22.jpg639976301.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (78, N'/Files/Images/Offers11_1.jpg1410504229.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (79, N'/Files/Images/Offers8.jpg819622345.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (80, N'/Files/Images/Offers11_1.jpg489809904.jpg', 1, 1)
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (81, N'/Files/Images/Offers23.jpg1679493869.jpg', 1, 1)
SET IDENTITY_INSERT [dbo].[Files] OFF
SET IDENTITY_INSERT [dbo].[FileTypes] ON 

INSERT [dbo].[FileTypes] ([Id], [ResourceName]) VALUES (1, N'Image')
INSERT [dbo].[FileTypes] ([Id], [ResourceName]) VALUES (2, N'Text')
INSERT [dbo].[FileTypes] ([Id], [ResourceName]) VALUES (3, N'Audio')
SET IDENTITY_INSERT [dbo].[FileTypes] OFF
SET IDENTITY_INSERT [dbo].[Genders] ON 

INSERT [dbo].[Genders] ([Id], [ResourceName]) VALUES (1, N'Male')
INSERT [dbo].[Genders] ([Id], [ResourceName]) VALUES (2, N'Female')
SET IDENTITY_INSERT [dbo].[Genders] OFF
SET IDENTITY_INSERT [dbo].[Histories] ON 

INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitelEn], [TitleAr]) VALUES (62, CAST(N'2018-08-29T21:43:30.787' AS DateTime), NULL, 2, 1, 1, 29, N'Test', N'تجربة')
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitelEn], [TitleAr]) VALUES (63, CAST(N'2018-08-29T21:45:43.793' AS DateTime), NULL, 2, 1, 1, 29, N'Test', N'تجربة')
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitelEn], [TitleAr]) VALUES (111, CAST(N'2018-09-16T00:16:26.573' AS DateTime), NULL, 1, 1, 19, 203, N'Test', N'تجربة')
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitelEn], [TitleAr]) VALUES (112, CAST(N'2018-09-16T00:16:42.780' AS DateTime), NULL, 2, 1, 19, 1, N'Test', N'تجربة')
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitelEn], [TitleAr]) VALUES (114, CAST(N'2018-09-16T00:16:53.407' AS DateTime), NULL, 3, 1, 19, NULL, N'Test', N'تجربة')
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitelEn], [TitleAr]) VALUES (115, CAST(N'2018-09-16T00:16:53.483' AS DateTime), NULL, 1, 1, 19, 205, N'Test', N'تجربة')
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitelEn], [TitleAr]) VALUES (116, CAST(N'2018-09-16T00:46:34.340' AS DateTime), NULL, 1, 1, 19, 218, N'Test', N'تجربة')
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitelEn], [TitleAr]) VALUES (117, CAST(N'2018-09-16T00:50:53.443' AS DateTime), NULL, 2, 1, 19, 203, N'Test', N'تجربة')
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitelEn], [TitleAr]) VALUES (118, CAST(N'2018-09-16T00:50:57.000' AS DateTime), NULL, 2, 1, 19, 205, N'Test', N'تجربة')
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitelEn], [TitleAr]) VALUES (119, CAST(N'2018-09-16T00:50:57.927' AS DateTime), NULL, 2, 1, 19, 218, N'Test', N'تجربة')
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitelEn], [TitleAr]) VALUES (120, CAST(N'2018-09-16T01:23:18.157' AS DateTime), NULL, 1, 1, 20, 219, N'Test', N'تجربة')
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitelEn], [TitleAr]) VALUES (122, CAST(N'2018-09-16T01:23:25.543' AS DateTime), NULL, 3, 1, 20, NULL, N'Test', N'تجربة')
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitelEn], [TitleAr]) VALUES (123, CAST(N'2018-09-16T01:23:36.353' AS DateTime), NULL, 2, 1, 20, 219, N'Test', N'تجربة')
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitelEn], [TitleAr]) VALUES (124, CAST(N'2018-09-16T01:26:27.213' AS DateTime), NULL, 2, 1, 20, 219, N'Test', N'تجربة')
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitelEn], [TitleAr]) VALUES (125, CAST(N'2018-09-16T01:26:27.233' AS DateTime), NULL, 1, 1, 20, 221, N'Test', N'تجربة')
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitelEn], [TitleAr]) VALUES (126, CAST(N'2018-09-16T01:26:27.240' AS DateTime), NULL, 1, 1, 20, 222, N'Test', N'تجربة')
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitelEn], [TitleAr]) VALUES (127, CAST(N'2018-09-16T01:33:26.127' AS DateTime), NULL, 1, 1, 20, 223, N'Test', N'تجربة')
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitelEn], [TitleAr]) VALUES (128, CAST(N'2018-09-16T01:33:26.137' AS DateTime), NULL, 1, 1, 20, 224, N'Test', N'تجربة')
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitelEn], [TitleAr]) VALUES (129, CAST(N'2018-09-16T01:33:26.137' AS DateTime), NULL, 1, 1, 20, 236, N'Test', N'تجربة')
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitelEn], [TitleAr]) VALUES (130, CAST(N'2018-09-16T05:02:10.993' AS DateTime), NULL, 2, 1, 21, 236, N'Test', N'تجربة')
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitelEn], [TitleAr]) VALUES (131, CAST(N'2018-09-16T05:02:35.440' AS DateTime), NULL, 2, 1, 21, 236, N'Test', N'تجربة')
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitelEn], [TitleAr]) VALUES (132, CAST(N'2018-09-16T05:02:40.167' AS DateTime), NULL, 2, 1, 21, 236, N'Test', N'تجربة')
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitelEn], [TitleAr]) VALUES (133, CAST(N'2018-09-16T22:10:51.830' AS DateTime), NULL, 2, 1, 21, 236, N'Test', N'تجربة')
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitelEn], [TitleAr]) VALUES (134, CAST(N'2018-09-16T22:12:47.620' AS DateTime), NULL, 2, 1, 21, 236, N'Test', N'تجربة')
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitelEn], [TitleAr]) VALUES (135, CAST(N'2018-09-16T22:14:51.200' AS DateTime), NULL, 2, 1, 21, 236, N'Test', N'تجربة')
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitelEn], [TitleAr]) VALUES (136, CAST(N'2018-09-19T15:41:23.690' AS DateTime), NULL, 2, 1, 21, 236, N'Test', N'تجربة')
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitelEn], [TitleAr]) VALUES (137, CAST(N'2018-09-19T15:41:23.707' AS DateTime), NULL, 4, 1, 21, 236, N'Test', N'تجربة')
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitelEn], [TitleAr]) VALUES (138, CAST(N'2018-09-19T15:42:21.690' AS DateTime), NULL, 2, 1, 21, 236, N'Test', N'تجربة')
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitelEn], [TitleAr]) VALUES (139, CAST(N'2018-09-19T17:26:50.067' AS DateTime), NULL, 2, 1, 21, 236, N'اعلان الدياسطى', N'اعلان الدياسطى')
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitelEn], [TitleAr]) VALUES (140, CAST(N'2018-09-19T17:26:50.073' AS DateTime), NULL, 5, 1, 21, 236, N'اعلان الدياسطى', N'اعلان الدياسطى')
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitelEn], [TitleAr]) VALUES (145, CAST(N'2018-09-24T01:50:13.147' AS DateTime), NULL, 1, 1, 21, 250, N'sdsdsd', N'sdsdsd')
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitelEn], [TitleAr]) VALUES (146, CAST(N'2018-09-24T01:50:39.803' AS DateTime), NULL, 2, 1, 21, 250, N'sdsdsd', N'sdsdsd')
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitelEn], [TitleAr]) VALUES (147, CAST(N'2018-09-24T01:54:41.060' AS DateTime), NULL, 3, 1, 20, NULL, N'dsdDSDS', N'dsdDSDS')
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitelEn], [TitleAr]) VALUES (148, CAST(N'2018-09-24T14:40:36.360' AS DateTime), NULL, 1, 1, 21, 251, N'new test offer', N'new test offer')
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitelEn], [TitleAr]) VALUES (149, CAST(N'2018-09-24T14:40:51.060' AS DateTime), NULL, 2, 1, 21, 251, N'new test offer', N'new test offer')
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitelEn], [TitleAr]) VALUES (150, CAST(N'2018-09-24T14:41:02.017' AS DateTime), NULL, 2, 1, 21, 251, N'new test offer', N'new test offer')
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitelEn], [TitleAr]) VALUES (151, CAST(N'2018-09-24T14:41:11.827' AS DateTime), NULL, 2, 1, 21, 251, N'new test offer', N'new test offer')
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitelEn], [TitleAr]) VALUES (152, CAST(N'2018-09-24T14:42:59.667' AS DateTime), NULL, 2, 1, 21, 251, N'new test offer', N'new test offer')
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitelEn], [TitleAr]) VALUES (153, CAST(N'2018-09-24T14:43:36.190' AS DateTime), NULL, 2, 1, 21, 251, N'new test offer', N'new test offer')
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitelEn], [TitleAr]) VALUES (154, CAST(N'2018-09-24T14:44:07.013' AS DateTime), NULL, 2, 1, 21, 251, N'new test offer', N'new test offer')
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitelEn], [TitleAr]) VALUES (155, CAST(N'2018-09-24T14:51:57.103' AS DateTime), NULL, 2, 1, 21, 250, N'sdsdsd', N'sdsdsd')
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitelEn], [TitleAr]) VALUES (156, CAST(N'2018-09-24T14:52:09.807' AS DateTime), NULL, 2, 1, 21, 250, N'sdsdsd', N'sdsdsd')
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitelEn], [TitleAr]) VALUES (157, CAST(N'2018-09-24T14:52:28.717' AS DateTime), NULL, 2, 1, 21, 250, N'sdsdsd', N'sdsdsd')
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitelEn], [TitleAr]) VALUES (158, CAST(N'2018-09-24T14:54:51.677' AS DateTime), NULL, 2, 1, 21, 250, N'sdsdsd', N'sdsdsd')
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitelEn], [TitleAr]) VALUES (159, CAST(N'2018-09-24T14:57:22.493' AS DateTime), NULL, 2, 1, 21, 250, N'sdsdsd', N'sdsdsd')
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitelEn], [TitleAr]) VALUES (160, CAST(N'2018-09-24T14:57:40.790' AS DateTime), NULL, 2, 1, 21, 250, N'sdsdsd', N'sdsdsd')
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitelEn], [TitleAr]) VALUES (161, CAST(N'2018-09-24T14:57:53.320' AS DateTime), NULL, 2, 1, 21, 250, N'sdsdsd', N'sdsdsd')
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitelEn], [TitleAr]) VALUES (162, CAST(N'2018-09-24T14:58:14.127' AS DateTime), NULL, 2, 1, 21, 250, N'sdsdsd', N'sdsdsd')
SET IDENTITY_INSERT [dbo].[Histories] OFF
SET IDENTITY_INSERT [dbo].[HistoryDetails] ON 

INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (219, N'NameAr', NULL, N'sd', 111, 0, 0)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (220, N'NameEn', NULL, N'sd', 111, 0, 1)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (221, N'NameAr', N'sd', N'مصر', 112, 0, 0)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (222, N'NameEn', N'sd5', N'Egypt', 112, 0, 1)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (225, N'NameAr', NULL, N'sd0', 114, 0, 0)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (226, N'NameEn', NULL, N'sddsd', 114, 0, 1)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (227, N'NameAr', NULL, N'dsd', 115, 0, 0)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (228, N'NameEn', NULL, N'ss', 115, 0, 1)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (229, N'NameAr', NULL, N'x', 116, 0, 0)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (230, N'NameEn', NULL, N's', 116, 0, 1)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (231, N'NameAr', N'ملابس', N'sd', 117, 0, 0)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (232, N'NameEn', N'Clothes', N'sd', 117, 0, 1)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (233, N'NameAr', N'عقارات', N'dsd', 118, 0, 0)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (234, N'NameEn', N'Real estate', N'ss', 118, 0, 1)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (235, N'NameAr', N'مركبات', N'x', 119, 0, 0)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (236, N'NameEn', N'Vehicles', N's', 119, 0, 1)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (237, N'NameAr', NULL, N'sd', 120, 0, 0)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (238, N'NameEn', NULL, N'dsds', 120, 0, 1)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (241, N'NameAr', NULL, N'sa', 122, 0, 0)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (242, N'NameEn', NULL, N'ds', 122, 0, 1)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (243, N'NameAr', N'sd2', N'sd', 123, 0, 0)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (244, N'NameEn', N'dsdsw', N'dsds', 123, 0, 1)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (245, N'NameAr', N'دفع رباعى', N'sd2', 124, 0, 0)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (246, N'NameEn', N'4wd', N'dsdsw', 124, 0, 1)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (247, N'NameAr', NULL, N'دراجة نارية', 125, 0, 0)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (248, N'NameEn', NULL, N'Motorcycle', 125, 0, 1)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (249, N'NameAr', NULL, N'دراجة هوائية', 126, 0, 0)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (250, N'NameEn', NULL, N'Bicycles', 126, 0, 1)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (251, N'NameAr', NULL, N'منازل', 127, 0, 0)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (252, N'NameEn', NULL, N'Houses', 127, 0, 1)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (253, N'NameAr', NULL, N'شقق سكنية', 128, 0, 0)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (254, N'NameEn', NULL, N'Apartment', 128, 0, 1)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (255, N'StartDateTime', N'01/01/2010 12:00:00 AM', N'01/02/2020 12:00:00 AM', 130, 1, 0)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (256, N'EndDateTime', N'01/01/2010 12:00:00 AM', N'02/02/2020 12:00:00 AM', 130, 1, 0)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (257, N'IsApprove', N'True', N'False', 130, 1, 0)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (258, N'Title', N'ahmed', N'ads', 131, 1, 0)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (259, N'Description', N'ahmed description', N'ads ads', 131, 1, 0)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (260, N'IsApprove', N'False', N'True', 132, 1, 0)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (261, N'Title', NULL, N'ads00', 133, 1, 0)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (262, N'Title', N'ads', N'ads00', 133, 1, 0)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (263, N'Title', NULL, N'اعلان تجربة', 134, 1, 0)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (264, N'Title', N'ads00', N'اعلان تجربة', 134, 1, 0)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (265, N'Title', N'اعلان تجربة', N'اعلان الدياسطى', 135, 1, 0)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (266, N'IsApprove', N'True', N'False', 136, 1, 0)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (267, N'IsApprove', N'True', N'False', 137, 1, 0)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (268, N'Id', NULL, NULL, 139, 1, 0)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (269, N'Id', NULL, N'1', 139, 1, 0)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (270, N'IsApprove', N'False', N'True', 139, 1, 0)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (271, N'Id', NULL, NULL, 140, 1, 0)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (272, N'Id', NULL, N'1', 140, 1, 0)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (273, N'IsApprove', N'False', N'True', 140, 1, 0)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (286, N'Title', NULL, N'sdsdsd', 145, 1, 0)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (287, N'Description', NULL, N'ssdsd', 145, 1, 0)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (288, N'IsTop', NULL, N'False', 145, 1, 0)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (289, N'Price', NULL, N'20', 145, 1, 0)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (290, N'Id', NULL, NULL, 146, 1, 0)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (291, N'Id', NULL, N'4', 146, 1, 0)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (292, N'Description', N'ssdsd', N'000ssdsd', 146, 1, 0)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (293, N'Id', NULL, N'3', 147, 1, 0)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (294, N'NameAr', NULL, N'dsdDSDS', 147, 1, 0)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (295, N'NameEn', NULL, N'DSD', 147, 1, 0)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (296, N'Title', NULL, N'new test offer', 148, 1, 0)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (297, N'Description', NULL, N'fdfncvmvmkjjfkgj', 148, 1, 0)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (298, N'IsTop', NULL, N'False', 148, 1, 0)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (299, N'Price', NULL, N'500', 148, 1, 0)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (300, N'Id', NULL, NULL, 149, 1, 0)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (301, N'Id', NULL, N'5', 149, 1, 0)
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (302, N'Description', N'fdfncvmvmkjjfkgj', N'test update', 149, 1, 0)
SET IDENTITY_INSERT [dbo].[HistoryDetails] OFF
SET IDENTITY_INSERT [dbo].[Jobs] ON 

INSERT [dbo].[Jobs] ([Id], [NameAr], [NameEn], [FkLog_Id]) VALUES (1, N'مطور', N'Developer', 4)
INSERT [dbo].[Jobs] ([Id], [NameAr], [NameEn], [FkLog_Id]) VALUES (4, N'محاسب', N'Account', 35)
SET IDENTITY_INSERT [dbo].[Jobs] OFF
SET IDENTITY_INSERT [dbo].[Languages] ON 

INSERT [dbo].[Languages] ([Id], [Notes]) VALUES (1, N'')
INSERT [dbo].[Languages] ([Id], [Notes]) VALUES (2, NULL)
INSERT [dbo].[Languages] ([Id], [Notes]) VALUES (3, NULL)
INSERT [dbo].[Languages] ([Id], [Notes]) VALUES (4, NULL)
INSERT [dbo].[Languages] ([Id], [Notes]) VALUES (5, NULL)
SET IDENTITY_INSERT [dbo].[Languages] OFF
SET IDENTITY_INSERT [dbo].[LanguageTypes] ON 

INSERT [dbo].[LanguageTypes] ([Id], [ResourceName], [Code]) VALUES (1, N'Arabic', N'ar')
INSERT [dbo].[LanguageTypes] ([Id], [ResourceName], [Code]) VALUES (2, N'English', N'en')
SET IDENTITY_INSERT [dbo].[LanguageTypes] OFF
SET IDENTITY_INSERT [dbo].[LanguageUsing] ON 

INSERT [dbo].[LanguageUsing] ([Id], [IsDefault], [FKLanguageType_Id], [FKLanguage_Id]) VALUES (1, 1, 2, 1)
INSERT [dbo].[LanguageUsing] ([Id], [IsDefault], [FKLanguageType_Id], [FKLanguage_Id]) VALUES (3, 0, 1, 1)
INSERT [dbo].[LanguageUsing] ([Id], [IsDefault], [FKLanguageType_Id], [FKLanguage_Id]) VALUES (4, 1, 2, 2)
SET IDENTITY_INSERT [dbo].[LanguageUsing] OFF
SET IDENTITY_INSERT [dbo].[Logs] ON 

INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (1, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (2, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (4, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (5, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (6, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (7, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (8, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (9, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (10, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (29, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (30, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (31, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (35, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (36, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (37, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (38, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (39, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (40, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (41, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (42, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (43, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (44, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (45, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (46, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (47, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (48, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (49, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (50, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (60, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (61, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (62, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (63, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (64, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (65, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (66, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (67, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (68, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (69, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (70, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (71, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (72, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (73, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (74, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (75, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (76, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (77, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (78, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (79, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (80, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (81, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (82, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (83, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (84, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (85, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (86, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (87, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (88, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (96, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (97, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (98, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (100, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (101, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (102, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (103, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (105, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (106, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (107, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (124, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (126, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (128, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (177, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (178, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (179, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (180, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (181, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (182, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (183, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (186, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (187, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (193, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (194, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (195, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (196, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (197, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (198, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (199, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (200, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (201, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (202, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (203, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (205, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (208, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (209, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (210, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (211, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (212, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (213, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (214, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (215, NULL)
GO
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (216, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (217, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (218, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (219, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (221, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (222, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (223, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (224, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (225, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (226, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (227, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (228, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (229, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (230, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (231, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (232, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (233, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (234, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (236, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (237, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (238, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (239, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (240, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (241, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (242, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (243, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (244, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (245, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (246, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (250, NULL)
INSERT [dbo].[Logs] ([Id], [Notes]) VALUES (251, NULL)
SET IDENTITY_INSERT [dbo].[Logs] OFF
SET IDENTITY_INSERT [dbo].[Menus] ON 

INSERT [dbo].[Menus] ([Id], [OrderNumber], [ClassIcon], [ResourceName]) VALUES (1, 1, N'far fa-hand-point-right', N'Setting')
INSERT [dbo].[Menus] ([Id], [OrderNumber], [ClassIcon], [ResourceName]) VALUES (2, 3, N'far fa-hand-point-right', N'Users')
INSERT [dbo].[Menus] ([Id], [OrderNumber], [ClassIcon], [ResourceName]) VALUES (7, 4, N'far fa-hand-point-right', N'TechnicalSupport')
INSERT [dbo].[Menus] ([Id], [OrderNumber], [ClassIcon], [ResourceName]) VALUES (8, 2, N'far fa-hand-point-right', N'Categories')
INSERT [dbo].[Menus] ([Id], [OrderNumber], [ClassIcon], [ResourceName]) VALUES (9, 5, N'far fa-hand-point-right', N'Ads')
INSERT [dbo].[Menus] ([Id], [OrderNumber], [ClassIcon], [ResourceName]) VALUES (10, 6, N'far fa-hand-point-right', N'Offers')
SET IDENTITY_INSERT [dbo].[Menus] OFF
SET IDENTITY_INSERT [dbo].[Nationalities] ON 

INSERT [dbo].[Nationalities] ([Id], [NameAr], [NameEn], [FkLog_Id]) VALUES (1, N'مصرى', N'Egeiption', 5)
INSERT [dbo].[Nationalities] ([Id], [NameAr], [NameEn], [FkLog_Id]) VALUES (2, N'سعودى', N'Saudi', 96)
INSERT [dbo].[Nationalities] ([Id], [NameAr], [NameEn], [FkLog_Id]) VALUES (3, N'كويتى', N'Kuwaiti', 97)
SET IDENTITY_INSERT [dbo].[Nationalities] OFF
SET IDENTITY_INSERT [dbo].[NotificationsIsRead] ON 

INSERT [dbo].[NotificationsIsRead] ([Id], [FkHistory_Id], [FKUser_Id]) VALUES (18, 135, 1)
INSERT [dbo].[NotificationsIsRead] ([Id], [FkHistory_Id], [FKUser_Id]) VALUES (19, 140, 1)
INSERT [dbo].[NotificationsIsRead] ([Id], [FkHistory_Id], [FKUser_Id]) VALUES (20, 139, 1)
SET IDENTITY_INSERT [dbo].[NotificationsIsRead] OFF
SET IDENTITY_INSERT [dbo].[Offers] ON 

INSERT [dbo].[Offers] ([Id], [Title], [Description], [StartDateTime], [EndDateTime], [Price], [IsTop], [FkAlbum_Id], [FkLog_Id], [FkUser_Id]) VALUES (4, N'sdsdsd', N'000ssdsd', CAST(N'2018-09-24T05:00:00.000' AS DateTime), CAST(N'2018-10-20T01:00:00.000' AS DateTime), CAST(20.00 AS Decimal(8, 2)), 0, 17, 250, 1)
INSERT [dbo].[Offers] ([Id], [Title], [Description], [StartDateTime], [EndDateTime], [Price], [IsTop], [FkAlbum_Id], [FkLog_Id], [FkUser_Id]) VALUES (5, N'new test offer', N'test update', CAST(N'2018-09-24T19:00:00.000' AS DateTime), CAST(N'2021-03-03T01:00:00.000' AS DateTime), CAST(500.00 AS Decimal(8, 2)), 0, 18, 251, 1)
SET IDENTITY_INSERT [dbo].[Offers] OFF
SET IDENTITY_INSERT [dbo].[Pages] ON 

INSERT [dbo].[Pages] ([Id], [ResourceName], [IsControlPanel], [IsFronEnd], [Url]) VALUES (1, N'Cities', 1, 0, N'Cities')
INSERT [dbo].[Pages] ([Id], [ResourceName], [IsControlPanel], [IsFronEnd], [Url]) VALUES (2, N'Users', 1, 0, N'Users')
INSERT [dbo].[Pages] ([Id], [ResourceName], [IsControlPanel], [IsFronEnd], [Url]) VALUES (3, N'Jobs', 1, 0, N'Jobs')
INSERT [dbo].[Pages] ([Id], [ResourceName], [IsControlPanel], [IsFronEnd], [Url]) VALUES (4, N'Countries', 1, 0, N'Countries')
INSERT [dbo].[Pages] ([Id], [ResourceName], [IsControlPanel], [IsFronEnd], [Url]) VALUES (5, N'PagesAllow', 1, 0, N'PagesAllow')
INSERT [dbo].[Pages] ([Id], [ResourceName], [IsControlPanel], [IsFronEnd], [Url]) VALUES (6, N'PagesRoles', 1, 0, N'PagesRoles')
INSERT [dbo].[Pages] ([Id], [ResourceName], [IsControlPanel], [IsFronEnd], [Url]) VALUES (7, N'Nationalities', 1, 0, N'Nationalities')
INSERT [dbo].[Pages] ([Id], [ResourceName], [IsControlPanel], [IsFronEnd], [Url]) VALUES (8, N'UserLogins', 1, 0, N'UserLogins')
INSERT [dbo].[Pages] ([Id], [ResourceName], [IsControlPanel], [IsFronEnd], [Url]) VALUES (9, N'Notifications', 1, 0, N'Notifications')
INSERT [dbo].[Pages] ([Id], [ResourceName], [IsControlPanel], [IsFronEnd], [Url]) VALUES (16, N'TechnicalSupport', 1, 0, N'TechnicalSupport')
INSERT [dbo].[Pages] ([Id], [ResourceName], [IsControlPanel], [IsFronEnd], [Url]) VALUES (17, N'Menus', 1, 0, N'Menus')
INSERT [dbo].[Pages] ([Id], [ResourceName], [IsControlPanel], [IsFronEnd], [Url]) VALUES (18, N'SubMenus', 1, 0, N'SubMenus')
INSERT [dbo].[Pages] ([Id], [ResourceName], [IsControlPanel], [IsFronEnd], [Url]) VALUES (19, N'Categories', 1, 0, N'Categories')
INSERT [dbo].[Pages] ([Id], [ResourceName], [IsControlPanel], [IsFronEnd], [Url]) VALUES (20, N'SubCategories', 1, 0, N'SubCategories')
INSERT [dbo].[Pages] ([Id], [ResourceName], [IsControlPanel], [IsFronEnd], [Url]) VALUES (21, N'Ads', 1, 1, N'Ads')
INSERT [dbo].[Pages] ([Id], [ResourceName], [IsControlPanel], [IsFronEnd], [Url]) VALUES (22, N'Offers', 1, 0, N'Offers')
SET IDENTITY_INSERT [dbo].[Pages] OFF
SET IDENTITY_INSERT [dbo].[PagesAllow] ON 

INSERT [dbo].[PagesAllow] ([Id], [IsAllowNotify], [IsAllowLog], [FkLog_Id], [FkPage_Id]) VALUES (1, 1, 1, 6, 1)
INSERT [dbo].[PagesAllow] ([Id], [IsAllowNotify], [IsAllowLog], [FkLog_Id], [FkPage_Id]) VALUES (2, 1, 1, 7, 2)
INSERT [dbo].[PagesAllow] ([Id], [IsAllowNotify], [IsAllowLog], [FkLog_Id], [FkPage_Id]) VALUES (3, 1, 1, 8, 3)
INSERT [dbo].[PagesAllow] ([Id], [IsAllowNotify], [IsAllowLog], [FkLog_Id], [FkPage_Id]) VALUES (4, 1, 1, 9, 4)
INSERT [dbo].[PagesAllow] ([Id], [IsAllowNotify], [IsAllowLog], [FkLog_Id], [FkPage_Id]) VALUES (5, 1, 1, 10, 5)
INSERT [dbo].[PagesAllow] ([Id], [IsAllowNotify], [IsAllowLog], [FkLog_Id], [FkPage_Id]) VALUES (6, 1, 1, 36, 6)
INSERT [dbo].[PagesAllow] ([Id], [IsAllowNotify], [IsAllowLog], [FkLog_Id], [FkPage_Id]) VALUES (7, 1, 1, 88, 7)
INSERT [dbo].[PagesAllow] ([Id], [IsAllowNotify], [IsAllowLog], [FkLog_Id], [FkPage_Id]) VALUES (9, 1, 1, 107, 9)
INSERT [dbo].[PagesAllow] ([Id], [IsAllowNotify], [IsAllowLog], [FkLog_Id], [FkPage_Id]) VALUES (16, 1, 1, 177, 16)
INSERT [dbo].[PagesAllow] ([Id], [IsAllowNotify], [IsAllowLog], [FkLog_Id], [FkPage_Id]) VALUES (17, 1, 1, 202, 19)
INSERT [dbo].[PagesAllow] ([Id], [IsAllowNotify], [IsAllowLog], [FkLog_Id], [FkPage_Id]) VALUES (18, 1, 1, 208, 20)
INSERT [dbo].[PagesAllow] ([Id], [IsAllowNotify], [IsAllowLog], [FkLog_Id], [FkPage_Id]) VALUES (19, 1, 1, 234, 21)
INSERT [dbo].[PagesAllow] ([Id], [IsAllowNotify], [IsAllowLog], [FkLog_Id], [FkPage_Id]) VALUES (20, 1, 1, 246, 22)
SET IDENTITY_INSERT [dbo].[PagesAllow] OFF
SET IDENTITY_INSERT [dbo].[PagesRoles] ON 

INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (18, 1, 1, 1, 1, 1, 1, 1, 37)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (19, 1, 1, 1, 1, 1, 1, 2, 38)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (20, 1, 1, 1, 1, 1, 1, 3, 39)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (21, 1, 1, 1, 1, 1, 2, 1, 40)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (22, 1, 1, 1, 1, 1, 2, 2, 41)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (23, 1, 1, 1, 1, 1, 2, 3, 42)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (24, 1, 1, 1, 1, 2, 1, 1, 43)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (25, 1, 1, 1, 1, 2, 1, 2, 44)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (26, 1, 1, 1, 1, 2, 1, 3, 45)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (27, 1, 1, 1, 1, 2, 2, 1, 46)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (28, 1, 1, 1, 1, 2, 2, 2, 47)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (29, 1, 1, 1, 1, 2, 2, 3, 48)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (30, 1, 1, 1, 1, 3, 1, 1, 49)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (31, 1, 1, 1, 1, 3, 1, 2, 50)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (32, 1, 1, 1, 1, 3, 1, 3, 60)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (33, 1, 1, 1, 1, 3, 2, 1, 61)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (34, 1, 1, 1, 1, 3, 2, 2, 62)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (35, 1, 1, 1, 1, 3, 2, 3, 63)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (36, 1, 1, 1, 1, 4, 1, 1, 64)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (37, 1, 1, 1, 1, 4, 1, 2, 65)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (38, 1, 1, 1, 1, 4, 1, 3, 66)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (39, 1, 1, 1, 1, 4, 2, 1, 67)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (40, 1, 1, 1, 1, 4, 2, 2, 68)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (41, 1, 1, 1, 1, 4, 2, 3, 69)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (42, 1, 1, 1, 1, 5, 1, 1, 70)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (43, 1, 1, 1, 1, 5, 1, 2, 71)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (44, 1, 1, 1, 1, 5, 1, 3, 72)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (45, 1, 1, 1, 1, 5, 2, 1, 73)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (46, 1, 1, 1, 1, 5, 2, 2, 74)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (47, 1, 1, 1, 1, 5, 2, 3, 75)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (48, 1, 1, 1, 1, 6, 1, 1, 76)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (49, 1, 1, 1, 1, 6, 1, 2, 77)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (50, 1, 1, 1, 1, 6, 1, 3, 78)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (51, 1, 1, 1, 1, 6, 2, 1, 79)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (52, 1, 1, 1, 1, 6, 2, 2, 80)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (53, 1, 1, 1, 1, 6, 2, 3, 81)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (54, 1, 1, 1, 1, 7, 1, 1, 82)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (55, 1, 1, 1, 1, 7, 1, 2, 83)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (56, 1, 1, 1, 1, 7, 1, 3, 84)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (57, 1, 1, 1, 1, 7, 2, 1, 85)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (58, 1, 1, 1, 1, 7, 2, 2, 86)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (59, 1, 1, 1, 1, 7, 2, 3, 87)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (66, 1, 1, 1, 1, 8, 1, 1, 98)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (67, 1, 1, 1, 1, 8, 1, 2, 100)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (68, 1, 1, 1, 1, 8, 1, 3, 101)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (69, 1, 1, 1, 1, 8, 2, 1, 102)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (70, 1, 1, 1, 1, 8, 2, 2, 103)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (108, 1, 1, 1, 1, 16, 1, 1, 178)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (109, 1, 1, 1, 1, 16, 1, 2, 179)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (110, 1, 1, 1, 1, 16, 1, 3, 180)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (111, 1, 1, 1, 1, 16, 2, 1, 181)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (112, 1, 1, 1, 1, 16, 2, 2, 182)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (113, 1, 1, 1, 1, 16, 2, 3, 183)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (119, 1, 1, 1, 1, 17, 1, 1, 186)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (120, 1, 1, 1, 1, 18, 1, 1, 187)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (122, 1, 1, 1, 1, 19, 1, 1, 193)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (123, 1, 1, 1, 1, 19, 2, 1, 194)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (124, 1, 1, 1, 1, 19, 3, 1, 195)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (125, 1, 1, 1, 1, 19, 1, 2, 196)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (126, 1, 1, 1, 1, 19, 2, 2, 197)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (127, 1, 1, 1, 1, 19, 3, 2, 198)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (128, 1, 1, 1, 1, 19, 1, 3, 199)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (129, 1, 1, 1, 1, 19, 2, 3, 200)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (130, 1, 1, 1, 1, 19, 3, 3, 201)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (131, 1, 1, 1, 1, 20, 1, 1, 209)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (132, 1, 1, 1, 1, 20, 2, 1, 210)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (133, 1, 1, 1, 1, 20, 3, 1, 211)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (134, 1, 1, 1, 1, 20, 1, 2, 212)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (135, 1, 1, 1, 1, 20, 2, 2, 213)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (136, 1, 1, 1, 1, 20, 3, 2, 214)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (137, 1, 1, 1, 1, 20, 1, 3, 215)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (138, 1, 1, 1, 1, 20, 2, 3, 216)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (139, 1, 1, 1, 1, 20, 3, 3, 217)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (140, 1, 1, 1, 1, 21, 1, 1, 225)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (141, 1, 1, 1, 1, 21, 2, 1, 226)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (142, 1, 1, 1, 1, 21, 3, 1, 227)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (143, 1, 1, 1, 1, 21, 1, 2, 228)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (144, 1, 1, 1, 1, 21, 2, 2, 229)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (145, 1, 1, 1, 1, 21, 3, 2, 230)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (146, 1, 1, 1, 1, 21, 1, 3, 231)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (147, 1, 1, 1, 1, 21, 2, 3, 232)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (148, 1, 1, 1, 1, 21, 3, 3, 233)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (149, 1, 1, 1, 1, 22, 1, 1, 237)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (150, 1, 1, 1, 1, 22, 2, 1, 238)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (151, 1, 1, 1, 1, 22, 3, 1, 239)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (152, 1, 1, 1, 1, 22, 1, 2, 240)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (153, 1, 1, 1, 1, 22, 2, 2, 241)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (154, 1, 1, 1, 1, 22, 3, 2, 242)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (155, 1, 1, 1, 1, 22, 1, 3, 243)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (156, 1, 1, 1, 1, 22, 2, 3, 244)
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (157, 1, 1, 1, 1, 22, 3, 3, 245)
SET IDENTITY_INSERT [dbo].[PagesRoles] OFF
SET IDENTITY_INSERT [dbo].[PagesRoleTypes] ON 

INSERT [dbo].[PagesRoleTypes] ([Id], [ResourceName]) VALUES (1, N'Management')
INSERT [dbo].[PagesRoleTypes] ([Id], [ResourceName]) VALUES (2, N'Notifications')
INSERT [dbo].[PagesRoleTypes] ([Id], [ResourceName]) VALUES (3, N'Logs')
SET IDENTITY_INSERT [dbo].[PagesRoleTypes] OFF
SET IDENTITY_INSERT [dbo].[PhoneNumbers] ON 

INSERT [dbo].[PhoneNumbers] ([Id], [Number], [FKPhone_Id], [FkPhoneType_Id]) VALUES (9, N'01025249400', 1, 1)
INSERT [dbo].[PhoneNumbers] ([Id], [Number], [FKPhone_Id], [FkPhoneType_Id]) VALUES (12, N'01025249401', 1, 1)
SET IDENTITY_INSERT [dbo].[PhoneNumbers] OFF
SET IDENTITY_INSERT [dbo].[Phones] ON 

INSERT [dbo].[Phones] ([Id], [Notes]) VALUES (1, NULL)
INSERT [dbo].[Phones] ([Id], [Notes]) VALUES (2, NULL)
INSERT [dbo].[Phones] ([Id], [Notes]) VALUES (3, NULL)
INSERT [dbo].[Phones] ([Id], [Notes]) VALUES (4, NULL)
INSERT [dbo].[Phones] ([Id], [Notes]) VALUES (5, NULL)
SET IDENTITY_INSERT [dbo].[Phones] OFF
SET IDENTITY_INSERT [dbo].[PhoneTypes] ON 

INSERT [dbo].[PhoneTypes] ([Id], [ResourceName]) VALUES (1, N'Mobile')
INSERT [dbo].[PhoneTypes] ([Id], [ResourceName]) VALUES (2, N'Fax')
INSERT [dbo].[PhoneTypes] ([Id], [ResourceName]) VALUES (3, N'Home')
SET IDENTITY_INSERT [dbo].[PhoneTypes] OFF
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([Id], [ResourceName], [Notes], [IsControlPanel]) VALUES (1, N'Manager', NULL, 1)
INSERT [dbo].[Roles] ([Id], [ResourceName], [Notes], [IsControlPanel]) VALUES (2, N'Supervisor', NULL, 1)
INSERT [dbo].[Roles] ([Id], [ResourceName], [Notes], [IsControlPanel]) VALUES (3, N'Client', NULL, 1)
SET IDENTITY_INSERT [dbo].[Roles] OFF
SET IDENTITY_INSERT [dbo].[SocialStatus] ON 

INSERT [dbo].[SocialStatus] ([Id], [ResourceName]) VALUES (1, N'Single')
INSERT [dbo].[SocialStatus] ([Id], [ResourceName]) VALUES (2, N'Married')
INSERT [dbo].[SocialStatus] ([Id], [ResourceName]) VALUES (3, N'Widower')
SET IDENTITY_INSERT [dbo].[SocialStatus] OFF
SET IDENTITY_INSERT [dbo].[States] ON 

INSERT [dbo].[States] ([Id], [ResourceName], [CssClassStyle], [CssClassIcon]) VALUES (1, N'Create', N'label-success', N'fa fa-plus')
INSERT [dbo].[States] ([Id], [ResourceName], [CssClassStyle], [CssClassIcon]) VALUES (2, N'Update', N'label-warning', N'fas fa-edit')
INSERT [dbo].[States] ([Id], [ResourceName], [CssClassStyle], [CssClassIcon]) VALUES (3, N'Delete', N'label-danger', N'fas fa-trash-alt')
INSERT [dbo].[States] ([Id], [ResourceName], [CssClassStyle], [CssClassIcon]) VALUES (4, N'Reject', N'label-danger', N'fas fa-times')
INSERT [dbo].[States] ([Id], [ResourceName], [CssClassStyle], [CssClassIcon]) VALUES (5, N'Approve', N'label-success', N'fas fa-check-double')
SET IDENTITY_INSERT [dbo].[States] OFF
SET IDENTITY_INSERT [dbo].[SubCategories] ON 

INSERT [dbo].[SubCategories] ([Id], [NameAr], [NameEn], [FkLog_Id], [FkCategory_Id]) VALUES (1, N'دفع رباعى', N'4wd', 219, 4)
INSERT [dbo].[SubCategories] ([Id], [NameAr], [NameEn], [FkLog_Id], [FkCategory_Id]) VALUES (3, N'دراجة نارية', N'Motorcycle', 221, 4)
INSERT [dbo].[SubCategories] ([Id], [NameAr], [NameEn], [FkLog_Id], [FkCategory_Id]) VALUES (4, N'دراجة هوائية', N'Bicycles', 222, 4)
INSERT [dbo].[SubCategories] ([Id], [NameAr], [NameEn], [FkLog_Id], [FkCategory_Id]) VALUES (5, N'منازل', N'Houses', 223, 3)
INSERT [dbo].[SubCategories] ([Id], [NameAr], [NameEn], [FkLog_Id], [FkCategory_Id]) VALUES (6, N'شقق سكنية', N'Apartment', 224, 3)
SET IDENTITY_INSERT [dbo].[SubCategories] OFF
SET IDENTITY_INSERT [dbo].[SubMenus] ON 

INSERT [dbo].[SubMenus] ([Id], [OrderNumber], [ClassIcon], [FkMenu_Id], [FKPage_Id]) VALUES (5, 1, N'fas fa-not-equal', 1, 1)
INSERT [dbo].[SubMenus] ([Id], [OrderNumber], [ClassIcon], [FkMenu_Id], [FKPage_Id]) VALUES (6, 1, N'fas fa-not-equal', 2, 2)
INSERT [dbo].[SubMenus] ([Id], [OrderNumber], [ClassIcon], [FkMenu_Id], [FKPage_Id]) VALUES (7, 3, N'fas fa-not-equal', 1, 3)
INSERT [dbo].[SubMenus] ([Id], [OrderNumber], [ClassIcon], [FkMenu_Id], [FKPage_Id]) VALUES (8, 4, N'fas fa-not-equal', 1, 4)
INSERT [dbo].[SubMenus] ([Id], [OrderNumber], [ClassIcon], [FkMenu_Id], [FKPage_Id]) VALUES (9, 5, N'fas fa-not-equal', 1, 5)
INSERT [dbo].[SubMenus] ([Id], [OrderNumber], [ClassIcon], [FkMenu_Id], [FKPage_Id]) VALUES (10, 6, N'fas fa-not-equal', 1, 6)
INSERT [dbo].[SubMenus] ([Id], [OrderNumber], [ClassIcon], [FkMenu_Id], [FKPage_Id]) VALUES (11, 7, N'fas fa-not-equal', 1, 7)
INSERT [dbo].[SubMenus] ([Id], [OrderNumber], [ClassIcon], [FkMenu_Id], [FKPage_Id]) VALUES (16, 2, N'fas fa-not-equal', 2, 8)
INSERT [dbo].[SubMenus] ([Id], [OrderNumber], [ClassIcon], [FkMenu_Id], [FKPage_Id]) VALUES (23, 1, N'fas fa-not-equal', 7, 16)
INSERT [dbo].[SubMenus] ([Id], [OrderNumber], [ClassIcon], [FkMenu_Id], [FKPage_Id]) VALUES (24, 8, N'fas fa-not-equal', 1, 17)
INSERT [dbo].[SubMenus] ([Id], [OrderNumber], [ClassIcon], [FkMenu_Id], [FKPage_Id]) VALUES (25, 9, N'fas fa-not-equal', 1, 18)
INSERT [dbo].[SubMenus] ([Id], [OrderNumber], [ClassIcon], [FkMenu_Id], [FKPage_Id]) VALUES (26, 1, N'fas fa-not-equal', 8, 19)
INSERT [dbo].[SubMenus] ([Id], [OrderNumber], [ClassIcon], [FkMenu_Id], [FKPage_Id]) VALUES (27, 2, N'fas fa-not-equal', 8, 20)
INSERT [dbo].[SubMenus] ([Id], [OrderNumber], [ClassIcon], [FkMenu_Id], [FKPage_Id]) VALUES (28, 1, N'fas fa-not-equal', 9, 21)
INSERT [dbo].[SubMenus] ([Id], [OrderNumber], [ClassIcon], [FkMenu_Id], [FKPage_Id]) VALUES (29, 1, N'fas fa-not-equal', 10, 22)
SET IDENTITY_INSERT [dbo].[SubMenus] OFF
SET IDENTITY_INSERT [dbo].[TechnicalSupport] ON 

INSERT [dbo].[TechnicalSupport] ([Id], [UserName], [Email], [Phone], [Message], [CreateDateTime]) VALUES (1, N'ahmed Nageeb', N'Sezer.info@gmail.com', N'01025249400', N'test test ahmed ahmed test test ahmed ahmed aya mohamed ', CAST(N'2018-09-07T22:18:05.423' AS DateTime))
INSERT [dbo].[TechnicalSupport] ([Id], [UserName], [Email], [Phone], [Message], [CreateDateTime]) VALUES (2, N'ahmed Nageeb', N'Sezer.info@gmail.com', N'01025249400', N'test test ahmed ahmed test te


st ahmed ahmed aya mohamed ', CAST(N'2018-09-07T22:51:17.983' AS DateTime))
SET IDENTITY_INSERT [dbo].[TechnicalSupport] OFF
SET IDENTITY_INSERT [dbo].[TechnicalSupportRead] ON 

INSERT [dbo].[TechnicalSupportRead] ([Id], [FkTechnicalSupport_Id], [FkUser_Id]) VALUES (1, 1, 1)
INSERT [dbo].[TechnicalSupportRead] ([Id], [FkTechnicalSupport_Id], [FkUser_Id]) VALUES (2, 2, 1)
SET IDENTITY_INSERT [dbo].[TechnicalSupportRead] OFF
INSERT [dbo].[UserInformation] ([Id], [FirstName], [MediumName], [LastName], [NationalId], [BirthDate], [FkImage_Id], [FKAddress_Id], [FkNationality_Id], [FKGender_Id], [FKSocialStatus_Id], [FKJob_Id], [FKLanguage_Id], [FkPhone_Id]) VALUES (1, N'Ahmed', N'Nageeb', N'Mahmoud', N'123654879', CAST(N'1997-02-04' AS Date), 1, 1, 1, 1, 1, 4, 1, 1)
INSERT [dbo].[UserInformation] ([Id], [FirstName], [MediumName], [LastName], [NationalId], [BirthDate], [FkImage_Id], [FKAddress_Id], [FkNationality_Id], [FKGender_Id], [FKSocialStatus_Id], [FKJob_Id], [FKLanguage_Id], [FkPhone_Id]) VALUES (2, N'Aya', NULL, N'Nageeb', N'12121212654', NULL, 2, 2, NULL, NULL, NULL, 1, 2, 2)
INSERT [dbo].[UserInformation] ([Id], [FirstName], [MediumName], [LastName], [NationalId], [BirthDate], [FkImage_Id], [FKAddress_Id], [FkNationality_Id], [FKGender_Id], [FKSocialStatus_Id], [FKJob_Id], [FKLanguage_Id], [FkPhone_Id]) VALUES (3, N'xxqq1', NULL, N'qq', NULL, NULL, 27, 3, NULL, NULL, NULL, NULL, 3, 3)
INSERT [dbo].[UserInformation] ([Id], [FirstName], [MediumName], [LastName], [NationalId], [BirthDate], [FkImage_Id], [FKAddress_Id], [FkNationality_Id], [FKGender_Id], [FKSocialStatus_Id], [FKJob_Id], [FKLanguage_Id], [FkPhone_Id]) VALUES (5, N'ghjklkn8888', NULL, N'sdsdsd', NULL, NULL, 29, 5, NULL, NULL, NULL, NULL, 5, 5)
INSERT [dbo].[UserInformation] ([Id], [FirstName], [MediumName], [LastName], [NationalId], [BirthDate], [FkImage_Id], [FKAddress_Id], [FkNationality_Id], [FKGender_Id], [FKSocialStatus_Id], [FKJob_Id], [FKLanguage_Id], [FkPhone_Id]) VALUES (9, N'', NULL, N'', NULL, NULL, 43, 6, NULL, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[UserLogins] ON 

INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (1, CAST(N'2018-08-19T17:54:54.117' AS DateTime), 1, 1)
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (2, CAST(N'2018-08-19T17:55:11.110' AS DateTime), 1, 1)
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (3, CAST(N'2018-08-19T17:56:18.620' AS DateTime), 1, 1)
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (4, CAST(N'2018-08-19T17:56:54.307' AS DateTime), 1, 1)
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (5, CAST(N'2018-08-19T17:58:30.443' AS DateTime), 1, 1)
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (6, CAST(N'2018-08-19T17:59:33.700' AS DateTime), 1, 1)
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (7, CAST(N'2018-08-19T18:00:37.667' AS DateTime), 1, 1)
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (8, CAST(N'2018-08-19T18:01:49.207' AS DateTime), 1, 1)
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (9, CAST(N'2018-08-19T18:06:22.350' AS DateTime), 1, 1)
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (10, CAST(N'2018-08-19T18:07:35.967' AS DateTime), 1, 1)
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (11, CAST(N'2018-08-19T18:07:55.160' AS DateTime), 1, 1)
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (12, CAST(N'2018-08-19T18:08:57.743' AS DateTime), 1, 1)
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (13, CAST(N'2018-08-19T18:10:15.493' AS DateTime), 1, 1)
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (14, CAST(N'2018-08-19T18:10:31.273' AS DateTime), 1, 1)
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (15, CAST(N'2018-08-19T18:10:56.700' AS DateTime), 1, 1)
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (16, CAST(N'2018-08-19T18:12:08.717' AS DateTime), 1, 1)
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (17, CAST(N'2018-08-19T18:13:05.743' AS DateTime), 1, 1)
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (18, CAST(N'2018-08-19T18:13:05.957' AS DateTime), 1, 1)
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (19, CAST(N'2018-08-19T18:13:23.530' AS DateTime), 1, 1)
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (20, CAST(N'2018-08-19T18:15:33.137' AS DateTime), 1, 1)
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (21, CAST(N'2018-08-19T18:28:31.153' AS DateTime), 1, 1)
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (22, CAST(N'2018-08-19T18:28:51.610' AS DateTime), 1, 1)
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (23, CAST(N'2018-08-19T18:31:21.073' AS DateTime), 0, 1)
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (24, CAST(N'2018-08-19T18:31:24.643' AS DateTime), 1, 1)
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (25, CAST(N'2018-08-19T18:33:38.513' AS DateTime), 1, 1)
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (26, CAST(N'2018-08-19T18:34:52.157' AS DateTime), 1, 1)
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (27, CAST(N'2018-08-19T19:25:40.097' AS DateTime), 1, 1)
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (28, CAST(N'2018-08-19T19:25:40.843' AS DateTime), 1, 1)
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (29, CAST(N'2018-08-19T19:31:10.290' AS DateTime), 1, 1)
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (30, CAST(N'2018-08-19T19:33:21.480' AS DateTime), 1, 1)
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (31, CAST(N'2018-08-24T16:45:44.917' AS DateTime), 1, 1)
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (32, CAST(N'2018-08-30T19:33:16.707' AS DateTime), 1, 1)
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (33, CAST(N'2018-09-09T22:54:25.140' AS DateTime), 1, 1)
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (34, CAST(N'2018-09-15T19:51:39.437' AS DateTime), 0, 1)
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (35, CAST(N'2018-09-15T19:51:45.297' AS DateTime), 0, 1)
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (36, CAST(N'2018-09-15T19:54:14.973' AS DateTime), 1, 1)
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (37, CAST(N'2018-09-15T19:56:32.130' AS DateTime), 1, 1)
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (38, CAST(N'2018-09-19T14:13:39.543' AS DateTime), 1, 1)
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (39, CAST(N'2018-09-19T17:05:29.640' AS DateTime), 1, 1)
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (40, CAST(N'2018-09-19T17:19:43.167' AS DateTime), 1, 1)
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (41, CAST(N'2018-09-19T17:21:28.580' AS DateTime), 1, 1)
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (42, CAST(N'2018-09-19T17:23:53.580' AS DateTime), 1, 1)
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (43, CAST(N'2018-09-20T00:15:33.650' AS DateTime), 1, 1)
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (44, CAST(N'2018-09-20T21:31:49.970' AS DateTime), 1, 1)
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (45, CAST(N'2018-09-21T13:58:38.190' AS DateTime), 1, 1)
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (46, CAST(N'2018-09-21T13:58:40.080' AS DateTime), 1, 1)
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (47, CAST(N'2018-09-21T13:58:40.377' AS DateTime), 1, 1)
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (48, CAST(N'2018-09-23T05:12:58.793' AS DateTime), 1, 1)
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (49, CAST(N'2018-09-23T05:12:58.793' AS DateTime), 1, 1)
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (50, CAST(N'2018-09-23T14:39:04.970' AS DateTime), 1, 1)
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (51, CAST(N'2018-09-23T15:14:56.997' AS DateTime), 1, 1)
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (52, CAST(N'2018-09-23T20:53:42.237' AS DateTime), 1, 1)
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (53, CAST(N'2018-09-24T01:30:13.023' AS DateTime), 1, 1)
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (54, CAST(N'2018-09-24T14:38:08.053' AS DateTime), 1, 1)
SET IDENTITY_INSERT [dbo].[UserLogins] OFF
SET IDENTITY_INSERT [dbo].[UserRoles] ON 

INSERT [dbo].[UserRoles] ([Id], [FkUser_Id], [FkRole_Id]) VALUES (1, 1, 1)
INSERT [dbo].[UserRoles] ([Id], [FkUser_Id], [FkRole_Id]) VALUES (2, 1, 2)
INSERT [dbo].[UserRoles] ([Id], [FkUser_Id], [FkRole_Id]) VALUES (3, 2, 3)
INSERT [dbo].[UserRoles] ([Id], [FkUser_Id], [FkRole_Id]) VALUES (4, 3, 3)
INSERT [dbo].[UserRoles] ([Id], [FkUser_Id], [FkRole_Id]) VALUES (6, 5, 3)
INSERT [dbo].[UserRoles] ([Id], [FkUser_Id], [FkRole_Id]) VALUES (7, 9, 3)
SET IDENTITY_INSERT [dbo].[UserRoles] OFF
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([Id], [UserName], [Email], [Password], [IsBlocked], [CreateDate], [Serial], [FkLog_Id]) VALUES (1, N'ahmed', N'ahmed@gmail.com', N'123456', 0, CAST(N'2012-12-01T00:00:00.000' AS DateTime), N'ahmed1', 105)
INSERT [dbo].[Users] ([Id], [UserName], [Email], [Password], [IsBlocked], [CreateDate], [Serial], [FkLog_Id]) VALUES (2, N'AYa', N'sezer.info.0@gmail.com', N'123456', 0, CAST(N'2018-08-26T23:41:08.133' AS DateTime), N'69680b54-2c75-4235-a297-5bd326eb2b30', 106)
INSERT [dbo].[Users] ([Id], [UserName], [Email], [Password], [IsBlocked], [CreateDate], [Serial], [FkLog_Id]) VALUES (3, N'ahmedw', N'ahmednageeb@gmail.com', N'123456', 0, CAST(N'2018-08-30T16:57:19.937' AS DateTime), N'dfc43fcf-a4e8-4a25-b97a-d1bf76d46897', 124)
INSERT [dbo].[Users] ([Id], [UserName], [Email], [Password], [IsBlocked], [CreateDate], [Serial], [FkLog_Id]) VALUES (5, N'sasasa', N'dowqnlaodvid1eoyou@gmail.com', N'123456', 0, CAST(N'2018-08-30T17:19:26.103' AS DateTime), N'7fbca0dd-3216-4425-b52d-fb8441d48109', 126)
INSERT [dbo].[Users] ([Id], [UserName], [Email], [Password], [IsBlocked], [CreateDate], [Serial], [FkLog_Id]) VALUES (9, N'ahmeddd@gmail_com', N'ahmeddd@gmail.com', N'123456', 0, CAST(N'2018-08-30T21:09:50.823' AS DateTime), N'504d102d-6141-43c5-8cf4-10ed4623bb91', 128)
SET IDENTITY_INSERT [dbo].[Users] OFF
SET IDENTITY_INSERT [dbo].[ViewerAds] ON 

INSERT [dbo].[ViewerAds] ([Id], [CountViewer], [FkUser_Id], [FKAd_Id]) VALUES (2, 1, NULL, 1)
SET IDENTITY_INSERT [dbo].[ViewerAds] OFF
SET ANSI_PADDING ON
GO
/****** Object:  Index [Email]    Script Date: 9/24/2018 4:57:12 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [Email] ON [dbo].[Users]
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Serial]    Script Date: 9/24/2018 4:57:12 PM ******/
CREATE NONCLUSTERED INDEX [Serial] ON [dbo].[Users]
(
	[Serial] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UserName]    Script Date: 9/24/2018 4:57:12 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UserName] ON [dbo].[Users]
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Addresses]  WITH CHECK ADD  CONSTRAINT [FK_Addresses_Cities] FOREIGN KEY([FkCity_Id])
REFERENCES [dbo].[Cities] ([Id])
GO
ALTER TABLE [dbo].[Addresses] CHECK CONSTRAINT [FK_Addresses_Cities]
GO
ALTER TABLE [dbo].[Addresses]  WITH CHECK ADD  CONSTRAINT [FK_Addresses_Countries] FOREIGN KEY([FKCountry_Id])
REFERENCES [dbo].[Countries] ([Id])
GO
ALTER TABLE [dbo].[Addresses] CHECK CONSTRAINT [FK_Addresses_Countries]
GO
ALTER TABLE [dbo].[AdFavorites]  WITH CHECK ADD  CONSTRAINT [FK_AdFavorites_Ads] FOREIGN KEY([FKAd_Id])
REFERENCES [dbo].[Ads] ([Id])
GO
ALTER TABLE [dbo].[AdFavorites] CHECK CONSTRAINT [FK_AdFavorites_Ads]
GO
ALTER TABLE [dbo].[AdFavorites]  WITH CHECK ADD  CONSTRAINT [FK_AdFavorites_Users] FOREIGN KEY([Id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[AdFavorites] CHECK CONSTRAINT [FK_AdFavorites_Users]
GO
ALTER TABLE [dbo].[Ads]  WITH CHECK ADD  CONSTRAINT [FK_Ads_Albums] FOREIGN KEY([FkAlbum_Id])
REFERENCES [dbo].[Albums] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Ads] CHECK CONSTRAINT [FK_Ads_Albums]
GO
ALTER TABLE [dbo].[Ads]  WITH CHECK ADD  CONSTRAINT [FK_Ads_Categories] FOREIGN KEY([FkCategory_Id])
REFERENCES [dbo].[Categories] ([Id])
GO
ALTER TABLE [dbo].[Ads] CHECK CONSTRAINT [FK_Ads_Categories]
GO
ALTER TABLE [dbo].[Ads]  WITH CHECK ADD  CONSTRAINT [FK_Ads_Logs] FOREIGN KEY([FkLog_Id])
REFERENCES [dbo].[Logs] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Ads] CHECK CONSTRAINT [FK_Ads_Logs]
GO
ALTER TABLE [dbo].[Ads]  WITH CHECK ADD  CONSTRAINT [FK_Ads_SubCategories] FOREIGN KEY([FkSubCategory_Id])
REFERENCES [dbo].[SubCategories] ([Id])
GO
ALTER TABLE [dbo].[Ads] CHECK CONSTRAINT [FK_Ads_SubCategories]
GO
ALTER TABLE [dbo].[Ads]  WITH CHECK ADD  CONSTRAINT [FK_Ads_Users] FOREIGN KEY([FkUser_Id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Ads] CHECK CONSTRAINT [FK_Ads_Users]
GO
ALTER TABLE [dbo].[AlbumFiles]  WITH CHECK ADD  CONSTRAINT [FK_AlbumFiles_Albums] FOREIGN KEY([FkAlbum_Id])
REFERENCES [dbo].[Albums] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AlbumFiles] CHECK CONSTRAINT [FK_AlbumFiles_Albums]
GO
ALTER TABLE [dbo].[AlbumFiles]  WITH CHECK ADD  CONSTRAINT [FK_AlbumFiles_Files] FOREIGN KEY([FkFile_Id])
REFERENCES [dbo].[Files] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AlbumFiles] CHECK CONSTRAINT [FK_AlbumFiles_Files]
GO
ALTER TABLE [dbo].[Categories]  WITH CHECK ADD  CONSTRAINT [FK_Categories_Logs] FOREIGN KEY([FkLog_Id])
REFERENCES [dbo].[Logs] ([Id])
GO
ALTER TABLE [dbo].[Categories] CHECK CONSTRAINT [FK_Categories_Logs]
GO
ALTER TABLE [dbo].[Cities]  WITH CHECK ADD  CONSTRAINT [FK_Cities_Countries] FOREIGN KEY([FKCountry_Id])
REFERENCES [dbo].[Countries] ([Id])
GO
ALTER TABLE [dbo].[Cities] CHECK CONSTRAINT [FK_Cities_Countries]
GO
ALTER TABLE [dbo].[Cities]  WITH CHECK ADD  CONSTRAINT [FK_Cities_Logs] FOREIGN KEY([FkLog_Id])
REFERENCES [dbo].[Logs] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Cities] CHECK CONSTRAINT [FK_Cities_Logs]
GO
ALTER TABLE [dbo].[Countries]  WITH CHECK ADD  CONSTRAINT [FK_Countries_Logs] FOREIGN KEY([FkLog_Id])
REFERENCES [dbo].[Logs] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Countries] CHECK CONSTRAINT [FK_Countries_Logs]
GO
ALTER TABLE [dbo].[Files]  WITH CHECK ADD  CONSTRAINT [FK_Files_FileTypes] FOREIGN KEY([FkFileType_Id])
REFERENCES [dbo].[FileTypes] ([Id])
GO
ALTER TABLE [dbo].[Files] CHECK CONSTRAINT [FK_Files_FileTypes]
GO
ALTER TABLE [dbo].[Files]  WITH CHECK ADD  CONSTRAINT [FK_Images_AppInformation] FOREIGN KEY([FKAppInformation_Id])
REFERENCES [dbo].[AppsInformation] ([Id])
GO
ALTER TABLE [dbo].[Files] CHECK CONSTRAINT [FK_Images_AppInformation]
GO
ALTER TABLE [dbo].[Histories]  WITH CHECK ADD  CONSTRAINT [FK_Histories_Logs] FOREIGN KEY([FkLog_Id])
REFERENCES [dbo].[Logs] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Histories] CHECK CONSTRAINT [FK_Histories_Logs]
GO
ALTER TABLE [dbo].[Histories]  WITH CHECK ADD  CONSTRAINT [FK_Histories_Pages] FOREIGN KEY([FKPage_Id])
REFERENCES [dbo].[Pages] ([Id])
GO
ALTER TABLE [dbo].[Histories] CHECK CONSTRAINT [FK_Histories_Pages]
GO
ALTER TABLE [dbo].[Histories]  WITH CHECK ADD  CONSTRAINT [FK_Histories_States] FOREIGN KEY([FkState_Id])
REFERENCES [dbo].[States] ([Id])
GO
ALTER TABLE [dbo].[Histories] CHECK CONSTRAINT [FK_Histories_States]
GO
ALTER TABLE [dbo].[Histories]  WITH CHECK ADD  CONSTRAINT [FK_Histories_Users] FOREIGN KEY([FkUser_Id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Histories] CHECK CONSTRAINT [FK_Histories_Users]
GO
ALTER TABLE [dbo].[HistoryDetails]  WITH CHECK ADD  CONSTRAINT [FK_HistoryDetails_Histories] FOREIGN KEY([FkHistory_Id])
REFERENCES [dbo].[Histories] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[HistoryDetails] CHECK CONSTRAINT [FK_HistoryDetails_Histories]
GO
ALTER TABLE [dbo].[Jobs]  WITH CHECK ADD  CONSTRAINT [FK_Jobs_Logs] FOREIGN KEY([FkLog_Id])
REFERENCES [dbo].[Logs] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Jobs] CHECK CONSTRAINT [FK_Jobs_Logs]
GO
ALTER TABLE [dbo].[LanguageUsing]  WITH CHECK ADD  CONSTRAINT [FK_LanguageUsing_Languages] FOREIGN KEY([FKLanguage_Id])
REFERENCES [dbo].[Languages] ([Id])
GO
ALTER TABLE [dbo].[LanguageUsing] CHECK CONSTRAINT [FK_LanguageUsing_Languages]
GO
ALTER TABLE [dbo].[LanguageUsing]  WITH CHECK ADD  CONSTRAINT [FK_LanguageUsing_LanguageTypes] FOREIGN KEY([FKLanguageType_Id])
REFERENCES [dbo].[LanguageTypes] ([Id])
GO
ALTER TABLE [dbo].[LanguageUsing] CHECK CONSTRAINT [FK_LanguageUsing_LanguageTypes]
GO
ALTER TABLE [dbo].[Nationalities]  WITH CHECK ADD  CONSTRAINT [FK_Nationalities_Logs] FOREIGN KEY([FkLog_Id])
REFERENCES [dbo].[Logs] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Nationalities] CHECK CONSTRAINT [FK_Nationalities_Logs]
GO
ALTER TABLE [dbo].[NotificationsIsRead]  WITH CHECK ADD  CONSTRAINT [FK_NotificationsIsRead_Histories] FOREIGN KEY([FkHistory_Id])
REFERENCES [dbo].[Histories] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[NotificationsIsRead] CHECK CONSTRAINT [FK_NotificationsIsRead_Histories]
GO
ALTER TABLE [dbo].[NotificationsIsRead]  WITH CHECK ADD  CONSTRAINT [FK_NotificationsIsRead_Users] FOREIGN KEY([FKUser_Id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[NotificationsIsRead] CHECK CONSTRAINT [FK_NotificationsIsRead_Users]
GO
ALTER TABLE [dbo].[OfferFavorites]  WITH CHECK ADD  CONSTRAINT [FK_OfferFavorites_Offers] FOREIGN KEY([FKOffer_Id])
REFERENCES [dbo].[Offers] ([Id])
GO
ALTER TABLE [dbo].[OfferFavorites] CHECK CONSTRAINT [FK_OfferFavorites_Offers]
GO
ALTER TABLE [dbo].[OfferFavorites]  WITH CHECK ADD  CONSTRAINT [FK_OfferFavorites_Users] FOREIGN KEY([FkUser_Id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[OfferFavorites] CHECK CONSTRAINT [FK_OfferFavorites_Users]
GO
ALTER TABLE [dbo].[Offers]  WITH CHECK ADD  CONSTRAINT [FK_Offers_Albums] FOREIGN KEY([FkAlbum_Id])
REFERENCES [dbo].[Albums] ([Id])
GO
ALTER TABLE [dbo].[Offers] CHECK CONSTRAINT [FK_Offers_Albums]
GO
ALTER TABLE [dbo].[Offers]  WITH CHECK ADD  CONSTRAINT [FK_Offers_Logs] FOREIGN KEY([FkLog_Id])
REFERENCES [dbo].[Logs] ([Id])
GO
ALTER TABLE [dbo].[Offers] CHECK CONSTRAINT [FK_Offers_Logs]
GO
ALTER TABLE [dbo].[Offers]  WITH CHECK ADD  CONSTRAINT [FK_Offers_Users] FOREIGN KEY([FkUser_Id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Offers] CHECK CONSTRAINT [FK_Offers_Users]
GO
ALTER TABLE [dbo].[PagesAllow]  WITH CHECK ADD  CONSTRAINT [FK_PagesAllow_Logs] FOREIGN KEY([FkLog_Id])
REFERENCES [dbo].[Logs] ([Id])
GO
ALTER TABLE [dbo].[PagesAllow] CHECK CONSTRAINT [FK_PagesAllow_Logs]
GO
ALTER TABLE [dbo].[PagesAllow]  WITH CHECK ADD  CONSTRAINT [FK_PagesAllow_Pages] FOREIGN KEY([FkPage_Id])
REFERENCES [dbo].[Pages] ([Id])
GO
ALTER TABLE [dbo].[PagesAllow] CHECK CONSTRAINT [FK_PagesAllow_Pages]
GO
ALTER TABLE [dbo].[PagesRoles]  WITH CHECK ADD  CONSTRAINT [FK_PagesRoles_Logs] FOREIGN KEY([FkLog_Id])
REFERENCES [dbo].[Logs] ([Id])
GO
ALTER TABLE [dbo].[PagesRoles] CHECK CONSTRAINT [FK_PagesRoles_Logs]
GO
ALTER TABLE [dbo].[PagesRoles]  WITH CHECK ADD  CONSTRAINT [FK_PagesRoles_Pages] FOREIGN KEY([FkPage_Id])
REFERENCES [dbo].[Pages] ([Id])
GO
ALTER TABLE [dbo].[PagesRoles] CHECK CONSTRAINT [FK_PagesRoles_Pages]
GO
ALTER TABLE [dbo].[PagesRoles]  WITH CHECK ADD  CONSTRAINT [FK_PagesRoles_PagesRoles] FOREIGN KEY([Id])
REFERENCES [dbo].[PagesRoles] ([Id])
GO
ALTER TABLE [dbo].[PagesRoles] CHECK CONSTRAINT [FK_PagesRoles_PagesRoles]
GO
ALTER TABLE [dbo].[PagesRoles]  WITH CHECK ADD  CONSTRAINT [FK_PagesRoles_PagesRoleTypes] FOREIGN KEY([FkPageRoleTypes_Id])
REFERENCES [dbo].[PagesRoleTypes] ([Id])
GO
ALTER TABLE [dbo].[PagesRoles] CHECK CONSTRAINT [FK_PagesRoles_PagesRoleTypes]
GO
ALTER TABLE [dbo].[PagesRoles]  WITH CHECK ADD  CONSTRAINT [FK_PagesRoles_Roles] FOREIGN KEY([FkRole_Id])
REFERENCES [dbo].[Roles] ([Id])
GO
ALTER TABLE [dbo].[PagesRoles] CHECK CONSTRAINT [FK_PagesRoles_Roles]
GO
ALTER TABLE [dbo].[PhoneNumbers]  WITH CHECK ADD  CONSTRAINT [FK_PhoneNumbers_PagesRoleTypes] FOREIGN KEY([FkPhoneType_Id])
REFERENCES [dbo].[PhoneTypes] ([Id])
GO
ALTER TABLE [dbo].[PhoneNumbers] CHECK CONSTRAINT [FK_PhoneNumbers_PagesRoleTypes]
GO
ALTER TABLE [dbo].[PhoneNumbers]  WITH CHECK ADD  CONSTRAINT [FK_PhoneNumbers_Phones] FOREIGN KEY([FKPhone_Id])
REFERENCES [dbo].[Phones] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PhoneNumbers] CHECK CONSTRAINT [FK_PhoneNumbers_Phones]
GO
ALTER TABLE [dbo].[SubCategories]  WITH CHECK ADD  CONSTRAINT [FK_SubCategories_Categories] FOREIGN KEY([FkCategory_Id])
REFERENCES [dbo].[Categories] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SubCategories] CHECK CONSTRAINT [FK_SubCategories_Categories]
GO
ALTER TABLE [dbo].[SubCategories]  WITH CHECK ADD  CONSTRAINT [FK_SubCategories_Logs] FOREIGN KEY([FkLog_Id])
REFERENCES [dbo].[Logs] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SubCategories] CHECK CONSTRAINT [FK_SubCategories_Logs]
GO
ALTER TABLE [dbo].[SubMenus]  WITH CHECK ADD  CONSTRAINT [FK_SubMenu_Menu] FOREIGN KEY([FkMenu_Id])
REFERENCES [dbo].[Menus] ([Id])
GO
ALTER TABLE [dbo].[SubMenus] CHECK CONSTRAINT [FK_SubMenu_Menu]
GO
ALTER TABLE [dbo].[SubMenus]  WITH CHECK ADD  CONSTRAINT [FK_SubMenu_Pages] FOREIGN KEY([FKPage_Id])
REFERENCES [dbo].[Pages] ([Id])
GO
ALTER TABLE [dbo].[SubMenus] CHECK CONSTRAINT [FK_SubMenu_Pages]
GO
ALTER TABLE [dbo].[TechnicalSupportRead]  WITH CHECK ADD  CONSTRAINT [FK_TechnicalSupportRead_TechnicalSupport] FOREIGN KEY([FkTechnicalSupport_Id])
REFERENCES [dbo].[TechnicalSupport] ([Id])
GO
ALTER TABLE [dbo].[TechnicalSupportRead] CHECK CONSTRAINT [FK_TechnicalSupportRead_TechnicalSupport]
GO
ALTER TABLE [dbo].[TechnicalSupportRead]  WITH CHECK ADD  CONSTRAINT [FK_TechnicalSupportRead_Users] FOREIGN KEY([FkUser_Id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[TechnicalSupportRead] CHECK CONSTRAINT [FK_TechnicalSupportRead_Users]
GO
ALTER TABLE [dbo].[UserInformation]  WITH CHECK ADD  CONSTRAINT [FK_UserInformation_Addresses] FOREIGN KEY([FKAddress_Id])
REFERENCES [dbo].[Addresses] ([Id])
GO
ALTER TABLE [dbo].[UserInformation] CHECK CONSTRAINT [FK_UserInformation_Addresses]
GO
ALTER TABLE [dbo].[UserInformation]  WITH CHECK ADD  CONSTRAINT [FK_UserInformation_Genders] FOREIGN KEY([FKGender_Id])
REFERENCES [dbo].[Genders] ([Id])
GO
ALTER TABLE [dbo].[UserInformation] CHECK CONSTRAINT [FK_UserInformation_Genders]
GO
ALTER TABLE [dbo].[UserInformation]  WITH CHECK ADD  CONSTRAINT [FK_UserInformation_Images] FOREIGN KEY([FkImage_Id])
REFERENCES [dbo].[Files] ([Id])
GO
ALTER TABLE [dbo].[UserInformation] CHECK CONSTRAINT [FK_UserInformation_Images]
GO
ALTER TABLE [dbo].[UserInformation]  WITH CHECK ADD  CONSTRAINT [FK_UserInformation_Jobs] FOREIGN KEY([FKJob_Id])
REFERENCES [dbo].[Jobs] ([Id])
GO
ALTER TABLE [dbo].[UserInformation] CHECK CONSTRAINT [FK_UserInformation_Jobs]
GO
ALTER TABLE [dbo].[UserInformation]  WITH CHECK ADD  CONSTRAINT [FK_UserInformation_Languages] FOREIGN KEY([FKLanguage_Id])
REFERENCES [dbo].[Languages] ([Id])
GO
ALTER TABLE [dbo].[UserInformation] CHECK CONSTRAINT [FK_UserInformation_Languages]
GO
ALTER TABLE [dbo].[UserInformation]  WITH CHECK ADD  CONSTRAINT [FK_UserInformation_Nationalities] FOREIGN KEY([FkNationality_Id])
REFERENCES [dbo].[Nationalities] ([Id])
GO
ALTER TABLE [dbo].[UserInformation] CHECK CONSTRAINT [FK_UserInformation_Nationalities]
GO
ALTER TABLE [dbo].[UserInformation]  WITH CHECK ADD  CONSTRAINT [FK_UserInformation_Phones] FOREIGN KEY([FkPhone_Id])
REFERENCES [dbo].[Phones] ([Id])
GO
ALTER TABLE [dbo].[UserInformation] CHECK CONSTRAINT [FK_UserInformation_Phones]
GO
ALTER TABLE [dbo].[UserInformation]  WITH CHECK ADD  CONSTRAINT [FK_UserInformation_SocialStatuses] FOREIGN KEY([FKSocialStatus_Id])
REFERENCES [dbo].[SocialStatus] ([Id])
GO
ALTER TABLE [dbo].[UserInformation] CHECK CONSTRAINT [FK_UserInformation_SocialStatuses]
GO
ALTER TABLE [dbo].[UserInformation]  WITH CHECK ADD  CONSTRAINT [FK_UserInformation_Users] FOREIGN KEY([Id])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserInformation] CHECK CONSTRAINT [FK_UserInformation_Users]
GO
ALTER TABLE [dbo].[UserLogins]  WITH CHECK ADD  CONSTRAINT [FK_UserLogins_Users] FOREIGN KEY([FkUser_Id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[UserLogins] CHECK CONSTRAINT [FK_UserLogins_Users]
GO
ALTER TABLE [dbo].[UserRoles]  WITH CHECK ADD  CONSTRAINT [FK_UserRoles_Roles] FOREIGN KEY([FkRole_Id])
REFERENCES [dbo].[Roles] ([Id])
GO
ALTER TABLE [dbo].[UserRoles] CHECK CONSTRAINT [FK_UserRoles_Roles]
GO
ALTER TABLE [dbo].[UserRoles]  WITH CHECK ADD  CONSTRAINT [FK_UserRoles_Users] FOREIGN KEY([FkUser_Id])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserRoles] CHECK CONSTRAINT [FK_UserRoles_Users]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Logs] FOREIGN KEY([FkLog_Id])
REFERENCES [dbo].[Logs] ([Id])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Logs]
GO
ALTER TABLE [dbo].[ViewerAds]  WITH CHECK ADD  CONSTRAINT [FK_AdViewer_Ads] FOREIGN KEY([FKAd_Id])
REFERENCES [dbo].[Ads] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ViewerAds] CHECK CONSTRAINT [FK_AdViewer_Ads]
GO
ALTER TABLE [dbo].[ViewerAds]  WITH CHECK ADD  CONSTRAINT [FK_AdViewer_Users] FOREIGN KEY([FkUser_Id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[ViewerAds] CHECK CONSTRAINT [FK_AdViewer_Users]
GO
ALTER TABLE [dbo].[ViewerOffers]  WITH CHECK ADD  CONSTRAINT [FK_ViewerOffers_Offers] FOREIGN KEY([FKOffer_Id])
REFERENCES [dbo].[Offers] ([Id])
GO
ALTER TABLE [dbo].[ViewerOffers] CHECK CONSTRAINT [FK_ViewerOffers_Offers]
GO
ALTER TABLE [dbo].[ViewerOffers]  WITH CHECK ADD  CONSTRAINT [FK_ViewerOffers_Users] FOREIGN KEY([FkUser_Id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[ViewerOffers] CHECK CONSTRAINT [FK_ViewerOffers_Users]
GO
/****** Object:  StoredProcedure [dbo].[InsertLog]    Script Date: 9/24/2018 4:57:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create  proc [dbo].[InsertLog]
as 
begin 
insert Logs(Notes)values (null)
return scope_identity();
end
GO
/****** Object:  StoredProcedure [dbo].[InsertPage]    Script Date: 9/24/2018 4:57:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[InsertPage] 
@ResourceName nvarchar(50),
@IsControlPanel bit ,
@IsFronEnd bit
as 
begin 
insert Pages(ResourceName,Url,IsControlPanel,IsFronEnd)values (@ResourceName,@ResourceName,@IsControlPanel,@IsFronEnd)
return scope_identity();
end
GO
/****** Object:  StoredProcedure [dbo].[InsertPageRles]    Script Date: 9/24/2018 4:57:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  proc [dbo].[InsertPageRles] 
@FkPage_Id int,
@FkPageRoleTypes_Id int ,
@FkRole_Id int,
@FkLog_Id int
as 
begin 
insert PagesRoles(FkPage_Id,FkPageRoleTypes_Id,FkRole_Id,FkLog_Id,IsCreate,IsDelete,IsDisplay,IsUpdate)values (@FkPage_Id,@FkPageRoleTypes_Id,@FkRole_Id,@FkLog_Id,1,1,1,1)
return scope_identity();
end
GO
USE [master]
GO
ALTER DATABASE [Silgaram] SET  READ_WRITE 
GO

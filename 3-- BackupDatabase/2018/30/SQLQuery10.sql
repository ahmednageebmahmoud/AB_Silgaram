CREATE TABLE [dbo].[Addresses](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Street] [nvarchar](50) NULL,
	[PostalCode] [nvarchar](10) NULL,
	[FKCountry_Id] [int] NULL,
	[FkProvince_Id] [int] NULL,
	[City] [nvarchar](50) NULL,
 CONSTRAINT [PK_Addresses] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AdFavorites]    Script Date: 12/30/2018 8:50:17 PM ******/
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
/****** Object:  Table [dbo].[Ads]    Script Date: 12/30/2018 8:50:17 PM ******/
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
	[IsApprove] [bit] NOT NULL,
	[FkSubCategory_Id] [int] NULL,
	[FkCategory_Id] [int] NOT NULL,
	[FkAlbum_Id] [int] NOT NULL,
	[FkLog_Id] [int] NOT NULL,
	[FkUser_Id] [int] NOT NULL,
	[FkLocation_Id] [int] NOT NULL,
	[PhoneNumber] [nvarchar](50) NOT NULL,
	[IsAllowMessaging] [bit] NOT NULL,
	[IsPostWithOutPhoneNumber] [bit] NOT NULL,
	[IsAutoPost] [bit] NOT NULL,
	[CountAutoPostToNow] [int] NOT NULL,
 CONSTRAINT [PK_Ads] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AdsSlider]    Script Date: 12/30/2018 8:50:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdsSlider](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ViewerCount] [int] NOT NULL,
	[FkFile_Id] [int] NOT NULL,
	[FkLog_Id] [int] NOT NULL,
	[FkPositionType_Id] [int] NOT NULL,
 CONSTRAINT [PK_AdsSlider] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AlbumFiles]    Script Date: 12/30/2018 8:50:17 PM ******/
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
/****** Object:  Table [dbo].[Albums]    Script Date: 12/30/2018 8:50:17 PM ******/
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
/****** Object:  Table [dbo].[AppsInformation]    Script Date: 12/30/2018 8:50:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppsInformation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ResourceName] [nvarchar](50) NOT NULL,
	[Value] [nvarchar](max) NOT NULL,
	[FkLog_Id] [int] NOT NULL,
 CONSTRAINT [PK_AppInformation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 12/30/2018 8:50:17 PM ******/
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
/****** Object:  Table [dbo].[Countries]    Script Date: 12/30/2018 8:50:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Countries](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[NameAr] [nvarchar](50) NOT NULL,
	[NameEn] [nvarchar](50) NOT NULL,
	[FkLog_Id] [int] NOT NULL,
	[CountryKey] [nvarchar](50) NOT NULL,
	[FkFile_Id] [int] NOT NULL,
 CONSTRAINT [PK_Countries] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Files]    Script Date: 12/30/2018 8:50:17 PM ******/
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
/****** Object:  Table [dbo].[FileTypes]    Script Date: 12/30/2018 8:50:17 PM ******/
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
/****** Object:  Table [dbo].[Following]    Script Date: 12/30/2018 8:50:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Following](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Notes] [nvarchar](50) NULL,
 CONSTRAINT [PK_UsersFollowing] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Genders]    Script Date: 12/30/2018 8:50:17 PM ******/
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
/****** Object:  Table [dbo].[Histories]    Script Date: 12/30/2018 8:50:17 PM ******/
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
	[TitleEn] [nvarchar](250) NOT NULL,
	[TitleAr] [nvarchar](250) NOT NULL,
 CONSTRAINT [PK_Histories] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HistoryDetails]    Script Date: 12/30/2018 8:50:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HistoryDetails](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ColumResourceName] [nvarchar](50) NOT NULL,
	[ColumOldContent] [nvarchar](max) NULL,
	[ColumNewContent] [nvarchar](max) NULL,
	[FkHistory_Id] [int] NOT NULL,
	[CoulmIsSingl] [bit] NOT NULL,
	[CoulmIsEn] [bit] NOT NULL,
 CONSTRAINT [PK_HistoryDetails] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Jobs]    Script Date: 12/30/2018 8:50:17 PM ******/
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
/****** Object:  Table [dbo].[Languages]    Script Date: 12/30/2018 8:50:17 PM ******/
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
/****** Object:  Table [dbo].[LanguageTypes]    Script Date: 12/30/2018 8:50:18 PM ******/
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
/****** Object:  Table [dbo].[LanguageUsing]    Script Date: 12/30/2018 8:50:18 PM ******/
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
/****** Object:  Table [dbo].[Location]    Script Date: 12/30/2018 8:50:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Location](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Longitude] [nvarchar](50) NOT NULL,
	[Latitude] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Location] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Logs]    Script Date: 12/30/2018 8:50:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Logs](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreateDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_Logs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Menus]    Script Date: 12/30/2018 8:50:18 PM ******/
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
/****** Object:  Table [dbo].[Nationalities]    Script Date: 12/30/2018 8:50:18 PM ******/
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
/****** Object:  Table [dbo].[NotificationsIsRead]    Script Date: 12/30/2018 8:50:18 PM ******/
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
/****** Object:  Table [dbo].[OfferFavorites]    Script Date: 12/30/2018 8:50:18 PM ******/
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
/****** Object:  Table [dbo].[Offers]    Script Date: 12/30/2018 8:50:18 PM ******/
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
	[DiscountRate] [int] NOT NULL,
	[SmallDiscription] [nvarchar](200) NOT NULL,
	[FkCategory_Id] [int] NOT NULL,
	[FkSubCategory_Id] [int] NOT NULL,
 CONSTRAINT [PK_Offers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pages]    Script Date: 12/30/2018 8:50:18 PM ******/
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
/****** Object:  Table [dbo].[PagesAllow]    Script Date: 12/30/2018 8:50:18 PM ******/
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
/****** Object:  Table [dbo].[PagesRoles]    Script Date: 12/30/2018 8:50:18 PM ******/
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
/****** Object:  Table [dbo].[PagesRoleTypes]    Script Date: 12/30/2018 8:50:18 PM ******/
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
/****** Object:  Table [dbo].[PhoneNumbers]    Script Date: 12/30/2018 8:50:19 PM ******/
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
/****** Object:  Table [dbo].[Phones]    Script Date: 12/30/2018 8:50:19 PM ******/
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
/****** Object:  Table [dbo].[PhoneTypes]    Script Date: 12/30/2018 8:50:19 PM ******/
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
/****** Object:  Table [dbo].[PositionTypes]    Script Date: 12/30/2018 8:50:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PositionTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ResourceName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_PositionTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Provinces]    Script Date: 12/30/2018 8:50:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Provinces](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[NameAr] [nvarchar](50) NOT NULL,
	[NameEn] [nvarchar](50) NOT NULL,
	[FKCountry_Id] [int] NOT NULL,
	[FkLog_Id] [int] NOT NULL,
 CONSTRAINT [PK_Provinces] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reports]    Script Date: 12/30/2018 8:50:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reports](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](4000) NULL,
	[FkUser_Id] [int] NOT NULL,
	[FkAd_Id] [int] NOT NULL,
	[FkReportType_Id] [int] NOT NULL,
	[FkLog_Id] [int] NOT NULL,
 CONSTRAINT [PK_Reports] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReportTypes]    Script Date: 12/30/2018 8:50:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReportTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[NameAr] [nvarchar](50) NOT NULL,
	[NameEn] [nvarchar](50) NOT NULL,
	[FkLog_Id] [int] NOT NULL,
 CONSTRAINT [PK_ReportTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 12/30/2018 8:50:19 PM ******/
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
/****** Object:  Table [dbo].[SocialStatus]    Script Date: 12/30/2018 8:50:19 PM ******/
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
/****** Object:  Table [dbo].[States]    Script Date: 12/30/2018 8:50:19 PM ******/
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
/****** Object:  Table [dbo].[SubCategories]    Script Date: 12/30/2018 8:50:19 PM ******/
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
	[FkFile_Id] [int] NOT NULL,
 CONSTRAINT [PK_SubCategories] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SubMenus]    Script Date: 12/30/2018 8:50:20 PM ******/
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
/****** Object:  Table [dbo].[TechnicalSupport]    Script Date: 12/30/2018 8:50:20 PM ******/
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
/****** Object:  Table [dbo].[TechnicalSupportRead]    Script Date: 12/30/2018 8:50:20 PM ******/
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
/****** Object:  Table [dbo].[UserInformation]    Script Date: 12/30/2018 8:50:20 PM ******/
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
	[FkFollowing_Id] [int] NOT NULL,
 CONSTRAINT [PK_UserInformation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserLogins]    Script Date: 12/30/2018 8:50:21 PM ******/
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
/****** Object:  Table [dbo].[UserRoles]    Script Date: 12/30/2018 8:50:21 PM ******/
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
/****** Object:  Table [dbo].[Users]    Script Date: 12/30/2018 8:50:21 PM ******/
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
/****** Object:  Table [dbo].[UsersFollowing]    Script Date: 12/30/2018 8:50:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UsersFollowing](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FkUser_Id] [int] NOT NULL,
	[FkFollowing_Id] [int] NOT NULL,
 CONSTRAINT [PK_Followers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UsersPurchasesAds]    Script Date: 12/30/2018 8:50:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UsersPurchasesAds](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FkUser_Id] [int] NOT NULL,
	[FkAd_Id] [int] NOT NULL,
	[AdPrice] [decimal](18, 2) NOT NULL,
	[BayDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_UsersPurchases] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UsersPurchasesOffers]    Script Date: 12/30/2018 8:50:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UsersPurchasesOffers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FkUser_Id] [int] NOT NULL,
	[FkOffer_Id] [int] NOT NULL,
	[OfferPrice] [decimal](18, 2) NOT NULL,
	[OfferDiscountRate] [int] NOT NULL,
	[OfferNetPrice] [decimal](18, 2) NOT NULL,
	[BayDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_UsersPurchasesOffers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ViewerAds]    Script Date: 12/30/2018 8:50:22 PM ******/
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
/****** Object:  Table [dbo].[ViewerOffers]    Script Date: 12/30/2018 8:50:23 PM ******/
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
GO
INSERT [dbo].[Addresses] ([Id], [Street], [PostalCode], [FKCountry_Id], [FkProvince_Id], [City]) VALUES (1, NULL, N'12', 1, 19, NULL)
GO
INSERT [dbo].[Addresses] ([Id], [Street], [PostalCode], [FKCountry_Id], [FkProvince_Id], [City]) VALUES (2, NULL, N'645', 1, 1, NULL)
GO
INSERT [dbo].[Addresses] ([Id], [Street], [PostalCode], [FKCountry_Id], [FkProvince_Id], [City]) VALUES (3, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Addresses] ([Id], [Street], [PostalCode], [FKCountry_Id], [FkProvince_Id], [City]) VALUES (4, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Addresses] ([Id], [Street], [PostalCode], [FKCountry_Id], [FkProvince_Id], [City]) VALUES (5, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Addresses] ([Id], [Street], [PostalCode], [FKCountry_Id], [FkProvince_Id], [City]) VALUES (6, NULL, NULL, 2, NULL, NULL)
GO
INSERT [dbo].[Addresses] ([Id], [Street], [PostalCode], [FKCountry_Id], [FkProvince_Id], [City]) VALUES (7, NULL, NULL, 2, NULL, NULL)
GO
INSERT [dbo].[Addresses] ([Id], [Street], [PostalCode], [FKCountry_Id], [FkProvince_Id], [City]) VALUES (1007, NULL, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[Addresses] ([Id], [Street], [PostalCode], [FKCountry_Id], [FkProvince_Id], [City]) VALUES (1008, NULL, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[Addresses] ([Id], [Street], [PostalCode], [FKCountry_Id], [FkProvince_Id], [City]) VALUES (1009, NULL, NULL, 1, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[Addresses] OFF
GO
SET IDENTITY_INSERT [dbo].[Ads] ON 
GO
INSERT [dbo].[Ads] ([Id], [Title], [Description], [StartDateTime], [EndDateTime], [Price], [IsTop], [IsApprove], [FkSubCategory_Id], [FkCategory_Id], [FkAlbum_Id], [FkLog_Id], [FkUser_Id], [FkLocation_Id], [PhoneNumber], [IsAllowMessaging], [IsPostWithOutPhoneNumber], [IsAutoPost], [CountAutoPostToNow]) VALUES (7, N'NNNN', N'NNNN', CAST(N'2017-12-19T22:34:08.000' AS DateTime), CAST(N'2020-12-20T22:34:09.000' AS DateTime), CAST(57.00 AS Decimal(8, 2)), 1, 1, 3, 4, 1024, 1276, 1, 3, N'010252', 1, 1, 1, 0)
GO
INSERT [dbo].[Ads] ([Id], [Title], [Description], [StartDateTime], [EndDateTime], [Price], [IsTop], [IsApprove], [FkSubCategory_Id], [FkCategory_Id], [FkAlbum_Id], [FkLog_Id], [FkUser_Id], [FkLocation_Id], [PhoneNumber], [IsAllowMessaging], [IsPostWithOutPhoneNumber], [IsAutoPost], [CountAutoPostToNow]) VALUES (8, N'vb', N'erfgh', CAST(N'2019-01-01T01:00:00.000' AS DateTime), CAST(N'2020-01-01T00:00:00.000' AS DateTime), CAST(55.00 AS Decimal(8, 2)), 0, 0, 3, 4, 1028, 1288, 1, 4, N'010', 0, 0, 0, 0)
GO
SET IDENTITY_INSERT [dbo].[Ads] OFF
GO
SET IDENTITY_INSERT [dbo].[AlbumFiles] ON 
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (1, 1, 1)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (11, 4, 12)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (12, 4, 13)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (13, 4, 14)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (14, 4, 15)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (15, 4, 16)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (17, 5, 18)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (20, 5, 21)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (21, 5, 22)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (22, 5, 23)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (23, 5, 24)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (24, 5, 25)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (25, 7, 26)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (27, 9, 31)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (28, 9, 32)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (29, 9, 33)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (30, 9, 34)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (31, 8, 35)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (32, 8, 36)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (33, 8, 37)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (34, 8, 38)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (35, 8, 39)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (36, 10, 44)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (37, 10, 45)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (38, 10, 46)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (39, 11, 47)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (40, 11, 48)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (41, 11, 49)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (42, 11, 50)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (43, 12, 51)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (44, 12, 52)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (45, 12, 53)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (46, 12, 54)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (47, 12, 55)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (48, 13, 56)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (51, 16, 59)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (52, 16, 60)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (57, 17, 65)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (58, 17, 66)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (62, 18, 70)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (63, 18, 71)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (66, 18, 74)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (67, 18, 75)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (68, 18, 76)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (69, 18, 77)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (70, 18, 78)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (71, 17, 79)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (72, 17, 80)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (73, 17, 81)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (98, 22, 114)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (99, 22, 115)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (100, 22, 116)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (101, 22, 117)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (102, 22, 118)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (103, 22, 119)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (104, 22, 120)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (105, 22, 121)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (1075, 1019, 1094)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (1076, 1019, 1095)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (1077, 1019, 1096)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (1088, 1024, 1107)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (1089, 1024, 1108)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (1090, 1024, 1109)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (1091, 1025, 1110)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (1092, 1025, 1111)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (1093, 1025, 1112)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (1094, 1027, 1113)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (1095, 1027, 1114)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (1096, 1027, 1115)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (1097, 1026, 1116)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (1098, 1026, 1117)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (1099, 1026, 1118)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (1100, 1026, 1119)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (1101, 1026, 1120)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (1102, 1026, 1121)
GO
INSERT [dbo].[AlbumFiles] ([Id], [FkAlbum_Id], [FkFile_Id]) VALUES (1103, 1026, 1122)
GO
SET IDENTITY_INSERT [dbo].[AlbumFiles] OFF
GO
SET IDENTITY_INSERT [dbo].[Albums] ON 
GO
INSERT [dbo].[Albums] ([Id], [Notes]) VALUES (1, NULL)
GO
INSERT [dbo].[Albums] ([Id], [Notes]) VALUES (4, NULL)
GO
INSERT [dbo].[Albums] ([Id], [Notes]) VALUES (5, NULL)
GO
INSERT [dbo].[Albums] ([Id], [Notes]) VALUES (6, NULL)
GO
INSERT [dbo].[Albums] ([Id], [Notes]) VALUES (7, NULL)
GO
INSERT [dbo].[Albums] ([Id], [Notes]) VALUES (8, NULL)
GO
INSERT [dbo].[Albums] ([Id], [Notes]) VALUES (9, NULL)
GO
INSERT [dbo].[Albums] ([Id], [Notes]) VALUES (10, NULL)
GO
INSERT [dbo].[Albums] ([Id], [Notes]) VALUES (11, NULL)
GO
INSERT [dbo].[Albums] ([Id], [Notes]) VALUES (12, NULL)
GO
INSERT [dbo].[Albums] ([Id], [Notes]) VALUES (13, NULL)
GO
INSERT [dbo].[Albums] ([Id], [Notes]) VALUES (16, NULL)
GO
INSERT [dbo].[Albums] ([Id], [Notes]) VALUES (17, NULL)
GO
INSERT [dbo].[Albums] ([Id], [Notes]) VALUES (18, NULL)
GO
INSERT [dbo].[Albums] ([Id], [Notes]) VALUES (22, NULL)
GO
INSERT [dbo].[Albums] ([Id], [Notes]) VALUES (1019, NULL)
GO
INSERT [dbo].[Albums] ([Id], [Notes]) VALUES (1024, NULL)
GO
INSERT [dbo].[Albums] ([Id], [Notes]) VALUES (1025, NULL)
GO
INSERT [dbo].[Albums] ([Id], [Notes]) VALUES (1026, NULL)
GO
INSERT [dbo].[Albums] ([Id], [Notes]) VALUES (1027, NULL)
GO
INSERT [dbo].[Albums] ([Id], [Notes]) VALUES (1028, NULL)
GO
SET IDENTITY_INSERT [dbo].[Albums] OFF
GO
SET IDENTITY_INSERT [dbo].[AppsInformation] ON 
GO
INSERT [dbo].[AppsInformation] ([Id], [ResourceName], [Value], [FkLog_Id]) VALUES (1, N'ControllPanelLink', N'http://localhost:53913/', 259)
GO
INSERT [dbo].[AppsInformation] ([Id], [ResourceName], [Value], [FkLog_Id]) VALUES (2, N'Api', N'http://localhost:50353/', 260)
GO
INSERT [dbo].[AppsInformation] ([Id], [ResourceName], [Value], [FkLog_Id]) VALUES (3, N'AboutUsAr', N'خلافاَ للإعتقاد السائد فإن لوريم إيبسوم ليس نصاَ عشوائياً، بل إن له جذور في الأدب اللاتيني الكلاسيكي منذ العام 45 قبل الميلاد، مما يجعله أكثر من 2000 عام في القدم. قام البروفيسور "ريتشارد ماك لينتوك" (Richard McClintock) وهو بروفيسور اللغة اللاتينية في جامعة هامبدن-سيدني في فيرجينيا بالبحث عن أصول كلمة لاتينية غامضة في نص لوريم إيبسوم وهي "consectetur"، وخلال تتبعه لهذه الكلمة في الأدب اللاتيني اكتشف المصدر الغير قابل للشك. فلقد اتضح أن كلمات نص لوريم إيبسوم تأتي من الأقسام 1.10.32 و 1.10.33 من كتاب "حول أقاصي الخير والشر" (de Finibus Bonorum et Malorum) للمفكر شيشيرون (Cicero) والذي كتبه في عام 45 قبل الميلاد. هذا الكتاب هو بمثابة مقالة علمية مطولة في نظرية الأخلاق، وكان له شعبية كبيرة في عصر النهضة. السطر الأول من لوريم إيبسوم "Lorem ipsum dolor sit amet.." يأتي من سطر في القسم 1.20.32 من هذا الكتاب.

', 261)
GO
INSERT [dbo].[AppsInformation] ([Id], [ResourceName], [Value], [FkLog_Id]) VALUES (4, N'AboutUsEn', N'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.

', 262)
GO
INSERT [dbo].[AppsInformation] ([Id], [ResourceName], [Value], [FkLog_Id]) VALUES (5, N'TermsAr', N'لوريم إيبسوم(Lorem Ipsum) هو ببساطة نص شكلي (بمعنى أن الغاية هي الشكل وليس المحتوى) ويُستخدم في صناعات المطابع ودور النشر. كان لوريم إيبسوم ولايزال المعيار للنص الشكلي منذ القرن الخامس عشر عندما قامت مطبعة مجهولة برص مجموعة من الأحرف بشكل عشوائي أخذتها من نص، لتكوّن كتيّب بمثابة دليل أو مرجع شكلي لهذه الأحرف. خمسة قرون من الزمن لم تقضي على هذا النص، بل انه حتى صار مستخدماً وبشكله الأصلي في الطباعة والتنضيد الإلكتروني. انتشر بشكل كبير في ستينيّات هذا القرن مع إصدار رقائق "ليتراسيت" (Letraset) البلاستيكية تحوي مقاطع من هذا النص، وعاد لينتشر مرة أخرى مؤخراَ مع ظهور برامج النشر الإلكتروني مثل "ألدوس بايج مايكر" (Aldus PageMaker) والتي حوت أيضاً على نسخ من نص لوريم إيبسوم.

', 263)
GO
INSERT [dbo].[AppsInformation] ([Id], [ResourceName], [Value], [FkLog_Id]) VALUES (6, N'TermsEn', N'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.

', 264)
GO
INSERT [dbo].[AppsInformation] ([Id], [ResourceName], [Value], [FkLog_Id]) VALUES (7, N'FaceBookLink', N'http://localhost:50353/', 265)
GO
INSERT [dbo].[AppsInformation] ([Id], [ResourceName], [Value], [FkLog_Id]) VALUES (8, N'TwitterLink', N'http://localhost:50353/', 266)
GO
INSERT [dbo].[AppsInformation] ([Id], [ResourceName], [Value], [FkLog_Id]) VALUES (9, N'InstagramLink', N'http://localhost:50353/', 272)
GO
INSERT [dbo].[AppsInformation] ([Id], [ResourceName], [Value], [FkLog_Id]) VALUES (10, N'AdPeriodDays', N'1', 1267)
GO
SET IDENTITY_INSERT [dbo].[AppsInformation] OFF
GO
SET IDENTITY_INSERT [dbo].[Categories] ON 
GO
INSERT [dbo].[Categories] ([Id], [NameAr], [NameEn], [FkLog_Id]) VALUES (1, N'ملابس', N'Clothes', 203)
GO
INSERT [dbo].[Categories] ([Id], [NameAr], [NameEn], [FkLog_Id]) VALUES (3, N'عقارات', N'Real estate', 205)
GO
INSERT [dbo].[Categories] ([Id], [NameAr], [NameEn], [FkLog_Id]) VALUES (4, N'مركبات', N'Vehicles', 218)
GO
SET IDENTITY_INSERT [dbo].[Categories] OFF
GO
SET IDENTITY_INSERT [dbo].[Countries] ON 
GO
INSERT [dbo].[Countries] ([Id], [NameAr], [NameEn], [FkLog_Id], [CountryKey], [FkFile_Id]) VALUES (1, N'sd', N'sd5', 1, N'21', 88)
GO
INSERT [dbo].[Countries] ([Id], [NameAr], [NameEn], [FkLog_Id], [CountryKey], [FkFile_Id]) VALUES (2, N'الكوست', N'Kwit', 31, N'23', 89)
GO
SET IDENTITY_INSERT [dbo].[Countries] OFF
GO
SET IDENTITY_INSERT [dbo].[Files] ON 
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (1, N'/Files/Images/Users/Profile/team3.jpg1345323910.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (2, N'/Files/Images/Users/Profile/2013-04-20-056.jpg1710883803.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (3, N'/Files/Images/Products12.jpg133553739.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (4, N'/Files/Images/Products2013-04-18-005.jpg1620502976.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (5, N'/Files/Images/Products2013-04-18-008.jpg676717047.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (6, N'/Files/Images/Products2013-04-18-031.jpg257561010.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (7, N'/Files/Images/Products2013-04-18-018.jpg1821788483.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (8, N'/Files/Images/Products2013-04-18-031.jpg1719321017.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (9, N'/Files/Images/Products309533_175924209157228_1171723283_n.jpg1719321017.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (10, N'/Files/Images/Products2013-04-19-049.jpg110481015.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (11, N'/Files/Images/Products574671_423296531086660_623817755_n.jpg461852906.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (12, N'/Files/Images/Products2013-04-18-038.jpg2131060694.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (13, N'/Files/Images/Products2013-04-20-057.jpg334948938.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (14, N'/Files/Images/Products2013-04-18-031.jpg334948938.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (15, N'/Files/Images/Products2013-04-18-037.jpg1711904657.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (16, N'/Files/Images/Products2013-04-18-032.jpg103064655.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (18, N'/Files/Images/Products531038_384620164954297_319905800_n.jpg39438179.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (21, N'/Files/Images/Products2013-04-19-045.jpg1861438131.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (22, N'/Files/Images/Products2013-04-18-038.jpg338174276.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (23, N'/Files/Images/Products2013-04-18-031.jpg338174276.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (24, N'/Files/Images/Products2013-04-18-037.jpg1715129995.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (25, N'/Files/Images/Products2013-04-18-032.jpg944602067.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (26, N'/Files/Images/Products2013-04-18-008.jpg1859443628.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (27, N'~/Files/Images/Users/Profile/userDefult.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (28, N'~/Files/Images/Users/Profile/userDefult.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (29, N'~/Files/Images/Users/Profile/userDefult.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (31, N'/Files/Images/Products2013-04-18-005.jpg123537471.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (32, N'/Files/Images/Products2013-04-18-008.jpg123537471.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (33, N'/Files/Images/Products2013-04-18-031.jpg310809225.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (34, N'/Files/Images/Products2013-04-18-032.jpg310809225.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (35, N'/Files/Images/Products5.jpg1182994235.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (36, N'/Files/Images/Products3.jpg1182994235.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (37, N'/Files/Images/Products4.jpg1534366126.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (38, N'/Files/Images/Products6.jpg1534366126.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (39, N'/Files/Images/Products7.jpg1534366126.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (43, N'~/Files/Images/Users/Profile/userDefult.jpg', 2, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (44, N'/Files/Images/Products1.jpg478824495.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (45, N'/Files/Images/Products2.jpg523437024.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (46, N'/Files/Images/Products3.jpg523437024.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (47, N'/Files/Images/Products1.jpg1109421782.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (48, N'/Files/Images/Products2.jpg1879949710.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (49, N'/Files/Images/Products4.jpg1879949710.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (50, N'/Files/Images/Products3.jpg1528577819.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (51, N'/Files/Images/Products9_1.jpg1242339042.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (52, N'/Files/Images/Products11_2.jpg1242339042.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (53, N'/Files/Images/Products12_1.jpg1242339042.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (54, N'/Files/Images/Products8-1.jpg2012866970.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (55, N'/Files/Images/Products10_2.jpg284539360.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (56, N'/Files/Images/Products3-المجاملات.jpg1134500806.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (59, N'/Files/Images/Products1_2.jpg1174746056.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (60, N'/Files/Images/Offers9.jpg88721010.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (65, N'/Files/Images/Offers7.jpg1298093333.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (66, N'/Files/Images/Offers5.jpg340293651.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (70, N'/Files/Images/Offers5.jpg2136419628.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (71, N'/Files/Images/Offers05_5.jpg408092018.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (74, N'/Files/Images/Offers23.jpg1597775983.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (75, N'/Files/Images/Offers12.jpg220820264.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (76, N'/Files/Images/Offers21.jpg639976301.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (77, N'/Files/Images/Offers22.jpg639976301.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (78, N'/Files/Images/Offers11_1.jpg1410504229.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (79, N'/Files/Images/Offers8.jpg819622345.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (80, N'/Files/Images/Offers11_1.jpg489809904.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (81, N'/Files/Images/Offers23.jpg1679493869.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (82, N'1', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (83, N'2', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (84, N'3', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (85, N'4', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (86, N'5', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (87, N'6', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (88, N'1', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (89, N'2', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (114, N'/Files/Images/Offers14.jpg2017427269.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (115, N'/Files/Images/Offers23.jpg1666055378.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (116, N'/Files/Images/Offers12.jpg289099659.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (117, N'/Files/Images/Offers13.jpg708255696.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (118, N'/Files/Images/Offers22.jpg1478783624.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (119, N'/Files/Images/Offers21.jpg1127411733.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (120, N'/Files/Images/Offers11_1.jpg1897939661.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (121, N'/Files/Images/Offers25.jpg1897939661.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (122, N'~/Files/Images/Users/Profile/userDefult.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (1090, N'', 2, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (1091, N'', 2, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (1092, N'', 2, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (1094, N'/Files/Images/Ads/Imagefe67b4ed-6d2c-48b4-8c72-22132b01b330.jpg', 2, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (1095, N'/Files/Images/Ads/Imagecb98212f-f60b-4db2-b2ac-e6a0801777a7.jpg', 2, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (1096, N'/Files/Images/Ads/Image96df6f99-71a9-454c-89f1-6eb3d7ebfc66.jpg', 2, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (1106, N'/Files/Images/1.jpg841056653.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (1107, N'/Files/Images/2.jpg932516755.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (1108, N'/Files/Images/3.jpg2101264147.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (1109, N'/Files/Images/2.jpg53367186.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (1110, N'/Files/Images/Offers3.jpg873921113.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (1111, N'/Files/Images/Offers2.jpg873921113.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (1112, N'/Files/Images/Offers4.jpg522549222.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (1113, N'/Files/Images/Offers11.jpg463788430.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (1114, N'/Files/Images/Offers9.jpg695672713.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (1115, N'/Files/Images/Offers10.png695672713.png', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (1116, N'/Files/Images/Offers1.png1660627871.png', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (1117, N'/Files/Images/Offers2.jpg351456298.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (1118, N'/Files/Images/Offers3.jpg1121984226.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (1119, N'/Files/Images/Offers4.jpg1121984226.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (1120, N'/Files/Images/Offers9.jpg1960296300.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (1121, N'/Files/Images/Offers11.jpg1960296300.jpg', 1, 1)
GO
INSERT [dbo].[Files] ([Id], [FileUrl], [FKAppInformation_Id], [FkFileType_Id]) VALUES (1122, N'/Files/Images/Offers10.png231968690.png', 1, 1)
GO
SET IDENTITY_INSERT [dbo].[Files] OFF
GO
SET IDENTITY_INSERT [dbo].[FileTypes] ON 
GO
INSERT [dbo].[FileTypes] ([Id], [ResourceName]) VALUES (1, N'Image')
GO
INSERT [dbo].[FileTypes] ([Id], [ResourceName]) VALUES (2, N'Text')
GO
INSERT [dbo].[FileTypes] ([Id], [ResourceName]) VALUES (3, N'Audio')
GO
SET IDENTITY_INSERT [dbo].[FileTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[Following] ON 
GO
INSERT [dbo].[Following] ([Id], [Notes]) VALUES (1, N'1')
GO
INSERT [dbo].[Following] ([Id], [Notes]) VALUES (2, N'2')
GO
INSERT [dbo].[Following] ([Id], [Notes]) VALUES (3, N'3')
GO
INSERT [dbo].[Following] ([Id], [Notes]) VALUES (4, N'4')
GO
INSERT [dbo].[Following] ([Id], [Notes]) VALUES (5, N'5')
GO
INSERT [dbo].[Following] ([Id], [Notes]) VALUES (6, N'6')
GO
INSERT [dbo].[Following] ([Id], [Notes]) VALUES (7, N'7')
GO
INSERT [dbo].[Following] ([Id], [Notes]) VALUES (8, N'8')
GO
INSERT [dbo].[Following] ([Id], [Notes]) VALUES (9, N'9')
GO
SET IDENTITY_INSERT [dbo].[Following] OFF
GO
SET IDENTITY_INSERT [dbo].[Genders] ON 
GO
INSERT [dbo].[Genders] ([Id], [ResourceName]) VALUES (1, N'Male')
GO
INSERT [dbo].[Genders] ([Id], [ResourceName]) VALUES (2, N'Female')
GO
SET IDENTITY_INSERT [dbo].[Genders] OFF
GO
SET IDENTITY_INSERT [dbo].[Histories] ON 
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (62, CAST(N'2018-08-29T21:43:30.787' AS DateTime), NULL, 2, 1, 1, 29, N'Test', N'تجربة')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (63, CAST(N'2018-08-29T21:45:43.793' AS DateTime), NULL, 2, 1, 1, 29, N'Test', N'تجربة')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (111, CAST(N'2018-09-16T00:16:26.573' AS DateTime), NULL, 1, 1, 19, 203, N'Test', N'تجربة')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (112, CAST(N'2018-09-16T00:16:42.780' AS DateTime), NULL, 2, 1, 19, 1, N'Test', N'تجربة')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (114, CAST(N'2018-09-16T00:16:53.407' AS DateTime), NULL, 3, 1, 19, NULL, N'Test', N'تجربة')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (115, CAST(N'2018-09-16T00:16:53.483' AS DateTime), NULL, 1, 1, 19, 205, N'Test', N'تجربة')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (116, CAST(N'2018-09-16T00:46:34.340' AS DateTime), NULL, 1, 1, 19, 218, N'Test', N'تجربة')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (117, CAST(N'2018-09-16T00:50:53.443' AS DateTime), NULL, 2, 1, 19, 203, N'Test', N'تجربة')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (118, CAST(N'2018-09-16T00:50:57.000' AS DateTime), NULL, 2, 1, 19, 205, N'Test', N'تجربة')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (119, CAST(N'2018-09-16T00:50:57.927' AS DateTime), NULL, 2, 1, 19, 218, N'Test', N'تجربة')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (120, CAST(N'2018-09-16T01:23:18.157' AS DateTime), NULL, 1, 1, 20, 219, N'Test', N'تجربة')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (122, CAST(N'2018-09-16T01:23:25.543' AS DateTime), NULL, 3, 1, 20, NULL, N'Test', N'تجربة')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (123, CAST(N'2018-09-16T01:23:36.353' AS DateTime), NULL, 2, 1, 20, 219, N'Test', N'تجربة')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (124, CAST(N'2018-09-16T01:26:27.213' AS DateTime), NULL, 2, 1, 20, 219, N'Test', N'تجربة')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (125, CAST(N'2018-09-16T01:26:27.233' AS DateTime), NULL, 1, 1, 20, 221, N'Test', N'تجربة')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (126, CAST(N'2018-09-16T01:26:27.240' AS DateTime), NULL, 1, 1, 20, 222, N'Test', N'تجربة')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (127, CAST(N'2018-09-16T01:33:26.127' AS DateTime), NULL, 1, 1, 20, 223, N'Test', N'تجربة')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (128, CAST(N'2018-09-16T01:33:26.137' AS DateTime), NULL, 1, 1, 20, 224, N'Test', N'تجربة')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (129, CAST(N'2018-09-16T01:33:26.137' AS DateTime), NULL, 1, 1, 20, 236, N'Test', N'تجربة')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (130, CAST(N'2018-09-16T05:02:10.993' AS DateTime), NULL, 2, 1, 21, 236, N'Test', N'تجربة')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (131, CAST(N'2018-09-16T05:02:35.440' AS DateTime), NULL, 2, 1, 21, 236, N'Test', N'تجربة')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (132, CAST(N'2018-09-16T05:02:40.167' AS DateTime), NULL, 2, 1, 21, 236, N'Test', N'تجربة')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (133, CAST(N'2018-09-16T22:10:51.830' AS DateTime), NULL, 2, 1, 21, 236, N'Test', N'تجربة')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (134, CAST(N'2018-09-16T22:12:47.620' AS DateTime), NULL, 2, 1, 21, 236, N'Test', N'تجربة')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (135, CAST(N'2018-09-16T22:14:51.200' AS DateTime), NULL, 2, 1, 21, 236, N'Test', N'تجربة')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (136, CAST(N'2018-09-19T15:41:23.690' AS DateTime), NULL, 2, 1, 21, 236, N'Test', N'تجربة')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (137, CAST(N'2018-09-19T15:41:23.707' AS DateTime), NULL, 4, 1, 21, 236, N'Test', N'تجربة')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (138, CAST(N'2018-09-19T15:42:21.690' AS DateTime), NULL, 2, 1, 21, 236, N'Test', N'تجربة')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (139, CAST(N'2018-09-19T17:26:50.067' AS DateTime), NULL, 2, 1, 21, 236, N'اعلان الدياسطى', N'اعلان الدياسطى')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (140, CAST(N'2018-09-19T17:26:50.073' AS DateTime), NULL, 5, 1, 21, 236, N'اعلان الدياسطى', N'اعلان الدياسطى')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (145, CAST(N'2018-09-24T01:50:13.147' AS DateTime), NULL, 1, 1, 21, 250, N'sdsdsd', N'sdsdsd')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (146, CAST(N'2018-09-24T01:50:39.803' AS DateTime), NULL, 2, 1, 21, 250, N'sdsdsd', N'sdsdsd')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (147, CAST(N'2018-09-24T01:54:41.060' AS DateTime), NULL, 3, 1, 20, NULL, N'dsdDSDS', N'dsdDSDS')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (148, CAST(N'2018-09-24T14:40:36.360' AS DateTime), NULL, 1, 1, 21, 251, N'new test offer', N'new test offer')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (149, CAST(N'2018-09-24T14:40:51.060' AS DateTime), NULL, 2, 1, 21, 251, N'new test offer', N'new test offer')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (150, CAST(N'2018-09-24T14:41:02.017' AS DateTime), NULL, 2, 1, 21, 251, N'new test offer', N'new test offer')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (151, CAST(N'2018-09-24T14:41:11.827' AS DateTime), NULL, 2, 1, 21, 251, N'new test offer', N'new test offer')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (152, CAST(N'2018-09-24T14:42:59.667' AS DateTime), NULL, 2, 1, 21, 251, N'new test offer', N'new test offer')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (153, CAST(N'2018-09-24T14:43:36.190' AS DateTime), NULL, 2, 1, 21, 251, N'new test offer', N'new test offer')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (154, CAST(N'2018-09-24T14:44:07.013' AS DateTime), NULL, 2, 1, 21, 251, N'new test offer', N'new test offer')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (155, CAST(N'2018-09-24T14:51:57.103' AS DateTime), NULL, 2, 1, 21, 250, N'sdsdsd', N'sdsdsd')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (156, CAST(N'2018-09-24T14:52:09.807' AS DateTime), NULL, 2, 1, 21, 250, N'sdsdsd', N'sdsdsd')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (157, CAST(N'2018-09-24T14:52:28.717' AS DateTime), NULL, 2, 1, 21, 250, N'sdsdsd', N'sdsdsd')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (158, CAST(N'2018-09-24T14:54:51.677' AS DateTime), NULL, 2, 1, 21, 250, N'sdsdsd', N'sdsdsd')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (159, CAST(N'2018-09-24T14:57:22.493' AS DateTime), NULL, 2, 1, 21, 250, N'sdsdsd', N'sdsdsd')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (160, CAST(N'2018-09-24T14:57:40.790' AS DateTime), NULL, 2, 1, 21, 250, N'sdsdsd', N'sdsdsd')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (161, CAST(N'2018-09-24T14:57:53.320' AS DateTime), NULL, 2, 1, 21, 250, N'sdsdsd', N'sdsdsd')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (162, CAST(N'2018-09-24T14:58:14.127' AS DateTime), NULL, 2, 1, 21, 250, N'sdsdsd', N'sdsdsd')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (163, CAST(N'2018-10-17T22:46:39.343' AS DateTime), NULL, 2, 1, 21, 251, N'new test offer', N'new test offer')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (164, CAST(N'2018-10-18T01:01:09.847' AS DateTime), NULL, 1, 1, 22, 270, N'dddd', N'dddd')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (165, CAST(N'2018-10-18T01:04:36.110' AS DateTime), NULL, 2, 1, 22, 250, N'sdsdsd', N'sdsdsd')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (166, CAST(N'2018-12-19T00:13:45.127' AS DateTime), NULL, 1, 1012, 21, 1271, N'تجربة اعلان', N'تجربة اعلان')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (167, CAST(N'2018-12-19T01:03:18.703' AS DateTime), NULL, 2, 1012, 21, 1271, N'تحديث تجربة اعلان', N'تحديث تجربة اعلان')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (168, CAST(N'2018-12-19T01:03:43.103' AS DateTime), NULL, 2, 1012, 21, 1271, N'تحديث تجربة اعلان', N'تحديث تجربة اعلان')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (169, CAST(N'2018-12-19T01:06:20.490' AS DateTime), NULL, 2, 1012, 21, 1271, N'تحديث تجربة اعلان', N'تحديث تجربة اعلان')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (170, CAST(N'2018-12-19T01:11:41.263' AS DateTime), NULL, 3, 1012, 21, NULL, N'تحديث تجربة اعلان', N'تحديث تجربة اعلان')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (171, CAST(N'2018-12-19T18:53:40.910' AS DateTime), NULL, 3, 1, 21, NULL, N'اعلان الدياسطى', N'اعلان الدياسطى')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (172, CAST(N'2018-12-19T22:34:11.733' AS DateTime), NULL, 1, 1, 21, 1276, N'fghj', N'fghj')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (173, CAST(N'2018-12-19T23:40:38.723' AS DateTime), NULL, 2, 1, 22, 1276, N'fghj', N'fghj')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (174, CAST(N'2018-12-19T23:41:00.220' AS DateTime), NULL, 2, 1, 22, 1276, N'fghj', N'fghj')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (175, CAST(N'2018-12-19T23:43:29.620' AS DateTime), NULL, 2, 1, 22, 1276, N'NNNN', N'NNNN')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (176, CAST(N'2018-12-19T23:43:46.607' AS DateTime), NULL, 2, 1, 22, 1276, N'NNNN', N'NNNN')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (177, CAST(N'2018-12-19T23:44:34.170' AS DateTime), NULL, 2, 1, 22, 1276, N'NNNN', N'NNNN')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (178, CAST(N'2018-12-19T23:44:55.303' AS DateTime), NULL, 2, 1, 22, 1276, N'NNNN', N'NNNN')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (179, CAST(N'2018-12-20T00:26:09.287' AS DateTime), NULL, 1, 1, 22, 1277, N'test', N'test')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (180, CAST(N'2018-12-20T00:27:01.917' AS DateTime), NULL, 2, 1, 22, 1277, N'test', N'test')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (181, CAST(N'2018-12-20T00:54:32.567' AS DateTime), NULL, 2, 1, 22, 1276, N'NNNN', N'NNNN')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (182, CAST(N'2018-12-20T01:02:14.333' AS DateTime), NULL, 2, 1, 22, 1276, N'NNNN', N'NNNN')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (183, CAST(N'2018-12-20T01:05:12.790' AS DateTime), NULL, 2, 1, 22, 1277, N'testnnnnn', N'testnnnnn')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (184, CAST(N'2018-12-20T01:08:48.700' AS DateTime), NULL, 3, 1, 22, NULL, N'dgkbfdls', N'dgkbfdls')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (185, CAST(N'2018-12-20T01:19:13.723' AS DateTime), NULL, 1, 1, 22, 1278, N'bnm,', N'bnm,')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (186, CAST(N'2018-12-20T01:24:23.453' AS DateTime), NULL, 1, 1, 22, 1279, N'hjkl', N'hjkl')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (187, CAST(N'2018-12-20T01:32:10.183' AS DateTime), NULL, 2, 1, 22, 1278, N'bnm,', N'bnm,')
GO
INSERT [dbo].[Histories] ([Id], [DateTime], [RedirectUrl], [FkState_Id], [FkUser_Id], [FKPage_Id], [FkLog_Id], [TitleEn], [TitleAr]) VALUES (188, CAST(N'2018-12-20T21:49:56.783' AS DateTime), NULL, 1, 1, 21, 1288, N'vb', N'vb')
GO
SET IDENTITY_INSERT [dbo].[Histories] OFF
GO
SET IDENTITY_INSERT [dbo].[HistoryDetails] ON 
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (219, N'NameAr', NULL, N'sd', 111, 0, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (220, N'NameEn', NULL, N'sd', 111, 0, 1)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (221, N'NameAr', N'sd', N'مصر', 112, 0, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (222, N'NameEn', N'sd5', N'Egypt', 112, 0, 1)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (225, N'NameAr', NULL, N'sd0', 114, 0, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (226, N'NameEn', NULL, N'sddsd', 114, 0, 1)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (227, N'NameAr', NULL, N'dsd', 115, 0, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (228, N'NameEn', NULL, N'ss', 115, 0, 1)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (229, N'NameAr', NULL, N'x', 116, 0, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (230, N'NameEn', NULL, N's', 116, 0, 1)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (231, N'NameAr', N'ملابس', N'sd', 117, 0, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (232, N'NameEn', N'Clothes', N'sd', 117, 0, 1)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (233, N'NameAr', N'عقارات', N'dsd', 118, 0, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (234, N'NameEn', N'Real estate', N'ss', 118, 0, 1)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (235, N'NameAr', N'مركبات', N'x', 119, 0, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (236, N'NameEn', N'Vehicles', N's', 119, 0, 1)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (237, N'NameAr', NULL, N'sd', 120, 0, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (238, N'NameEn', NULL, N'dsds', 120, 0, 1)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (241, N'NameAr', NULL, N'sa', 122, 0, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (242, N'NameEn', NULL, N'ds', 122, 0, 1)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (243, N'NameAr', N'sd2', N'sd', 123, 0, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (244, N'NameEn', N'dsdsw', N'dsds', 123, 0, 1)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (245, N'NameAr', N'دفع رباعى', N'sd2', 124, 0, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (246, N'NameEn', N'4wd', N'dsdsw', 124, 0, 1)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (247, N'NameAr', NULL, N'دراجة نارية', 125, 0, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (248, N'NameEn', NULL, N'Motorcycle', 125, 0, 1)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (249, N'NameAr', NULL, N'دراجة هوائية', 126, 0, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (250, N'NameEn', NULL, N'Bicycles', 126, 0, 1)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (251, N'NameAr', NULL, N'منازل', 127, 0, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (252, N'NameEn', NULL, N'Houses', 127, 0, 1)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (253, N'NameAr', NULL, N'شقق سكنية', 128, 0, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (254, N'NameEn', NULL, N'Apartment', 128, 0, 1)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (255, N'StartDateTime', N'01/01/2010 12:00:00 AM', N'01/02/2020 12:00:00 AM', 130, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (256, N'EndDateTime', N'01/01/2010 12:00:00 AM', N'02/02/2020 12:00:00 AM', 130, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (257, N'IsApprove', N'True', N'False', 130, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (258, N'Title', N'ahmed', N'ads', 131, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (259, N'Description', N'ahmed description', N'ads ads', 131, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (260, N'IsApprove', N'False', N'True', 132, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (261, N'Title', NULL, N'ads00', 133, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (262, N'Title', N'ads', N'ads00', 133, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (263, N'Title', NULL, N'اعلان تجربة', 134, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (264, N'Title', N'ads00', N'اعلان تجربة', 134, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (265, N'Title', N'اعلان تجربة', N'اعلان الدياسطى', 135, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (266, N'IsApprove', N'True', N'False', 136, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (267, N'IsApprove', N'True', N'False', 137, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (268, N'Id', NULL, NULL, 139, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (269, N'Id', NULL, N'1', 139, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (270, N'IsApprove', N'False', N'True', 139, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (271, N'Id', NULL, NULL, 140, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (272, N'Id', NULL, N'1', 140, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (273, N'IsApprove', N'False', N'True', 140, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (286, N'Title', NULL, N'sdsdsd', 145, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (287, N'Description', NULL, N'ssdsd', 145, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (288, N'IsTop', NULL, N'False', 145, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (289, N'Price', NULL, N'20', 145, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (290, N'Id', NULL, NULL, 146, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (291, N'Id', NULL, N'4', 146, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (292, N'Description', N'ssdsd', N'000ssdsd', 146, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (293, N'Id', NULL, N'3', 147, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (294, N'NameAr', NULL, N'dsdDSDS', 147, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (295, N'NameEn', NULL, N'DSD', 147, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (296, N'Title', NULL, N'new test offer', 148, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (297, N'Description', NULL, N'fdfncvmvmkjjfkgj', 148, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (298, N'IsTop', NULL, N'False', 148, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (299, N'Price', NULL, N'500', 148, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (300, N'Id', NULL, NULL, 149, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (301, N'Id', NULL, N'5', 149, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (302, N'Description', N'fdfncvmvmkjjfkgj', N'test update', 149, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (303, N'Title', NULL, N'dddd', 164, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (304, N'Description', NULL, N'dsdsdjhj', 164, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (305, N'IsTop', NULL, N'False', 164, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (306, N'Price', NULL, N'3', 164, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (307, N'Title', NULL, N'تجربة اعلان', 166, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (308, N'Description', NULL, N'تجربة اعلان وصف', 166, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (309, N'Price', NULL, N'45', 166, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (310, N'CategoryNameEn', NULL, N'ملابس', 166, 0, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (311, N'CategoryNameAr', NULL, N'Clothes', 166, 0, 1)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (312, N'Title', N'تجربة اعلان', N'تحديث تجربة اعلان', 167, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (313, N'Description', N'تجربة اعلان وصف', N'تحديث تجربة اعلان وصف', 167, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (314, N'Price', N'45.00', N'45', 167, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (315, N'Price', N'45.00', N'45', 168, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (316, N'Price', N'45.00', N'45', 169, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (317, N'Title', NULL, N'تحديث تجربة اعلان', 170, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (318, N'Description', NULL, N'تحديث تجربة اعلان وصف', 170, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (319, N'Price', NULL, N'45.00', 170, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (320, N'Id', NULL, N'1', 171, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (321, N'Title', NULL, N'اعلان الدياسطى', 171, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (322, N'Description', NULL, N'ads ads', 171, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (323, N'Title', NULL, N'fghj', 172, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (324, N'Description', NULL, N'ghjk', 172, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (325, N'IsApprove', NULL, N'True', 172, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (326, N'IsTop', NULL, N'True', 172, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (327, N'Price', NULL, N'55', 172, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (328, N'Id', NULL, NULL, 174, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (329, N'Id', NULL, N'7', 174, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (330, N'Title', N'fghj', N'NNNN', 174, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (331, N'Description', N'ghjk', N'NNNN', 174, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (332, N'Title', NULL, N'test', 179, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (333, N'Description', NULL, N'ff', 179, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (334, N'IsTop', NULL, N'True', 179, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (335, N'Price', NULL, N'500', 179, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (336, N'Id', NULL, NULL, 180, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (337, N'Id', NULL, N'1006', 180, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (338, N'Title', N'test', N'testnnnnn', 180, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (339, N'Description', N'ff', N'testnnnnn', 180, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (340, N'Id', NULL, NULL, 181, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (341, N'Id', NULL, N'7', 181, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (342, N'EndDateTime', N'20/12/2018 10:34:09 PM', N'20/12/2019 10:34:09 PM', 181, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (343, N'Id', NULL, NULL, 183, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (344, N'Id', NULL, N'1006', 183, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (345, N'EndDateTime', N'01/01/2020 01:00:00 AM', N'31/01/2020 01:00:00 AM', 183, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (346, N'Id', NULL, N'1006', 184, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (347, N'Title', NULL, N'dgkbfdls', 184, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (348, N'Description', NULL, N'testnnnnn', 184, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (349, N'Title', NULL, N'bnm,', 185, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (350, N'Description', NULL, N'nj', 185, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (351, N'IsTop', NULL, N'True', 185, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (352, N'Price', NULL, N'55', 185, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (353, N'Title', NULL, N'hjkl', 186, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (354, N'Description', NULL, N'hjkl', 186, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (355, N'IsTop', NULL, N'True', 186, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (356, N'Price', NULL, N'5', 186, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (357, N'Title', NULL, N'vb', 188, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (358, N'Description', NULL, N'erfgh', 188, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (359, N'IsApprove', NULL, N'False', 188, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (360, N'IsTop', NULL, N'False', 188, 1, 0)
GO
INSERT [dbo].[HistoryDetails] ([Id], [ColumResourceName], [ColumOldContent], [ColumNewContent], [FkHistory_Id], [CoulmIsSingl], [CoulmIsEn]) VALUES (361, N'Price', NULL, N'55', 188, 1, 0)
GO
SET IDENTITY_INSERT [dbo].[HistoryDetails] OFF
GO
SET IDENTITY_INSERT [dbo].[Jobs] ON 
GO
INSERT [dbo].[Jobs] ([Id], [NameAr], [NameEn], [FkLog_Id]) VALUES (1, N'مطور', N'Developer', 4)
GO
INSERT [dbo].[Jobs] ([Id], [NameAr], [NameEn], [FkLog_Id]) VALUES (4, N'محاسب', N'Account', 35)
GO
SET IDENTITY_INSERT [dbo].[Jobs] OFF
GO
SET IDENTITY_INSERT [dbo].[Languages] ON 
GO
INSERT [dbo].[Languages] ([Id], [Notes]) VALUES (1, N'')
GO
INSERT [dbo].[Languages] ([Id], [Notes]) VALUES (2, NULL)
GO
INSERT [dbo].[Languages] ([Id], [Notes]) VALUES (3, NULL)
GO
INSERT [dbo].[Languages] ([Id], [Notes]) VALUES (4, NULL)
GO
INSERT [dbo].[Languages] ([Id], [Notes]) VALUES (5, NULL)
GO
SET IDENTITY_INSERT [dbo].[Languages] OFF
GO
SET IDENTITY_INSERT [dbo].[LanguageTypes] ON 
GO
INSERT [dbo].[LanguageTypes] ([Id], [ResourceName], [Code]) VALUES (1, N'Arabic', N'ar')
GO
INSERT [dbo].[LanguageTypes] ([Id], [ResourceName], [Code]) VALUES (2, N'English', N'en')
GO
SET IDENTITY_INSERT [dbo].[LanguageTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[LanguageUsing] ON 
GO
INSERT [dbo].[LanguageUsing] ([Id], [IsDefault], [FKLanguageType_Id], [FKLanguage_Id]) VALUES (1, 1, 2, 1)
GO
INSERT [dbo].[LanguageUsing] ([Id], [IsDefault], [FKLanguageType_Id], [FKLanguage_Id]) VALUES (3, 0, 1, 1)
GO
INSERT [dbo].[LanguageUsing] ([Id], [IsDefault], [FKLanguageType_Id], [FKLanguage_Id]) VALUES (4, 1, 2, 2)
GO
SET IDENTITY_INSERT [dbo].[LanguageUsing] OFF
GO
SET IDENTITY_INSERT [dbo].[Location] ON 
GO
INSERT [dbo].[Location] ([Id], [Longitude], [Latitude]) VALUES (1, N'h', N'k')
GO
INSERT [dbo].[Location] ([Id], [Longitude], [Latitude]) VALUES (2, N'23654', N'8571')
GO
INSERT [dbo].[Location] ([Id], [Longitude], [Latitude]) VALUES (3, N'4545', N'8845')
GO
INSERT [dbo].[Location] ([Id], [Longitude], [Latitude]) VALUES (4, N'qfdg', N'erth')
GO
SET IDENTITY_INSERT [dbo].[Location] OFF
GO
SET IDENTITY_INSERT [dbo].[Logs] ON 
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (1, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (2, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (4, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (5, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (6, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (7, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (8, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (9, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (10, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (29, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (30, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (31, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (35, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (36, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (37, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (38, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (39, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (40, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (41, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (42, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (43, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (44, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (45, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (46, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (47, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (48, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (49, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (50, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (60, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (61, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (62, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (63, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (64, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (65, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (66, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (67, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (68, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (69, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (70, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (71, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (72, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (73, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (74, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (75, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (76, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (77, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (78, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (79, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (80, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (81, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (82, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (83, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (84, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (85, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (86, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (87, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (88, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (96, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (97, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (98, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (100, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (101, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (102, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (103, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (105, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (106, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (107, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (124, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (126, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (128, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (177, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (178, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (179, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (180, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (181, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (182, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (183, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (186, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (187, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (193, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (194, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (195, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (196, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (197, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (198, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (199, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (200, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (201, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (202, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (203, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (205, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (208, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (209, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (210, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (211, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (212, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (213, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (214, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (215, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (216, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (217, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (218, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (219, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (221, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (222, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (223, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (224, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (225, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (226, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (227, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (228, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (229, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (230, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (231, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (232, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (233, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (234, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (236, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (237, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (238, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (239, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (240, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (241, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (242, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (243, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (244, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (245, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (246, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (250, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (251, CAST(N'2018-10-15T04:57:52.483' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (252, CAST(N'2018-10-17T18:01:55.757' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (253, CAST(N'2018-10-17T18:01:55.843' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (254, CAST(N'2018-10-17T18:01:55.853' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (255, CAST(N'2018-10-17T18:01:55.857' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (256, CAST(N'2018-10-17T18:01:55.860' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (257, CAST(N'2018-10-17T18:01:55.877' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (258, CAST(N'2018-10-17T18:02:32.917' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (259, CAST(N'2018-10-17T18:58:29.720' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (260, CAST(N'2018-10-17T18:58:39.487' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (261, CAST(N'2018-10-17T18:58:47.700' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (262, CAST(N'2018-10-17T18:58:55.340' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (263, CAST(N'2018-10-17T18:59:00.977' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (264, CAST(N'2018-10-17T18:59:07.940' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (265, CAST(N'2018-10-17T19:02:33.457' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (266, CAST(N'2018-10-17T19:02:39.977' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (270, CAST(N'2018-10-18T01:01:09.847' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (271, CAST(N'2018-10-20T00:12:52.940' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (272, CAST(N'2018-10-20T01:34:24.413' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (1267, CAST(N'2018-10-20T01:34:24.413' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (1268, CAST(N'2018-12-18T23:40:02.027' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (1269, CAST(N'2018-12-18T23:50:45.700' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (1270, CAST(N'2018-12-18T23:56:04.773' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (1271, CAST(N'2018-12-19T00:13:45.107' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (1276, CAST(N'2018-12-19T22:34:09.703' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (1277, CAST(N'2018-12-20T00:26:09.287' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (1278, CAST(N'2018-12-20T01:19:13.723' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (1279, CAST(N'2018-12-20T01:24:23.453' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (1280, CAST(N'2018-12-20T17:58:55.033' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (1281, CAST(N'2018-12-20T17:58:55.057' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (1282, CAST(N'2018-12-20T17:58:55.060' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (1283, CAST(N'2018-12-20T17:58:55.060' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (1284, CAST(N'2018-12-20T18:00:08.173' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (1285, CAST(N'2018-12-20T18:00:08.187' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (1286, CAST(N'2018-12-20T18:00:08.190' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (1287, CAST(N'2018-12-20T18:00:08.190' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (1288, CAST(N'2018-12-20T21:49:56.783' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (1289, CAST(N'2018-12-25T16:29:48.403' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (1290, CAST(N'2018-12-25T16:29:48.430' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (1291, CAST(N'2018-12-25T16:29:48.440' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (1292, CAST(N'2018-12-25T16:29:48.440' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (1293, CAST(N'2018-12-25T17:34:36.800' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (1294, CAST(N'2018-12-25T17:34:36.810' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (1295, CAST(N'2018-12-25T17:34:36.813' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (1296, CAST(N'2018-12-25T17:34:36.813' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (1297, CAST(N'2018-12-30T18:01:59.247' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (1298, CAST(N'2018-12-30T18:01:59.310' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (1299, CAST(N'2018-12-30T18:01:59.320' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (1300, CAST(N'2018-12-30T18:01:59.320' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (1301, CAST(N'2018-12-30T20:48:39.793' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (1302, CAST(N'2018-12-30T20:48:39.813' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (1303, CAST(N'2018-12-30T20:48:39.850' AS DateTime))
GO
INSERT [dbo].[Logs] ([Id], [CreateDateTime]) VALUES (1304, CAST(N'2018-12-30T20:48:39.850' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Logs] OFF
GO
SET IDENTITY_INSERT [dbo].[Menus] ON 
GO
INSERT [dbo].[Menus] ([Id], [OrderNumber], [ClassIcon], [ResourceName]) VALUES (1, 1, N'far fa-hand-point-right', N'Setting')
GO
INSERT [dbo].[Menus] ([Id], [OrderNumber], [ClassIcon], [ResourceName]) VALUES (2, 3, N'far fa-hand-point-right', N'Users')
GO
INSERT [dbo].[Menus] ([Id], [OrderNumber], [ClassIcon], [ResourceName]) VALUES (7, 4, N'far fa-hand-point-right', N'TechnicalSupport')
GO
INSERT [dbo].[Menus] ([Id], [OrderNumber], [ClassIcon], [ResourceName]) VALUES (8, 2, N'far fa-hand-point-right', N'Categories')
GO
INSERT [dbo].[Menus] ([Id], [OrderNumber], [ClassIcon], [ResourceName]) VALUES (9, 5, N'far fa-hand-point-right', N'Ads')
GO
INSERT [dbo].[Menus] ([Id], [OrderNumber], [ClassIcon], [ResourceName]) VALUES (10, 6, N'far fa-hand-point-right', N'Offers')
GO
SET IDENTITY_INSERT [dbo].[Menus] OFF
GO
SET IDENTITY_INSERT [dbo].[Nationalities] ON 
GO
INSERT [dbo].[Nationalities] ([Id], [NameAr], [NameEn], [FkLog_Id]) VALUES (1, N'مصرى', N'Egeiption', 5)
GO
INSERT [dbo].[Nationalities] ([Id], [NameAr], [NameEn], [FkLog_Id]) VALUES (2, N'سعودى', N'Saudi', 96)
GO
INSERT [dbo].[Nationalities] ([Id], [NameAr], [NameEn], [FkLog_Id]) VALUES (3, N'كويتى', N'Kuwaiti', 97)
GO
SET IDENTITY_INSERT [dbo].[Nationalities] OFF
GO
SET IDENTITY_INSERT [dbo].[NotificationsIsRead] ON 
GO
INSERT [dbo].[NotificationsIsRead] ([Id], [FkHistory_Id], [FKUser_Id]) VALUES (18, 135, 1)
GO
INSERT [dbo].[NotificationsIsRead] ([Id], [FkHistory_Id], [FKUser_Id]) VALUES (19, 140, 1)
GO
INSERT [dbo].[NotificationsIsRead] ([Id], [FkHistory_Id], [FKUser_Id]) VALUES (20, 139, 1)
GO
SET IDENTITY_INSERT [dbo].[NotificationsIsRead] OFF
GO
SET IDENTITY_INSERT [dbo].[Offers] ON 
GO
INSERT [dbo].[Offers] ([Id], [Title], [Description], [StartDateTime], [EndDateTime], [Price], [IsTop], [FkAlbum_Id], [FkLog_Id], [DiscountRate], [SmallDiscription], [FkCategory_Id], [FkSubCategory_Id]) VALUES (1007, N'njkl', N'nj', CAST(N'2018-12-20T03:16:00.000' AS DateTime), CAST(N'2018-12-20T05:16:00.000' AS DateTime), CAST(55.00 AS Decimal(8, 2)), 1, 1026, 1278, 1, N'njkl', 4, 3)
GO
INSERT [dbo].[Offers] ([Id], [Title], [Description], [StartDateTime], [EndDateTime], [Price], [IsTop], [FkAlbum_Id], [FkLog_Id], [DiscountRate], [SmallDiscription], [FkCategory_Id], [FkSubCategory_Id]) VALUES (1008, N'hjkl', N'hjkl', CAST(N'2018-12-20T03:23:00.000' AS DateTime), CAST(N'2018-12-20T05:23:00.000' AS DateTime), CAST(5.00 AS Decimal(8, 2)), 1, 1027, 1279, 5, N'hjkl;', 4, 3)
GO
SET IDENTITY_INSERT [dbo].[Offers] OFF
GO
SET IDENTITY_INSERT [dbo].[Pages] ON 
GO
INSERT [dbo].[Pages] ([Id], [ResourceName], [IsControlPanel], [IsFronEnd], [Url]) VALUES (1, N'Provinces', 1, 0, N'Provinces')
GO
INSERT [dbo].[Pages] ([Id], [ResourceName], [IsControlPanel], [IsFronEnd], [Url]) VALUES (2, N'Users', 1, 0, N'Users')
GO
INSERT [dbo].[Pages] ([Id], [ResourceName], [IsControlPanel], [IsFronEnd], [Url]) VALUES (3, N'Jobs', 1, 0, N'Jobs')
GO
INSERT [dbo].[Pages] ([Id], [ResourceName], [IsControlPanel], [IsFronEnd], [Url]) VALUES (4, N'Countries', 1, 0, N'Countries')
GO
INSERT [dbo].[Pages] ([Id], [ResourceName], [IsControlPanel], [IsFronEnd], [Url]) VALUES (5, N'PagesAllow', 1, 0, N'PagesAllow')
GO
INSERT [dbo].[Pages] ([Id], [ResourceName], [IsControlPanel], [IsFronEnd], [Url]) VALUES (6, N'PagesRoles', 1, 0, N'PagesRoles')
GO
INSERT [dbo].[Pages] ([Id], [ResourceName], [IsControlPanel], [IsFronEnd], [Url]) VALUES (7, N'Nationalities', 1, 0, N'Nationalities')
GO
INSERT [dbo].[Pages] ([Id], [ResourceName], [IsControlPanel], [IsFronEnd], [Url]) VALUES (8, N'UserLogins', 1, 0, N'UserLogins')
GO
INSERT [dbo].[Pages] ([Id], [ResourceName], [IsControlPanel], [IsFronEnd], [Url]) VALUES (9, N'Notifications', 1, 0, N'Notifications')
GO
INSERT [dbo].[Pages] ([Id], [ResourceName], [IsControlPanel], [IsFronEnd], [Url]) VALUES (16, N'TechnicalSupport', 1, 0, N'TechnicalSupport')
GO
INSERT [dbo].[Pages] ([Id], [ResourceName], [IsControlPanel], [IsFronEnd], [Url]) VALUES (17, N'Menus', 1, 0, N'Menus')
GO
INSERT [dbo].[Pages] ([Id], [ResourceName], [IsControlPanel], [IsFronEnd], [Url]) VALUES (18, N'SubMenus', 1, 0, N'SubMenus')
GO
INSERT [dbo].[Pages] ([Id], [ResourceName], [IsControlPanel], [IsFronEnd], [Url]) VALUES (19, N'Categories', 1, 0, N'Categories')
GO
INSERT [dbo].[Pages] ([Id], [ResourceName], [IsControlPanel], [IsFronEnd], [Url]) VALUES (20, N'SubCategories', 1, 0, N'SubCategories')
GO
INSERT [dbo].[Pages] ([Id], [ResourceName], [IsControlPanel], [IsFronEnd], [Url]) VALUES (21, N'Ads', 1, 1, N'Ads')
GO
INSERT [dbo].[Pages] ([Id], [ResourceName], [IsControlPanel], [IsFronEnd], [Url]) VALUES (22, N'Offers', 1, 0, N'Offers')
GO
INSERT [dbo].[Pages] ([Id], [ResourceName], [IsControlPanel], [IsFronEnd], [Url]) VALUES (23, N'AppsInformations', 1, 0, N'AppsInformations')
GO
INSERT [dbo].[Pages] ([Id], [ResourceName], [IsControlPanel], [IsFronEnd], [Url]) VALUES (24, N'UsersPurchasesAds', 1, 0, N'UsersPurchasesAds')
GO
INSERT [dbo].[Pages] ([Id], [ResourceName], [IsControlPanel], [IsFronEnd], [Url]) VALUES (25, N'UsersPurchasesOffers', 1, 0, N'UsersPurchasesOffers')
GO
INSERT [dbo].[Pages] ([Id], [ResourceName], [IsControlPanel], [IsFronEnd], [Url]) VALUES (26, N'AdsSlider', 1, 0, N'AdsSlider')
GO
INSERT [dbo].[Pages] ([Id], [ResourceName], [IsControlPanel], [IsFronEnd], [Url]) VALUES (27, N'AdsSlider', 1, 0, N'AdsSlider')
GO
INSERT [dbo].[Pages] ([Id], [ResourceName], [IsControlPanel], [IsFronEnd], [Url]) VALUES (28, N'Reports', 1, 0, N'Reports')
GO
INSERT [dbo].[Pages] ([Id], [ResourceName], [IsControlPanel], [IsFronEnd], [Url]) VALUES (29, N'ReportTypes', 1, 0, N'ReportTypes')
GO
SET IDENTITY_INSERT [dbo].[Pages] OFF
GO
SET IDENTITY_INSERT [dbo].[PagesAllow] ON 
GO
INSERT [dbo].[PagesAllow] ([Id], [IsAllowNotify], [IsAllowLog], [FkLog_Id], [FkPage_Id]) VALUES (1, 1, 1, 6, 1)
GO
INSERT [dbo].[PagesAllow] ([Id], [IsAllowNotify], [IsAllowLog], [FkLog_Id], [FkPage_Id]) VALUES (2, 1, 1, 7, 2)
GO
INSERT [dbo].[PagesAllow] ([Id], [IsAllowNotify], [IsAllowLog], [FkLog_Id], [FkPage_Id]) VALUES (3, 1, 1, 8, 3)
GO
INSERT [dbo].[PagesAllow] ([Id], [IsAllowNotify], [IsAllowLog], [FkLog_Id], [FkPage_Id]) VALUES (4, 1, 1, 9, 4)
GO
INSERT [dbo].[PagesAllow] ([Id], [IsAllowNotify], [IsAllowLog], [FkLog_Id], [FkPage_Id]) VALUES (5, 1, 1, 10, 5)
GO
INSERT [dbo].[PagesAllow] ([Id], [IsAllowNotify], [IsAllowLog], [FkLog_Id], [FkPage_Id]) VALUES (6, 1, 1, 36, 6)
GO
INSERT [dbo].[PagesAllow] ([Id], [IsAllowNotify], [IsAllowLog], [FkLog_Id], [FkPage_Id]) VALUES (7, 1, 1, 88, 7)
GO
INSERT [dbo].[PagesAllow] ([Id], [IsAllowNotify], [IsAllowLog], [FkLog_Id], [FkPage_Id]) VALUES (9, 1, 1, 107, 9)
GO
INSERT [dbo].[PagesAllow] ([Id], [IsAllowNotify], [IsAllowLog], [FkLog_Id], [FkPage_Id]) VALUES (16, 1, 1, 177, 16)
GO
INSERT [dbo].[PagesAllow] ([Id], [IsAllowNotify], [IsAllowLog], [FkLog_Id], [FkPage_Id]) VALUES (17, 1, 1, 202, 19)
GO
INSERT [dbo].[PagesAllow] ([Id], [IsAllowNotify], [IsAllowLog], [FkLog_Id], [FkPage_Id]) VALUES (18, 1, 1, 208, 20)
GO
INSERT [dbo].[PagesAllow] ([Id], [IsAllowNotify], [IsAllowLog], [FkLog_Id], [FkPage_Id]) VALUES (19, 1, 1, 234, 21)
GO
INSERT [dbo].[PagesAllow] ([Id], [IsAllowNotify], [IsAllowLog], [FkLog_Id], [FkPage_Id]) VALUES (20, 1, 1, 246, 22)
GO
INSERT [dbo].[PagesAllow] ([Id], [IsAllowNotify], [IsAllowLog], [FkLog_Id], [FkPage_Id]) VALUES (23, 1, 1, 258, 23)
GO
INSERT [dbo].[PagesAllow] ([Id], [IsAllowNotify], [IsAllowLog], [FkLog_Id], [FkPage_Id]) VALUES (24, 1, 1, 1280, 24)
GO
INSERT [dbo].[PagesAllow] ([Id], [IsAllowNotify], [IsAllowLog], [FkLog_Id], [FkPage_Id]) VALUES (25, 1, 1, 1284, 25)
GO
INSERT [dbo].[PagesAllow] ([Id], [IsAllowNotify], [IsAllowLog], [FkLog_Id], [FkPage_Id]) VALUES (26, 1, 1, 1289, 26)
GO
INSERT [dbo].[PagesAllow] ([Id], [IsAllowNotify], [IsAllowLog], [FkLog_Id], [FkPage_Id]) VALUES (28, 1, 1, 1297, 28)
GO
INSERT [dbo].[PagesAllow] ([Id], [IsAllowNotify], [IsAllowLog], [FkLog_Id], [FkPage_Id]) VALUES (29, 1, 1, 1301, 29)
GO
SET IDENTITY_INSERT [dbo].[PagesAllow] OFF
GO
SET IDENTITY_INSERT [dbo].[PagesRoles] ON 
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (18, 1, 1, 1, 1, 1, 1, 1, 37)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (19, 1, 1, 1, 1, 1, 1, 2, 38)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (20, 1, 1, 1, 1, 1, 1, 3, 39)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (21, 1, 1, 1, 1, 1, 2, 1, 40)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (22, 1, 1, 1, 1, 1, 2, 2, 41)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (23, 1, 1, 1, 1, 1, 2, 3, 42)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (24, 1, 1, 1, 1, 2, 1, 1, 43)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (25, 1, 1, 1, 1, 2, 1, 2, 44)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (26, 1, 1, 1, 1, 2, 1, 3, 45)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (27, 1, 1, 1, 1, 2, 2, 1, 46)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (28, 1, 1, 1, 1, 2, 2, 2, 47)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (29, 1, 1, 1, 1, 2, 2, 3, 48)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (30, 1, 1, 1, 1, 3, 1, 1, 49)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (31, 1, 1, 1, 1, 3, 1, 2, 50)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (32, 1, 1, 1, 1, 3, 1, 3, 60)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (33, 1, 1, 1, 1, 3, 2, 1, 61)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (34, 1, 1, 1, 1, 3, 2, 2, 62)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (35, 1, 1, 1, 1, 3, 2, 3, 63)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (36, 1, 1, 1, 1, 4, 1, 1, 64)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (37, 1, 1, 1, 1, 4, 1, 2, 65)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (38, 1, 1, 1, 1, 4, 1, 3, 66)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (39, 1, 1, 1, 1, 4, 2, 1, 67)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (40, 1, 1, 1, 1, 4, 2, 2, 68)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (41, 1, 1, 1, 1, 4, 2, 3, 69)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (42, 1, 1, 1, 1, 5, 1, 1, 70)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (43, 1, 1, 1, 1, 5, 1, 2, 71)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (44, 1, 1, 1, 1, 5, 1, 3, 72)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (45, 1, 1, 1, 1, 5, 2, 1, 73)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (46, 1, 1, 1, 1, 5, 2, 2, 74)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (47, 1, 1, 1, 1, 5, 2, 3, 75)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (48, 1, 1, 1, 1, 6, 1, 1, 76)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (49, 1, 1, 1, 1, 6, 1, 2, 77)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (50, 1, 1, 1, 1, 6, 1, 3, 78)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (51, 1, 1, 1, 1, 6, 2, 1, 79)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (52, 1, 1, 1, 1, 6, 2, 2, 80)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (53, 1, 1, 1, 1, 6, 2, 3, 81)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (54, 1, 1, 1, 1, 7, 1, 1, 82)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (55, 1, 1, 1, 1, 7, 1, 2, 83)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (56, 1, 1, 1, 1, 7, 1, 3, 84)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (57, 1, 1, 1, 1, 7, 2, 1, 85)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (58, 1, 1, 1, 1, 7, 2, 2, 86)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (59, 1, 1, 1, 1, 7, 2, 3, 87)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (66, 1, 1, 1, 1, 8, 1, 1, 98)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (67, 1, 1, 1, 1, 8, 1, 2, 100)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (68, 1, 1, 1, 1, 8, 1, 3, 101)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (69, 1, 1, 1, 1, 8, 2, 1, 102)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (70, 1, 1, 1, 1, 8, 2, 2, 103)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (108, 1, 1, 1, 1, 16, 1, 1, 178)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (109, 1, 1, 1, 1, 16, 1, 2, 179)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (110, 1, 1, 1, 1, 16, 1, 3, 180)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (111, 1, 1, 1, 1, 16, 2, 1, 181)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (112, 1, 1, 1, 1, 16, 2, 2, 182)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (113, 1, 1, 1, 1, 16, 2, 3, 183)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (119, 1, 1, 1, 1, 17, 1, 1, 186)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (120, 1, 1, 1, 1, 18, 1, 1, 187)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (122, 1, 1, 1, 1, 19, 1, 1, 193)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (123, 1, 1, 1, 1, 19, 2, 1, 194)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (124, 1, 1, 1, 1, 19, 3, 1, 195)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (125, 1, 1, 1, 1, 19, 1, 2, 196)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (126, 1, 1, 1, 1, 19, 2, 2, 197)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (127, 1, 1, 1, 1, 19, 3, 2, 198)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (128, 1, 1, 1, 1, 19, 1, 3, 199)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (129, 1, 1, 1, 1, 19, 2, 3, 200)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (130, 1, 1, 1, 1, 19, 3, 3, 201)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (131, 1, 1, 1, 1, 20, 1, 1, 209)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (132, 1, 1, 1, 1, 20, 2, 1, 210)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (133, 1, 1, 1, 1, 20, 3, 1, 211)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (134, 1, 1, 1, 1, 20, 1, 2, 212)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (135, 1, 1, 1, 1, 20, 2, 2, 213)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (136, 1, 1, 1, 1, 20, 3, 2, 214)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (137, 1, 1, 1, 1, 20, 1, 3, 215)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (138, 1, 1, 1, 1, 20, 2, 3, 216)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (139, 1, 1, 1, 1, 20, 3, 3, 217)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (140, 1, 1, 1, 1, 21, 1, 1, 225)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (141, 1, 1, 1, 1, 21, 2, 1, 226)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (142, 1, 1, 1, 1, 21, 3, 1, 227)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (143, 1, 1, 1, 1, 21, 1, 2, 228)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (144, 1, 1, 1, 1, 21, 2, 2, 229)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (145, 1, 1, 1, 1, 21, 3, 2, 230)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (146, 1, 1, 1, 1, 21, 1, 3, 231)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (147, 1, 1, 1, 1, 21, 2, 3, 232)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (148, 1, 1, 1, 1, 21, 3, 3, 233)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (149, 1, 1, 1, 1, 22, 1, 1, 237)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (150, 1, 1, 1, 1, 22, 2, 1, 238)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (151, 1, 1, 1, 1, 22, 3, 1, 239)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (152, 1, 1, 1, 1, 22, 1, 2, 240)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (153, 1, 1, 1, 1, 22, 2, 2, 241)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (154, 1, 1, 1, 1, 22, 3, 2, 242)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (155, 1, 1, 1, 1, 22, 1, 3, 243)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (156, 1, 1, 1, 1, 22, 2, 3, 244)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (157, 1, 1, 1, 1, 22, 3, 3, 245)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (165, 1, 1, 1, 1, 23, 1, 1, 252)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (166, 1, 1, 1, 1, 23, 2, 1, 253)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (167, 1, 1, 1, 1, 23, 1, 2, 254)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (168, 1, 1, 1, 1, 23, 2, 2, 255)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (169, 1, 1, 1, 1, 23, 1, 3, 256)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (170, 1, 1, 1, 1, 23, 2, 3, 257)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (171, 1, 1, 1, 1, 24, 2, 1, 1281)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (172, 1, 1, 1, 1, 24, 2, 2, 1282)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (173, 1, 1, 1, 1, 24, 2, 3, 1283)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (174, 1, 1, 1, 1, 25, 2, 1, 1285)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (175, 1, 1, 1, 1, 25, 2, 2, 1286)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (176, 1, 1, 1, 1, 25, 2, 3, 1287)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (177, 1, 1, 1, 1, 26, 2, 1, 1290)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (178, 1, 1, 1, 1, 26, 2, 2, 1291)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (179, 1, 1, 1, 1, 26, 2, 3, 1292)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (180, 1, 1, 1, 1, 26, 2, 1, 1294)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (181, 1, 1, 1, 1, 26, 2, 2, 1295)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (182, 1, 1, 1, 1, 26, 2, 3, 1296)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (183, 1, 1, 1, 1, 28, 2, 1, 1298)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (184, 1, 1, 1, 1, 28, 2, 2, 1299)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (185, 1, 1, 1, 1, 28, 2, 3, 1300)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (186, 1, 1, 1, 1, 29, 2, 1, 1302)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (187, 1, 1, 1, 1, 29, 2, 2, 1303)
GO
INSERT [dbo].[PagesRoles] ([Id], [IsDisplay], [IsCreate], [IsUpdate], [IsDelete], [FkPage_Id], [FkRole_Id], [FkPageRoleTypes_Id], [FkLog_Id]) VALUES (188, 1, 1, 1, 1, 29, 2, 3, 1304)
GO
SET IDENTITY_INSERT [dbo].[PagesRoles] OFF
GO
SET IDENTITY_INSERT [dbo].[PagesRoleTypes] ON 
GO
INSERT [dbo].[PagesRoleTypes] ([Id], [ResourceName]) VALUES (1, N'Management')
GO
INSERT [dbo].[PagesRoleTypes] ([Id], [ResourceName]) VALUES (2, N'Notifications')
GO
INSERT [dbo].[PagesRoleTypes] ([Id], [ResourceName]) VALUES (3, N'Logs')
GO
SET IDENTITY_INSERT [dbo].[PagesRoleTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[PhoneNumbers] ON 
GO
INSERT [dbo].[PhoneNumbers] ([Id], [Number], [FKPhone_Id], [FkPhoneType_Id]) VALUES (9, N'01025249400', 1, 1)
GO
INSERT [dbo].[PhoneNumbers] ([Id], [Number], [FKPhone_Id], [FkPhoneType_Id]) VALUES (12, N'01025249401', 1, 1)
GO
INSERT [dbo].[PhoneNumbers] ([Id], [Number], [FKPhone_Id], [FkPhoneType_Id]) VALUES (13, N'01025249400', 6, 1)
GO
INSERT [dbo].[PhoneNumbers] ([Id], [Number], [FKPhone_Id], [FkPhoneType_Id]) VALUES (1013, N'0025249700', 1006, 4)
GO
INSERT [dbo].[PhoneNumbers] ([Id], [Number], [FKPhone_Id], [FkPhoneType_Id]) VALUES (1014, N'0025249700', 1007, 4)
GO
INSERT [dbo].[PhoneNumbers] ([Id], [Number], [FKPhone_Id], [FkPhoneType_Id]) VALUES (1015, N'0525249700', 1008, 4)
GO
SET IDENTITY_INSERT [dbo].[PhoneNumbers] OFF
GO
SET IDENTITY_INSERT [dbo].[Phones] ON 
GO
INSERT [dbo].[Phones] ([Id], [Notes]) VALUES (1, NULL)
GO
INSERT [dbo].[Phones] ([Id], [Notes]) VALUES (2, NULL)
GO
INSERT [dbo].[Phones] ([Id], [Notes]) VALUES (3, NULL)
GO
INSERT [dbo].[Phones] ([Id], [Notes]) VALUES (4, NULL)
GO
INSERT [dbo].[Phones] ([Id], [Notes]) VALUES (5, NULL)
GO
INSERT [dbo].[Phones] ([Id], [Notes]) VALUES (6, NULL)
GO
INSERT [dbo].[Phones] ([Id], [Notes]) VALUES (1006, NULL)
GO
INSERT [dbo].[Phones] ([Id], [Notes]) VALUES (1007, NULL)
GO
INSERT [dbo].[Phones] ([Id], [Notes]) VALUES (1008, NULL)
GO
SET IDENTITY_INSERT [dbo].[Phones] OFF
GO
SET IDENTITY_INSERT [dbo].[PhoneTypes] ON 
GO
INSERT [dbo].[PhoneTypes] ([Id], [ResourceName]) VALUES (1, N'Mobile')
GO
INSERT [dbo].[PhoneTypes] ([Id], [ResourceName]) VALUES (2, N'Fax')
GO
INSERT [dbo].[PhoneTypes] ([Id], [ResourceName]) VALUES (3, N'Home')
GO
INSERT [dbo].[PhoneTypes] ([Id], [ResourceName]) VALUES (4, N'MobileLogin')
GO
SET IDENTITY_INSERT [dbo].[PhoneTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[PositionTypes] ON 
GO
INSERT [dbo].[PositionTypes] ([Id], [ResourceName]) VALUES (1, N'P1')
GO
INSERT [dbo].[PositionTypes] ([Id], [ResourceName]) VALUES (2, N'P2')
GO
INSERT [dbo].[PositionTypes] ([Id], [ResourceName]) VALUES (3, N'P3')
GO
INSERT [dbo].[PositionTypes] ([Id], [ResourceName]) VALUES (4, N'P4')
GO
INSERT [dbo].[PositionTypes] ([Id], [ResourceName]) VALUES (5, N'P5')
GO
SET IDENTITY_INSERT [dbo].[PositionTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[Provinces] ON 
GO
INSERT [dbo].[Provinces] ([Id], [NameAr], [NameEn], [FKCountry_Id], [FkLog_Id]) VALUES (1, N'القاهرة', N'Cairo', 1, 2)
GO
INSERT [dbo].[Provinces] ([Id], [NameAr], [NameEn], [FKCountry_Id], [FkLog_Id]) VALUES (18, N'المنصورة', N'Mansoura', 1, 29)
GO
INSERT [dbo].[Provinces] ([Id], [NameAr], [NameEn], [FKCountry_Id], [FkLog_Id]) VALUES (19, N'الاسكندرية', N'Alx', 1, 30)
GO
SET IDENTITY_INSERT [dbo].[Provinces] OFF
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 
GO
INSERT [dbo].[Roles] ([Id], [ResourceName], [Notes], [IsControlPanel]) VALUES (1, N'Manager', NULL, 1)
GO
INSERT [dbo].[Roles] ([Id], [ResourceName], [Notes], [IsControlPanel]) VALUES (2, N'Supervisor', NULL, 1)
GO
INSERT [dbo].[Roles] ([Id], [ResourceName], [Notes], [IsControlPanel]) VALUES (3, N'Client', NULL, 1)
GO
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO
SET IDENTITY_INSERT [dbo].[SocialStatus] ON 
GO
INSERT [dbo].[SocialStatus] ([Id], [ResourceName]) VALUES (1, N'Single')
GO
INSERT [dbo].[SocialStatus] ([Id], [ResourceName]) VALUES (2, N'Married')
GO
INSERT [dbo].[SocialStatus] ([Id], [ResourceName]) VALUES (3, N'Widower')
GO
INSERT [dbo].[SocialStatus] ([Id], [ResourceName]) VALUES (4, N'Report')
GO
SET IDENTITY_INSERT [dbo].[SocialStatus] OFF
GO
SET IDENTITY_INSERT [dbo].[States] ON 
GO
INSERT [dbo].[States] ([Id], [ResourceName], [CssClassStyle], [CssClassIcon]) VALUES (1, N'Create', N'label-success', N'fa fa-plus')
GO
INSERT [dbo].[States] ([Id], [ResourceName], [CssClassStyle], [CssClassIcon]) VALUES (2, N'Update', N'label-warning', N'fas fa-edit')
GO
INSERT [dbo].[States] ([Id], [ResourceName], [CssClassStyle], [CssClassIcon]) VALUES (3, N'Delete', N'label-danger', N'fas fa-trash-alt')
GO
INSERT [dbo].[States] ([Id], [ResourceName], [CssClassStyle], [CssClassIcon]) VALUES (4, N'Reject', N'label-danger', N'fas fa-times')
GO
INSERT [dbo].[States] ([Id], [ResourceName], [CssClassStyle], [CssClassIcon]) VALUES (5, N'Approve', N'label-success', N'fas fa-check-double')
GO
INSERT [dbo].[States] ([Id], [ResourceName], [CssClassStyle], [CssClassIcon]) VALUES (6, N'Report', N'label-success', N'fas fa-info-circle')
GO
INSERT [dbo].[States] ([Id], [ResourceName], [CssClassStyle], [CssClassIcon]) VALUES (7, N'Buy', N'label-success', N'fas fa-shopping-cart')
GO
SET IDENTITY_INSERT [dbo].[States] OFF
GO
SET IDENTITY_INSERT [dbo].[SubCategories] ON 
GO
INSERT [dbo].[SubCategories] ([Id], [NameAr], [NameEn], [FkLog_Id], [FkCategory_Id], [FkFile_Id]) VALUES (1, N'دفع رباعى', N'4wd', 219, 4, 82)
GO
INSERT [dbo].[SubCategories] ([Id], [NameAr], [NameEn], [FkLog_Id], [FkCategory_Id], [FkFile_Id]) VALUES (3, N'دراجة نارية', N'Motorcycle', 221, 4, 83)
GO
INSERT [dbo].[SubCategories] ([Id], [NameAr], [NameEn], [FkLog_Id], [FkCategory_Id], [FkFile_Id]) VALUES (4, N'دراجة هوائية', N'Bicycles', 222, 4, 84)
GO
INSERT [dbo].[SubCategories] ([Id], [NameAr], [NameEn], [FkLog_Id], [FkCategory_Id], [FkFile_Id]) VALUES (5, N'منازل', N'Houses', 223, 3, 85)
GO
INSERT [dbo].[SubCategories] ([Id], [NameAr], [NameEn], [FkLog_Id], [FkCategory_Id], [FkFile_Id]) VALUES (6, N'شقق سكنية', N'Apartment', 224, 3, 86)
GO
SET IDENTITY_INSERT [dbo].[SubCategories] OFF
GO
SET IDENTITY_INSERT [dbo].[SubMenus] ON 
GO
INSERT [dbo].[SubMenus] ([Id], [OrderNumber], [ClassIcon], [FkMenu_Id], [FKPage_Id]) VALUES (5, 1, N'fas fa-not-equal', 1, 1)
GO
INSERT [dbo].[SubMenus] ([Id], [OrderNumber], [ClassIcon], [FkMenu_Id], [FKPage_Id]) VALUES (6, 1, N'fas fa-not-equal', 2, 2)
GO
INSERT [dbo].[SubMenus] ([Id], [OrderNumber], [ClassIcon], [FkMenu_Id], [FKPage_Id]) VALUES (7, 3, N'fas fa-not-equal', 1, 3)
GO
INSERT [dbo].[SubMenus] ([Id], [OrderNumber], [ClassIcon], [FkMenu_Id], [FKPage_Id]) VALUES (8, 4, N'fas fa-not-equal', 1, 4)
GO
INSERT [dbo].[SubMenus] ([Id], [OrderNumber], [ClassIcon], [FkMenu_Id], [FKPage_Id]) VALUES (9, 5, N'fas fa-not-equal', 1, 5)
GO
INSERT [dbo].[SubMenus] ([Id], [OrderNumber], [ClassIcon], [FkMenu_Id], [FKPage_Id]) VALUES (10, 6, N'fas fa-not-equal', 1, 6)
GO
INSERT [dbo].[SubMenus] ([Id], [OrderNumber], [ClassIcon], [FkMenu_Id], [FKPage_Id]) VALUES (11, 7, N'fas fa-not-equal', 1, 7)
GO
INSERT [dbo].[SubMenus] ([Id], [OrderNumber], [ClassIcon], [FkMenu_Id], [FKPage_Id]) VALUES (16, 2, N'fas fa-not-equal', 2, 8)
GO
INSERT [dbo].[SubMenus] ([Id], [OrderNumber], [ClassIcon], [FkMenu_Id], [FKPage_Id]) VALUES (23, 1, N'fas fa-not-equal', 7, 16)
GO
INSERT [dbo].[SubMenus] ([Id], [OrderNumber], [ClassIcon], [FkMenu_Id], [FKPage_Id]) VALUES (24, 8, N'fas fa-not-equal', 1, 17)
GO
INSERT [dbo].[SubMenus] ([Id], [OrderNumber], [ClassIcon], [FkMenu_Id], [FKPage_Id]) VALUES (25, 9, N'fas fa-not-equal', 1, 18)
GO
INSERT [dbo].[SubMenus] ([Id], [OrderNumber], [ClassIcon], [FkMenu_Id], [FKPage_Id]) VALUES (26, 1, N'fas fa-not-equal', 8, 19)
GO
INSERT [dbo].[SubMenus] ([Id], [OrderNumber], [ClassIcon], [FkMenu_Id], [FKPage_Id]) VALUES (27, 2, N'fas fa-not-equal', 8, 20)
GO
INSERT [dbo].[SubMenus] ([Id], [OrderNumber], [ClassIcon], [FkMenu_Id], [FKPage_Id]) VALUES (28, 1, N'fas fa-not-equal', 9, 21)
GO
INSERT [dbo].[SubMenus] ([Id], [OrderNumber], [ClassIcon], [FkMenu_Id], [FKPage_Id]) VALUES (29, 1, N'fas fa-not-equal', 10, 22)
GO
INSERT [dbo].[SubMenus] ([Id], [OrderNumber], [ClassIcon], [FkMenu_Id], [FKPage_Id]) VALUES (30, 10, N'fas fa-not-equal', 1, 23)
GO
INSERT [dbo].[SubMenus] ([Id], [OrderNumber], [ClassIcon], [FkMenu_Id], [FKPage_Id]) VALUES (1030, 2, N'fas fa-not-equal', 9, 24)
GO
INSERT [dbo].[SubMenus] ([Id], [OrderNumber], [ClassIcon], [FkMenu_Id], [FKPage_Id]) VALUES (1031, 2, N'fas fa-not-equal', 10, 25)
GO
INSERT [dbo].[SubMenus] ([Id], [OrderNumber], [ClassIcon], [FkMenu_Id], [FKPage_Id]) VALUES (1032, 11, N'fas fa-not-equal', 1, 26)
GO
INSERT [dbo].[SubMenus] ([Id], [OrderNumber], [ClassIcon], [FkMenu_Id], [FKPage_Id]) VALUES (1033, 10, N'fas fa-not-equal', 1, 26)
GO
INSERT [dbo].[SubMenus] ([Id], [OrderNumber], [ClassIcon], [FkMenu_Id], [FKPage_Id]) VALUES (1034, 3, N'fas fa-info-circle', 9, 28)
GO
INSERT [dbo].[SubMenus] ([Id], [OrderNumber], [ClassIcon], [FkMenu_Id], [FKPage_Id]) VALUES (1035, 15, N'fas fa-not-equal', 1, 29)
GO
SET IDENTITY_INSERT [dbo].[SubMenus] OFF
GO
SET IDENTITY_INSERT [dbo].[TechnicalSupport] ON 
GO
INSERT [dbo].[TechnicalSupport] ([Id], [UserName], [Email], [Phone], [Message], [CreateDateTime]) VALUES (1, N'ahmed Nageeb', N'Sezer.info@gmail.com', N'01025249400', N'test test ahmed ahmed test test ahmed ahmed aya mohamed ', CAST(N'2018-09-07T22:18:05.423' AS DateTime))
GO
INSERT [dbo].[TechnicalSupport] ([Id], [UserName], [Email], [Phone], [Message], [CreateDateTime]) VALUES (2, N'ahmed Nageeb', N'Sezer.info@gmail.com', N'01025249400', N'test test ahmed ahmed test te


st ahmed ahmed aya mohamed ', CAST(N'2018-09-07T22:51:17.983' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[TechnicalSupport] OFF
GO
SET IDENTITY_INSERT [dbo].[TechnicalSupportRead] ON 
GO
INSERT [dbo].[TechnicalSupportRead] ([Id], [FkTechnicalSupport_Id], [FkUser_Id]) VALUES (1, 1, 1)
GO
INSERT [dbo].[TechnicalSupportRead] ([Id], [FkTechnicalSupport_Id], [FkUser_Id]) VALUES (2, 2, 1)
GO
SET IDENTITY_INSERT [dbo].[TechnicalSupportRead] OFF
GO
INSERT [dbo].[UserInformation] ([Id], [FirstName], [MediumName], [LastName], [NationalId], [BirthDate], [FkImage_Id], [FKAddress_Id], [FkNationality_Id], [FKGender_Id], [FKSocialStatus_Id], [FKJob_Id], [FKLanguage_Id], [FkPhone_Id], [FkFollowing_Id]) VALUES (1, N'Ahmed', N'Nageeb', N'Mahmoud', N'123654879', CAST(N'1997-02-04' AS Date), 1, 1, 1, 1, 1, 4, 1, 1, 1)
GO
INSERT [dbo].[UserInformation] ([Id], [FirstName], [MediumName], [LastName], [NationalId], [BirthDate], [FkImage_Id], [FKAddress_Id], [FkNationality_Id], [FKGender_Id], [FKSocialStatus_Id], [FKJob_Id], [FKLanguage_Id], [FkPhone_Id], [FkFollowing_Id]) VALUES (2, N'Aya', NULL, N'Nageeb', N'12121212654', NULL, 2, 2, NULL, NULL, NULL, 1, 2, 2, 2)
GO
INSERT [dbo].[UserInformation] ([Id], [FirstName], [MediumName], [LastName], [NationalId], [BirthDate], [FkImage_Id], [FKAddress_Id], [FkNationality_Id], [FKGender_Id], [FKSocialStatus_Id], [FKJob_Id], [FKLanguage_Id], [FkPhone_Id], [FkFollowing_Id]) VALUES (3, N'xxqq1', NULL, N'qq', NULL, NULL, 27, 3, NULL, NULL, NULL, NULL, 3, 3, 3)
GO
INSERT [dbo].[UserInformation] ([Id], [FirstName], [MediumName], [LastName], [NationalId], [BirthDate], [FkImage_Id], [FKAddress_Id], [FkNationality_Id], [FKGender_Id], [FKSocialStatus_Id], [FKJob_Id], [FKLanguage_Id], [FkPhone_Id], [FkFollowing_Id]) VALUES (5, N'ghjklkn8888', NULL, N'sdsdsd', NULL, NULL, 29, 5, NULL, NULL, NULL, NULL, 5, 5, 4)
GO
INSERT [dbo].[UserInformation] ([Id], [FirstName], [MediumName], [LastName], [NationalId], [BirthDate], [FkImage_Id], [FKAddress_Id], [FkNationality_Id], [FKGender_Id], [FKSocialStatus_Id], [FKJob_Id], [FKLanguage_Id], [FkPhone_Id], [FkFollowing_Id]) VALUES (9, N'', NULL, N'', NULL, NULL, 43, 6, NULL, NULL, NULL, NULL, NULL, NULL, 5)
GO
INSERT [dbo].[UserInformation] ([Id], [FirstName], [MediumName], [LastName], [NationalId], [BirthDate], [FkImage_Id], [FKAddress_Id], [FkNationality_Id], [FKGender_Id], [FKSocialStatus_Id], [FKJob_Id], [FKLanguage_Id], [FkPhone_Id], [FkFollowing_Id]) VALUES (10, N'', NULL, N'', NULL, NULL, 122, 7, NULL, NULL, NULL, NULL, NULL, 6, 6)
GO
INSERT [dbo].[UserInformation] ([Id], [FirstName], [MediumName], [LastName], [NationalId], [BirthDate], [FkImage_Id], [FKAddress_Id], [FkNationality_Id], [FKGender_Id], [FKSocialStatus_Id], [FKJob_Id], [FKLanguage_Id], [FkPhone_Id], [FkFollowing_Id]) VALUES (1010, N'', NULL, N'', NULL, NULL, 1090, 1007, NULL, NULL, NULL, NULL, NULL, 1006, 7)
GO
INSERT [dbo].[UserInformation] ([Id], [FirstName], [MediumName], [LastName], [NationalId], [BirthDate], [FkImage_Id], [FKAddress_Id], [FkNationality_Id], [FKGender_Id], [FKSocialStatus_Id], [FKJob_Id], [FKLanguage_Id], [FkPhone_Id], [FkFollowing_Id]) VALUES (1011, N'', NULL, N'', NULL, NULL, 1091, 1008, NULL, NULL, NULL, NULL, NULL, 1007, 8)
GO
INSERT [dbo].[UserInformation] ([Id], [FirstName], [MediumName], [LastName], [NationalId], [BirthDate], [FkImage_Id], [FKAddress_Id], [FkNationality_Id], [FKGender_Id], [FKSocialStatus_Id], [FKJob_Id], [FKLanguage_Id], [FkPhone_Id], [FkFollowing_Id]) VALUES (1012, N'', NULL, N'', NULL, NULL, 1092, 1009, NULL, NULL, NULL, NULL, NULL, 1008, 9)
GO
SET IDENTITY_INSERT [dbo].[UserLogins] ON 
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (1, CAST(N'2018-08-19T17:54:54.117' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (2, CAST(N'2018-08-19T17:55:11.110' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (3, CAST(N'2018-08-19T17:56:18.620' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (4, CAST(N'2018-08-19T17:56:54.307' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (5, CAST(N'2018-08-19T17:58:30.443' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (6, CAST(N'2018-08-19T17:59:33.700' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (7, CAST(N'2018-08-19T18:00:37.667' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (8, CAST(N'2018-08-19T18:01:49.207' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (9, CAST(N'2018-08-19T18:06:22.350' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (10, CAST(N'2018-08-19T18:07:35.967' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (11, CAST(N'2018-08-19T18:07:55.160' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (12, CAST(N'2018-08-19T18:08:57.743' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (13, CAST(N'2018-08-19T18:10:15.493' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (14, CAST(N'2018-08-19T18:10:31.273' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (15, CAST(N'2018-08-19T18:10:56.700' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (16, CAST(N'2018-08-19T18:12:08.717' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (17, CAST(N'2018-08-19T18:13:05.743' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (18, CAST(N'2018-08-19T18:13:05.957' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (19, CAST(N'2018-08-19T18:13:23.530' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (20, CAST(N'2018-08-19T18:15:33.137' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (21, CAST(N'2018-08-19T18:28:31.153' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (22, CAST(N'2018-08-19T18:28:51.610' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (23, CAST(N'2018-08-19T18:31:21.073' AS DateTime), 0, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (24, CAST(N'2018-08-19T18:31:24.643' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (25, CAST(N'2018-08-19T18:33:38.513' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (26, CAST(N'2018-08-19T18:34:52.157' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (27, CAST(N'2018-08-19T19:25:40.097' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (28, CAST(N'2018-08-19T19:25:40.843' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (29, CAST(N'2018-08-19T19:31:10.290' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (30, CAST(N'2018-08-19T19:33:21.480' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (31, CAST(N'2018-08-24T16:45:44.917' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (32, CAST(N'2018-08-30T19:33:16.707' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (33, CAST(N'2018-09-09T22:54:25.140' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (34, CAST(N'2018-09-15T19:51:39.437' AS DateTime), 0, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (35, CAST(N'2018-09-15T19:51:45.297' AS DateTime), 0, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (36, CAST(N'2018-09-15T19:54:14.973' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (37, CAST(N'2018-09-15T19:56:32.130' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (38, CAST(N'2018-09-19T14:13:39.543' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (39, CAST(N'2018-09-19T17:05:29.640' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (40, CAST(N'2018-09-19T17:19:43.167' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (41, CAST(N'2018-09-19T17:21:28.580' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (42, CAST(N'2018-09-19T17:23:53.580' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (43, CAST(N'2018-09-20T00:15:33.650' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (44, CAST(N'2018-09-20T21:31:49.970' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (45, CAST(N'2018-09-21T13:58:38.190' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (46, CAST(N'2018-09-21T13:58:40.080' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (47, CAST(N'2018-09-21T13:58:40.377' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (48, CAST(N'2018-09-23T05:12:58.793' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (49, CAST(N'2018-09-23T05:12:58.793' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (50, CAST(N'2018-09-23T14:39:04.970' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (51, CAST(N'2018-09-23T15:14:56.997' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (52, CAST(N'2018-09-23T20:53:42.237' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (53, CAST(N'2018-09-24T01:30:13.023' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (54, CAST(N'2018-09-24T14:38:08.053' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (55, CAST(N'2018-10-17T21:50:36.703' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (56, CAST(N'2018-10-17T21:50:36.703' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (57, CAST(N'2018-10-17T21:50:36.703' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (58, CAST(N'2018-10-17T21:50:37.123' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (59, CAST(N'2018-10-17T22:31:24.087' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (60, CAST(N'2018-10-18T00:17:35.157' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (61, CAST(N'2018-10-18T16:39:12.790' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (1055, CAST(N'2018-12-18T23:49:05.087' AS DateTime), 1, 1010)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (1056, CAST(N'2018-12-18T23:56:15.170' AS DateTime), 1, 1012)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (1057, CAST(N'2018-12-19T17:43:38.880' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (1058, CAST(N'2018-12-19T21:28:16.283' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (1059, CAST(N'2018-12-19T22:17:51.527' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (1060, CAST(N'2018-12-20T00:24:06.927' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (1061, CAST(N'2018-12-20T00:24:06.927' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (1062, CAST(N'2018-12-20T00:24:06.927' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (1063, CAST(N'2018-12-20T17:22:11.887' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (1064, CAST(N'2018-12-20T21:48:52.893' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (1065, CAST(N'2018-12-20T21:48:52.893' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (1066, CAST(N'2018-12-20T21:48:53.547' AS DateTime), 1, 1)
GO
INSERT [dbo].[UserLogins] ([Id], [LoginDate], [IsSuccess], [FkUser_Id]) VALUES (1067, CAST(N'2018-12-20T23:22:35.570' AS DateTime), 1, 1)
GO
SET IDENTITY_INSERT [dbo].[UserLogins] OFF
GO
SET IDENTITY_INSERT [dbo].[UserRoles] ON 
GO
INSERT [dbo].[UserRoles] ([Id], [FkUser_Id], [FkRole_Id]) VALUES (1, 1, 1)
GO
INSERT [dbo].[UserRoles] ([Id], [FkUser_Id], [FkRole_Id]) VALUES (2, 1, 2)
GO
INSERT [dbo].[UserRoles] ([Id], [FkUser_Id], [FkRole_Id]) VALUES (3, 2, 3)
GO
INSERT [dbo].[UserRoles] ([Id], [FkUser_Id], [FkRole_Id]) VALUES (4, 3, 3)
GO
INSERT [dbo].[UserRoles] ([Id], [FkUser_Id], [FkRole_Id]) VALUES (6, 5, 3)
GO
INSERT [dbo].[UserRoles] ([Id], [FkUser_Id], [FkRole_Id]) VALUES (7, 9, 3)
GO
INSERT [dbo].[UserRoles] ([Id], [FkUser_Id], [FkRole_Id]) VALUES (8, 10, 3)
GO
INSERT [dbo].[UserRoles] ([Id], [FkUser_Id], [FkRole_Id]) VALUES (1008, 1010, 3)
GO
INSERT [dbo].[UserRoles] ([Id], [FkUser_Id], [FkRole_Id]) VALUES (1009, 1011, 3)
GO
INSERT [dbo].[UserRoles] ([Id], [FkUser_Id], [FkRole_Id]) VALUES (1010, 1012, 3)
GO
SET IDENTITY_INSERT [dbo].[UserRoles] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 
GO
INSERT [dbo].[Users] ([Id], [UserName], [Email], [Password], [IsBlocked], [CreateDate], [Serial], [FkLog_Id]) VALUES (1, N'ahmed', N'ahmed@gmail.com', N'123456', 0, CAST(N'2012-12-01T00:00:00.000' AS DateTime), N'ahmed1', 105)
GO
INSERT [dbo].[Users] ([Id], [UserName], [Email], [Password], [IsBlocked], [CreateDate], [Serial], [FkLog_Id]) VALUES (2, N'AYa', N'sezer.info.0@gmail.com', N'123456', 0, CAST(N'2018-08-26T23:41:08.133' AS DateTime), N'69680b54-2c75-4235-a297-5bd326eb2b30', 106)
GO
INSERT [dbo].[Users] ([Id], [UserName], [Email], [Password], [IsBlocked], [CreateDate], [Serial], [FkLog_Id]) VALUES (3, N'ahmedw', N'ahmednageeb@gmail.com', N'123456', 0, CAST(N'2018-08-30T16:57:19.937' AS DateTime), N'dfc43fcf-a4e8-4a25-b97a-d1bf76d46897', 124)
GO
INSERT [dbo].[Users] ([Id], [UserName], [Email], [Password], [IsBlocked], [CreateDate], [Serial], [FkLog_Id]) VALUES (5, N'sasasa', N'dowqnlaodvid1eoyou@gmail.com', N'123456', 0, CAST(N'2018-08-30T17:19:26.103' AS DateTime), N'7fbca0dd-3216-4425-b52d-fb8441d48109', 126)
GO
INSERT [dbo].[Users] ([Id], [UserName], [Email], [Password], [IsBlocked], [CreateDate], [Serial], [FkLog_Id]) VALUES (9, N'ahmeddd@gmail_com', N'ahmeddd@gmail.com', N'123456', 0, CAST(N'2018-08-30T21:09:50.823' AS DateTime), N'504d102d-6141-43c5-8cf4-10ed4623bb91', 128)
GO
INSERT [dbo].[Users] ([Id], [UserName], [Email], [Password], [IsBlocked], [CreateDate], [Serial], [FkLog_Id]) VALUES (10, N'ahm0ed@gmail.com', N'ahm0ed@gmail.com', N'123456', 0, CAST(N'2018-10-20T00:12:52.937' AS DateTime), N'3e233fb4-b81a-4afc-9c06-68bf3a842f5b', 271)
GO
INSERT [dbo].[Users] ([Id], [UserName], [Email], [Password], [IsBlocked], [CreateDate], [Serial], [FkLog_Id]) VALUES (1010, N'ANagee0b@gmail.com', N'ANagee0b@gmail.com', N'01010056689', 0, CAST(N'2018-12-18T23:40:02.023' AS DateTime), N'f8883082-9047-4b5f-9ccb-b4a5485e0c1b', 1268)
GO
INSERT [dbo].[Users] ([Id], [UserName], [Email], [Password], [IsBlocked], [CreateDate], [Serial], [FkLog_Id]) VALUES (1011, N'ANageer0b@gmail.com', N'ANageer0b@gmail.com', N'01010056689', 0, CAST(N'2018-12-18T23:50:45.700' AS DateTime), N'69e5fd05-2b71-4bb3-8c00-46e1332704f4', 1269)
GO
INSERT [dbo].[Users] ([Id], [UserName], [Email], [Password], [IsBlocked], [CreateDate], [Serial], [FkLog_Id]) VALUES (1012, N'ANage5er0b@gmail.com', N'ANage5er0b@gmail.com', N'01010056689', 0, CAST(N'2018-12-18T23:56:04.770' AS DateTime), N'551ecb66-eeee-4b0b-8986-d96656383894', 1270)
GO
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Email]    Script Date: 12/30/2018 8:50:24 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [Email] ON [dbo].[Users]
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Serial]    Script Date: 12/30/2018 8:50:24 PM ******/
CREATE NONCLUSTERED INDEX [Serial] ON [dbo].[Users]
(
	[Serial] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UserName]    Script Date: 12/30/2018 8:50:24 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UserName] ON [dbo].[Users]
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Addresses]  WITH CHECK ADD  CONSTRAINT [FK_Addresses_Countries] FOREIGN KEY([FKCountry_Id])
REFERENCES [dbo].[Countries] ([Id])
GO
ALTER TABLE [dbo].[Addresses] CHECK CONSTRAINT [FK_Addresses_Countries]
GO
ALTER TABLE [dbo].[Addresses]  WITH CHECK ADD  CONSTRAINT [FK_Addresses_Provinces] FOREIGN KEY([FkProvince_Id])
REFERENCES [dbo].[Provinces] ([Id])
GO
ALTER TABLE [dbo].[Addresses] CHECK CONSTRAINT [FK_Addresses_Provinces]
GO
ALTER TABLE [dbo].[AdFavorites]  WITH CHECK ADD  CONSTRAINT [FK_AdFavorites_Ads] FOREIGN KEY([FKAd_Id])
REFERENCES [dbo].[Ads] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AdFavorites] CHECK CONSTRAINT [FK_AdFavorites_Ads]
GO
ALTER TABLE [dbo].[AdFavorites]  WITH CHECK ADD  CONSTRAINT [FK_AdFavorites_Users] FOREIGN KEY([FkUser_Id])
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
ALTER TABLE [dbo].[Ads]  WITH CHECK ADD  CONSTRAINT [FK_Ads_Location] FOREIGN KEY([FkLocation_Id])
REFERENCES [dbo].[Location] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Ads] CHECK CONSTRAINT [FK_Ads_Location]
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
ALTER TABLE [dbo].[AdsSlider]  WITH CHECK ADD  CONSTRAINT [FK_AdsSlider_Files] FOREIGN KEY([FkFile_Id])
REFERENCES [dbo].[Files] ([Id])
GO
ALTER TABLE [dbo].[AdsSlider] CHECK CONSTRAINT [FK_AdsSlider_Files]
GO
ALTER TABLE [dbo].[AdsSlider]  WITH CHECK ADD  CONSTRAINT [FK_AdsSlider_Logs] FOREIGN KEY([FkLog_Id])
REFERENCES [dbo].[Logs] ([Id])
GO
ALTER TABLE [dbo].[AdsSlider] CHECK CONSTRAINT [FK_AdsSlider_Logs]
GO
ALTER TABLE [dbo].[AdsSlider]  WITH CHECK ADD  CONSTRAINT [FK_AdsSlider_PositionTypes] FOREIGN KEY([FkPositionType_Id])
REFERENCES [dbo].[PositionTypes] ([Id])
GO
ALTER TABLE [dbo].[AdsSlider] CHECK CONSTRAINT [FK_AdsSlider_PositionTypes]
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
ALTER TABLE [dbo].[AppsInformation]  WITH CHECK ADD  CONSTRAINT [FK_AppsInformation_Logs] FOREIGN KEY([FkLog_Id])
REFERENCES [dbo].[Logs] ([Id])
GO
ALTER TABLE [dbo].[AppsInformation] CHECK CONSTRAINT [FK_AppsInformation_Logs]
GO
ALTER TABLE [dbo].[Categories]  WITH CHECK ADD  CONSTRAINT [FK_Categories_Logs] FOREIGN KEY([FkLog_Id])
REFERENCES [dbo].[Logs] ([Id])
GO
ALTER TABLE [dbo].[Categories] CHECK CONSTRAINT [FK_Categories_Logs]
GO
ALTER TABLE [dbo].[Countries]  WITH CHECK ADD  CONSTRAINT [FK_Countries_Files] FOREIGN KEY([FkFile_Id])
REFERENCES [dbo].[Files] ([Id])
GO
ALTER TABLE [dbo].[Countries] CHECK CONSTRAINT [FK_Countries_Files]
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
ON DELETE CASCADE
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
ALTER TABLE [dbo].[Offers]  WITH CHECK ADD  CONSTRAINT [FK_Offers_Categories] FOREIGN KEY([FkCategory_Id])
REFERENCES [dbo].[Categories] ([Id])
GO
ALTER TABLE [dbo].[Offers] CHECK CONSTRAINT [FK_Offers_Categories]
GO
ALTER TABLE [dbo].[Offers]  WITH CHECK ADD  CONSTRAINT [FK_Offers_Logs] FOREIGN KEY([FkLog_Id])
REFERENCES [dbo].[Logs] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Offers] CHECK CONSTRAINT [FK_Offers_Logs]
GO
ALTER TABLE [dbo].[Offers]  WITH CHECK ADD  CONSTRAINT [FK_Offers_SubCategories] FOREIGN KEY([FkSubCategory_Id])
REFERENCES [dbo].[SubCategories] ([Id])
GO
ALTER TABLE [dbo].[Offers] CHECK CONSTRAINT [FK_Offers_SubCategories]
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
ALTER TABLE [dbo].[Provinces]  WITH CHECK ADD  CONSTRAINT [FK_Provinces_Countries] FOREIGN KEY([FKCountry_Id])
REFERENCES [dbo].[Countries] ([Id])
GO
ALTER TABLE [dbo].[Provinces] CHECK CONSTRAINT [FK_Provinces_Countries]
GO
ALTER TABLE [dbo].[Provinces]  WITH CHECK ADD  CONSTRAINT [FK_Provinces_Logs] FOREIGN KEY([FkLog_Id])
REFERENCES [dbo].[Logs] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Provinces] CHECK CONSTRAINT [FK_Provinces_Logs]
GO
ALTER TABLE [dbo].[Reports]  WITH CHECK ADD  CONSTRAINT [FK_Reports_Ads] FOREIGN KEY([FkAd_Id])
REFERENCES [dbo].[Ads] ([Id])
GO
ALTER TABLE [dbo].[Reports] CHECK CONSTRAINT [FK_Reports_Ads]
GO
ALTER TABLE [dbo].[Reports]  WITH CHECK ADD  CONSTRAINT [FK_Reports_Logs] FOREIGN KEY([FkLog_Id])
REFERENCES [dbo].[Logs] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Reports] CHECK CONSTRAINT [FK_Reports_Logs]
GO
ALTER TABLE [dbo].[Reports]  WITH CHECK ADD  CONSTRAINT [FK_Reports_ReportTypes] FOREIGN KEY([FkReportType_Id])
REFERENCES [dbo].[ReportTypes] ([Id])
GO
ALTER TABLE [dbo].[Reports] CHECK CONSTRAINT [FK_Reports_ReportTypes]
GO
ALTER TABLE [dbo].[Reports]  WITH CHECK ADD  CONSTRAINT [FK_Reports_Users] FOREIGN KEY([FkUser_Id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Reports] CHECK CONSTRAINT [FK_Reports_Users]
GO
ALTER TABLE [dbo].[ReportTypes]  WITH CHECK ADD  CONSTRAINT [FK_ReportTypes_Logs] FOREIGN KEY([FkLog_Id])
REFERENCES [dbo].[Logs] ([Id])
GO
ALTER TABLE [dbo].[ReportTypes] CHECK CONSTRAINT [FK_ReportTypes_Logs]
GO
ALTER TABLE [dbo].[SubCategories]  WITH CHECK ADD  CONSTRAINT [FK_SubCategories_Categories] FOREIGN KEY([FkCategory_Id])
REFERENCES [dbo].[Categories] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SubCategories] CHECK CONSTRAINT [FK_SubCategories_Categories]
GO
ALTER TABLE [dbo].[SubCategories]  WITH CHECK ADD  CONSTRAINT [FK_SubCategories_Files] FOREIGN KEY([FkFile_Id])
REFERENCES [dbo].[Files] ([Id])
GO
ALTER TABLE [dbo].[SubCategories] CHECK CONSTRAINT [FK_SubCategories_Files]
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
ALTER TABLE [dbo].[UserInformation]  WITH CHECK ADD  CONSTRAINT [FK_UserInformation_Following] FOREIGN KEY([FkFollowing_Id])
REFERENCES [dbo].[Following] ([Id])
GO
ALTER TABLE [dbo].[UserInformation] CHECK CONSTRAINT [FK_UserInformation_Following]
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
ALTER TABLE [dbo].[UsersFollowing]  WITH CHECK ADD  CONSTRAINT [FK_Followers_Users] FOREIGN KEY([FkUser_Id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[UsersFollowing] CHECK CONSTRAINT [FK_Followers_Users]
GO
ALTER TABLE [dbo].[UsersFollowing]  WITH CHECK ADD  CONSTRAINT [FK_UsersFollowing_Users] FOREIGN KEY([FkFollowing_Id])
REFERENCES [dbo].[Following] ([Id])
GO
ALTER TABLE [dbo].[UsersFollowing] CHECK CONSTRAINT [FK_UsersFollowing_Users]
GO
ALTER TABLE [dbo].[UsersPurchasesAds]  WITH CHECK ADD  CONSTRAINT [FK_UsersPurchases_Ads] FOREIGN KEY([FkAd_Id])
REFERENCES [dbo].[Ads] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UsersPurchasesAds] CHECK CONSTRAINT [FK_UsersPurchases_Ads]
GO
ALTER TABLE [dbo].[UsersPurchasesAds]  WITH CHECK ADD  CONSTRAINT [FK_UsersPurchases_Users] FOREIGN KEY([FkUser_Id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[UsersPurchasesAds] CHECK CONSTRAINT [FK_UsersPurchases_Users]
GO
ALTER TABLE [dbo].[UsersPurchasesOffers]  WITH CHECK ADD  CONSTRAINT [FK_UsersPurchasesOffers_Offers] FOREIGN KEY([FkOffer_Id])
REFERENCES [dbo].[Offers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UsersPurchasesOffers] CHECK CONSTRAINT [FK_UsersPurchasesOffers_Offers]
GO
ALTER TABLE [dbo].[UsersPurchasesOffers]  WITH CHECK ADD  CONSTRAINT [FK_UsersPurchasesOffers_Users] FOREIGN KEY([FkUser_Id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[UsersPurchasesOffers] CHECK CONSTRAINT [FK_UsersPurchasesOffers_Users]
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
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ViewerOffers] CHECK CONSTRAINT [FK_ViewerOffers_Offers]
GO
ALTER TABLE [dbo].[ViewerOffers]  WITH CHECK ADD  CONSTRAINT [FK_ViewerOffers_Users] FOREIGN KEY([FkUser_Id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[ViewerOffers] CHECK CONSTRAINT [FK_ViewerOffers_Users]
GO
/****** Object:  StoredProcedure [dbo].[InsertLog]    Script Date: 12/30/2018 8:50:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  proc [dbo].[InsertLog]
as 
begin 
insert Logs(CreateDateTime)values (GETDATE())
return scope_identity();
end
GO
/****** Object:  StoredProcedure [dbo].[InsertPage]    Script Date: 12/30/2018 8:50:24 PM ******/
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
/****** Object:  StoredProcedure [dbo].[InsertPageRles]    Script Date: 12/30/2018 8:50:24 PM ******/
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

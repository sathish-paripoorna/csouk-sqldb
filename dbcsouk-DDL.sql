/****** Object:  UserDefinedFunction [dbo].[fn_survey_code]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_survey_code]
(
            @survey_Prefix VARCHAR(20)
          --  @order_Length INT
)
RETURNS VARCHAR(20)
AS
BEGIN
--Get maximum Emp id from table i.e. the last generated Empid in the table. (initially 0 if table has no data).
DECLARE @max_survey_Id INT,@survey_Length INT=3;
SET @max_survey_Id= ISNULL((SELECT MAX(Id) FROM surveycatalog),0)
--Increment maxempid by 1 to get next emp id.
SET @max_survey_Id+=1
DECLARE @surveyCode VARCHAR(20),@i INT=1;
WHILE(@i=1)
BEGIN
--Generate new emp code of specified code length prefixed by specified prefix passed as parameters.
SET @surveyCode=@survey_Prefix +RIGHT(REPLICATE('0', @survey_Length-1) + CONVERT(VARCHAR(20),@max_survey_Id),@survey_Length)
--Check generated emp code. If already exists then get next emp code untill we get fresh emp code.
IF EXISTS(SELECT 1 FROM surveycatalog WHERE surveycode=@surveyCode)
BEGIN
            SET @max_survey_Id +=1
END
ELSE
BEGIN
            SET @i=0
END
END
--Return newly generated emp code
RETURN @surveyCode
END


GO
/****** Object:  Table [dbo].[App_User]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[App_User](
	[USR_ID] [int] IDENTITY(1,1) NOT NULL,
	[USR_Name] [varchar](100) NOT NULL,
	[USR_Password] [nvarchar](200) NOT NULL,
	[USR_MobileNo] [bigint] NOT NULL,
	[USR_EmailId] [varchar](100) NOT NULL,
	[USR_JobTitle] [varchar](500) NULL,
	[USR_CompanyName] [varchar](500) NULL,
	[USR_IsMobileVerified] [bit] NOT NULL,
	[USR_IsEmailVerified] [bit] NOT NULL,
	[USR_IsSurveyCompleted] [bit] NOT NULL,
	[USR_DeviceId] [nvarchar](max) NULL,
	[USR_FCMToken] [nvarchar](max) NULL,
	[USR_CreatedDate] [datetime] NOT NULL,
	[USR_ModifyDate] [datetime] NOT NULL,
	[USR_IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_App_User] PRIMARY KEY CLUSTERED 
(
	[USR_ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChatDetails]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChatDetails](
	[CHD_ID] [int] IDENTITY(1,1) NOT NULL,
	[CHD_MemberId] [int] NOT NULL,
	[CHD_EventId] [int] NOT NULL,
	[CHD_Message] [nvarchar](max) NULL,
	[CHD_FileName] [nvarchar](max) NULL,
	[CHD_FilePath] [nvarchar](max) NULL,
	[CHD_FileType] [nvarchar](max) NULL,
	[CHD_Date] [datetime] NOT NULL,
	[CHD_ParentChatId] [int] NULL,
	[CHD_CreatedDate] [datetime] NOT NULL,
	[CHD_ModifyDate] [datetime] NOT NULL,
	[CHD_IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_ChatDetails] PRIMARY KEY CLUSTERED 
(
	[CHD_ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EventAttendees]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventAttendees](
	[EVA_ID] [int] IDENTITY(1,1) NOT NULL,
	[EVA_EventId] [int] NOT NULL,
	[EVA_EventName] [varchar](500) NOT NULL,
	[EVA_MemberName] [varchar](100) NULL,
	[EVA_Email] [varchar](100) NOT NULL,
	[EVA_Job] [varchar](100) NULL,
	[EVA_CompanyName] [varchar](100) NULL,
	[EVA_CreatedDate] [datetime] NOT NULL,
	[EVA_ModifyDate] [datetime] NOT NULL,
	[EVA_IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_EventAttendees] PRIMARY KEY CLUSTERED 
(
	[EVA_ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EventNotification]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventNotification](
	[ENT_ID] [int] IDENTITY(1,1) NOT NULL,
	[ENT_EventId] [int] NOT NULL,
	[ENT_MemberId] [int] NOT NULL,
	[ENT_FCMToken] [nvarchar](max) NULL,
	[ENT_IsNotify] [bit] NULL,
	[ENT_IsSaved] [bit] NULL,
	[ENT_Status] [int] NULL,
	[ENT_CreatedDate] [datetime] NOT NULL,
	[ENT_ModifyDate] [datetime] NOT NULL,
	[ENT_IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_EventNotification] PRIMARY KEY CLUSTERED 
(
	[ENT_ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Events]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Events](
	[EVT_ID] [int] IDENTITY(1,1) NOT NULL,
	[EVT_EventName] [varchar](500) NOT NULL,
	[EVT_EventContent] [nvarchar](max) NULL,
	[EVT_Venue] [nvarchar](max) NOT NULL,
	[EVT_PhotoFileName] [nvarchar](max) NULL,
	[EVT_PhotoFilePath] [nvarchar](max) NULL,
	[EVT_BgPhotoFileName] [nvarchar](max) NULL,
	[EVT_BgPhotoFilePath] [nvarchar](max) NULL,
	[EVT_StartDate] [datetime] NULL,
	[EVT_EndDate] [datetime] NULL,
	[EVT_ChannelId] [varchar](500) NOT NULL,
	[EVT_IsshowChannel] [bit] NOT NULL,
	[EVT_CreatedDate] [datetime] NOT NULL,
	[EVT_ModifyDate] [datetime] NOT NULL,
	[EVT_IsActive] [bit] NOT NULL,
	[EVT_IsExcelUpload] [bit] NULL,
	[EVT_URLLink] [varchar](500) NULL,
 CONSTRAINT [PK_Events] PRIMARY KEY CLUSTERED 
(
	[EVT_ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Member]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Member](
	[MBR_ID] [int] IDENTITY(1,1) NOT NULL,
	[MBR_FirstName] [varchar](100) NOT NULL,
	[MBR_LastName] [varchar](100) NOT NULL,
	[MBR_Password] [nvarchar](200) NOT NULL,
	[MBR_MobileNo] [bigint] NOT NULL,
	[MBR_EmailId] [varchar](100) NOT NULL,
	[MBR_SecondaryEmailId] [varchar](100) NULL,
	[MBR_PhotoFileName] [nvarchar](max) NULL,
	[MBR_PhotoFilePath] [nvarchar](max) NULL,
	[MBR_JobTitle] [varchar](500) NULL,
	[MBR_CompanyName] [varchar](500) NULL,
	[MBR_Info] [nvarchar](max) NULL,
	[MBR_IsMobileVerified] [bit] NOT NULL,
	[MBR_IsEmailVerified] [bit] NOT NULL,
	[MBR_IsSurveyCompleted] [bit] NOT NULL,
	[MBR_SurveyQueId] [int] NULL,
	[MBR_SurveyAnsId] [int] NULL,
	[MBR_DeviceId] [nvarchar](max) NULL,
	[MBR_FCMToken] [nvarchar](max) NULL,
	[MBR_CreatedDate] [datetime] NOT NULL,
	[MBR_ModifyDate] [datetime] NOT NULL,
	[MBR_IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Member] PRIMARY KEY CLUSTERED 
(
	[MBR_ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MemberEvent]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MemberEvent](
	[MBE_ID] [int] IDENTITY(1,1) NOT NULL,
	[MBE_MemberId] [int] NOT NULL,
	[MBE_EventId] [int] NOT NULL,
	[MBE_CreatedDate] [datetime] NOT NULL,
	[MBE_ModifyDate] [datetime] NOT NULL,
	[MBE_IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_MemberEvent] PRIMARY KEY CLUSTERED 
(
	[MBE_ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SurveyAns]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SurveyAns](
	[SRA_ID] [int] IDENTITY(1,1) NOT NULL,
	[SRA_QueID] [int] NOT NULL,
	[SRA_Ans] [varchar](max) NOT NULL,
	[SRA_IsEnable] [bit] NOT NULL,
	[SRA_CreatedDate] [datetime] NOT NULL,
	[SRA_ModifyDate] [datetime] NOT NULL,
	[SRA_IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_SurveyAns] PRIMARY KEY CLUSTERED 
(
	[SRA_ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[surveycatalog]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[surveycatalog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[surveyname] [varchar](500) NOT NULL,
	[surveydescription] [varchar](500) NULL,
	[surveycode] [varchar](20) NOT NULL,
	[IsActive] [bit] NULL,
	[IsDeleted] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SurveyMaster]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SurveyMaster](
	[SurveyMasterId] [uniqueidentifier] NOT NULL,
	[SurveyCode] [nvarchar](10) NOT NULL,
	[QuestionId] [int] IDENTITY(1,1) NOT NULL,
	[QuestionDesc] [nvarchar](250) NOT NULL,
	[OfferedAnswers] [nvarchar](250) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[QuestionId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [survey_info] UNIQUE NONCLUSTERED 
(
	[SurveyCode] ASC,
	[QuestionId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SurveyQue]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SurveyQue](
	[SRQ_ID] [int] IDENTITY(1,1) NOT NULL,
	[SRQ_Que] [varchar](max) NOT NULL,
	[SRQ_IsEnable] [bit] NOT NULL,
	[SRQ_CreatedDate] [datetime] NOT NULL,
	[SRQ_ModifyDate] [datetime] NOT NULL,
	[SRQ_IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_SurveyQue] PRIMARY KEY CLUSTERED 
(
	[SRQ_ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SurveyResult]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SurveyResult](
	[SurveyResultId] [uniqueidentifier] NOT NULL,
	[SurveyCode] [nvarchar](10) NOT NULL,
	[MemberId] [nvarchar](15) NOT NULL,
	[QuestionId] [int] NOT NULL,
	[ChoosenAnswer] [nvarchar](250) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedDT] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[SurveyResultId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [survey_resultinfo] UNIQUE NONCLUSTERED 
(
	[SurveyCode] ASC,
	[MemberId] ASC,
	[QuestionId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[App_User] ADD  DEFAULT ((0)) FOR [USR_IsMobileVerified]
GO
ALTER TABLE [dbo].[App_User] ADD  DEFAULT ((0)) FOR [USR_IsEmailVerified]
GO
ALTER TABLE [dbo].[App_User] ADD  DEFAULT ((0)) FOR [USR_IsSurveyCompleted]
GO
ALTER TABLE [dbo].[App_User] ADD  DEFAULT (getdate()) FOR [USR_CreatedDate]
GO
ALTER TABLE [dbo].[App_User] ADD  DEFAULT (getdate()) FOR [USR_ModifyDate]
GO
ALTER TABLE [dbo].[App_User] ADD  DEFAULT ((1)) FOR [USR_IsActive]
GO
ALTER TABLE [dbo].[ChatDetails] ADD  DEFAULT (getdate()) FOR [CHD_CreatedDate]
GO
ALTER TABLE [dbo].[ChatDetails] ADD  DEFAULT (getdate()) FOR [CHD_ModifyDate]
GO
ALTER TABLE [dbo].[ChatDetails] ADD  DEFAULT ((1)) FOR [CHD_IsActive]
GO
ALTER TABLE [dbo].[EventAttendees] ADD  DEFAULT (getdate()) FOR [EVA_CreatedDate]
GO
ALTER TABLE [dbo].[EventAttendees] ADD  DEFAULT (getdate()) FOR [EVA_ModifyDate]
GO
ALTER TABLE [dbo].[EventAttendees] ADD  DEFAULT ((1)) FOR [EVA_IsActive]
GO
ALTER TABLE [dbo].[EventNotification] ADD  DEFAULT ((1)) FOR [ENT_IsNotify]
GO
ALTER TABLE [dbo].[EventNotification] ADD  DEFAULT ((0)) FOR [ENT_IsSaved]
GO
ALTER TABLE [dbo].[EventNotification] ADD  DEFAULT (getdate()) FOR [ENT_CreatedDate]
GO
ALTER TABLE [dbo].[EventNotification] ADD  DEFAULT (getdate()) FOR [ENT_ModifyDate]
GO
ALTER TABLE [dbo].[EventNotification] ADD  DEFAULT ((1)) FOR [ENT_IsActive]
GO
ALTER TABLE [dbo].[Events] ADD  DEFAULT ((1)) FOR [EVT_IsshowChannel]
GO
ALTER TABLE [dbo].[Events] ADD  DEFAULT (getdate()) FOR [EVT_CreatedDate]
GO
ALTER TABLE [dbo].[Events] ADD  DEFAULT (getdate()) FOR [EVT_ModifyDate]
GO
ALTER TABLE [dbo].[Events] ADD  DEFAULT ((1)) FOR [EVT_IsActive]
GO
ALTER TABLE [dbo].[Events] ADD  DEFAULT ((0)) FOR [EVT_IsExcelUpload]
GO
ALTER TABLE [dbo].[Member] ADD  DEFAULT ((0)) FOR [MBR_IsMobileVerified]
GO
ALTER TABLE [dbo].[Member] ADD  DEFAULT ((0)) FOR [MBR_IsEmailVerified]
GO
ALTER TABLE [dbo].[Member] ADD  DEFAULT ((0)) FOR [MBR_IsSurveyCompleted]
GO
ALTER TABLE [dbo].[Member] ADD  DEFAULT (getdate()) FOR [MBR_CreatedDate]
GO
ALTER TABLE [dbo].[Member] ADD  DEFAULT (getdate()) FOR [MBR_ModifyDate]
GO
ALTER TABLE [dbo].[Member] ADD  DEFAULT ((1)) FOR [MBR_IsActive]
GO
ALTER TABLE [dbo].[MemberEvent] ADD  DEFAULT (getdate()) FOR [MBE_CreatedDate]
GO
ALTER TABLE [dbo].[MemberEvent] ADD  DEFAULT (getdate()) FOR [MBE_ModifyDate]
GO
ALTER TABLE [dbo].[MemberEvent] ADD  DEFAULT ((1)) FOR [MBE_IsActive]
GO
ALTER TABLE [dbo].[SurveyAns] ADD  DEFAULT (getdate()) FOR [SRA_CreatedDate]
GO
ALTER TABLE [dbo].[SurveyAns] ADD  DEFAULT (getdate()) FOR [SRA_ModifyDate]
GO
ALTER TABLE [dbo].[SurveyAns] ADD  DEFAULT ((1)) FOR [SRA_IsActive]
GO
ALTER TABLE [dbo].[surveycatalog] ADD  DEFAULT ((0)) FOR [IsActive]
GO
ALTER TABLE [dbo].[surveycatalog] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[SurveyMaster] ADD  DEFAULT (newid()) FOR [SurveyMasterId]
GO
ALTER TABLE [dbo].[SurveyMaster] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[SurveyMaster] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[SurveyQue] ADD  DEFAULT (getdate()) FOR [SRQ_CreatedDate]
GO
ALTER TABLE [dbo].[SurveyQue] ADD  DEFAULT (getdate()) FOR [SRQ_ModifyDate]
GO
ALTER TABLE [dbo].[SurveyQue] ADD  DEFAULT ((1)) FOR [SRQ_IsActive]
GO
ALTER TABLE [dbo].[SurveyResult] ADD  DEFAULT (newid()) FOR [SurveyResultId]
GO
ALTER TABLE [dbo].[SurveyResult] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[SurveyResult] ADD  DEFAULT (getdate()) FOR [CreatedDT]
GO
/****** Object:  StoredProcedure [dbo].[Proc_admin_authentication]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_admin_authentication](@USR_Name varchar(100),
                                                     @USR_Password nvarchar(400)
                                                    )
AS
  BEGIN

      SELECT *
      FROM   [dbo].[App_User]
		  WHERE  [USR_Name] = @USR_Name
             AND [USR_Password] = @USR_Password
             AND [USR_IsActive] = 1

     
  END 


GO
/****** Object:  StoredProcedure [dbo].[Proc_AnsweredSurveyQuestions]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Proc_AnsweredSurveyQuestions 67
CREATE PROC [dbo].[Proc_AnsweredSurveyQuestions] 
@memberid INT
AS
BEGIN

SELECT SurveyResultId,
SC.SurveyCode,
MemberId,
sM.QuestionId,
ChoosenAnswer,QuestionDesc,surveyname,
surveydescription
OfferedAnswers FROM SurveyResult AS SR 
INNER JOIN SurveyMaster as SM ON SM.SurveyCode=SR.SurveyCode and SM.QuestionId=SR.QuestionId
LEFT JOIN surveycatalog AS SC ON SC.IsActive=1
WHERE MemberId=@memberid

END

GO
/****** Object:  StoredProcedure [dbo].[Proc_ChatDetails_IsActive]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Proc_ChatDetails_IsActive] (@CHD_Id	int
)
AS
BEGIN
 
   update  ChatDetails set CHD_IsActive=0 where CHD_Id=@CHD_Id and CHD_IsActive=1

   select 1 [status],'Deleted Successfully' [Message]
  
END
GO
/****** Object:  StoredProcedure [dbo].[Proc_Email_Validate]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_Email_Validate] (@EmailID varchar(100))
AS
BEGIN

  IF EXISTS (SELECT
      1
    FROM Member
    WHERE MBR_EmailId = @EmailID
    AND MBR_IsActive = 1)
  BEGIN
    SELECT
        1 [status]
  END
  ELSE
  BEGIN
    IF EXISTS (SELECT
        1
      FROM EventAttendees
      WHERE EVA_Email = @EmailID
      AND EVA_IsActive = 1)
    BEGIN
      SELECT
        2 [status]
    END
    ELSE
    BEGIN
      SELECT
        3 [status]
    END
  END

END

GO
/****** Object:  StoredProcedure [dbo].[Proc_EnableSurvey]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Proc_EnableSurvey]
@surveyId INT
AS
BEGIN

UPDATE surveycatalog SET IsActive=1 WHERE Id=@surveyId and IsDeleted=0

UPDATE surveycatalog SET IsActive=0 WHERE Id<>@surveyId and IsDeleted=0

END

SELECT 1 as [status], 'Updated Successfully' as [message]
GO
/****** Object:  StoredProcedure [dbo].[Proc_EventAttendee_update]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Proc_EventAttendee_update 'jayashree2.m@paripoorna.in','ab','testing', 'psss1', '[{"EVT_EventName":"reactnative","EVA_EventId":136},{"EVT_EventName":"reactnative","EVA_EventId":136}]'
 CREATE PROC [dbo].[Proc_EventAttendee_update]
  @EVA_Email VARCHAR(100) ,
 @EVA_MemberName VARCHAR(100) ,
 @EVA_Job VARCHAR(100) ,
 @EVA_CompanyName VARCHAR(100) ,
 @EventDetails VARCHAR(MAX)
 AS
 BEGIN


 DELETE FROM  EventAttendees WHERE EVA_Email=@EVA_Email

  INSERT INTO EventAttendees (EVA_EventId,
    EVA_EventName,
    EVA_MemberName,
    EVA_Email,
    EVA_Job,
    EVA_CompanyName)
	SELECT EVA_EventId,EVT_EventName,@EVA_MemberName,@EVA_Email,@EVA_Job,@EVA_CompanyName
  FROM Openjson(@EventDetails) WITH (EVA_EventId int,EVT_EventName VARCHAR(500)) 	

	SELECT  1 as [status], 'Updated Successfully' as [message] 

 END

GO
/****** Object:  StoredProcedure [dbo].[Proc_EventAttendees_Insert]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Proc_EventAttendees_Insert 41,'[{"EVA_EventName":"reactnative","EVA_MemberName":"abi","EVA_Email":"abirami.a@paripoorna.in","EVA_Job":"","EVA_CompanyName":""},{"EVA_EventName":"reactnative","EVA_MemberName":"abi","EVA_Email":"abi.a@paripoorna.in","EVA_Job":"","EVA_CompanyName":""},{"EVA_EventName":"reactnative","EVA_MemberName":"abi","EVA_Email":"rami.a@paripoorna.in","EVA_Job":"","EVA_CompanyName":""}]'

CREATE PROCEDURE [dbo].[Proc_EventAttendees_Insert] (@EVA_EventId int,
@EventDetails Nvarchar(max))
AS
BEGIN


DECLARE @Event_Count INT;

DECLARE @Count INT;
SET @Count = 1;

Declare @EVA_Email varchar(100)

Declare @MemberId int


 SELECT ROW_NUMBER() over(order by @EVA_EventId) SNO,  @EVA_EventId EVA_EventId ,EVA_EventName,EVA_MemberName,EVA_Email,EVA_Job,EVA_CompanyName into #EventDetails  
  FROM Openjson(@EventDetails) WITH (EVA_EventName varchar(500),EVA_MemberName  varchar(100),EVA_Email  varchar(100),EVA_Job varchar(100),EVA_CompanyName  varchar(100))


  select @Event_Count=COUNT(1) from #EventDetails


  WHILE @Count <= @Event_Count
BEGIN


select @EVA_Email=EVA_Email from #EventDetails where SNO=@Count




  IF NOT EXISTS (SELECT
      1
    FROM EventAttendees
    WHERE 
	EVA_EventId = @EVA_EventId
   AND EVA_Email = @EVA_Email
   AND 
	EVA_IsActive = 1)
  BEGIN


   IF  EXISTS (SELECT
      1
    FROM Member
    WHERE  MBR_EmailId = @EVA_Email
    AND MBR_IsActive = 1)
  BEGIN
  select @MemberId=MBR_Id from Member where MBR_EmailId = @EVA_Email
    AND MBR_IsActive = 1

	--select  @MemberId
	exec Proc_MemberEvent_Insert  @MemberId,@EVA_EventId

  END

    INSERT INTO EventAttendees (EVA_EventId,
    EVA_EventName,
    EVA_MemberName,
    EVA_Email,
    EVA_Job,
    EVA_CompanyName)
	select EVA_EventId ,EVA_EventName,EVA_MemberName,EVA_Email,EVA_Job,EVA_CompanyName from #EventDetails where SNO=@Count
   
  END
  --ELSE
  --BEGIN
  --  SELECT
  --    0 [status],
  --    'Inserted Failed' [message]
  --END
   SET @Count = @Count + 1;
END;


  

    SELECT
      1 [status],
      'Successfully Inserted' [message]

END


GO
/****** Object:  StoredProcedure [dbo].[Proc_EventMapping_Attendees_Insert]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Proc_EventMapping_Attendees_Insert]
@MBR_ID int,  @MBR_FirstName  varchar(100), @MBR_LastName  varchar(100),@MBR_EmailId  varchar(100),@MBR_JobTitle varchar(100),@MBR_CompanyName  varchar(100) , @MBR_EVT_MAP nvarchar(max)
AS
BEGIN
 DELETE FROM [dbo].[MemberEvent]
  WHERE  MBE_MemberId = @MBR_ID
  insert into MemberEvent (MBE_MemberId,MBE_EventId,MBE_IsActive)
  SELECT @MBR_ID,EVA_EventId,1
  FROM Openjson(@MBR_EVT_MAP) WITH (EVA_EventId int) 
  DELETE FROM [dbo].[EventAttendees] WHERE EVA_Email = @MBR_EmailId
  INSERT INTO EventAttendees (EVA_EventId,
    EVA_EventName,
    EVA_MemberName,
    EVA_Email,
    EVA_Job,
    EVA_CompanyName)
	SELECT EVA_EventId,EVT_EventName,@MBR_FirstName+' '+@MBR_LastName
	,@MBR_EmailId,@MBR_JobTitle,@MBR_CompanyName
  FROM Openjson(@MBR_EVT_MAP) WITH (EVA_EventId int,EVT_EventName varchar(500))
  select 1 [status],'Updated Successfully' [Message]
END
GO
/****** Object:  StoredProcedure [dbo].[Proc_EventNotification_Insert]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_EventNotification_Insert] (@ENT_EventId int)
AS
BEGIN
  INSERT INTO [EventNotification] (ENT_EventId,
ENT_MemberId,
ENT_FCMToken,ENT_Status)
    select @ENT_EventId,MBR_ID,MBR_FCMToken,1 from Member where MBR_IsActive=1
END
GO
/****** Object:  StoredProcedure [dbo].[Proc_Events_Attendees_Delete]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--[Proc_Events_Attendees_Delete] 123,135
CREATE PROCEDURE [dbo].[Proc_Events_Attendees_Delete] (@AttendeesID int,@EventId INT,@MemberID INT)
AS
BEGIN

Update  MemberEvent set MBE_IsActive=0 where MBE_EventId=@EventId and MBE_MemberId=@MemberID

  UPDATE EventAttendees
  SET EVA_IsActive = 0
  WHERE EVA_ID = @AttendeesID
  AND EVA_IsActive = 1

  SELECT
    1 [status],
    ' Updated Successfully' [message]

END
GO
/****** Object:  StoredProcedure [dbo].[Proc_Events_Channel_Status_Update]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_Events_Channel_Status_Update] (@EVT_ID int,@EVT_IsshowChannel bit)
AS
BEGIN



  UPDATE [Events]
  SET EVT_IsshowChannel = @EVT_IsshowChannel
  WHERE EVT_ID = @EVT_ID
  AND EVT_IsActive = 1

  SELECT
    1 [status],
    ' Updated Successfully' [message]

END


GO
/****** Object:  StoredProcedure [dbo].[Proc_Events_Excel_Status_Update]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_Events_Excel_Status_Update] (@EVT_ID int,@EVT_ExcelUpload bit)
AS
BEGIN



  UPDATE [Events]
  SET EVT_IsExcelUpload = @EVT_ExcelUpload
  WHERE EVT_ID = @EVT_ID
  AND EVT_IsActive = 1

  SELECT
    1 [status],
    ' Updated Successfully' [message]

END



GO
/****** Object:  StoredProcedure [dbo].[Proc_Events_Insert]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--- Proc_Events_Insert 'CAP','Cloud Allaince Partner','chennai-50  
  
CREATE PROCEDURE [dbo].[Proc_Events_Insert] (@EVT_EventName varchar(500),  
@EVT_EventContent  nvarchar(max),  
@EVT_Venue nvarchar(max),  
@EVT_PhotoFileName nvarchar (max) ,  
@EVT_PhotoFilePath nvarchar(max) ,  
@EVT_BgPhotoFileName nvarchar (max) ,  
@EVT_BgPhotoFilePath nvarchar(max) ,  
@EVT_StartDate datetime,  
@EVT_EndDate datetime,  
@EVT_ChannelId varchar(500),  
@EVT_IsshowChannel bit,  
@EVT_URLLink varchar(500)  
)  
AS  
BEGIN  
  --IF NOT EXISTS (SELECT  
  --    1  
  --  FROM Member  
  --  WHERE MBR_EmailId = @MBR_EmailId and MBR_IsActive=1)  
  --BEGIN  
  INSERT INTO [Events] (EVT_EventName,  
  EVT_EventContent,  
  EVT_Venue,  
 EVT_PhotoFileName,  
 EVT_PhotoFilePath,  
  EVT_BgPhotoFileName,  
 EVT_BgPhotoFilePath,  
  EVT_StartDate,  
  EVT_EndDate,  
  EVT_ChannelId,  
  EVT_IsshowChannel,EVT_URLLink)  
    VALUES (@EVT_EventName, @EVT_EventContent, @EVT_Venue, @EVT_PhotoFileName,@EVT_PhotoFilePath,@EVT_BgPhotoFileName,@EVT_BgPhotoFilePath, @EVT_StartDate, @EVT_EndDate, @EVT_ChannelId,@EVT_IsshowChannel,@EVT_URLLink)  
  
 exec Proc_EventNotification_Insert @@IDENTITY  
  
   
  
DECLARE @TokenList VARCHAR(MAX)  
SELECT @TokenList = COALESCE(@TokenList+',' , '') + MBR_FCMToken   
FROM Member where MBR_IsActive=1  
  
  
  
  SELECT  
    1 [status],@@IDENTITY [EventId],@TokenList FCMTOKEN,  
    'Successfully Inserted' [message]  
--END  
--ELSE  
--BEGIN  
--  SELECT  
--    0 [status],  
--    'Inserted Failed' [message]  
--END  
END  
  
GO
/****** Object:  StoredProcedure [dbo].[Proc_Events_Notification_Delete]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_Events_Notification_Delete] (@NotificationID varchar(100))
AS
BEGIN



 SELECT NotificationId into #NotificationDetails  
  FROM Openjson(@NotificationID) WITH (NotificationId int)

  --select * from #NotificationDetails


  --select @Event_Count=COUNT(1) from #EventDetails

  UPDATE EventNotification
  SET ENT_IsActive = 0
  WHERE ENT_ID in ( select NotificationId from #NotificationDetails )
  AND ENT_IsActive = 1

  SELECT
    1 [status],
    ' Updated Successfully' [message]

END
GO
/****** Object:  StoredProcedure [dbo].[Proc_Events_Notification_Saved_Update]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_Events_Notification_Saved_Update] (@ENT_ID int,@ENT_IsSaved bit)
AS
BEGIN



  UPDATE EventNotification
  SET ENT_IsSaved = @ENT_IsSaved
  WHERE ENT_ID = @ENT_ID
  AND ENT_IsActive = 1

  SELECT
    1 [status],
    ' Updated Successfully' [message]

END
GO
/****** Object:  StoredProcedure [dbo].[Proc_Events_Notification_Status_Update]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_Events_Notification_Status_Update] (@ENT_ID int,@ENT_Status int)
AS
BEGIN



  UPDATE EventNotification
  SET ENT_Status = @ENT_Status
  WHERE ENT_ID = @ENT_ID
  AND ENT_IsActive = 1

  SELECT
    1 [status],
    ' Updated Successfully' [message]

END
GO
/****** Object:  StoredProcedure [dbo].[Proc_Events_Status_Update]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_Events_Status_Update] (@EVT_ID int)
AS
BEGIN



  UPDATE [Events]
  SET EVT_IsActive = 0
  WHERE EVT_ID = @EVT_ID
  AND EVT_IsActive = 1

  SELECT
    1 [status],
    ' Updated Successfully' [message]

END
GO
/****** Object:  StoredProcedure [dbo].[Proc_Events_Update]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Proc_Events_Update] (
@EVT_ID int,
@EVT_EventName varchar(500),
@EVT_EventContent nvarchar(max),
@EVT_Venue nvarchar(max),
@EVT_PhotoFileName nvarchar (max) ,
@EVT_PhotoFilePath nvarchar(max) ,
@EVT_BgPhotoFileName nvarchar (max) ,
@EVT_BgPhotoFilePath nvarchar(max) ,
@EVT_StartDate datetime,
@EVT_EndDate datetime,
@EVT_ChannelId varchar(500),
@EVT_IsshowChannel bit)
AS
BEGIN
  IF EXISTS (SELECT
      1
    FROM [Events] 
    WHERE EVT_ID = @EVT_ID
    AND EVT_IsActive = 1)
  BEGIN


    UPDATE [Events] 
    SET EVT_EventName = @EVT_EventName,
        EVT_EventContent = @EVT_EventContent,
        EVT_Venue = @EVT_Venue,
        EVT_PhotoFileName = @EVT_PhotoFileName,
		EVT_PhotoFilePath=@EVT_PhotoFilePath,
		 EVT_BgPhotoFileName = @EVT_BgPhotoFileName,
		EVT_BgPhotoFilePath=@EVT_BgPhotoFilePath,
        EVT_StartDate = @EVT_StartDate,
        EVT_EndDate = @EVT_EndDate,
        EVT_ChannelId = @EVT_ChannelId,
		EVT_IsshowChannel=@EVT_IsshowChannel
    WHERE EVT_ID = @EVT_ID
    AND EVT_IsActive = 1

    SELECT
      1 [status],
      ' Updated Successfully' [message]
  END
  ELSE
  BEGIN
    SELECT
      0 [status],
      'Invalid Data ' [message]
  END
END



GO
/****** Object:  StoredProcedure [dbo].[Proc_get_ChatDetails]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
--Proc_get_ChatDetails 76,184,1065  
CREATE PROCEDURE [dbo].[Proc_get_ChatDetails] (@CHD_MemberId INT,  
@CHD_EventId INT,  
@CHD_ID INT=null  
)  
AS  
BEGIN  
  
DECLARE @CheckDate DATETIME   
  
SELECT @CheckDate=MBR_CreatedDate FROM Member WHERE MBR_ID=@CHD_MemberId and MBR_IsActive=1  
  
SELECT CAST(cht.CHD_CreatedDate AS DATE)  title,   
(SELECT cd.*,cm.MBR_FirstName +' '+cm.MBR_LastName as CD_UserName,  
     cm.MBR_PhotoFileName,cm.MBR_FCMToken,cm.MBR_MobileNo,  
     cm.MBR_EmailId,  
     CASE WHEN cm.MBR_IsActive=1 THEN CASE WHEN me.MBE_ID IS NOT NULL THEN 1 ELSE 0 END ELSE 0 END AS IsMemberActive ,  
     (SELECT ct.*,rm.MBR_FirstName +' '+rm.MBR_LastName AS CD_UserName,  
     rm.MBR_PhotoFileName,rm.MBR_FCMToken,rm.MBR_MobileNo,  
     rm.MBR_EmailId  
     FROM ChatDetails ct     
     LEFT JOIN ChatDetails AS ct_rt ON  ct.CHD_ParentChatId=ct_rt.CHD_ID  
     LEFT JOIN Member as rm on rm.MBR_ID=ct.CHD_MemberId  
     WHERE ct.CHD_ParentChatId IS NOT NULL  
     AND cd.CHD_ID=ct.CHD_ParentChatId  
     AND ct.CHD_EventId=@CHD_EventId  
	 and ct.CHD_IsActive=1  
     FOR JSON PATH) 'replied_message' 
 FROM ChatDetails cd  
 LEFT JOIN Member as cm on cm.MBR_ID=cd.CHD_MemberId   
 LEFT JOIN MemberEvent  as me on me.MBE_EventId=cd.CHD_EventId and me.MBE_MemberId=cd.CHD_MemberId and MBE_IsActive=1  
 WHERE CAST(cd.CHD_CreatedDate AS DATE) =  CAST(cht.CHD_CreatedDate AS DATE)  
       AND cd.CHD_ParentChatId IS NULL and cd.CHD_EventId=@CHD_EventId  
    and cd.CHD_ID=Isnull(@CHD_ID, cd.CHD_ID)  
    and cd.CHD_IsActive =1
       FOR JSON PATH) 'data'   
 FROM ChatDetails  cht  
 WHERE cht.CHD_EventId=@CHD_EventId  
 AND cht.CHD_IsActive=1  
 AND cht.CHD_Date > @CheckDate  
 and cht.CHD_ID=Isnull(@CHD_ID, cht.CHD_ID)  
 GROUP BY CAST(cht.CHD_CreatedDate AS DATE)    
 ORDER BY CAST(cht.CHD_CreatedDate AS DATE)     
     
 --where CD.CHD_EventId=@CHD_EventId and CD.CHD_IsActive=1  and CDM.MBR_IsActive=1 and CD.CHD_Date > @CheckDate  
  
    
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_get_ChatDetails_bak]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
--Proc_get_ChatDetails_bak 76,184,1065  
CREATE PROCEDURE [dbo].[Proc_get_ChatDetails_bak] (@CHD_MemberId INT,  
@CHD_EventId INT,  
@CHD_ID INT=null  
)  
AS  
BEGIN  
  
DECLARE @CheckDate DATETIME   
  
SELECT @CheckDate=MBR_CreatedDate FROM Member WHERE MBR_ID=@CHD_MemberId and MBR_IsActive=1  

DECLARE @SQL VARCHAR(MAX);
  
set @SQL='SELECT CAST(cht.CHD_CreatedDate AS DATE)  title,   
(SELECT cd.*,t.chd_Id fdd,cm.MBR_FirstName  as CD_UserName,  
     cm.MBR_PhotoFileName,cm.MBR_FCMToken,cm.MBR_MobileNo,  
     cm.MBR_EmailId, 
     CASE WHEN cm.MBR_IsActive=1 THEN CASE WHEN me.MBE_ID IS NOT NULL THEN 1 ELSE 0 END ELSE 0 END AS IsMemberActive ,  
	 CASE WHEN t.chd_Id IS NOT NULL THEN 1 ELSE 0 END AS sdf ,  
     (SELECT ct.*,rm.MBR_FirstName AS CD_UserName,  
     rm.MBR_PhotoFileName,rm.MBR_FCMToken,rm.MBR_MobileNo,  
     rm.MBR_EmailId  
     FROM ChatDetails ct     
     LEFT JOIN ChatDetails AS ct_rt ON  ct.CHD_ParentChatId=ct_rt.CHD_ID  
     LEFT JOIN Member as rm on rm.MBR_ID=ct.CHD_MemberId  
     WHERE
		 ct.CHD_ParentChatId IS NOT NULL  
		  AND
	  cd.CHD_ID=ct.CHD_ParentChatId  
     AND ct.CHD_EventId=184  
	 and ct.CHD_IsActive=1  
     FOR JSON PATH) ''replied_message'' 
 FROM ChatDetails cd  
 LEFT JOIN Member as cm on cm.MBR_ID=cd.CHD_MemberId   
 LEFT JOIN MemberEvent  as me on me.MBE_EventId=cd.CHD_EventId and me.MBE_MemberId=cd.CHD_MemberId and MBE_IsActive=1  
 left join ChatDetails as t on t.CHD_ParentChatId=cd.CHD_ID
 WHERE CAST(cd.CHD_CreatedDate AS DATE) =  CAST(cht.CHD_CreatedDate AS DATE)  
       AND cd.CHD_ParentChatId IS NULL and cd.CHD_EventId=184 
    and cd.CHD_ID=Isnull(null, cd.CHD_ID)  
    and cd.CHD_IsActive = CASE WHEN t.chd_Id IS NOT NULL THEN 1 ELSE ISNULL(null,Cd.CHD_IsActive) END  
       FOR JSON PATH) ''data''   
 FROM ChatDetails  cht  
 WHERE cht.CHD_EventId=184  
 AND cht.CHD_IsActive=1  

 and cht.CHD_ID=Isnull(null, cht.CHD_ID)  
 GROUP BY CAST(cht.CHD_CreatedDate AS DATE)    
 ORDER BY CAST(cht.CHD_CreatedDate AS DATE) '
 
 SELECT @SQL

 EXEC(@SQL)   

  
    
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_get_ChatDetails_bak1]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Proc_get_ChatDetails_bak1 76,184,1065  
CREATE PROCEDURE [dbo].[Proc_get_ChatDetails_bak1] (@CHD_MemberId INT,  
@CHD_EventId INT,  
@CHD_ID INT=null  
)  
AS  
BEGIN  
  
DECLARE @CheckDate DATETIME   
  
SELECT @CheckDate=MBR_CreatedDate FROM Member WHERE MBR_ID=@CHD_MemberId and MBR_IsActive=1  
  
SELECT CAST(cht.CHD_CreatedDate AS DATE)  title,   
(SELECT distinct cd.*,cm.MBR_FirstName +' '+cm.MBR_LastName as CD_UserName,  
     cm.MBR_PhotoFileName,cm.MBR_FCMToken,cm.MBR_MobileNo,  
     cm.MBR_EmailId,  
     CASE WHEN cm.MBR_IsActive=1 THEN CASE WHEN me.MBE_ID IS NOT NULL THEN 1 ELSE 0 END ELSE 0 END AS IsMemberActive ,
     (SELECT distinct ct.*,rm.MBR_FirstName +' '+rm.MBR_LastName AS CD_UserName,  
     rm.MBR_PhotoFileName,rm.MBR_FCMToken,rm.MBR_MobileNo,  
     rm.MBR_EmailId
     FROM ChatDetails ct     
     LEFT JOIN ChatDetails AS ct_rt ON  ct.CHD_ParentChatId=ct_rt.CHD_ID  
     LEFT JOIN Member as rm on rm.MBR_ID=ct.CHD_MemberId  
     WHERE ct.CHD_ParentChatId IS NOT NULL  
     AND cd.CHD_ID=ct.CHD_ParentChatId  
     AND ct.CHD_EventId=@CHD_EventId  
	 and ct.CHD_IsActive=1  
     FOR JSON PATH) 'replied_message' 
 FROM ChatDetails cd  
 LEFT JOIN Member as cm on cm.MBR_ID=cd.CHD_MemberId   
 LEFT JOIN MemberEvent  as me on me.MBE_EventId=cd.CHD_EventId and me.MBE_MemberId=cd.CHD_MemberId and MBE_IsActive=1  
 LEFT JOIN ChatDetails as tt on tt.CHD_ParentChatId=cd.chd_id and tt.chd_ISactive=1
 WHERE CAST(cd.CHD_CreatedDate AS DATE) =  CAST(cht.CHD_CreatedDate AS DATE)  
       AND cd.CHD_ParentChatId IS NULL and cd.CHD_EventId=@CHD_EventId  
    and cd.CHD_ID=Isnull(@CHD_ID, cd.CHD_ID)  
  and  cd.CHD_IsActive = (case when tt.chd_id is not null then ISNULL(null,cd.CHD_IsActive) else  1  end)
	 
       FOR JSON PATH) 'data'
 FROM ChatDetails  cht  
 WHERE cht.CHD_EventId=@CHD_EventId  
 AND cht.CHD_IsActive=1  
 AND cht.CHD_Date > @CheckDate  
 and cht.CHD_ID=Isnull(@CHD_ID, cht.CHD_ID)  
 GROUP BY CAST(cht.CHD_CreatedDate AS DATE)    
 ORDER BY CAST(cht.CHD_CreatedDate AS DATE)    
  
    
END
GO
/****** Object:  StoredProcedure [dbo].[Proc_get_ChatMember]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Proc_get_ChatMember]
@CHD_EventId INT
AS
BEGIN

 SELECT  
 MBR_ID,
MBR_FirstName+' '+MBR_LastName AS MBR_Name,MBR_MobileNo,MBR_PhotoFileName    
    FROM MemberEvent  AS EA
	INNER JOIN Member M on EA.MBE_MemberId=M.MBR_ID
    WHERE EA.MBE_EventId = @CHD_EventId  
    AND EA.MBE_IsActive = 1 and M.MBR_IsActive=1

END
GO
/****** Object:  StoredProcedure [dbo].[Proc_get_ChatMessages]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[Proc_get_ChatMessages]
@EventId INT,
@MemberId INT,
@Date DATETIME
AS
BEGIN

SELECT CD.*, E.EVT_EventName,M.MBR_FirstName+' '+MBR_LastName as  MBR_Name,M.MBR_PhotoFileName,MBR_MobileNo,
MBR_EmailId,MBR_JobTitle,
MBR_CompanyName FROM ChatDetails AS CD
INNER JOIN Member as M ON M.MBR_ID=CD.CHD_MemberID
InNER JOIN Events as E On E.EVT_ID=CD.CHD_EventId
WHERE CD.CHD_MemberId=@MemberId 
AND CD.CHD_EventId=@EventId
AND CAST(CD.CHD_Date AS DATE)=CAST(@Date AS DATE)
AND CD.CHD_IsActive=1
END
GO
/****** Object:  StoredProcedure [dbo].[Proc_get_EventAttendees_Details]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_get_EventAttendees_Details] (@EVA_EventId int)  
AS  
BEGIN  
 SELECT  
      EA.*,MBR_Info,MBR_PhotoFileName,MBR_ID
    FROM EventAttendees  AS EA
	LEFT JOIN Member M on EA.EVA_Email=M.MBR_EmailId
    WHERE EVA_EventId = @EVA_EventId  
    --AND EVA_ID = isnull(@EVA_ID,EVA_ID)  
    AND EVA_IsActive = 1  
END  
GO
/****** Object:  StoredProcedure [dbo].[Proc_get_EventNotification]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_get_EventNotification] (@ENT_MemberId int)
AS
BEGIN
 SELECT
      *,( case when EVT_StartDate <= CONVERT(date, GETDATE()) then 1 else 0 end) navigate
    FROM EventNotification
	inner join [Events] on ENT_EventId=EVT_ID
    WHERE ENT_MemberId = @ENT_MemberId
    --AND EVA_ID = isnull(@EVA_ID,EVA_ID)
    AND ENT_IsActive = 1
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_get_Events_Details]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_get_Events_Details] (@EVT_ID int null)
AS
BEGIN
  select * from [Events]  WHERE EVT_ID = isnull(@EVT_ID,EVT_ID) 
    AND EVT_IsActive = 1
END
GO
/****** Object:  StoredProcedure [dbo].[Proc_get_Events_withFilter]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Proc_get_Events_withFilter null,null,null,null,null



CREATE PROCEDURE [dbo].[Proc_get_Events_withFilter] (@EVT_EventName varchar(500) null ,@EVT_StartDate datetime null, @EVT_EndDate datetime null, @EVT_ChannelId varchar(500),@EVT_IsshowChannel bit null  )
AS
BEGIN

 select * from [Events]  WHERE EVT_EventName LIKE '%' +isnull(@EVT_EventName,EVT_EventName) + '%'   and  EVT_ChannelId = isnull(@EVT_ChannelId,EVT_ChannelId) 
  and EVT_IsshowChannel = isnull(@EVT_IsshowChannel,EVT_IsshowChannel) and EVT_StartDate between isnull(@EVT_StartDate,EVT_StartDate) and  isnull(@EVT_EndDate,EVT_StartDate)
  AND EVT_EndDate between isnull(@EVT_StartDate,EVT_EndDate) and  isnull(@EVT_EndDate,EVT_EndDate)
    AND EVT_IsActive = 1

END

GO
/****** Object:  StoredProcedure [dbo].[Proc_get_Member_Details]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Proc_get_Member_Details] (@MBR_ID int)
AS
BEGIN
  select * from Member  WHERE MBR_ID = @MBR_ID
    AND MBR_IsActive = 1
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_get_Member_Isactive]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_get_Member_Isactive] (@MBR_ID int,    
@MBR_IsActive int)    
AS    
BEGIN    
  IF EXISTS (SELECT    
      1    
    FROM Member    
    WHERE MBR_ID = @MBR_ID    
    )    
  BEGIN    
    
    
    UPDATE Member    
    SET MBR_IsActive = @MBR_IsActive  
    WHERE MBR_ID = @MBR_ID    
    
    SELECT    
      1 [status],    
      ' Updated Successfully' [message]    
  END    
  ELSE    
  BEGIN    
    SELECT    
      0 [status],    
      'Invalid Data ' [message]    
  END    
END 
GO
/****** Object:  StoredProcedure [dbo].[Proc_get_Member_Survey_Details]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create proc [dbo].[Proc_get_Member_Survey_Details](
@MBR_ID int
)
as
begin

select * from SurveyQue inner join SurveyAns on SRQ_ID=SRA_QueID
inner join Member MBA on  MBA.MBR_SurveyAnsId=SRA_ID where MBA.MBR_ID=@MBR_ID

end



GO
/****** Object:  StoredProcedure [dbo].[Proc_get_Member_withFilter]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Proc_get_Member_withFilter @MBR_EmailId='hello'
CREATE PROC [dbo].[Proc_get_Member_withFilter]
@MBR_FirstName varchar(100)= null,  
@MBR_LastName varchar(100)= null,  
@MBR_EmailId varchar(100)= null,  
@MBR_SecondaryEmailId varchar(100)= null,  
@MBR_CompanyName varchar(500)= null,  
@MBR_JobTitle varchar(500)= null,  
@MBR_MobileNo nvarchar(100)= null,   
@MBR_IsActive varchar(100)=null  
AS
BEGIN

SELECT distinct MBR_ID,MBR_FirstName,MBR_LastName ,
MBR_MobileNo,MBR_EmailId,MBR_SecondaryEmailId,MBR_PhotoFileName,
MBR_PhotoFilePath,MBR_JobTitle,MBR_CompanyName,MBR_Info,MBR_IsMobileVerified,
MBR_IsEmailVerified,MBR_IsSurveyCompleted,MBR_SurveyQueId,
MBR_SurveyAnsId,MBR_DeviceId,MBR_FCMToken,MBR_CreatedDate,
MBR_ModifyDate,MBR_IsActive,1 as IsRegistered,(SELECT MBE_ID,  
MBE_MemberId, EVT_ID,  
EVT_EventName,  
EVT_EventContent,  
EVT_Venue,  
EVT_PhotoFileName,  
EVT_PhotoFilePath,  
EVT_BgPhotoFileName,  
EVT_BgPhotoFilePath,  
EVT_StartDate,  
EVT_EndDate,  
EVT_IsActive,  
EVT_URLLink 
          FROM MemberEvent US    
          LEFT JOIN Events as E on E.EVT_ID=US.MBE_EventId  
          WHERE US.MBE_MemberId =MBR.MBR_ID  and MBE_IsActive=1
          FOR JSON PATH) 'MBR_EVT_MAPPING' 
		  from [Member] as MBR  
    WHERE MBR_IsActive=1 and 
	MBR_EmailId like '%'+(ISnull(@MBR_EmailId, MBR_EmailId))+'%'
and MBR_JobTitle like '%'+(ISnull(@MBR_JobTitle, MBR_JobTitle))+'%'
and MBR_CompanyName like '%'+(ISnull(@MBR_CompanyName, MBR_CompanyName))+'%'
and MBR_FirstName like '%'+(ISnull(@MBR_FirstName, MBR_FirstName))+'%'
and MBR_LastName like '%'+(ISnull(@MBR_LastName, MBR_LastName))+'%'
and MBR_MobileNo like '%'+(ISnull(@MBR_MobileNo, MBR_MobileNo))+'%'
union All
select distinct null as MBR_ID, EVA_MemberName MBR_FirstName,'' MBR_LastName,null MBR_MobileNo,
EVA_Email as MBR_EmailId,'' MBR_SecondaryEmailId,'' as MBR_PhotoFileName,
'' MBR_PhotoFilePath,EVA_Job MBR_JobTitle,EVA_CompanyName MBR_CompanyName,'' MBR_Info,null MBR_IsMobileVerified,
null MBR_IsEmailVerified,null MBR_IsSurveyCompleted,null MBR_SurveyQueId,
null MBR_SurveyAnsId,'' MBR_DeviceId,'' MBR_FCMToken,EVA_CreatedDate MBR_CreatedDate,
EVA_ModifyDate MBR_ModifyDate,EVA_IsActive MBR_IsActive,0 as IsRegistered,(SELECT null as MBE_ID,  
null MBE_MemberId, EVT_ID,  
EVT_EventName,  
EVT_EventContent,  
EVT_Venue,  
EVT_PhotoFileName,  
EVT_PhotoFilePath,  
EVT_BgPhotoFileName,  
EVT_BgPhotoFilePath,  
EVT_StartDate,  
EVT_EndDate,  
EVT_IsActive,  
EVT_URLLink 
          FROM EventAttendees US    
          LEFT JOIN Events as E on E.EVT_ID=US.EVA_EventId  
          WHERE US.EVA_Email =MBR.EVA_Email  and EVA_IsActive=1
          FOR JSON PATH) 'MBR_EVT_MAPPING'  
		  from EventAttendees as MBR  
    WHERE  EVA_Email not in (select MBR_EmailId from Member) and EVA_IsActive=1
	and 
	EVA_Email like '%'+(ISnull(@MBR_EmailId, EVA_Email))+'%'
and EVA_Job like '%'+(ISnull(@MBR_JobTitle, EVA_Job))+'%'
and EVA_CompanyName like '%'+(ISnull(@MBR_CompanyName, EVA_CompanyName))+'%'


 
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_get_Member_withFilter_bak]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Proc_get_Member_withFilter_bak]
@MBR_EmailId VARCHAR(100)=null,
@MBR_JobTitle VARCHAR(100)=null,
@MBR_CompanyName VARCHAR(100)=null
AS
BEGIN

SELECT distinct MBR_ID,MBR_FirstName+' '+MBR_LastName as MBR_Name,
MBR_MobileNo,MBR_EmailId,MBR_SecondaryEmailId,MBR_PhotoFileName,
MBR_PhotoFilePath,MBR_JobTitle,MBR_CompanyName,MBR_Info,MBR_IsMobileVerified,
MBR_IsEmailVerified,MBR_IsSurveyCompleted,MBR_SurveyQueId,
MBR_SurveyAnsId,MBR_DeviceId,MBR_FCMToken,MBR_CreatedDate,
MBR_ModifyDate,MBR_IsActive,1 as IsRegistered,(SELECT MBE_ID,  
MBE_MemberId, EVT_ID,  
EVT_EventName,  
EVT_EventContent,  
EVT_Venue,  
EVT_PhotoFileName,  
EVT_PhotoFilePath,  
EVT_BgPhotoFileName,  
EVT_BgPhotoFilePath,  
EVT_StartDate,  
EVT_EndDate,  
EVT_IsActive,  
EVT_URLLink 
          FROM MemberEvent US    
          LEFT JOIN Events as E on E.EVT_ID=US.MBE_EventId  
          WHERE US.MBE_MemberId =MBR.MBR_ID  and MBE_IsActive=1
          FOR JSON PATH) 'MBR_EVT_MAPPING' into #registereduser
		  from [Member] as MBR  
    WHERE 1=1


select distinct null as MBR_ID, EVA_MemberName as MBR_Name,null MBR_MobileNo,
EVA_Email as MBR_EmailId,'' MBR_SecondaryEmailId,'' as MBR_PhotoFileName,
'' MBR_PhotoFilePath,EVA_Job MBR_JobTitle,EVA_CompanyName MBR_CompanyName,'' MBR_Info,null MBR_IsMobileVerified,
null MBR_IsEmailVerified,null MBR_IsSurveyCompleted,null MBR_SurveyQueId,
null MBR_SurveyAnsId,'' MBR_DeviceId,'' MBR_FCMToken,EVA_CreatedDate MBR_CreatedDate,
EVA_ModifyDate MBR_ModifyDate,EVA_IsActive MBR_IsActive,0 as IsRegistered,(SELECT null as MBE_ID,  
null MBE_MemberId, EVT_ID,  
EVT_EventName,  
EVT_EventContent,  
EVT_Venue,  
EVT_PhotoFileName,  
EVT_PhotoFilePath,  
EVT_BgPhotoFileName,  
EVT_BgPhotoFilePath,  
EVT_StartDate,  
EVT_EndDate,  
EVT_IsActive,  
EVT_URLLink 
          FROM EventAttendees US    
          LEFT JOIN Events as E on E.EVT_ID=US.EVA_EventId  
          WHERE US.EVA_Email =MBR.EVA_Email  and EVA_IsActive=1
          FOR JSON PATH) 'MBR_EVT_MAPPING'  into #eventattendee
		  from EventAttendees as MBR  
    WHERE  EVA_Email not in (select MBR_EmailId from Member)




 select * from (select *  from #registereduser 
	union
select *  from #eventattendee ) as t

WHERE t.MBR_EmailId like '%'+(ISnull(@MBR_EmailId,t.MBR_EmailId))+'%'
and t.MBR_JobTitle like '%'+(ISnull(@MBR_JobTitle,t.MBR_JobTitle))+'%'
and t.MBR_CompanyName like '%'+(ISnull(@MBR_CompanyName,t.MBR_CompanyName))+'%'

drop table #registereduser,#eventattendee
 
 END
GO
/****** Object:  StoredProcedure [dbo].[Proc_Get_QuestionBySurvey]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Proc_Get_QuestionBySurvey 's001'
CREATE PROC [dbo].[Proc_Get_QuestionBySurvey] 
@surveycode VARCHAR(20)
AS
BEGIN
--SELECT SurveyMasterId,
--QuestionId,
--sc.SurveyCode,
--QuestionDesc,
--OfferedAnswers,surveyname, 
--surveydescription,sc.IsActive FROM SurveyMaster AS SM
--LEFT JOIN surveycatalog AS SC ON sc.surveycode=sm.surveycode
-- WHERE SM.surveycode=@surveycode and  SM.IsActive=1

SELECT surveyname,surveydescription,SurveyCode as surveycode,IsActive,(
SELECT *,REPLACE(OfferedAnswers,'||',', ') as Answer FROM SurveyMaster AS SM
WHERE SM.SurveyCode=Sc.surveycode and SM.IsDeleted=0
FOR JSON PATH) 'SurveyQuestions' FROM surveycatalog AS sc
WHERE SC.surveycode=@surveycode and IsDeleted=0 
END
GO
/****** Object:  StoredProcedure [dbo].[Proc_get_Survey_Details]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

---Proc_get_Survey_Details 1

CREATE PROC [dbo].[Proc_get_Survey_Details] (@Type int)
AS
BEGIN
  IF (@Type = 1)
  BEGIN

    SELECT 
   SRQ_ID, SRQ_Que,SRQ_IsEnable,
(SELECT US.SRA_ID,
US.SRA_QueID,
US.SRA_Ans,
US.SRA_IsEnable 
          FROM SurveyAns US
          WHERE US.SRA_QueID = SS.SRQ_ID
          FOR JSON PATH) 'Options',0 IsEditable into #SurveyDetails
FROM  SurveyQue SS
    INNER JOIN SurveyAns
       ON SRQ_ID = SRA_QueID    
      AND SRQ_IsActive = 1
	  GROUP BY SRQ_ID, SRQ_Que,SRQ_IsEnable


	  --select * from #SurveyDetails SS inner join Member on MBR_SurveyQueId=SS.SRQ_ID 


	   update SD set IsEditable = (case when Isenable >0 then 1 else 0 end) from #SurveyDetails SD
         inner join (select SS.SRQ_ID,COUNT(1) Isenable from #SurveyDetails SS inner join Member 
		 on MBR_SurveyQueId=SS.SRQ_ID group by SS.SRQ_ID
		 ) X on 
		 X.SRQ_ID=SD.SRQ_ID

		 select * from #SurveyDetails

		 	 
	


  END
  ELSE if (@Type = 2)
  BEGIN

  SELECT 
   SRQ_ID, SRQ_Que,SRQ_IsEnable,
(SELECT US.SRA_ID,
US.SRA_QueID,
US.SRA_Ans,
US.SRA_IsEnable 
          FROM SurveyAns US
          WHERE US.SRA_QueID = SS.SRQ_ID
          FOR JSON PATH) 'Options'
FROM  SurveyQue SS
    INNER JOIN SurveyAns
      ON SRQ_ID = SRA_QueID    AND SRQ_IsEnable = 1
      AND SRQ_IsActive = 1
	  GROUP BY SRQ_ID, SRQ_Que,SRQ_IsEnable
  
  END
  else
  begin
    SELECT 
   SRQ_ID, SRQ_Que,SRQ_IsEnable,
(SELECT US.SRA_Ans 
          FROM SurveyAns US
          WHERE US.SRA_QueID = SS.SRQ_ID
          FOR JSON PATH) 'Options'
FROM  SurveyQue SS
    INNER JOIN SurveyAns
       ON SRQ_ID = SRA_QueID    
      AND SRQ_IsActive = 1
	  GROUP BY SRQ_ID, SRQ_Que,SRQ_IsEnable
  end

END


GO
/****** Object:  StoredProcedure [dbo].[Proc_getsurveyquestions]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_getsurveyquestions] --mobile
AS
    SELECT *
    FROM   surveymaster as s
	INNER JOIN surveycatalog as sc on s.SurveyCode=sc.surveycode
    WHERE  s.IsActive=1 and sc.IsActive=1 and sc.isdeleted=0 and s.IsDeleted=0
    ORDER  BY questionid
GO
/****** Object:  StoredProcedure [dbo].[Proc_Insert_ChatDetails]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_Insert_ChatDetails] (@CHD_MemberId	int,
@CHD_EventId int,
@CHD_Message	nvarchar(max),
@CHD_FileName	nvarchar(max),
@CHD_FilePath	nvarchar(max),
@CHD_FileType	nvarchar(max),
@CHD_Date	datetime,
@CHD_ParentChatId	int
)
AS
BEGIN

if(@CHD_ParentChatId = 0)
begin
set @CHD_ParentChatId=null
end
 
    INSERT INTO ChatDetails (CHD_MemberId,
	CHD_EventId,
CHD_Message,
CHD_FileName,
CHD_FilePath,
CHD_FileType,
CHD_Date,
CHD_ParentChatId)
      VALUES (@CHD_MemberId,
	  @CHD_EventId,
@CHD_Message,
@CHD_FileName,
@CHD_FilePath,
@CHD_FileType,
GETDATE(),
@CHD_ParentChatId)

    SELECT
      1 [status], 
      'Successfully Inserted' [message]
  
END







GO
/****** Object:  StoredProcedure [dbo].[Proc_member_authentication]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Proc_member_authentication 'abirami.a@paripoorna.in','263fec58861449aacc1c328a4aff64aff4c62df4a2d50b3f207fa89b6e242c9aa778e7a8baeffef85b6ca6d2e7dc16ff0a760d59c13c238f6bcdc32f8ce9cc62','asddsa'
CREATE PROCEDURE [dbo].[Proc_member_authentication](@MBR_EmailId varchar(100),
                                                     @MBR_Password nvarchar(400),
                                                     @MBR_FCMToken NVARCHAR(max))
AS
  BEGIN

   UPDATE [dbo].[Member]
      SET    [MBR_FCMToken] = @MBR_FCMToken
      WHERE  [MBR_EmailId] = @MBR_EmailId
             AND [MBR_Password] = @MBR_Password
             AND [MBR_IsActive] = 1

			 
Declare @EVA_EventId int

Declare @MemberId int
DECLARE @Event_Count INT;

DECLARE @Count INT;
SET @Count = 1;

select @MemberId=MBR_ID from Member where MBR_EmailId=@MBR_EmailId and MBR_IsActive=1

select ROW_NUMBER() over(order by EVA_ID) SNO,EVA_EventId  into #EventList from EventAttendees 
where EVA_Email=@MBR_EmailId and EVA_IsActive=1


  select @Event_Count=COUNT(1) from #EventList


  if( @MemberId is not null)
  begin
  WHILE @Count <= @Event_Count
BEGIN

select @EVA_EventId=EVA_EventId from #EventList where SNO=@Count

exec Proc_MemberEvent_Insert  @MemberId,@EVA_EventId

 SET @Count = @Count + 1;

END;
end

      SELECT *
      FROM   [dbo].[Member]
		  WHERE  [MBR_EmailId] = @MBR_EmailId
             AND [MBR_Password] = @MBR_Password
             AND [MBR_IsActive] = 1

     
  END 



GO
/****** Object:  StoredProcedure [dbo].[Proc_Member_ChangePAssword]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_Member_ChangePAssword] (@MemberId int,
@OldPassword nvarchar(400),
@NewPassword nvarchar(400))
AS
BEGIN
  IF EXISTS (SELECT
      1
    FROM Member
    WHERE MBR_ID = @MemberId and MBR_Password=@OldPassword
    AND MBR_IsActive = 1)
  BEGIN


    UPDATE Member
    SET 
        MBR_Password = @NewPassword
    WHERE MBR_ID = @MemberId
    AND MBR_IsActive = 1

    SELECT
      1 [status],
      ' Updated Successfully' [message]
  END
  ELSE
  BEGIN
    SELECT
      0 [status],
      'Invalid Data ' [message]
  END
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_Member_forgotPassword]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_Member_forgotPassword] (@EmailId varchar(100),
@Password nvarchar(400))
AS
BEGIN
  IF EXISTS (SELECT
      1
    FROM Member
    WHERE MBR_EmailId = @EmailId 
    AND MBR_IsActive = 1)
  BEGIN

  Declare @name varchar(100)

 SELECT @name = MBR_FirstName + ' '+
MBR_LastName
    FROM Member
    WHERE MBR_EmailId = @EmailId 
    AND MBR_IsActive = 1


    UPDATE Member
    SET 
        MBR_Password = @Password
    WHERE  MBR_EmailId = @EmailId 
    AND MBR_IsActive = 1

    SELECT
      1 [status], @name UserName,
      ' Updated Successfully' [message]
  END
  ELSE
  BEGIN
    SELECT
      0 [status],
      'Invalid Data ' [message]
  END
END




GO
/****** Object:  StoredProcedure [dbo].[Proc_Member_Registration]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_Member_Registration] (@MBR_FirstName varchar(50),
@MBR_LastName varchar(50),
@MBR_Password nvarchar(400),
@MBR_MobileNo bigint,
@MBR_EmailId varchar(100),
@MBR_SecondaryEmailId varchar(100),
@MBR_PhotoFileName nvarchar(max),
@MBR_PhotoFilePath nvarchar(max),
@MBR_JobTitle varchar(500),
@MBR_CompanyName varchar(500),
@MBR_Info nvarchar(max),
@MBR_DeviceId nvarchar(max),
@MBR_FCMToken nvarchar(max)
)
AS
BEGIN
  IF NOT EXISTS (SELECT
      1
    FROM Member
    WHERE MBR_EmailId = @MBR_EmailId and MBR_IsActive=1)
  BEGIN
    INSERT INTO Member (MBR_FirstName,
    MBR_LastName,
    MBR_Password,
    MBR_MobileNo,
    MBR_EmailId,
	MBR_SecondaryEmailId,
	MBR_PhotoFileName,
	MBR_PhotoFilePath,
    MBR_JobTitle,
    MBR_CompanyName,MBR_Info,MBR_DeviceId,MBR_FCMToken)
      VALUES (@MBR_FirstName, @MBR_LastName, @MBR_Password, @MBR_MobileNo, @MBR_EmailId,@MBR_SecondaryEmailId,@MBR_PhotoFileName,@MBR_PhotoFilePath, @MBR_JobTitle, @MBR_CompanyName,@MBR_Info,@MBR_DeviceId,@MBR_FCMToken)

    SELECT
      1 [status],  @@IDENTITY MemberId,
      'Successfully Registered' [message]
  END
  ELSE
  BEGIN
    SELECT
      0 [status],
      'Email Id Already Exists' [message]
  END
END






GO
/****** Object:  StoredProcedure [dbo].[Proc_Member_Update]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Proc_Member_Update] (@MBR_ID int,
@MBR_FirstName varchar(50),
@MBR_LastName varchar(50),
@MBR_Password nvarchar(400),
@MBR_MobileNo bigint,
@MBR_EmailId varchar(100),
@MBR_JobTitle varchar(500),
@MBR_CompanyName varchar(500))
AS
BEGIN
  IF EXISTS (SELECT
      1
    FROM Member
    WHERE MBR_ID = @MBR_ID
    AND MBR_IsActive = 1)
  BEGIN


    UPDATE Member
    SET MBR_FirstName = @MBR_FirstName,
        MBR_LastName = @MBR_LastName,
        MBR_Password = @MBR_Password,
        MBR_MobileNo = @MBR_MobileNo,
        MBR_EmailId = @MBR_EmailId,
        MBR_JobTitle = @MBR_JobTitle,
        MBR_CompanyName = @MBR_CompanyName
    WHERE MBR_ID = @MBR_ID
    AND MBR_IsActive = 1

    SELECT
      1 [status],
      ' Updated Successfully' [message]
  END
  ELSE
  BEGIN
    SELECT
      0 [status],
      'Invalid Data ' [message]
  END
END
GO
/****** Object:  StoredProcedure [dbo].[Proc_Member_UpdateProfile]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_Member_UpdateProfile] (@MBR_ID int,
@MBR_FirstName varchar(100),
@MBR_LastName varchar(100),
@MBR_MobileNo bigint,
@MBR_EmailId varchar(100),
@MBR_SecondaryEmailId varchar(100),
@MBR_PhotoFileName nvarchar(max),
@MBR_PhotoFilePath nvarchar(max),
@MBR_JobTitle varchar(500),
@MBR_CompanyName varchar(500),
@MBR_Info nvarchar(max)
)
AS
BEGIN
  IF EXISTS (SELECT
      1
    FROM Member
    WHERE MBR_ID = @MBR_ID
    AND MBR_IsActive = 1)
  BEGIN


    UPDATE Member
    SET MBR_FirstName = @MBR_FirstName,
        MBR_LastName = @MBR_LastName,
        MBR_MobileNo = @MBR_MobileNo,
        MBR_EmailId = @MBR_EmailId,
		MBR_SecondaryEmailId=@MBR_SecondaryEmailId,
		MBR_PhotoFileName=@MBR_PhotoFileName,
		MBR_PhotoFilePath=@MBR_PhotoFilePath,
        MBR_JobTitle = @MBR_JobTitle,
        MBR_CompanyName = @MBR_CompanyName,
		MBR_Info=@MBR_Info
    WHERE MBR_ID = @MBR_ID
    AND MBR_IsActive = 1

    SELECT
      1 [status],
      ' Updated Successfully' [message]
  END
  ELSE
  BEGIN
    SELECT
      0 [status],
      'Invalid Data ' [message]
  END
END



GO
/****** Object:  StoredProcedure [dbo].[Proc_MemberEvent_Insert]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Proc_MemberEvent_Insert] (@MBE_MemberId int,
@MBE_EventId int)
AS
BEGIN
  IF NOT EXISTS (SELECT
      1
    FROM [MemberEvent]
    WHERE MBE_MemberId = @MBE_MemberId and MBE_EventId=@MBE_EventId  and MBE_IsActive=1)
  BEGIN
  INSERT INTO [MemberEvent] (MBE_MemberId,
  MBE_EventId)
    VALUES (@MBE_MemberId, @MBE_EventId)

  --SELECT
  --  1 [status],
  --  'Successfully Inserted' [message]
END
--ELSE
--BEGIN
--  --SELECT
--  --  0 [status],
--  --  'Inserted Failed' [message]
--END
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_MemberEvent_List]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---Proc_MemberEvent_List 1,1

CREATE PROC [dbo].[Proc_MemberEvent_List] (@MemberId int,
@Type int)
AS
BEGIN

  IF (@Type = 1)
  BEGIN

    SELECT
      EV.*
    FROM MemberEvent ME

    INNER JOIN [Events] EV
      ON ME.MBE_EventId = EV.EVT_ID

    INNER JOIN Member MBR
      ON MBR.MBR_ID = ME.MBE_MemberId

    WHERE ME.MBE_IsActive = 1
    AND EV.EVT_IsActive = 1
    AND MBR_IsActive = 1
    AND MBR_ID = @MemberId
    AND EVT_StartDate <= CONVERT(date, GETDATE())
  END
  ELSE
  BEGIN

  select * from [Events] EV  where  EV.EVT_IsActive = 1 and EVT_StartDate > CONVERT(date, GETDATE())

    --SELECT
    --  EV.*
    --FROM MemberEvent ME

    --INNER JOIN [Events] EV
    --  ON ME.MBE_EventId = EV.EVT_ID

    --INNER JOIN Member MBR
    --  ON MBR.MBR_ID = ME.MBE_MemberId

    --WHERE ME.MBE_IsActive = 1
    --AND EV.EVT_IsActive = 1
    --AND MBR_IsActive = 1
   -- AND MBR_ID = @MemberId
    --AND EVT_StartDate > CONVERT(date, GETDATE())
  END


END
GO
/****** Object:  StoredProcedure [dbo].[Proc_MemberEvent_Mapping]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Proc_MemberEvent_Mapping] (@MBR_ID int,  @MBR_EVT_MAP nvarchar(max))  
AS  
BEGIN  

  DELETE FROM [dbo].[MemberEvent]    
  WHERE  MBE_MemberId = @MBR_ID 
  
  insert into MemberEvent (MBE_MemberId,MBE_EventId,MBE_IsActive)   
  SELECT @MBR_ID,EVA_EventId,1  
  FROM Openjson(@MBR_EVT_MAP) WITH (EVA_EventId int)  
  
  select 1 [status],'Updated Successfully' [Message]  
 
END  
GO
/****** Object:  StoredProcedure [dbo].[Proc_MemberSurveyQue_Enable]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[Proc_MemberSurveyQue_Enable]
(
@MemberId int,
@SurveyQueId int,
@SurveyAnsId int
)
as 
begin 


update Member set MBR_IsSurveyCompleted = 1, MBR_SurveyQueId=@SurveyQueId ,MBR_SurveyAnsId=@SurveyAnsId where MBR_ID=@MemberId


  select 1 [status],'status Changed Successfully' [Message]
end


GO
/****** Object:  StoredProcedure [dbo].[Proc_QuestionDelete]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[Proc_QuestionDelete]
@QuestionId INT
AS
BEGIN
UPDATE surveymaster set IsDeleted=1 where QuestionId=@QuestionId


SELECT 1 AS [status], 'Deleted Succesfully' as [message]
END
GO
/****** Object:  StoredProcedure [dbo].[Proc_QuestionEnable]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[Proc_QuestionEnable]
@QuestionId INT,
@IsActive BIT
AS
BEGIN
UPDATE surveymaster set IsActive=@IsActive where QuestionId=@QuestionId


SELECT 1 AS [status], 'Updated Succesfully' as [message]
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_SingleAttendee_Event_Insert]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Proc_SingleAttendee_Event_Insert  '[{"EVA_EventId":136,"EVT_EventName":"Problem solving techniques"},{"EVA_EventId":135,"EVT_EventName":"Networking, mind-sharing and problem solving"}]','Jays','jayashree2.m@paripoorna7.in', 'dev','psss'
 CREATE PROC [dbo].[Proc_SingleAttendee_Event_Insert]
 @EventDetails VARCHAR(MAX),
 @EVA_MemberName VARCHAR(100) ,
 @EVA_Email VARCHAR(100) ,
 @EVA_Job VARCHAR(100) ,
 @EVA_CompanyName VARCHAR(100) 
 AS
 BEGIN
 IF NOT EXISTS (SELECT
      1
    FROM EventAttendees
    WHERE 
	EVA_Email = @EVA_Email
   AND 
	EVA_IsActive = 1)
 BEGIN


  INSERT INTO EventAttendees (EVA_EventId,
    EVA_EventName,
    EVA_MemberName,
    EVA_Email,
    EVA_Job,
    EVA_CompanyName)
	SELECT EVA_EventId,EVT_EventName,@EVA_MemberName,@EVA_Email,@EVA_Job,@EVA_CompanyName
  FROM Openjson(@EventDetails) WITH (EVA_EventId int,EVT_EventName VARCHAR(500))
	SELECT  1 as [status], 'Added Successfully' as [message] 
 END
 ELSE
 BEGIN
 SELECT 0 AS [status], 'Attendee already exists. Kindly modify events by editing Attendee' as [message] END

 END 
GO
/****** Object:  StoredProcedure [dbo].[Proc_SingleEventAttendee_Insert]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Proc_SingleEventAttendee_Insert  135,'Jays','jayashree.m@paripoorna.in', 'dev','psss'
 CREATE PROC [dbo].[Proc_SingleEventAttendee_Insert]
 @EventDetails VARCHAR(MAX),
 @EVA_MemberName VARCHAR(100) ,
 @EVA_Email VARCHAR(100) ,
 @EVA_Job VARCHAR(100) ,
 @EVA_CompanyName VARCHAR(100) 
 AS
 BEGIN

 --DECLARE @EventName VARCHAR(500);

 --SELECT @EventName=EVT_EventName from Events where EVT_ID=@EVA_EventId

 IF NOT EXISTS (SELECT
      1
    FROM EventAttendees
    WHERE 
	EVA_Email = @EVA_Email
   AND 
	EVA_IsActive = 1)
 BEGIN

  INSERT INTO EventAttendees (EVA_EventId,
    EVA_EventName,
    EVA_MemberName,
    EVA_Email,
    EVA_Job,
    EVA_CompanyName)
	SELECT EVA_EventId,EVA_EventName,@EVA_MemberName,@EVA_Email,@EVA_Job,@EVA_CompanyName
  FROM Openjson(@EventDetails) WITH (EVA_EventId int,EVA_EventName VARCHAR(500)) 	

	SELECT  1 as [status], 'Added Successfully' as [message] 

 END

 ELSE

 BEGIN

 SELECT 0 AS [status], 'User Already exists. Kindly add events by editing user' as [message]

 END

 END 
GO
/****** Object:  StoredProcedure [dbo].[Proc_Survey_Delete]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[Proc_Survey_Delete]
@surveyId INT
AS
BEGIN

UPDATE surveycatalog set IsDeleted=1 where id=@surveyId

SELECT 1 AS [status], 'Deleted Succesfully' as [message]

END
GO
/****** Object:  StoredProcedure [dbo].[Proc_survey_report]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Proc_survey_report](
@surveyId int
)
as
begin

select * from SurveyQue inner join SurveyAns on SRQ_ID=SRA_QueID
inner join Member MBA on  MBA.MBR_SurveyAnsId=SRA_ID where SRQ_ID= isnull(@surveyId,SRQ_ID)

end



GO
/****** Object:  StoredProcedure [dbo].[Proc_SurveyCatalog_Insert]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Proc_SurveyCatalog_Insert]
@surveyname VARCHAR(500),
@surveydescription VARCHAR(500),
@IsActive BIT
AS
BEGIN

DECLARE @surveycode VARCHAR(100)=null;

SELECT @surveycode= [dbo].[fn_survey_code]('S')

INSERT INTO surveycatalog(surveyname,
surveydescription,
surveycode,
IsActive)
values(
@surveyname,
@surveydescription,
@surveycode,@IsActive)

SELECT surveycode from surveycatalog where Id=@@IDENTITY
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_SurveyExporttoExcel]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Proc_SurveyExporttoExcel null,null,null,null
CREATE PROC [dbo].[Proc_SurveyExporttoExcel]
@surveycode VARCHAR(20)=null,
@surveyname VARCHAR(500)=null,
@IsActive VARCHAR(10)=null,
@memberId INt=NULL
AS
BEGIN
SELECT surveyname,
surveydescription,
sc.surveycode,QuestionDesc,OfferedAnswers,ChoosenAnswer,MBR_FirstName+' '+MBR_LastName as MBR_Name,MBR_EmailId from surveycatalog as sc 
INNER JOIN surveymaster as sm on sm.surveycode=sc.surveycode
INNER JOIN SurveyResult as sr on sr.SurveyCode=sc.surveycode and sr.QuestionId=sm.QuestionId
INNER JOIN Member AS m on m.MBR_Id=sr.memberId
WHERE sc.surveycode=ISNULL(@surveycode,sc.surveycode) 
and sr.MemberId=ISNULL(@memberId,sr.MemberId)
and sc.surveyname	like '%'+ISnull( @surveyname,sc.surveyname)+'%'
and sc.IsActive	like '%'+ISnull(@IsActive,sc.IsActive)+'%'
and sc.IsDeleted=0 and sm.isDeleted=0
ORder by sc.surveycode,sm.QuestionId
END
GO
/****** Object:  StoredProcedure [dbo].[Proc_SurveyGetAll]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Proc_SurveyGetAll 's00','test',1
CREATE PROC [dbo].[Proc_SurveyGetAll]
@surveycode VARCHAR(20)=null,
@surveyname VARCHAR(500)=null,
@IsActive VARCHAR(10)=null,
@surveyId INT=null
AS
BEGIN
	SELECT distinct sc.*,
	CASE WHEN SR.surveycode IS NULL THEN 1 ELSE 0 END AS IsEditable
	FROM surveycatalog AS sc
	LEFT JOIN surveyresult as sr on sr.surveycode=sc.surveycode
	WHERE sc.surveycode	like '%'+ISnull(@surveycode,sc.surveycode)+'%'
	AND sc.surveyname	like '%'+ISnull( @surveyname,sc.surveyname)+'%'
	and sc.IsActive	like '%'+ISnull(@IsActive,sc.IsActive)+'%'
	and sc.IsDeleted=0
END
GO
/****** Object:  StoredProcedure [dbo].[Proc_SurveyMaster_Insert]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Proc_SurveyMaster_Insert]
@surveycode VARCHAR(20),
@surveyquestions VARCHAR(MAX)
As
BEGIN
INSERT INTO [SurveyMaster]([SurveyCode],[QuestionDesc],[OfferedAnswers])
 SELECT @SurveyCode,QuestionDesc,OfferedAnswers  
  FROM Openjson(@surveyquestions) WITH (QuestionDesc VARCHAR(500),OfferedAnswers VARCHAR(500))

  SELECT 1 as [status], 'Added successfullly' as [message]
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_SurveyMaster_Update]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Proc_SurveyMaster_Update]
@surveyname VARCHAR(500),
@surveydescription VARCHAR(500),
@surveycode VARCHAR(20),
@surveyquestions VARCHAR(MAX)
AS
BEGIN


DECLARE @Survey_Count INT;

DECLARE @Count INT;
SET @Count = 1;

DECLARE @que_id INT,@sur_que VARCHAR(500),@sur_ans VARCHAR(500);

		
	UPDATE surveycatalog SET surveyname=@surveyname,surveydescription=@surveydescription WHERE surveycode=@surveycode

	SELECT ROW_NUMBER() over(order by QuestionId) SNO, QuestionId ,QuestionDesc,OfferedAnswers 
	INTO #surveyquestions
	FROM Openjson(@surveyquestions) WITH (QuestionId INT,QuestionDesc VARCHAR(500),OfferedAnswers VARCHAR(500))

	SELECT @Survey_Count=COUNT(1) FROM #surveyquestions

	WHILE @Count <= @Survey_Count
	BEGIN
		SELECT @sur_que=QuestionDesc,@sur_ans=OfferedAnswers,@que_id=QuestionId FROM #surveyquestions WHERE SNO=@Count
			IF(@que_id>0)
				BEGIN
				UPDATE surveymaster SET QuestionDesc=@sur_que ,OfferedAnswers =@sur_ans WHERE QuestionId=@que_id   
				SET @Count = @Count + 1;
				END
			ELSE
				BEGIN
				INSERT INTO surveymaster(SurveyCode,
				QuestionDesc,
				OfferedAnswers)values(@surveycode,@sur_que,@sur_ans) 
				SET @Count = @Count + 1;
				END
	END
	END

SELECT 1 AS [status],'Updated successfully' AS [message]

DROP TABLE #surveyquestions

GO
/****** Object:  StoredProcedure [dbo].[Proc_SurveyQue_Delete]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create Proc [dbo].[Proc_SurveyQue_Delete]
(
@SurveyQueId int
)
as 
begin 

update SurveyQue set SRQ_IsActive = 0 where SRQ_ID=@SurveyQueId

update SurveyAns set SRA_IsActive = 0 WHERE  SRA_QueID = @SurveyQueId  



  select 1 [status],'Deleted Successfully' [Message]
end
GO
/****** Object:  StoredProcedure [dbo].[Proc_SurveyQue_Enable]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[Proc_SurveyQue_Enable]
(
@SurveyQueId int
)
as 
begin 

update SurveyQue set SRQ_IsEnable = 0 

update SurveyQue set SRQ_IsEnable = 1 where SRQ_ID=@SurveyQueId


  select 1 [status],'status Changed Successfully' [Message]
end
GO
/****** Object:  StoredProcedure [dbo].[Proc_SurveyQue_Insert]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--- Proc_SurveyQue_Insert "SRA_Ans", '[{"SRA_Ans":"reactnative"},{"SRA_Ans":"abi"},{"SRA_Ans":"abirami.a@paripoorna.in"},{"SRA_Ans":""}]'

CREATE Proc [dbo].[Proc_SurveyQue_Insert]
(
@SRQ_Que varchar(max),
@AnsDetails Nvarchar(max)
)
as 
begin 

Declare  @SurveyQueId int

insert into  SurveyQue (SRQ_Que,SRQ_IsEnable) values (@SRQ_Que,0)

set @SurveyQueId = @@IDENTITY


insert into  SurveyAns (SRA_QueID,SRA_Ans,SRA_IsEnable) 
 SELECT @SurveyQueId,SRA_Ans,1
  FROM Openjson(@AnsDetails) WITH (SRA_Ans varchar(max))

  select 1 [status], 'Inserted Successfully !!!' Message
end


GO
/****** Object:  StoredProcedure [dbo].[Proc_SurveyQue_Update]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--- Proc_SurveyQue_Update  1,"SRA_Anss", '[{"SRA_Ans":"reactnative"},{"SRA_Ans":"abi"},{"SRA_Ans":"abirami.a@paripoorna.in"},{"SRA_Ans":""}]'

CREATE Proc [dbo].[Proc_SurveyQue_Update]
(
@SurveyQueId int,
@SRQ_Que varchar(max),
@AnsDetails Nvarchar(max)
)
as 
begin 

update SurveyQue set SRQ_Que = @SRQ_Que where SRQ_ID=@SurveyQueId



      DELETE FROM [dbo].[SurveyAns]  
      WHERE  SRA_QueID = @SurveyQueId  


insert into  SurveyAns (SRA_QueID,SRA_Ans,SRA_IsEnable) 
 SELECT @SurveyQueId,SRA_Ans,1
  FROM Openjson(@AnsDetails) WITH (SRA_Ans varchar(max))

  select 1 [status],'Updated Successfully' [Message]
end

GO
/****** Object:  StoredProcedure [dbo].[Proc_surveyresult_Insert]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--[Proc_surveyresult_Insert] '[{"SurveyCode":"test","QuestionId":"1","ChoosenAnswer":"Immediate"}]',76

CREATE PROCEDURE [dbo].[Proc_surveyresult_Insert]
  @surveyresult VARCHAR(MAX)
  ,@MemberId VARCHAR(30)
AS
BEGIN
  
  BEGIN TRY

  INSERT INTO SurveyResult
  (
  SurveyCode,
  [MemberId],
  QuestionId,
  ChoosenAnswer
  )   
  SELECT SurveyCode,@MemberId,QuestionId,ChoosenAnswer  
  FROM OPENJSON(@surveyresult) WITH (SurveyCode VARCHAR(20),QuestionId INT,ChoosenAnswer NVARCHAR(500))

  SELECT 1 AS [status], 'Submitted Successfully' AS message
 END TRY
 BEGIN CATCH
 SELECT 0 AS [status], 'Error Occured. Try Again' AS message
 END CATCH

END
GO
/****** Object:  StoredProcedure [dbo].[Sp_putsurveyresult]    Script Date: 03/02/2021 7:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_putsurveyresult]
  @surveyresult VARCHAR(MAX)
AS
BEGIN
  
  insert into SurveyResult
  (
  SurveyCode,
  [MemberId],
  QuestionId,
  ChoosenAnswer
  )   
  SELECT SurveyCode,MemberId,QuestionId,ChoosenAnswer  
  FROM Openjson(@surveyresult) WITH (SurveyCode VARCHAR(20),MemberId VARCHAR(30),QuestionId INT,ChoosenAnswer NVARCHAR(500))
 
END
GO

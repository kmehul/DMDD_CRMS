CREATE DATABASE CRMS;

USE CRMS;

CREATE TABLE LOGINCATEGORY
	(
		Category_ID INT auto_increment UNIQUE NOT NULL,
		Category_Name varchar(255) NOT NULL constraint Category_Name_CHK check (Category_Name in ('ONCAMPUS_HIRINGMANAGER','OFFCAMPUS_HIRINGMANAGER','STUDENT')),
        CONSTRAINT Category_PK PRIMARY KEY (Category_ID)		#check 1
	);

CREATE TABLE LOGINPORTAL
	(
		Login_ID varchar(30) PRIMARY KEY NOT NULL,
        Email_ID varchar(320) NOT NULL,
		Password VARBINARY(250) NOT NULL,
		Phone_No varchar(15),
        Category_ID int NOT NULL constraint Category_ID_CHK check (Category_ID in (1,2,3)),		#check 2
        CONSTRAINT FK_CATEGORY_ID FOREIGN KEY (Category_ID) REFERENCES  LoginCategory(Category_ID),
        CONSTRAINT Unique_Email UNIQUE(Email_ID)
	);

CREATE TABLE STUDENTPROFILE 
	(
		Student_ID INT auto_increment UNIQUE NOT NULL,
		Login_ID varchar(30) NOT NULL,
		Student_FName varchar(255) NOT NULL,
		Student_LName varchar(255) NOT NULL,
		Gender varchar(10) check (Gender in ('Male','Female')),		#check 3
		Date_of_Birth Date,
		CONSTRAINT FK_StudentProfile_LoginID FOREIGN KEY (Login_ID) REFERENCES LoginPortal(Login_ID),
		CONSTRAINT PF_STUDENT_ID PRIMARY KEY (Student_ID)
	);

CREATE TABLE ORGANIZATION (
      Organization_ID INT NOT NULL PRIMARY KEY,
      Login_ID varchar(30) NOT NULL,
	  Organization_Name varchar(200) NOT NULL,
	  OrganizationWebsiteURL varchar(200),
      CONSTRAINT FK_Organization_LoginID FOREIGN KEY(Login_ID) REFERENCES LoginPortal(Login_ID)
	);

CREATE TABLE ORGANIZATION_FEEDBACK(
      Organization_Feedback_ID INT auto_increment UNIQUE NOT NULL,
	  Student_ID INT  NOT NULL,
      Organization_ID INT NOT NULL,
	  Review varchar(200),
	  Scaling_Rating DECIMAL(3,2) constraint Scale_Rating_CHK check (Scaling_Rating >= 1.0 and Scaling_Rating <= 5.0),		#check 4
	  CONSTRAINT FK_Organization_Feedback_1 FOREIGN KEY (Student_ID) REFERENCES StudentProfile(Student_ID),
      CONSTRAINT FK_Organization_Feedback_2 FOREIGN KEY (Organization_ID) REFERENCES Organization(Organization_ID),
      CONSTRAINT PK_Organization_Feedback_ID PRIMARY KEY (Organization_Feedback_ID)
    );

CREATE TABLE PLACEMENT_LOCATION (
      Placement_LocationID INT auto_increment UNIQUE NOT NULL,
	  StreetAddress varchar(255),
	  City varchar(255),
	  State varchar(255),
	  Zip varchar(255) constraint Zip_CHK check (character_length(Zip) = 5),		#CHECK 5
      CONSTRAINT PK_Placement_LocationID PRIMARY KEY (Placement_LocationID) 
	);

CREATE TABLE PLACEMENT_TYPE (
      Placement_Type_ID INT auto_increment UNIQUE NOT NULL,
	  Placement_Type varchar(255),
      CONSTRAINT PK_Placement_Type_ID PRIMARY KEY (Placement_Type_ID)
	);

CREATE TABLE PLACEMENT_LISTING (
	  Placement_ListingID INT NOT NULL PRIMARY KEY,
	  Organization_ID INT NOT NULL,
	  Placement_Type_ID INT NOT NULL,
	  Listing_Date DATE NOT NULL,
	  Placement_Location_ID INT NOT NULL,
      Seat_Availabilty INT,
	  PlacementDescription varchar(512),
	  CONSTRAINT FK_CompanyID FOREIGN KEY (Organization_ID) REFERENCES Organization(Organization_ID),
	  CONSTRAINT FK_PlacementTypeID FOREIGN KEY (Placement_Type_ID) REFERENCES Placement_Type(Placement_Type_ID),
	  CONSTRAINT FK_OrganizationLocationID FOREIGN KEY (Placement_Location_ID) REFERENCES Placement_Location(Placement_LocationID)
	);

CREATE TABLE PLACEMENTAPPLICATION (
	  Student_ID INT NOT NULL,
	  Placement_Listing_ID INT NOT NULL,
	  ApplyDate DATE NOT NULL,
	  CONSTRAINT PK_PlacementApplication PRIMARY KEY CLUSTERED(Student_ID, Placement_Listing_ID),
	  CONSTRAINT FK_StudentID FOREIGN KEY (Student_ID) REFERENCES StudentProfile(Student_ID),
	  CONSTRAINT FK_PlacementListingID FOREIGN KEY (Placement_Listing_ID) REFERENCES Placement_Listing(Placement_ListingID)
	);

CREATE TABLE SKILLS(
        Skill_ID INT NOT NULL PRIMARY KEY,
        Skill_Name varchar(300)
    );

create table STUDENTSKILLSETS(
        Skill_ID int not null,
        Student_ID int not null,
        Date_Acquired date,
        CONSTRAINT StudentSkillSet_PK PRIMARY key (Skill_ID,Student_ID),
        CONSTRAINT StudentSkillSet_FK1 FOREIGN key (Student_ID) REFERENCES StudentProfile(Student_ID),
        CONSTRAINT StudentSKillSet_FK2 FOREIGN KEY (Skill_ID) REFERENCES Skills(Skill_ID)
    );

CREATE TABLE PLACEMENTPOSTINGSKILL (
	  Skill_ID INT NOT NULL ,
	  PlacementListingID INT NOT NULL,
	  CONSTRAINT PK_PlacementPostingSkill PRIMARY KEY CLUSTERED (Skill_ID, PlacementListingID),
	  CONSTRAINT FK_SkillID FOREIGN KEY (Skill_ID) REFERENCES Skills(Skill_ID),
	  CONSTRAINT FK_PlacementSkill_JobPostingID FOREIGN KEY (PlacementListingID) REFERENCES Placement_Listing(Placement_ListingID)
	);

CREATE TABLE STUDENTWORKEX (
      Student_ID INT NOT NULL,
      StartDate Date,
      EndDate Date,
      WorkEx_Title varchar(255) NOT NULL,
      Company_Name varchar(255) NOT NULL,
      Placement_Location_ID int,
      CONSTRAINT PK_StudentWorkEx_ID PRIMARY KEY CLUSTERED(Student_ID, StartDate),
      CONSTRAINT FK_StudentWorkEx_Student_ID FOREIGN KEY(Student_ID) REFERENCES StudentProfile(Student_ID),
      CONSTRAINT FK_StudentExp_Placement_LocationID FOREIGN KEY(Placement_Location_ID) REFERENCES Placement_Location(Placement_LocationID)
    );

CREATE TABLE DEGREE(
    Degree_ID int primary key not null,
    Major varchar(255) not null,
    Degree_Type VARCHAR(255)
    );

CREATE TABLE STUDENTEDUCATION(
    Student_ID INT not null,
    Degree_ID int not null,
    GPA DECIMAL(3,2) constraint GPA_CHK check (GPA >= 1.0 and GPA <=4.0),   #check 6
    CONSTRAINT StudentEducation_PK PRIMARY key CLUSTERED (Student_ID,Degree_ID),
    CONSTRAINT StudentEducation_FK FOREIGN key (Degree_ID) references Degree(Degree_ID),
	CONSTRAINT StudentEducation_PPK FOREIGN key (Student_ID) references StudentProfile(Student_ID)
    );




create database DMDD_PROJECT_CRMS
use DMDD_PROJECT_CRMS

GO

---Login Schema

CREATE SCHEMA [Login] AUTHORIZATION dbo

GO

--Login Category Table

CREATE TABLE [Login].LoginCategory
    (
        Category_ID int PRIMARY KEY NOT NULL,
        Category_Name varchar(255) NOT NULL constraint Category_Name_CHK check (Category_Name in ('ONCAMPUS_HIRINGMANAGER','OFFCAMPUS_HIRINGMANAGER','STUDENT')),
    )

--Login Portal Table 

CREATE TABLE [Login].LoginPortal
    (
        Login_ID int PRIMARY KEY NOT NULL,
        email_ID varchar(320) NOT NULL,
        [Password] varchar(255) NOT NULL,
        Phone_No varchar(15),
        Category_ID int not null constraint Category_ID_CHK check (Category_ID in (1,2,3)),       
        CONSTRAINT Category_ID_FK FOREIGN KEY (Category_ID) REFERENCES [Login].LoginCategory (Category_ID)     
    )        

GO

--Skill Schema

CREATE SCHEMA  Skill  authorization dbo

GO

--Skill Table 

create table Skill
    (
        Skill_ID int PRIMARY key not null,
        Skill_Name varchar(255)
    )
GO

---Student Schema

CREATE SCHEMA Student AUTHORIZATION dbo

GO

--Student Profile Table

create table Student.StudentProfile
    (
        Student_ID int primary key not null,       
        Login_ID int not null,
        Student_FName varchar(255) not null,
        Student_LName varchar(255) not null,
        Gender VARCHAR(255) constraint Gender_CHK check (Gender in ('Male','Female')),      
        Student_DateofBirth date,
        CONSTRAINT StudentProfile_FK FOREIGN key (Login_ID) REFERENCES [Login].LoginPortal(Login_ID)
    )

--Degree Table

create table Student.Degree
    (
        Degree_ID int primary key not null,
        Major varchar(255) not null,
        Degree_Type VARCHAR(255),
    )

--Student Education Table

create table Student.StudentEducation
    (
        Student_ID int not null,      
        Degree_ID int not null,
        GPA DECIMAL constraint GPA_CHK check (GPA >= 1.0 and GPA <=4.0),        
        CONSTRAINT StudentEducation_PK PRIMARY key (Student_ID,Degree_ID),
        CONSTRAINT StudentEducation_FK FOREIGN key (Degree_ID) references Student.Degree(Degree_ID),
        CONSTRAINT StudentEducation_FK2 FOREIGN key (Student_ID) references Student.StudentProfile(Student_ID)
    )

--Student Work Experience Table

create table Student.StudentWorkExperience      
    (
        Student_ID int not null,        
        [Start_Date] date,
        [End_Date] date , 
        Company_Name VARCHAR(255),
        Workex_Title VARCHAR(255),     
        Placement_LocationID int not null,    
        CONSTRAINT StudentWorkExperience_PK PRIMARY key (Student_ID,[Start_Date],[End_Date]),
        CONSTRAINT StudentWorkExperience_FK1 FOREIGN key (Student_ID) references Student.StudentProfile(Student_ID),
        CONSTRAINT StudentWorkExperience_FK2 FOREIGN key (Placement_LocationID) REFERENCES PLACEMENT.Placement_Location(Placement_LocationID)
    )

--Student Skill Set Table 

create table Student.StudentSkillSet
    (
        Skill_ID int  not null,
        Student_ID int not null,        
        Date_Acquired date,
        CONSTRAINT StudentSkillSet_PK PRIMARY key (Skill_ID,Student_ID),
        CONSTRAINT StudentSkillSet_FK FOREIGN key (Student_ID) REFERENCES Student.StudentProfile(Student_ID),
        CONSTRAINT StudentSkillSet_FK2 FOREIGN key (Skill_ID) REFERENCES Skill(Skill_ID)
    )

GO

---Organization Schema

CREATE SCHEMA Organization AUTHORIZATION dbo

GO

--Organization Table

CREATE TABLE Organization.Organization 
    (
        Organization_ID INT PRIMARY KEY NOT NULL,
        Login_ID int NOT NULL,
        Organization_Name varchar(200) NOT NULL,
        Organization_Website varchar(200),
        CONSTRAINT Login_ID_FK FOREIGN KEY (Login_ID) REFERENCES [Login].LoginPortal (Login_ID)
    )

--Organization Feedback Table

CREATE TABLE Organization.Organization_Feedback
    (
        Organization_Feedback_ID int PRIMARY KEY NOT NULL,
        Student_ID int NOT NULL,        
        Organization_ID INT NOT NULL,
        Review varchar(255),
        Scale_Rating DECIMAL constraint Scale_Rating_CHK check (Scale_Rating >= 1.0 and Scale_Rating <= 5.0),       
        CONSTRAINT FK_Student_ID FOREIGN KEY (Student_ID) REFERENCES Student.StudentProfile(Student_ID),
        CONSTRAINT FK_Organization_ID FOREIGN KEY (Organization_ID) REFERENCES Organization.Organization(Organization_ID)
    )

GO

--Placement Schema

CREATE SCHEMA PLACEMENT AUTHORIZATION dbo

GO

--Placement Location Table

CREATE TABLE PLACEMENT.Placement_Location 
    (
	    Placement_LocationID INT NOT NULL PRIMARY KEY,
	    StreetAddress varchar(255),
	    City varchar(255),
	    [State] varchar(255),
	    Zip varchar(255) constraint Zip_CHK check (datalength(Zip) = 5),      
	)

--Placement Type Table

CREATE TABLE PLACEMENT.Placement_Type 
    (
	    Placement_Type_ID INT NOT NULL PRIMARY KEY,
	    Placement_Type varchar(255)
	)

--Placement Listing Table

CREATE TABLE PLACEMENT.Placement_Listing
    (
	    Placement_ListingID INT NOT NULL PRIMARY KEY,
	    Organization_ID INT NOT NULL,
	    Placement_Type_ID INT NOT NULL,
	    Listing_Date DATE NOT NULL,
	    Placement_Location_ID INT NOT NULL,
        Seat_Availabilty INT,
	    PlacementDescription varchar(512),
	    CONSTRAINT FK_CompanyID FOREIGN KEY (Organization_ID) REFERENCES Organization.Organization(Organization_ID),
	    CONSTRAINT FK_PlacementTypeID FOREIGN KEY (Placement_Type_ID) REFERENCES PLACEMENT.Placement_Type(Placement_Type_ID),
	    CONSTRAINT FK_OrganizationLocationID FOREIGN KEY (Placement_Location_ID) REFERENCES PLACEMENT.Placement_Location(Placement_LocationID)
	)

--Placement Application Table

CREATE TABLE Placement.PlacementApplication 
    (
	    Student_ID int NOT NULL,        
	    Placement_Listing_ID INT NOT NULL,
	    ApplyDate DATE NOT NULL,
	    CONSTRAINT PK_PlacementApplication PRIMARY KEY CLUSTERED(Student_ID, Placement_Listing_ID),
	    CONSTRAINT FK_StudentID FOREIGN KEY (Student_ID) REFERENCES Student.StudentProfile(Student_ID),
	    CONSTRAINT FK_PlacementListingID FOREIGN KEY (Placement_Listing_ID) REFERENCES PLACEMENT.Placement_Listing(Placement_ListingID)
	)

--Placement Skill Set Table

create table Placement.PlacementSkillSet
    (
        Skill_ID int  not null,
        Placement_ListingID int not null,
        CONSTRAINT PlacementSkillSet_PK PRIMARY key (Skill_ID,Placement_ListingID),
        CONSTRAINT PlacementkillSet_FK FOREIGN key (Placement_ListingID) REFERENCES PLACEMENT.Placement_Listing(Placement_ListingID),
        CONSTRAINT PlacementSkillSet_FK2 FOREIGN key (Skill_ID) REFERENCES Skill(Skill_ID)
    )
GO

-- User Defined Function to count the number of jobs student has applied to:
CREATE FUNCTION CountJobsAppliedByStudent(@Student_ID int)
	RETURNS int
	AS
	BEGIN
	DECLARE @count int
	SELECT @count = COUNT(p.PLACEMENT_LISTING_ID) 
	FROM PlacementApplication p
	WHERE p.Student_ID = @Student_ID
	GROUP BY Student_ID 
	SET @count = ISNULL(@count,0)
	RETURN @count
	END
    GO



ALTER TABLE StudentProfile ADD JobsAppliedCounts AS dbo.CountJobsAppliedByStudent(Student_ID)

GO

--User Defined Function to calculate the age of the student
create function CalculateStudentAge (@Date_of_Birth as date)
returns int 
AS
BEGIN
declare @Age as int 
set @Age = DATEDIFF(hour,@Date_of_Birth,GETDATE())/8766
return @Age
END

select CONCAT(Student_FName,' ',Student_LName), Gender, Date_of_Birth, CalculateStudentAge(Date_of_Birth) as Age
FROM
StudentProfile

GO


CREATE VIEW STUDENTDETAILS
AS
SELECT L.LOGIN_ID,CONCAT(S.STUDENT_FNAME,' ',S.STUDENT_LNAME) AS NAME,L.EMAIL_ID,L.PASSWORD,L.PHONE_NO,SE.GPA,D.MAJOR
FROM LoginPortal L
JOIN StudentProfile S
ON L.LOGIN_ID= S.LOGIN_ID
JOIN StudentEducation SE
ON S.STUDENT_ID= SE.STUDENT_ID
JOIN Degree D
ON SE.DEGREE_ID= D.DEGREE_ID
GO

SELECT * FROM STUDENTDETAILS;


--STUDENTS SKILLSETS:

select DISTINCT CONCAT(S.STUDENT_FNAME,' ',S.STUDENT_LNAME) AS NAME,SS.SKILL_ID,SS.SKILL_NAME
INTO #STUDENTSKILLSET
FROM STUDENTPROFILE S
JOIN STUDENTSKILLSET SSS 
ON SSS.STUDENT_ID= S.STUDENT_ID
JOIN SKILLS SS
ON SSS.SKILL_ID= SS.SKILL_ID

--CREATING TEMP TABLE FOR STUDENT SKILLSETS
SELECT * FROM #STUDENTSKILLSET


--PLACEMENT SKILLSETS:

select O.ORGANIZATION_NAME,S.SKILL_NAME, PT.PLACEMENT_TYPE AS 'JOB ROLES'
INTO #PLACEMENTSKILL
FROM ORGANIZATION O
JOIN PLACEMENT_LISTING PL
ON PL.ORGANIZATION_ID= O.ORGANIZATION_ID
JOIN PLACEMENTPOSTINGSKILL PSS
ON PL.PLACEMENT_LISTINGID= PSS.PLACEMENTLISTINGID
JOIN SKILLS S
ON PSS.SKILL_ID= S.SKILL_ID
JOIN PLACEMENT_TYPE PT
ON PT.PLACEMENT_TYPE_ID= PL.PLACEMENT_TYPE_ID

--CREATING TEMP TABLE:
SELECT * FROM #PLACEMENTSKILL


--PLACEMENTSKILLSETS STUDENTS APPLIED TO:

select DISTINCT CONCAT(S.STUDENT_FNAME,' ',S.STUDENT_LNAME) AS NAME,O.ORGANIZATION_NAME,PA.APPLYDATE,SS.SKILL_NAME AS SKILLSREQUIRED
INTO #PLACEMENTSTUDENT_SKILLS
FROM STUDENTPROFILE S
JOIN PLACEMENTAPPLICATION PA
ON S.STUDENT_ID= PA.STUDENT_ID
JOIN PLACEMENT_LISTING PL
ON PA.PLACEMENT_LISTING_ID= PL.PLACEMENT_LISTINGID
JOIN ORGANIZATION O
ON O.ORGANIZATION_ID = PL.ORGANIZATION_ID
JOIN PLACEMENTPOSTINGSKILL PS
ON PL.PLACEMENT_LISTINGID= PS.PLACEMENTLISTINGID
JOIN SKILLS SS
ON SS.SKILL_ID= PS.SKILL_ID
ORDER BY CONCAT(S.STUDENT_FNAME,' ',S.STUDENT_LNAME)

--CREATING TEMP TABLE:
SELECT * FROM #PLACEMENTSTUDENT_SKILLS


---FINDING MATCH FOR THE SKILLS ACQUIRED AND REQUIRED FOR THE JOB:
-- IF OUTPUT APPEARS: MEANS ELIGIBLE FOR THE JOB(S)

SELECT CONCAT(S.STUDENT_FNAME,' ',S.STUDENT_LNAME) AS NAME,SSS.SKILL_NAME,O.ORGANIZATION_NAME, PT.PLACEMENT_TYPE FROM STUDENTPROFILE S
JOIN PLACEMENTAPPLICATION PA 
ON S.STUDENT_ID= PA.STUDENT_ID
JOIN PLACEMENT_LISTING PL
ON PL.PLACEMENT_LISTINGID= PA.PLACEMENT_LISTING_ID
JOIN PLACEMENT_TYPE PT
ON PT.PLACEMENT_TYPE_ID= PL.PLACEMENT_TYPE_ID
JOIN ORGANIZATION O
ON O.ORGANIZATION_ID= PL.ORGANIZATION_ID
JOIN STUDENTSKILLSET SS
ON SS.STUDENT_ID = S.STUDENT_ID
JOIN PLACEMENTPOSTINGSKILL PSS
ON PSS.PLACEMENTLISTINGID= PL.PLACEMENT_LISTINGID
JOIN SKILLS SSS
ON SSS.SKILL_ID= PSS.SKILL_ID
WHERE PSS.SKILL_ID= SS.SKILL_ID AND CONCAT(S.STUDENT_FNAME,' ',S.STUDENT_LNAME)= 'HETAL GADA'



SELECT * FROM PLACEMENTAPPLICATION
WHERE STUDENT_ID=1



SELECT * FROM PLACEMENT_LISTING
WHERE PLACEMENT_LISTINGID=4

SELECT * FROM PLACEMENT_TYPE

SELECT * FROM PLACEMENTPOSTINGSKILL

SELECT * FROM SKILLS


SELECT * FROM STUDENTSKILLSET
WHERE STUDENT_ID=1



SELECT * FROM STUDENTPROFILE

SELECT * FROM #PLACEMENTSTUDENT_SKILLS
WHERE NAME='HETAL GADA'


---------------------

-- Total job postings by each organization (can be offcampus/oncampus)

    SELECT O.ORGANIZATION_NAME, COUNT(P.PLACEMENT_LISTINGID) AS 'TOTAL LISTINGS'
    FROM ORGANIZATION O
        INNER JOIN PLACEMENT_LISTING P
        ON O.ORGANIZATION_ID=P.ORGANIZATION_ID
        GROUP BY O.ORGANIZATION_ID, O.ORGANIZATION_NAME


--QUERY to find the student ratings and comments:

    SELECT CONCAT(S.STUDENT_FNAME,' ', S.STUDENT_LNAME) AS 'STUDENT NAME', O.ORGANIZATION_NAME,F.SCALING_RATING,F.REVIEW FROM STUDENTPROFILE S
    JOIN ORGANIZATION_FEEDBACK F
    ON S.STUDENT_ID= F.STUDENT_ID
    JOIN ORGANIZATION O
    ON O.ORGANIZATION_ID = F.ORGANIZATION_ID



--APPLICATION STATUS OF STUDENTS APPLIED:

SELECT CONCAT(S.STUDENT_FNAME,' ', S.STUDENT_LNAME) AS NAME, 'NOT APPLIED' AS STATUS 
FROM STUDENTPROFILE S WHERE S.STUDENT_ID NOT IN 
(
    SELECT STUDENT_ID FROM PLACEMENTAPPLICATION
)
UNION

SELECT CONCAT(S.STUDENT_FNAME, S.STUDENT_LNAME) AS NAME, 'APPLIED TO MORE THAN 1 JOB' AS STATUS
from STUDENTPROFILE S WHERE S.STUDENT_ID IN 
(
    SELECT STUDENT_ID FROM PLACEMENTAPPLICATION
    group by(STUDENT_ID)
    having count(*)>1
)
UNION
SELECT CONCAT(S.STUDENT_FNAME, S.STUDENT_LNAME) AS NAME, 'APPLIED TO 1 JOB' AS STATUS
from STUDENTPROFILE S WHERE S.STUDENT_ID IN 
(
    SELECT STUDENT_ID FROM PLACEMENTAPPLICATION
    group by(STUDENT_ID)
    having count(*)=1
)


--Creating non-clustered keys on the tables:

CREATE NONCLUSTERED INDEX STUD_FNAME
ON STUDENTPROFILE(STUDENT_FNAME ASC);

CREATE NONCLUSTERED INDEX P_LISTING_DATE
ON PLACEMENT_LISTING(LISTING_DATE);

CREATE NONCLUSTERED INDEX O_ORGANIZATION_ID
ON ORGANIZATION_FEEDBACK(ORGANIZATION_ID ASC);




-- CREATE VIEW FOR STUDENTS WHO HAS APPLIED TO OFF CAMPUS JOBS:
CREATE VIEW [STUDENT APPLIED OFFCAMPUS]
AS

SELECT PA.STUDENT_ID,CONCAT(S.STUDENT_FNAME,' ',S.STUDENT_LNAME)AS NAME, O.ORGANIZATION_NAME FROM ORGANIZATION O
JOIN PLACEMENT_LISTING PL 
ON O.ORGANIZATION_ID= PL.ORGANIZATION_ID
INNER JOIN PLACEMENTAPPLICATION PA 
ON PL.PLACEMENT_LISTINGID= PA.PLACEMENT_LISTING_ID
INNER JOIN STUDENTPROFILE S
ON S.STUDENT_ID= PA.STUDENT_ID
WHERE O.LOGIN_ID LIKE '%OFF%'

GO

SELECT * FROM [STUDENT APPLIED OFFCAMPUS]


--STORED PROCEDURE ON ORGANIZATION FEEDBACK TABLE:

CREATE PROCEDURE UPDATESCALINGRATING
(
    @STUDENT_ID INT,
    @SCALING_RATING DECIMAL,
    @ORGANIZATION_ID INT
)
AS
BEGIN
UPDATE ORGANIZATION_FEEDBACK
    SET SCALING_RATING= @SCALING_RATING
    WHERE STUDENT_ID= @STUDENT_ID AND ORGANIZATION_ID= @ORGANIZATION_ID
END
 

EXEC UPDATESCALINGRATING @STUDENT_ID = 1,@ORGANIZATION_ID= 101, @SCALING_RATING = 3.2;

-- ROUNDING OFF THE VALUE OF DECIMALS OF SCALING RATING IN ORGANIZATION FEEDBACK OUTPUT:

SELECT * FROM ORGANIZATION_FEEDBACK
WHERE STUDENT_ID=1 AND ORGANIZATION_ID= 101;



--STORED PROCEDURE TO FIND ALL THE STUDENTS WHO HAS APPLIED TO 'DELOITTE' FOR 'SOFTWARE DEVELOPER ROLE' WITH APPLIED DATE:

CREATE PROCEDURE GETDELOITTESDE @ORGANIZATIONID INT, @PLACEMENTTYPEID INT
AS
BEGIN
SELECT CONCAT(S.STUDENT_FNAME,' ', S.STUDENT_LNAME) AS 'STUDENT NAME',L.EMAIL_ID,O.ORGANIZATION_NAME, PT.PLACEMENT_TYPE,PA.APPLYDATE FROM PLACEMENTAPPLICATION PA
INNER JOIN PLACEMENT_LISTING PL ON PA.PLACEMENT_LISTING_ID = PL.PLACEMENT_LISTINGID
INNER JOIN ORGANIZATION O ON PL.ORGANIZATION_ID= O.ORGANIZATION_ID
INNER JOIN STUDENTPROFILE S ON S.STUDENT_ID= PA.STUDENT_ID
INNER JOIN LOGINPORTAL L ON L.LOGIN_ID= S.LOGIN_ID
INNER JOIN PLACEMENT_TYPE PT ON PT.PLACEMENT_TYPE_ID= PL.PLACEMENT_TYPE_ID
WHERE PL.PLACEMENT_TYPE_ID= @PLACEMENTTYPEID AND O.ORGANIZATION_ID= @ORGANIZATIONID
END

EXEC GETDELOITTESDE 101,1;



--CREATING PROCEDURE TO FIND STUDENTS WITH REQUIRED SKILLSETS:

CREATE PROCEDURE [STUDENT_SKILLSETS] @SKILL_NAME VARCHAR(300)
AS
BEGIN
SELECT CONCAT(S.STUDENT_FNAME,' ',S.STUDENT_LNAME), SS.SKILL_NAME FROM STUDENTPROFILE S
INNER JOIN STUDENTSKILLSET SSS ON S.STUDENT_ID = SSS.STUDENT_ID
INNER JOIN SKILLS SS ON SS.SKILL_ID= SSS.SKILL_ID
WHERE SS.SKILL_NAME= @SKILL_NAME
END

EXEC [STUDENT_SKILLSETS] 'CLOUD COMPUTING'



--TRIGGER FORMED FOR UPDATED STUDENT'S LATEST JOB:

CREATE TRIGGER STUDENTLATESTJOBLOGS
ON STUDENTPROFILE
AFTER INSERT
AS
BEGIN
    DECLARE @STUDENT_ID INT;
    SET @STUDENT_ID =(SELECT STUDENT_ID FROM INSERTED);
    INSERT INTO STUDENTLOGS VALUES (@STUDENT_ID, GETDATE(), GETDATE())

    END 
    GO


select * from degree

select * from Placement_Listing
where organization_id=102



select * from organization
select * from studentprofile
select * from PlacementApplication
where student_id=2

select * from Organization_Feedback
where organization_id=201


select * from StudentSkillSet
where student_id=1

GO

--1st View(Student previous work details)
create view WorkDetail AS
select sp.Student_FName,sp.Student_LName,we.Company_Name,we.Workex_Title,we.[Start_Date],we.[End_Date]
from 
StudentProfile sp left join StudentWorkExperience we
on 
sp.Student_ID = we.Student_ID

GO

--2nd View(Detailed view of student education)
create view EducationDetail AS
select sp.Student_FName,sp.Student_LName,d.Degree_Type,d.Major,se.GPA 
FROM
StudentProfile sp join StudentEducation se 
on
sp.Student_ID = se.Student_ID 
join 
Degree d 
on 
se.Degree_ID = d.Degree_ID

GO

--3rd View(Organization view with the details and rating of the organization)
create view FeedBack_View AS
select org.Organization_Name,org.Organization_Website,orf.Review,orf.Scale_Rating
from 
Organization org inner join Organization_Feedback orf
on 
org.Organization_ID = orf.Organization_ID

GO

--4th View(View of the skills acquired by the student with date)
create view Stud_Skill_View AS
select concat(sp.Student_FName,' ',sp.Student_LName) as Student_Name, sk.Skill_Name, stusk.Date_Acquired
FROM
StudentProfile sp full join StudentSkillSet stusk 
on 
sp.Student_ID = stusk.Student_ID 
join 
Skill sk 
on 
stusk.Skill_ID = sk.Skill_ID

GO

--5th View(Detailed view of the listing with all information such as the date, type, availability and the location)
create view Company_Placement_Listing AS
select org.Organization_Name,plist.Listing_Date,pt.Placement_Type,plist.Seat_Availabilty,ploc.StreetAddress,ploc.City,ploc.[State],ploc.Zip
FROM
Organization org join Placement_Listing plist 
on 
org.Organization_ID = plist.Organization_ID
join 
Placement_Type pt 
on 
plist.Placement_Type_ID = pt.Placement_Type_ID 
join 
Placement_Location ploc 
on 
plist.Placement_Location_ID = ploc.Placement_LocationID

GO

select * from WorkDetail 
select * from EducationDetail 
select * from FeedBack_View 
select * from Stud_Skill_View 
select * from Company_Placement_Listing 
#1st View(Student previous work details)
create view WorkDetail AS
select sp.Student_FName,sp.Student_LName,we.Company_Name,we.Workex_Title,we.[Start_Date],we.[End_Date]
from 
StudentProfile sp left join StudentWorkExperience we
on 
sp.Student_ID = we.Student_ID

GO

#2nd View(Detailed view of student education)
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

#3rd View(Organization view with the details and rating of the organization)
create view FeedBack_View AS
select org.Organization_Name,org.Organization_Website,orf.Review,orf.Scale_Rating
from 
Organization org inner join Organization_Feedback orf
on 
org.Organization_ID = orf.Organization_ID

GO

#4th View(View of the skills acquired by the student with date)
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

#5th View(Detailed view of the listing with all information such as the date, type, availability and the location)
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
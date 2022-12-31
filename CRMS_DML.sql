USE CAMPUS__RECRUITMENT_SYSTEM;

#Encryption process started
   
#Create Password protected Master key
	CREATE MASTER KEY 
	ENCRYPTION BY PASSWORD = 'DMDDProject_CRM';


    SELECT NAME KeyName,
    symmetric_key_id KeyID,
    key_length KeyLength,
    algorithm_desc KeyAlgorithm
    FROM sys.symmetric_keys;

#Create certificate to protect symetric key
	CREATE certificate DMDDCRMS
	WITH SUBJECT = 'DMDD Project';

--Create symetric key to encrypt data
	CREATE SYMMETRIC KEY DMDDSymmetricKey
	WITH ALGORITHM = AES_256
	ENCRYPTION BY CERTIFICATE DMDDCRMS
    GO

--Open symmetric key
	OPEN SYMMETRIC KEY DMDDSymmetricKey
	DECRYPTION BY CERTIFICATE DMDDCRMS
    GO


---Inserted values into LoginCategory 

    INSERT INTO LoginCategory VALUES ('ONCAMPUS_HIRINGMANAGER'),('OFFCAMPUS_HIRINGMANAGER'), ('STUDENT');


#Select * from LoginPortal
   
    INSERT INTO LoginPortal
    VALUES ('ST_1','hetalgada15@gmail.com',EncryptByKey(Key_GUID(N'DMDDSymmetricKey'), convert(varbinary,'hetal@231')), '(781) 460-1631',3);
    INSERT INTO LoginPortal
    VALUES ('ST_2','tanuj22@gmail.com',EncryptByKey(Key_GUID(N'DMDDSymmetricKey'), convert(varbinary,'tanuj@231')), '(332) 432-1331',3);
    INSERT INTO LoginPortal
    VALUES ('ST_3','mehul98@gmail.com',EncryptByKey(Key_GUID(N'DMDDSymmetricKey'), convert(varbinary,'mehul@231')), '(982) 232-9823',3);
    INSERT INTO LoginPortal
    VALUES ('ST_4','saniyakapur98@gmail.com',EncryptByKey(Key_GUID(N'DMDDSymmetricKey'), convert(varbinary,'saniya@231')), '(232) 233-2838',3);
    INSERT INTO LoginPortal
    VALUES ('ON_1','hellohiring@gmail.com',EncryptByKey(Key_GUID(N'DMDDSymmetricKey'), convert(varbinary,'xywe2@12')), '(100) 181-2911',1);
    INSERT INTO LoginPortal
    VALUES ('ON_2','same25@gmail.com',EncryptByKey(Key_GUID(N'DMDDSymmetricKey'), convert(varbinary,'sammy726@2')), '(982) 291-2219',1);
    INSERT INTO LoginPortal
    VALUES ('ON_3','bluemoon@gmail.com',EncryptByKey(Key_GUID(N'DMDDSymmetricKey'), convert(varbinary,'blue@878')), '(981) 781-2211',1);
    INSERT INTO LoginPortal
    VALUES ('OFF_1','offhiring1@gmail.com',EncryptByKey(Key_GUID(N'DMDDSymmetricKey'), convert(varbinary,'deowu@21')), '(187) 128-1291',2);
    INSERT INTO LoginPortal
    VALUES ('OFF_2','offhiring2@gmail.com',EncryptByKey(Key_GUID(N'DMDDSymmetricKey'), convert(varbinary,'pumpki@32')), '(291) 291-0922',2);
    INSERT INTO LoginPortal
    VALUES ('OFF_3','offhiring3@gmail.com',EncryptByKey(Key_GUID(N'DMDDSymmetricKey'), convert(varbinary,'ejsj@281')), '(091) 362-2311',2);
    INSERT INTO LoginPortal
    VALUES ('ST_5','samay98@gmail.com',EncryptByKey(Key_GUID(N'DMDDSymmetricKey'), convert(varbinary,'samay@231')), '(271) 312-9393',3);
    INSERT INTO LoginPortal
    VALUES ('ST_6','james@gmail.com',EncryptByKey(Key_GUID(N'DMDDSymmetricKey'), convert(varbinary,'James71')), '(232) 422-2323',3);


#Inserted values into Organization  in sequence of Organization_ID,Login_ID,OrganizationName,OrganizationWebsiteURL
    INSERT INTO Organization VALUES(101,'OFF_1', 'Deloitte','www.deloitte.com');
    INSERT INTO Organization VALUES(102,'OFF_2', 'EY','www.ey.com');
    INSERT INTO Organization VALUES(103,'OFF_3', 'Meta','www.meta.com');
    INSERT INTO Organization VALUES(104,'OFF_3', 'Facebook','www.facebook.com');
    INSERT INTO Organization VALUES(201,'ON_1', 'DunkinDonuts','www.northeastern_dunkindonuts.com');
    INSERT INTO Organization VALUES(202,'ON_2', 'Research Computing-JM','http://rc.northeastern.edu');
    INSERT INTO Organization VALUES(203,'ON_3', 'Architecture-JM','http://rca.northeastern.edu');
    INSERT INTO Organization VALUES(204,'ON_3', 'Campus Recreation-JM','www.northeastern.edu/diversity');
    INSERT INTO Organization VALUES(205,'ON_2', 'TeachingAssistant_DANA', 'cssh.northeastern.edu/cssh-teaching-assistants/');
    INSERT INTO Organization VALUES(206,'ON_1', 'LibraryAssistant', 'snellLibrary_northeastern.edu');


#Inserted values into StudentProfile in sequence of Student_ID,Login_ID,Student_FName,StudentLName,Gender,DateofBirth
    INSERT INTO StudentProfile VALUES ('ST_1','HETAL','GADA','FEMALE','1999-05-20');
    INSERT INTO StudentProfile VALUES ('ST_2','TANUJ','VERMA','MALE','1995-05-10');
    INSERT INTO StudentProfile VALUES ('ST_3','MEHUL','KUMAR','MALE','1998-03-20');
    INSERT INTO StudentProfile VALUES ('ST_4','SANIYA','KAPUR','FEMALE','2000-02-11');
    INSERT INTO StudentProfile VALUES ('ST_5','SAMAY','JOHN','MALE','1996-02-19');
    INSERT INTO StudentProfile VALUES ('ST_6','JAMES','CHARLES','MALE','1998-04-20');



#Inserted values into Organization_Feedback in sequence of Organization_Feedback_ID, Student_ID,Organization_ID,Review,Scale_Rating
    INSERT INTO Organization_Feedback VALUES (1,101,'Great Company to work with',4.8);
    INSERT INTO Organization_Feedback VALUES (2,102,'Rise in pay is good',4.99);
    INSERT INTO Organization_Feedback VALUES (3,203,'Great learning in research program',3.9);
    INSERT INTO Organization_Feedback VALUES (1,201,'No flexible hours working',2.9);
    INSERT INTO Organization_Feedback VALUES (4,201,'Flexible hours and good pay',4.9);
    INSERT INTO Organization_Feedback VALUES (4,103,'Hectic worklife balance',2.9);
    INSERT INTO Organization_Feedback VALUES (3,104,'Great learnings at Facebook',3.9);
    INSERT INTO Organization_Feedback VALUES (2,204,'Recommended for Research work',4.9);
    INSERT INTO Organization_Feedback VALUES (5,202,'Good Job',4.9);
    INSERT INTO Organization_Feedback VALUES (1,205,'Great learnings from professor',4.7);

#Inserted values into Placement_type:
    INSERT INTO Placement_Type VALUES
	('Software Development Engineer'),
	('Medical Analyst'),
	('Data Engineer'),
	('Business Analyst'),
	('HR Management'),
    ('Talent Acquistion'),
	('Data Scientist'),
	('Software Testing'),
	('Security Engineer'),
	('Network Administrator'),
	('Application Developer'),
	('DevOps Engineer'),
    ('SQL Developer'),
    ('Data Analyst'),
    ('Research Assistant'),
    ('Teaching Assistant'),
    ('Student Ambassador'),
    ('Squash Buster'),
    ('Graduate Assistant'),
    ('Application Assistant'),
    ('Residential Security Officer'),
    ('Barista');


#Inserted values into Placement_Location in sequence of Placement_LocationID,StreetAddress ,City ,State ,Zip
    INSERT INTO Placement_Location VALUES ('7168 Fremont Street','Harrison Township','MI','48045');
    INSERT INTO Placement_Location VALUES ('7527 Hawthorne St','Worcester','MA','01604');
    INSERT INTO Placement_Location VALUES ('9049 Bay Meadows Street','Muncie','IN','47302');
    INSERT INTO Placement_Location VALUES ('24 East Snake Hill Lane','Janesville','FL','17911');
    INSERT INTO Placement_Location VALUES ('7582 South Trenton Street','Perkasie','PA','18944');
    INSERT INTO Placement_Location VALUES ('8115 South Durham Dr','Pensacola','FL', '32503');
    INSERT INTO Placement_Location VALUES ('73 South Whitemarsh St','Hattiesburg','MS','39401');
    INSERT INTO Placement_Location VALUES ('241 Canal Lane','Wyandotte','MI','48192');
    INSERT INTO Placement_Location VALUES ('21 Forsyth St','Boston','MA','91891');
    INSERT INTO Placement_Location VALUES ('129 Hemenway St','Boston','MA','91821');
    INSERT INTO Placement_Location VALUES ('337 Huntington Ave','Boston','MA','28711');
    INSERT INTO Placement_Location VALUES ('10 Leon St','Boston','MA','22321');


#Inserted values into Placement_Listing in sequence of Placement_ListingID,Organization_ID ,Placement_Type_ID ,Listing_Date ,Placement_Location_ID ,Seat_Availabilty ,PlacementDescription
    INSERT INTO Placement_Listing(Placement_ListingID,Organization_ID ,Placement_Type_ID ,Listing_Date ,Placement_Location_ID ,Seat_Availabilty ,PlacementDescription)
    VALUES
    (1,101,1,'2021-08-22',1,60,'Develop, test, and document embedded or distributed software applications.'),
    (2,102,13,'2022-08-09',10,22,'Responsible for developing SQL databases and writing applications to interface with SQL databases'),
    (3,103,14,'2021-09-22',2,72,'Data analysts are responsible for analyzing data using statistical techniques, implementing and maintaining databases'),
    (4,201,22,'2022-10-22',7,80,'Responsible for serving beverages such as coffee, tea and specialty beverage'),
    (5,204,21,'2022-09-10',4,77,'Helping students find accessibility to places'),
    (6,205,16,'2022-05-20',10,80,'Helping teachers for grading in course'),
    (7,202,17,'2022-11-11',7,122,'Helping students find books and accessing rooms'),
    (8,104,7,'2022-09-22',3,34,'Responsible for collecting large amounts of data using analytical, statistical, and programmable skills'),
    (9,101,11,'2022-07-29',12,45,'Responsible for writing software programs for use across mobile operating systems, including Apple, Android, and Windows devices.'),
    (10,103,4,'2022-08-08',1,28,'Responsible for analyzing large data sets to identify effective ways of boosting organizational efficiency.'),
    (11,104,3,'2022-10-20',4,98,'Responsible for developing, testing, and maintaining data pipelines and data architectures.');



#Inserted values into Placement Application in sequence of Student_ID ,Placement_Listing_ID ,ApplyDate
    INSERT INTO PlacementApplication(Student_ID ,Placement_Listing_ID ,ApplyDate) VALUES (1,1,'2021-09-22');
    INSERT INTO PlacementApplication(Student_ID ,Placement_Listing_ID ,ApplyDate) VALUES(2,1,'2021-10-10');
    INSERT INTO PlacementApplication(Student_ID ,Placement_Listing_ID ,ApplyDate) VALUES (2,3,'2022-01-01');
    INSERT INTO PlacementApplication(Student_ID ,Placement_Listing_ID ,ApplyDate) VALUES (1,4,'2022-10-23');
    INSERT INTO PlacementApplication(Student_ID ,Placement_Listing_ID ,ApplyDate) VALUES (3,7,'2022-11-12');
    INSERT INTO PlacementApplication(Student_ID ,Placement_Listing_ID ,ApplyDate) VALUES (3,9,'2022-07-30');
    INSERT INTO PlacementApplication(Student_ID ,Placement_Listing_ID ,ApplyDate) VALUES (4,10,'2022-09-09');
    INSERT INTO PlacementApplication(Student_ID ,Placement_Listing_ID ,ApplyDate) VALUES (5,3,'2022-01-01');
    INSERT INTO PlacementApplication(Student_ID ,Placement_Listing_ID ,ApplyDate) VALUES (4,1,'2021-08-23');
    INSERT INTO PlacementApplication(Student_ID ,Placement_Listing_ID ,ApplyDate) VALUES (3,8,'2022-09-23');
    INSERT INTO PlacementApplication(Student_ID ,Placement_Listing_ID ,ApplyDate) VALUES (2,4,'2022-10-23');
    INSERT INTO PlacementApplication(Student_ID ,Placement_Listing_ID ,ApplyDate) VALUES (4,11,'2022-11-20');
    INSERT INTO PlacementApplication(Student_ID ,Placement_Listing_ID ,ApplyDate) VALUES (5,6,'2022-06-06');
    INSERT INTO PlacementApplication(Student_ID ,Placement_Listing_ID ,ApplyDate) VALUES (3,6,'2022-06-22');
    INSERT INTO PlacementApplication(Student_ID ,Placement_Listing_ID ,ApplyDate) VALUES (6,1,'2018-02-02');


#Inserted values into Skills in sequence of Skill_ID,Skill_Name
    INSERT INTO Skills 
    VALUES (1,'C Programming'),
    (2,'JAVA'),
    (3,'MYSQL'),
    (4,'Machine Learning'),
    (5,'Artificial Intelligence'),
    (6,'Big Data'),
    (7,'ETL Developer'),
    (8, 'UIUX'),
    (9,'Cloud Computing'),
    (10,'Statistical Analysis'),
    (11,'Deep Learning'),
    (12,'Cognitive Developer'),
    (13,'Reseacher'),
    (14,'Communication Skills'),
    (15,'Data Entry');

#Inserted values into StudentSkillSet in sequence of Skill_ID,Student_ID,Date_Acquired
    INSERT INTO StudentSkillSets VALUES (9,1,'2019-01-01');
    INSERT INTO StudentSkillSets VALUES (2,1,'2018-09-09');
    INSERT INTO StudentSkillSets VALUES (15,1,'2015-09-09');
    INSERT INTO StudentSkillSets VALUES (11,1,'2021-08-08');
    INSERT INTO StudentSkillSets VALUES (9,2,'2021-07-09');
    INSERT INTO StudentSkillSets VALUES (15,2,'2020-09-10');
    INSERT INTO StudentSkillSets VALUES (7,2,'2020-10-20');
    INSERT INTO StudentSkillSets VALUES (10,2,'2019-11-28');
    INSERT INTO StudentSkillSets VALUES (12,1,'2020-09-29');
    INSERT INTO StudentSkillSets VALUES (14,3,'2019-09-02');
    INSERT INTO StudentSkillSets VALUES (12,3,'2019-11-20');
    INSERT INTO StudentSkillSets VALUES (6,3,'2019-11-08');
    INSERT INTO StudentSkillSets VALUES (9,4,'2018-11-19');
    INSERT INTO StudentSkillSets VALUES (7,4,'2019-11-11');
    INSERT INTO StudentSkillSets VALUES (3,4,'2018-09-09');
    INSERT INTO StudentSkillSets VALUES (10,5,'2016-02-20');
    INSERT INTO StudentSkillSets VALUES (14,5,'2017-09-09');
    INSERT INTO StudentSkillSets VALUES (15,5,'2015-12-22');
    INSERT INTO StudentSkillSets VALUES (11,2,'2017-10-11');
    INSERT INTO StudentSkillSets VALUES (8,5,'2018-09-02');
    INSERT INTO StudentSkillSets VALUES (13,4,'2017-09-28');
    INSERT INTO StudentSkillSets VALUES (11,4,'2018-09-20');
    INSERT INTO StudentSkillSets VALUES(2, 6,'2018-01-20');

#Inserted values into PlacementPostingSkill  in sequence of Skill_ID , PlacementPostingID
     INSERT INTO PlacementPostingSkill
        VALUES (9,1),
    (3,2),
    (10,3),
    (15,4),
    (14,5),
    (14,6),
    (14,7),
    (6,8),
    (12,9),
    (3,10),
    (7,11);

#Inserted values into Degree in sequence of Degree_ID,Major,Degree_Type
    INSERT INTO Degree
    VALUES (1,'INFORMATION SYSTEMS','MASTERS'),
            (2,'COMPUTER SCIENCE','BACHELORS'),
            (3,'COMPUTER SCIENCE','BACHELORS'),
            (4,'ELECTRONCS ENGINEERING','BACHELORS'),
            (5,'UIUX DEVELOPER','MASTERS'),
            (6,'BUSINESS ADMINSTARTION','MASTERS'),
            (7,'MARKETING','MASTERS'),
            (8,'DATA ANALYSIS','MASTERS'),
            (9,'ARTIFICAL INTELLIGENCE','MASTERS'),
            (10,'MECHANICAL ENGINEERING','BACHELORS'),
            (11,'FINANCE','MASTERS');


#Inserted values into StudentEducation  in sequence of Student_ID,Degree_ID,GPA
    INSERT INTO StudentEducation
    VALUES (1,1,2.7),
    (2,5,3),
    (3,9,2),
    (4,8,4.0),
    (5,2,3.4),
    (6,10,3.99);

#select * from StudentEducation



#Inserted values into StudentWorkEx  in sequence of Student_ID,StartDate,EndDate,WorkEX_Title,Company_Name,Placement_Location,Is_Current_Status
    INSERT INTO StudentWorkEx
    VALUES(1,'2017-09-20','2019-09-02','Deloitte','Data Anlayst',1);
    INSERT INTO StudentWorkEx
    values(1,'2015-09-20','2017-09-02','Snell Library','Library Assistant',12);
    INSERT INTO StudentWorkEx
    values(2,'2019-09-10','2022-11-16','EY','Business Analyst',3);
    INSERT INTO StudentWorkEx(Student_ID,StartDate,WorkEx_Title,Company_Name,Placement_Location_ID)
    values(2,'2019-08-22','DANA','CampusRecreationAssistant',10);
    INSERT INTO StudentWorkEx(Student_ID,StartDate,WorkEx_Title,Company_Name,Placement_Location_ID)
    values(3,'2017-09-20','EL','Architect',5);
    INSERT INTO StudentWorkEx(Student_ID,StartDate,WorkEx_Title,Company_Name,Placement_Location_ID)
    values(3,'2019-09-08','Meta','Data Engineer',4);
    INSERT INTO StudentWorkEx
    values(4,'2019-01-01','2022-10-20','DunkinDonuts','DataEntry',10);
    INSERT INTO StudentWorkEx(Student_ID,StartDate,WorkEx_Title,Company_Name,Placement_Location_ID)
    values(4,'2017-10-20','Meta','Data Scientist',7);
    INSERT INTO StudentWorkEx(Student_ID,StartDate,WorkEx_Title,Company_Name,Placement_Location_ID)
    values(5,'2018-01-20','Snell Library','ResearchComputing',11);


#Use DecryptByKey to decrypt the encrypted data. We receive the output in binary format
	Select Login_ID,Email_ID, DecryptByKey(Password) as 'Encrypted Password' from LoginPortal;

#Find the decrypted passwords:
    Select Login_ID,Email_ID, convert(varchar, DecryptByKey(Password)) as 'Decrypted Password' from LoginPortal;


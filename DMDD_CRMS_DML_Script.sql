INSERT INTO [Login].LoginCategory
        VALUES    
            (1, 'ONCAMPUS_HIRINGMANAGER'),
            (2, 'OFFCAMPUS_HIRINGMANAGER'),
            (3, 'STUDENT')

INSERT INTO [Login].LoginPortal     
        VALUES 
            ('31','hetalgada15@gmail.com','hetal@231', '(781) 460-1631',3),
            ('32','tanuj22@gmail.com','tanuj@231', '(332) 432-1331',3),
            ('33','mehul98@gmail.com','mehul@231', '(982) 232-9823',3),
            ('34','saniyakapur98@gmail.com','saniya@231', '(232) 233-2838',3),
            ('11','hellohiring@gmail.com','xywe2@12', '(100) 181-2911',1),
            ('12','same25@gmail.com','sammy726@2', '(982) 291-2219',1),
            ('13','bluemoon@gmail.com','blue@878', '(981) 781-2211',1),
            ('21','offhiring1@gmail.com','deowu@21', '(187) 128-1291',2),
            ('22','offhiring2@gmail.com','pumpki@32', '(291) 291-0922',2),
            ('23','offhiring3@gmail.com','ejsj@281', '(091) 362-2311',2),
            ('35','samay98@gmail.com','samay@231', '(271) 312-9393',3),
            ('36','marc@gmail.com','Marc71', '(232) 422-2323',3),
            ('37','joey@gmail.com','Joey99', '(348) 239-2332',3),
            ('38','chandler@gmail.com','Chandler09', '(812) 231-3272',3),
            ('39','phoebe@gmail.com','phoebe94', '(272) 321-1231',3),
            ('310','rachel@gmail.com','Rachel17', '(128) 121-1231',3),
            ('311','ross@gmail.com','ross21', '(121) 121-3111',3),
            ('312','monica@gmail.com','monica762', '(181) 121-1242',3)

INSERT INTO Organization.Organization       
    VALUES
        (101, '21', 'DELOITTE','www.deloitte.com'),
        (102, '22', 'EY','www.ey.com'),
        (103, '23', 'Meta','www.meta.com'),
        (104, '23', 'Facebook','www.facebook.com'),
        (201, '11', 'DunkinDonuts','www.northeastern_dunkindonuts.com'),
        (202, '12', 'Research Computing-JM','http://rc.northeastern.edu'),
        (203, '13', 'Architecture-JM','http://rca.northeastern.edu'),
        (204, '13', 'Campus Recreation-JM','www.northeastern.edu/diversity'),
        (205, '12', 'TeachingAssistant_DANA', 'cssh.northeastern.edu/cssh-teaching-assistants/'),
        (206, '11', 'LibraryAssistant', 'snellLibrary_northeastern.edu')

INSERT INTO Student.StudentProfile      
    VALUES 
        (1,'31','HETAL','GADA','FEMALE','1999-05-20'),
        (2,'32','TANUJ','VERMA','MALE','1995-05-10'),
        (3,'33','MEHUL','KUMAR','MALE','1998-03-20'),
        (4,'34','SANIYA','KAPUR','FEMALE','2000-02-11'),
        (5,'35','MARC','JOHN','MALE','1999-04-20'),
        (6,'36','JAMES','CHARLES','MALE','1998-04-20')

INSERT INTO Organization.Organization_Feedback        
    VALUES
        (29000,1,101,'Great Company to work with',4.8),
        (29001,2,102,'Rise in pay is good',4.99),
        (29002,3,203,'Great learning in research program',3.9),
        (29003,1,206,'No flexible hours working',2.9),
        (29004,4,201,'Flexible hours and good pay',4.9),
        (29005,4,103,'Hectic worklife balance',2.9),
        (29006,3,104,'Great learnings at Facebook',3.9),
        (29007,2,204,'Recommended for Research work',4.9),
        (29008,5,202,'Good Job',4.9),
        (29009,1,205,'Great learnings from professor',4.7)

INSERT INTO PLACEMENT.Placement_Type(Placement_Type_ID, Placement_Type) 
        VALUES
	        (1, 'Software Development Engineer'),
	        (2, 'Medical Analyst'),
	        (3, 'Data Engineer'),
	        (4, 'Business Analyst'),
	        (5, 'HR Management'),
            (6, 'Talent Acquistion'),
	        (7, 'Data Scientist'),
	        (8, 'Software Testing'),
	        (9, 'Security Engineer'),
	        (10, 'Network Administrator'),
	        (11, 'Application Developer'),
	        (12, 'DevOps Engineer'),
            (13,'SQL Developer'),
            (14, 'Data Analyst'),
            (15,'Research Assistant'),
            (16, 'Teaching Assistant'),
            (17, 'Student Ambassador'),
            (18, 'Squash Buster'),
            (19, 'Graduate Assistant'),
            (20, 'Application Assistant'),
            (21, 'Residential Security Officer'),
            (22, 'Barista')

INSERT INTO PLACEMENT.Placement_Location(Placement_LocationID, StreetAddress ,City, [State], Zip ) 
    VALUES
        (1, '7168 Fremont Street','Harrison Township','MI','48045'),
        (2,'7527 Hawthorne St','Worcester','MA','01604'),
        (3,'9049 Bay Meadows Street','Muncie','IN','47302'),
        (4,'24 East Snake Hill Lane','Janesville','FL','17911'),
        (5,'7582 South Trenton Street','Perkasie','PA','18944'),
        (6,'8115 South Durham Dr','Pensacola','FL', '32503'),
        (7,'73 South Whitemarsh St','Hattiesburg','MS', '39401'),
        (8,'241 Canal Lane','Wyandotte','MI', '48192'),
        (9,'21 Forsyth St','Boston','MA', '91891'),
        (10,'129 Hemenway St','Boston','MA', '91821'),
        (11,'337 Huntington Ave','Boston','MA', '28711'),
        (12,'10 Leon St','Boston','MA', '22321')

INSERT INTO PLACEMENT.Placement_Listing(Placement_ListingID,Organization_ID ,Placement_Type_ID ,Listing_Date ,Placement_Location_ID ,Seat_Availabilty ,PlacementDescription)
    VALUES
        (1,101,1,'2021-08-22',1,60,'Develop, test, and document embedded or distributed software applications.'),
        (2,102,13,'2022-08-09',10,22,'Responsible for developing SQL databases and writing applications to interface with SQL databases'),
        (3,103,14,'2021-09-22',2,72,'Data analysts are responsible for analyzing data using statistical techniques, implementing and maintaining databases'),
        (4,201,22,'2022-10-22',7,80,'Responsible for serving beverages such as coffee, tea and specialty beverage'),
        (5,204,21,'2022-09-10',4,77,'Helping students find accessibility to places'),
        (6,205,16,'2022-05-20',10,80,'Helping teachers for grading in course'),
        (7,206,17,'2022-11-11',7,122,'Helping students find books and accessing rooms'),
        (8,104,7,'2022-09-22',3,34,'Responsible for collecting large amounts of data using analytical, statistical, and programmable skills'),
        (9,101,11,'2022-07-29',12,45,'Responsible for writing software programs for use across mobile operating systems, including Apple, Android, and Windows devices.'),
        (10,103,4,'2022-08-08',1,28,'Responsible for analyzing large data sets to identify effective ways of boosting organizational efficiency.'),
        (11,104,3,'2022-10-20',4,98,'Responsible for developing, testing, and maintaining data pipelines and data architectures.')

INSERT INTO Placement.PlacementApplication(Student_ID ,Placement_Listing_ID ,ApplyDate)     
    VALUES 
        (1,1,'2021-09-22'),
        (2,1,'2021-10-10'),
        (2,3,'2022-01-01'),
        (1,4,'2022-10-23'),
        (3,7,'2022-11-12'),
        (3,9,'2022-07-30'),
        (4,10,'2022-09-09'),
        (5,3,'2022-01-01'),
        (4,1,'2021-08-23'),
        (3,8,'2022-09-23'),
        (2,4,'2022-10-23'),
        (4,11,'2022-11-20'),
        (5,6,'2022-06-06'),
        (3,6,'2022-06-22'),
        (6,1,'2018-02-02')

INSERT INTO Skill 
    VALUES 
        (1,'C Programming'),
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
        (15,'Data Entry')

INSERT INTO Student.StudentSkillSet     
    VALUES 
        (9,1,'2019-01-01'),
        (2,1,'2018-09-09'),
        (15,1,'2015-09-09'),
        (11,1,'2021-08-08'),
        (9,2,'2021-07-09'),
        (15,2,'2020-09-10'),
        (7,2,'2020-10-20'),
        (10,2,'2019-11-28'),
        (12,1,'2020-09-29'),
        (14,3,'2019-09-02'),
        (12,3,'2019-11-20'),
        (6,3,'2019-11-08'),
        (9,4,'2018-11-19'),
        (7,4,'2019-11-11'),
        (3,4,'2018-09-09'),
        (10,5,'2016-02-20'),
        (14,5,'2017-09-09'),
        (15,5,'2015-12-22'),
        (11,2,'2017-10-11'),
        (8,5,'2018-09-02'),
        (13,4,'2017-09-28'),
        (11,4,'2018-09-20'),
        (2, 6,'2018-01-20')

INSERT INTO Placement.PlacementSkillSet     
    VALUES 
        (9,1),
        (3,2),
        (10,3),
        (15,4),
        (14,5),
        (14,6),
        (14,7),
        (6,8),
        (12,9),
        (3,10),
        (7,11)

INSERT INTO Student.Degree      
    VALUES 
        (1,'INFORMATION SYSTEMS','MASTERS'),
        (2,'COMPUTER SCIENCE','BACHELORS'),
        (3,'COMPUTER SCIENCE','BACHELORS'),
        (4,'ELECTRONCS ENGINEERING','BACHELORS'),
        (5,'UIUX DEVELOPER','MASTERS'),
        (6,'BUSINESS ADMINSTARTION','MASTERS'),
        (7,'MARKETING','MASTERS'),
        (8,'DATA ANALYSIS','MASTERS'),
        (9,'ARTIFICAL INTELLIGENCE','MASTERS'),
        (10,'MECHANICAL ENGINEERING','BACHELORS'),
        (11,'FINANCE','MASTERS')

INSERT INTO Student.StudentEducation        
    VALUES 
        (1,1,2.7),
        (2,5,3),
        (3,9,2),
        (4,8,4.0),
        (5,2,3.4)

INSERT INTO Student.StudentWorkExperience       
    VALUES
        (1,'2017-09-20','2019-09-02','Deloitte','Data Anlayst',1),
        (1,'2015-09-20','2017-09-02','Snell Library','Library Assistant',12),
        (2,'2019-09-10','2022-11-16','EY','Business Analyst',3),
        (2,'2019-08-22','2019-09-02','DANA','CampusRecreationAssistant',10),
        (3,'2017-09-20','2019-09-02','EL','Architect',5),
        (3,'2019-09-08','2019-09-02','Meta','Data Engineer',4),
        (4,'2019-01-01','2022-10-20','DunkinDonuts','DataEntry',10),
        (4,'2017-10-20','2019-09-02','Meta','Data Scientist',7),
        (5,'2018-01-20','2019-09-02','Snell Library','ResearchComputing',11)
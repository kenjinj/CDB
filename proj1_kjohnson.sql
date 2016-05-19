use johnson;

drop table if exists cdb_case;
create table cdb_case(case_id int auto_increment primary key, 
					  name varchar(50) unique, 
					  length float,
                      type varchar(50),
                      caliber float);

drop table if exists cdb_projectile;
create table cdb_projectile(proj_id int auto_increment primary key,
							caliber float,
							weight int,
							type varchar(50),
                            blstc_coef float,
                            unique(caliber, weight, type));
                            
create table cdb_manufacturer(manuf_id int auto_increment primary key,
							  name varchar(50) unique);
                              
drop table if exists cdb_powder;					
create table cdb_powder(powder_id int auto_increment primary key,
						name varchar(50),
                        manuf_id int,
                        foreign key(manuf_id) references cdb_manufacturer(manuf_id),
                        unique(manuf_id, name));
                        
drop table if exists cdb_primer;                        
create table cdb_primer(primer_id int auto_increment primary key,
					    name varchar(50) unique,
                        type varchar(50),
                        manuf_id int,
                        foreign key(manuf_id) references cdb_manufacturer(manuf_id));

drop table if exists cdb_load;                        
create table cdb_load(load_id int auto_increment primary key,
					  case_id int,
                      proj_id int,
                      powder_id int,
                      primer_id int,
                      powder_weight float,
                      col float,
                      velocity int,
                      barrel_length float,
                      foreign key(case_id) references cdb_case(case_id),
                      foreign key(proj_id) references cdb_projectile(proj_id),
                      foreign key(powder_id) references cdb_powder(powder_id),
                      foreign key(primer_id) references cdb_primer(primer_id),
                      unique(case_id, proj_id, powder_id, primer_id, powder_weight));
                      
create table cdb_powder_case(case_id int,
							 powder_id int,
                             foreign key(case_id) references cdb_case(case_id),
                             foreign key(powder_id) references cdb_powder(powder_id),
                             primary key(case_id, powder_id));                             
                             
insert into cdb_case(name, 						length, type, 		caliber) values
					('357 Magnum',				1.290,	'Rimmed',	0.357),
                    ('44 Remington Magnum',		1.285,	'Rimmed',	0.430),
                    ('45 Automatic',			0.898,	'Rimless',	0.451),
                    ('45 Colt (Revolver)',		1.285,	'Rimmed',	0.452),
                    ('45 Colt (Ruger & T/C)',	1.285,	'Rimmed',	0.452),
                    ('38 Special',				1.155, 	'Rimmed',	0.357),
                    ('9mm Luger',				0.754,	'Rimless',	0.355);
                    
insert into cdb_projectile(caliber, weight,	type, 		blstc_coef) values
						  (0.358,	158,	'LRN',		0.159),
                          (0.358,	158,	'SWC HP',	0.139),
                          (0.358,	158,	'SWC',		0.135),
                          (0.357,	158,	'FP',		0.199),
                          (0.357,	158,	'HP',		0.206),
                          (0.357,	180,	'HP',		0.230),
                          (0.357,	125,	'FP',		0.148),
                          (0.357,	125,	'HP',		0.151),
                          
                          (0.452,	230,	'LRN',		0.207),
                          (0.451,	230,	'FMJ-FP',	0.168),
                          (0.451,	230,	'FMJ-RN',	0.184),
                          (0.451,	230,	'FMJ-HP',	0.188),
                          
                          (0.452, 	250,	'HP',		0.146),
                          (0.452, 	300,	'HP',		0.180);
                          
insert into cdb_manufacturer(name) values
							('Winchester'),
                            ('Alliant'),
                            ('Hodgdon'),
                            ('IMR'),
                            ('Accurate'),
                            ('CCI'),
                            ('Remington'),
                            ('Federal');
                            
select * from cdb_manufacturer;                            
                            
insert into cdb_powder(name, 				manuf_id) values
					  ('Unique',			2),
                      ('2400',				2),
                      ('H110',				3),
					  ('Win 296',			1),
                      ('4227',				4),
                      ('Power Pro 300-MP',	5),
                      ('Universal',			3),
                      ('Power Pistol',		2);
                      
insert into cdb_primer(name, 	type, 					manuf_id) values
					  ('WSPM',	'Small Pistol Magnum',	1),
                      ('WSP',	'Small Pistol',			1),
                      ('WLP',	'Large Pistol',			1),
                      ('205',	'Small Rifle',			8),
                      ('WLR',	'Large Rifle',			1);
                      
select * from cdb_case;   
select * from cdb_projectile;
select * from cdb_powder;    
select * from cdb_primer;               
insert into cdb_load(case_id, 	proj_id, powder_id, primer_id, 	powder_weight, 	col, 	velocity, 	barrel_length) values
					(1,			4,		 4,			1,			12.4,			1.590,	1000,		8.0),
                    (1,			4,		 4,			1,			13.1,			1.590,	1050,		8.0),
                    (1,			4,		 4,			1,			13.8,			1.590,	1100,		8.0),
                    (1,			4,		 4,			1,			14.5,			1.590,	1150,		8.0),
                    (1,			4,		 4,			1,			15.2,			1.590,	1200,		8.0),
                    (1,			4,		 4,			1,			16.0,			1.590,	1250,		8.0),
                    
                    (1,			4,		 5,			1,			12.4,			1.590,	1000,		8.0),
                    (1,			4,		 5,			1,			13.1,			1.590,	1050,		8.0),
                    (1,			4,		 5,			1,			13.8,			1.590,	1100,		8.0),
                    (1,			4,		 5,			1,			14.5,			1.590,	1150,		8.0),
                    
                    (1,			4,		 2,			1,			10.5,			1.590,	1000,		8.0),
                    (1,			4,		 2,			1,			11.4,			1.590,	1050,		8.0),
                    (1,			4,		 2,			1,			12.4,			1.590,	1100,		8.0),
                    (1,			4,		 2,			1,			13.3,			1.590,	1150,		8.0),
                    (1,			4,		 2,			1,			14.3,			1.590,	1200,		8.0),
                    
                    (3,			11,		 7,			3,			5.2,			1.210,	750,		5.0),
                    (3,			11,		 7,			3,			5.4,			1.210,	800,		5.0),
                    (3,			11,		 7,			3,			5.7,			1.210,	850,		5.0),
                    
                    (5,			13,		 5,			3,			20.2,			1.595,	1150,		10.0),
                    (5,			13,		 5,			3,			21.5,			1.595,	1200,		10.0),
                    (5,			13,		 5,			3,			22.9,			1.595,	1250,		10.0),
                    (5,			13,		 5,			3,			24.2,			1.595,	1300,		10.0),
                    
                    (5,			14,		 4,			3,			17.9,			1.580,	1050,		10.0),
                    (5,			14,		 4,			3,			18.7,			1.580,	1100,		10.0),
                    (5,			14,		 4,			3,			19.4,			1.580,	1150,		10.0),
                    (5,			14,		 4,			3,			20.2,			1.580,	1200,		10.0),
                    (5,			14,		 4,			3,			21.0,			1.580,	1250,		10.0),
                    (5,			14,		 4,			3,			21.7,			1.580,	1300,		10.0);
                    
insert into cdb_powder_case(case_id,	powder_id) values
						   (1,			2),
                           (1,			3),
                           (1,			4),
                           (1,			5),
                           (1,			6),
                           (1,			7),
                           
                           (3,			7),
                           (3,			8),
                           
                           (5,			2),
                           (5,			4),
                           (5,			5);
                    
select powder_id, p.name, p.manuf_id, m.name from cdb_powder p join cdb_manufacturer m on p.manuf_id = m.manuf_id;
select primer_id, p.name, p.manuf_id, m.name from cdb_primer p join cdb_manufacturer m on p.manuf_id = m.manuf_id;
select * from cdb_load;
select load_id, c.name, pro.weight, pro.type, pow.name, pri.name, powder_weight, col, velocity, barrel_length from cdb_load l
	join cdb_case c on l.case_id = c.case_id
    join cdb_projectile pro on l.proj_id = pro.proj_id
    join cdb_powder pow on l.powder_id = pow.powder_id
    join cdb_primer pri on l.primer_id = pri.primer_id;
select pc.case_id, c.name, pc.powder_id, p.name from cdb_powder_case pc
	join cdb_case c on pc.case_id = c.case_id
    join cdb_powder p on pc.powder_id = p.powder_id;
    
-- subquery
select c.name, pro.weight as proj_weight, pro.type as proj_type, m.name as manuf, pow.name as powder, powder_weight, velocity from cdb_load l
	join cdb_case c on l.case_id = c.case_id
    join cdb_projectile pro on l.proj_id = pro.proj_id
    join cdb_powder pow on l.powder_id = pow.powder_id
    join cdb_manufacturer m on pow.manuf_id = m.manuf_id 
	where velocity = (
		select max(velocity) from cdb_load
	);
                    
-- JOIN, GROUP BY, HAVING and an aggregate function.
select c.name, pro.weight as proj_weight, pro.type as proj_type, m.name as manuf, pow.name as powder, m.name as manuf, min(powder_weight) from cdb_load l
	join cdb_case c on l.case_id = c.case_id
    join cdb_projectile pro on l.proj_id = pro.proj_id
    join cdb_powder pow on l.powder_id = pow.powder_id
    join cdb_manufacturer m on pow.manuf_id = m.manuf_id 
    group by powder
    having c.name = '357 Magnum';
    
-- WHERE EXISTS or WHERE NOT EXISTS
-- All cases that can use more than one powder, and which powders
select c.name as catridge from cdb_case c
	join cdb_powder_case pc on c.case_id = pc.case_id
    join cdb_powder p on pc.powder_id = p.powder_id;
                    
select distinct c.name as catridge from cdb_case c
	where exists (select * from cdb_powder_case pc
					where c.case_id = pc.case_id);
                    
select distinct c.name as catridge from cdb_case c
	where not exists (select * from cdb_powder_case pc
					where c.case_id = pc.case_id);
                    
--  A query using a UNION
select name from cdb_case
union
select name from cdb_powder
union
select name from cdb_manufacturer
union
select name from cdb_primer;

-- Update using query
update user_avg_rating_table ut
left join (select uName, avg_rating from user_avg_rating) u
	on ut.uName = u.uName
    set ut.avg_rating = u.avg_rating;
    
-- View
-- E = (M x V²) ÷ K
                        
-- where K = 450,435 and is derived from (2 x 32.1739 x 7000),
--            M is the weight of the projectile, in grains,
--            V is the velocity in feet per second and
--            E is the energy in foot pounds.

drop view if exists cdbView_energyByPowder;
create view cdbView_energyByPowder as 
select c.name as catridge, barrel_length, pro.weight as bulletGrn, m.name as manufacturer, pow.name as powder, 
	min(powder_weight) as grnMin, max(powder_weight) as grnMax,
	min(velocity) as velMin, max(velocity) as velMax,
	(min(velocity) * min(velocity) * pro.weight / 450435) as energyMin,
	(max(velocity) * max(velocity) * pro.weight / 450435) as energyMax from cdb_load l
	join cdb_case c on l.case_id = c.case_id
    join cdb_projectile pro on l.proj_id = pro.proj_id
    join cdb_powder pow on l.powder_id = pow.powder_id
    join cdb_primer pri on l.primer_id = pri.primer_id
    join cdb_manufacturer m on pow.manuf_id = m.manuf_id 
    group by c.name, pow.name;
select * from cdbView_energyByPowder;

-- function
drop function if exists cdbFunc_energyFind;
delimiter //
	create function cdbFunc_energyFind (_load_id int) returns double
		begin
        declare energy double;
		select (velocity * velocity * p.weight / 450435) into energy from cdb_load l
        join cdb_projectile p on l.proj_id = p.proj_id
            where _load_id = load_id;
		return energy;
		end //
delimiter ;

select cdbFunc_energyFind(1) from cdb_load where load_id = 1;

select load_id, c.name, pro.weight, pro.type, pow.name, pri.name, powder_weight, col, velocity, barrel_length, cdbFunc_energyFind(1) from cdb_load l
	join cdb_case c on l.case_id = c.case_id
    join cdb_projectile pro on l.proj_id = pro.proj_id
    join cdb_powder pow on l.powder_id = pow.powder_id
    join cdb_primer pri on l.primer_id = pri.primer_id
	where load_id = 1;

-- procedure
drop procedure if exists cdbProc_energyThreshold;
delimiter //
	create procedure cdbProc_energyThreshold (threshold double)
		begin
		select catridge, barrel_length, bulletGrn, manufacturer, powder, grnMax, velMax, energyMax from cdbView_energyByPowder
            where energyMax > threshold;
		end //
delimiter ;
call cdbProc_energyThreshold(525.0);

-- project 2
create table cdb_users(user_id int auto_increment primary key, firstname varchar(50), lastname varchar(50), email varchar(100) unique, password varchar(50));
insert into cdb_users(firstname, lastname, email, password) values
					('Kenji', 'Johnson','kenji.johnson@gmail.com', 'password');
            
DROP PROCEDURE IF EXISTS cdb_Account_GetByEmail;

DELIMITER //
CREATE PROCEDURE cdb_Account_GetByEmail(_email VARCHAR(256), _password VARCHAR(256))
BEGIN
	SELECT user_id, email, firstname, lastname FROM cdb_users where email=_email and password=_password;
END //
DELIMITER ;

select * from cdb_users;
DELETE FROM cdb_users WHERE firstname = 'Test';
                    
CALL cdb_Account_GetByEmail('kenji.johnson@gmail.com', 'password');

drop view if exists cdbView_all;
create view cdbView_all as 
select distinct c.case_id, c.name as case_name, pro.proj_id, pro.weight, pro.type, pow.powder_id, pow.name as powder_name from cdb_load l
	join cdb_case c on l.case_id = c.case_id
    join cdb_projectile pro on l.proj_id = pro.proj_id
    join cdb_powder pow on l.powder_id = pow.powder_id
    join cdb_primer pri on l.primer_id = pri.primer_id;

select * from cdbView_all order by powder_id asc, case_id asc;
select * from cdbView_all;

DROP PROCEDURE IF EXISTS cdb_CartridgeSearch;
DELIMITER //
CREATE PROCEDURE cdb_CartridgeSearch(_case_id int, _proj_id int, _powder_id int)
BEGIN
	select c.name, pro.weight as proj_weight, pro.type as proj_type, m.name as manuf, pow.name as powder, powder_weight, velocity from cdb_load l
	join cdb_case c on l.case_id = c.case_id
    join cdb_projectile pro on l.proj_id = pro.proj_id
    join cdb_powder pow on l.powder_id = pow.powder_id
    join cdb_manufacturer m on pow.manuf_id = m.manuf_id 
	where l.case_id = _case_id and l.proj_id = _proj_id and l.powder_id = _powder_id;
END //
DELIMITER ;      

CALL cdb_CartridgeSearch(1, 4 ,2);             
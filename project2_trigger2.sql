# Trigger 2. 2.	Write an SQL trigger called updateNVols that 
# detects when a volunteer volunteers for a timeslot and 
# decrements both the number of volunteers needed for the timeslot 
# and the number of volunteers needed for the project. [8 points]
drop trigger if exists updateNVols;

delimiter @@

create trigger updateNVols
after insert on projvolunteers

for each row begin

update timeslot set nVolneeded = nVolneeded - 1
where Day = NEW.Day AND startingTime = NEW.startingTime AND projID = NEW.projID;

update project set nVolneeded = nVolneeded - 1
where projID = NEW.projID;

end @@
delimiter ;

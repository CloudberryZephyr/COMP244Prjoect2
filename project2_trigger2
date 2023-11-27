
# Trigger 2. Write an SQL trigger called updateNVols that 
# detects when a volunteer volunteers for a timeslot and 
# decrements both the number of volunteers needed for the timeslot 
# and the number of volunteers needed for the project. [8 points]
delimiter @@

create trigger updateNVols
after update on projvolunteers

for each row begin

update timeslot set nVolneeded = nVolneeded - 1
where Day = OLD.Day AND startingTime = OLD.startingTime AND projID = OLD.projID;

update project set nVolneeded = nVolneeded - 1
where projID = OLD.projID;

end @@

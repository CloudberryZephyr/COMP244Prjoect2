# 1. Find project by date: Find the projects (all attributes of project) that start on February 9th, 2022. [5 points]
select *
from project
where startingDate = "2022-02-09";

# 2. Find volunteers by location: Find the names of all the volunteers who live in Grove City. [5 points]
select name
from volunteer 
where Address like "%Grove City%";

# 3. Change the duration of a timeslot: change the duration to 5 for the timeslot of project 2213, the starting time 12:00:00 and the date is “2021-09-08” [5 points]
-- select projID, startingTime, Day, duration
-- from timeslot;
update timeslot
set duration = 5
where projID = 2213 AND startingTime = "12:00:00" AND Day = "2021-09-08";

# 5. Volunteer for a timeslot:  Volunteer whose ID is 6123 wants to volunteer for the following timeslot: project ID 2212, date: "2021-10-24", and starting time is "10:00:00". 
# 5.. Write the SQL statement necessary for this action. [5 points]
insert into projvolunteers value (6123, 2212, "2021-10-24", "10:00:00");

# 10. Find most active organization: Display the OrgNo of the organization that has the greatest number of open projects. 
# 10.. Note that this is different from nProjects and that there might be a tie between two organizations. [7 points]
select OrgNo as "MostActiveOrg", openProjectsPerOrg
from (
select OrgNo, count(projID) as openProjectsPerOrg, status
from hosts h 
join organization o using (OrgNo) 
join project p using (projID) 
group by OrgNo
having p.status = "open"
) as numOpenProjects
where openProjectsPerOrg = (
select max(openProjectsPerOrg)
from (select OrgNo, count(projID) as openProjectsPerOrg, status
from hosts h 
join organization o using (OrgNo) 
join project p using (projID) 
group by OrgNo
having p.status = "open") as numOpenProjects2
);

# 11. Find the number of fans per organization: Find for each organization, count the number of volunteers who declared it as their preferred organization. 
# 11.. Display the organization name along with the number of fans in increasing alphabetical order. [6 points]
select o.name, numFans
from organization o
join (
select preferredOrg, count(VolID) as "numFans"
from volunteer v
group by preferredOrg
) as numF on o.OrgNo = numF.preferredOrg
order by o.name;

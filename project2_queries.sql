

# problem 4
# part a

INSERT INTO project VALUE(2214, "Birthday party of Joshua", 
	date(2021-10-12), date(2021-10-12), "Beverly's Birthdays", 5, 'open');
    
# part b

INSERT INTO timeslot VALUE(date(2021-10-12), time(1200), 5, 3, 2214);

# part c

INSERT INTO projectcat VALUE(1, 2214, 
	(SELECT catID
    FROM category
    WHERE name = 'fun'));
    
# part d

INSERT INTO hosts VALUE(10002, 2214);

SELECT orgNo
FROM hosts
WHERE projid = 2214;

# Problem 6

SELECT p.projID, p.description
FROM project p
JOIN projectcat
USING (projid)
JOIN (
	SELECT catid
	FROM category
    WHERE name = "service") AS t1
USING (catID);

# Problem 7

SELECT avg(count(catID))
FROM projectcat
GROUP BY (projid);

# Problem 8

SELECT p.description, o.name, c.name
FROM project p 
JOIN hosts h
USING (projid)
JOIN (
	SELECT *
    FROM projectcat 
    WHERE ranking = 1) AS t1
USING (projid)
JOIN organization o
ON (h.orgno = o.orgno)
JOIN category c
ON (t1.catid = c.catid);


# Problem 9

SELECT p.description, (p.nvolneeded - volunteers)
FROM project p
LEFT OUTER JOIN (
	SELECT projID, count(volid) as volunteers
    FROM projvolunteers
    GROUP BY (projid)
    ) as T1
USING (projid);
    



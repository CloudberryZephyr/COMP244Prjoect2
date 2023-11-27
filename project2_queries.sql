
# problem 4
# part a
INSERT INTO project VALUE(2214, "Birthday party for Joshua", 
	'2021-10-12', '2021-10-12', "Beverly's Birthdays", 5, 'open');
    
# part b
INSERT INTO timeslot VALUE('2021-10-12', '12:00', 5, 3, 2214);

# part c
INSERT INTO projectcat VALUE(1, 2214, 
	(SELECT catID
    FROM category
    WHERE name = 'fun'));
    
INSERT INTO projectcat VALUE(2, 2214, 
	(SELECT catID
    FROM category
    WHERE name = 'social'));

INSERT INTO projectcat VALUE(3, 2214, 
	(SELECT catID
    FROM category
    WHERE name = 'fundraiser'));


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
WHERE catID = (
	SELECT catid
	FROM category
    WHERE name = "service");

# Problem 7
SELECT avg(counts) 
FROM (
	SELECT count(catID) AS counts
	FROM projectcat
	GROUP BY (projid)) AS T1;

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
    FROM project
    LEFT OUTER JOIN projvolunteers
    USING (projid)
    GROUP BY (projid)
    ) as T1
USING (projid);

# Problem 12
SELECT *
FROM category 
WHERE catID = (
	SELECT catid
	FROM (
		SELECT catid, count(volid) as vols
		FROM interestedin
		GROUP BY (catid)) AS T2
	WHERE vols = (
		SELECT max(vols) as maxvols
		FROM (
			SELECT catid, count(volid) as vols
			FROM interestedin
			GROUP BY (catid)) AS T1)
);
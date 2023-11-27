
# trigger 1
DELIMITER @@
DROP TRIGGER IF EXISTS updateNProjects @@
CREATE TRIGGER updateNProjects
	AFTER INSERT ON hosts
    FOR EACH ROW
BEGIN
	UPDATE organization
    SET nProjects = nProjects + 1
    WHERE orgno = NEW.orgno;
END @@
DELIMITER ;
USE fukoshop;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE createRol (_rolName varchar(25))
    BEGIN
        Insert into roles(rolName)VALUES (_rolName);
    END$$
DELIMITER ;

CREATE DEFINER=`root`@`localhost` FUNCTION `updateRol`(idRol int, newRol varchar(25)) RETURNS int
BEGIN
    DECLARE _cant int;
    SELECT count(id) INTO _cant FROM roles WHERE id = idRol;
    IF _cant > 0 THEN
        UPDATE roles SET
            rolName = newRol
        WHERE id = idRol;
    END IF;
    RETURN _cant;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteRol`(_idRol INT)
    BEGIN
	    DELETE FROM roles WHERE id=_idRol;
    END$$
DELIMITER ;
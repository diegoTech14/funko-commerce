USE fukoshop;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `createPerson`(IN `_name` VARCHAR(25), IN `_surnameOne` VARCHAR(25), IN `_surnameTwo` VARCHAR(25))
    BEGIN
        INSERT INTO person (name, surnameOne, surnameTwo) VALUES (_name, _surnameOne, _surnameTwo);
    END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deletePerson`(IN `_id` INT)
    BEGIN
	    DELETE FROM  person WHERE id=_id;
    END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `searchPerson`(IN `_idPerson` INT)
    BEGIN
        SELECT * FROM person WHERE id = _idPerson;
    END$$
DELIMITER ;
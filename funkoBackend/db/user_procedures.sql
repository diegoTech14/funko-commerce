USE funkoshop;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `createPerson`(
    IN `_name` VARCHAR(25), 
    IN `_surnameOne` VARCHAR(25), 
    IN `_surnameTwo` VARCHAR(25)
)
    BEGIN
        INSERT INTO person (name, surnameOne, surnameTwo) VALUES (_name, _surnameOne, _surnameTwo);
    END$$


CREATE DEFINER = `root`@`localhost` FUNCTION `createUser`(
    `_email` VARCHAR(255), 
    `_id_person` INT, 
    `_passw` VARCHAR(255), 
    `_userName` VARCHAR(255), 
    `_idRol` INT
) RETURNS int

    BEGIN
	    DECLARE amountOne INT;
        DECLARE amountTwo INT;
        SELECT COUNT(id) into amountOne FROM person WHERE id =_id_person;
        SELECT COUNT(id) into amountTwo FROM users WHERE id_person = _id_person;
        if amountOne = 1 AND amountTwo = 0 THEN
            insert into users(emailAddress, id_person, password, userName, idRol) VALUES(_email, _id_person, _passw, _userName, _idRol);
	    end IF;
        return amountOne;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deletePerson`(IN `_id` INT)
    BEGIN
    	DELETE FROM  person WHERE id=_id;
    END$$


CREATE TRIGGER `deleteUser` AFTER DELETE ON `person`
    FOR EACH ROW BEGIN
        DELETE FROM users WHERE users.id_person = OLD.id;
    END $$

DELIMITER ;
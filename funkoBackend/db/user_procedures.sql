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


DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `userFilter`(
    _parameters varchar(250), -- %id%&%emailAddress%&%id_person%&%password%&%userName%&%idRol%&
    _page SMALLINT UNSIGNED, 
    _cantRegs SMALLINT UNSIGNED)
begin
    SELECT stringFilter(_parameters, 'id&emailAddress&id_person&password&userName&idRol&') INTO @filter;
    SELECT concat("SELECT * from users where ", @filter, " LIMIT ", 
        _page, ", ", _cantRegs) INTO @sql;
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
end$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `updateUser`(`_id` INT, `_emailAddress` VARCHAR(100), `_password` VARCHAR(255), `_userName` VARCHAR(25), `_idRol` INT) RETURNS int
begin
    declare _cant int;
    select count(id) into _cant from users where id = _id;
    if _cant > 0 then
        update users set
            emailAddress = _emailAddress,
            password = _password,
            userName = _userName,
            idRol = _idRol
        where id = _id;
    end if;
    return _cant;
end$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `stringFilter`(`_parameters` VARCHAR(250), `_camps` VARCHAR(50)) RETURNS varchar(250) CHARSET utf8mb4
begin
    declare _output varchar (250);
    set @param = _parameters;
    set @camps2 = _camps;
    set @filter = "";
    WHILE (LOCATE('&', @param) > 0) DO
        set @value = SUBSTRING_INDEX(@param, '&', 1);
        set @param = substr(@param, LOCATE('&', @param)+1);
        set @camp = SUBSTRING_INDEX(@camps2, '&', 1);
        set @camps2 = substr(@camps2, LOCATE('&', @camps2)+1);
        set @filter = concat(@filter, " `", @camp, "` LIKE '", @value, "' and");       
    END WHILE;
    set @filter = TRIM(TRAILING 'and' FROM @filter);  
    return @filter;
end$$
DELIMITER ;
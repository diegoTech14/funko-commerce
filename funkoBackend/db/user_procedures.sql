USE funkoshop;
DELIMITER $$

DELIMITER $$
DROP FUNCTION IF EXISTS createUser$$
CREATE FUNCTION createUser(_id_Person INT, _emailAddress VARCHAR(100), _password VARCHAR(255), _userName VARCHAR(25)) RETURNS int
BEGIN
    DECLARE _cant int;
    select count(id) into _cant from users where id_Person = _id_Person;
    
    if _cant > 0 THEN
    UPDATE users
    SET emailAddress = _emailAddress,
        password = _password,
        userName = _userName,
        idRol = 0
    WHERE id_person = _id_Person;
    end if;
 
    RETURN _cant;
END$$
DELIMITER ;

DELIMITER $$
DROP FUNCTION IF EXISTS deleteUser$$
CREATE FUNCTION deleteUser (_id INT) RETURNS int
BEGIN
    DECLARE rowsAffected INT;
    
    DELETE FROM users WHERE id_Person = _id;
    SET rowsAffected = ROW_COUNT();
    
    RETURN rowsAffected;
END$$
DELIMITER ;

DELIMITER $$
DROP FUNCTION IF EXISTS editUser$$
CREATE FUNCTION editUser (_id_Person INT, _emailAddress VARCHAR(100), _password VARCHAR(255), _userName VARCHAR(25)) RETURNS int
begin
    declare _cant int;
    select count(id) into _cant from users where id_Person = _id_Person;
    if _cant > 0 then
        update users set
            emailAddress = _emailAddress,
            password = _password,
            userName = _userName
        where id_Person = _id_Person;
    end if;
    return _cant;
end$$
DELIMITER ;


DELIMITER $$
DROP PROCEDURE IF EXISTS filterUser$$
CREATE PROCEDURE filterUser (IN _parameters VARCHAR(250), IN _page SMALLINT UNSIGNED, IN _cantRegs SMALLINT UNSIGNED)
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
DROP PROCEDURE IF EXISTS searchUser$$
CREATE DEFINER=`root`@`localhost` PROCEDURE searchUser(_id INT, _idPerson INT)
begin
    select * from users where id_person = _idPerson OR id = _id;
end$$
DELIMITER ;

DELIMITER $$
DROP FUNCTION IF EXISTS userPassword$$
CREATE FUNCTION userPassword (
    _id int, 
    _passw Varchar(255)
    ) RETURNS INT(1) 
begin
    declare _amount int;
    select count(id) into _amount from users where id = _id;
    if _amount > 0 then
        update users set
            password = _passw
        where id = _id;
    end if;
    return _amount;
end$$
DELIMITER ;

DELIMITER $$ 
DROP FUNCTION IF EXISTS lastId$$
CREATE FUNCTION lastId() RETURNS INT
    BEGIN
        DECLARE _quant int;
        SELECT id INTO _quant FROM person ORDER BY id DESC LIMIT 1;
    return _quant+1;
    END$$
DELIMITER ;
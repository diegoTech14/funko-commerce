USE funkoshop;
DELIMITER $$

DROP PROCEDURE IF EXISTS searchFunko$$
CREATE PROCEDURE searchFunko (IN _name VARCHAR(70))
    BEGIN
        SELECT * FROM funkos WHERE funkos.name LIKE CONCAT("%", _name ,"%");
    END $$


DROP PROCEDURE IF EXISTS createFunko$$
CREATE PROCEDURE  createFunko (
    IN `_name` VARCHAR(50),
    IN `_productTypeID` INT,
    IN `_categoryID` INT,
    IN `_exclusivity` INT, 
    IN `_urlImage` VARCHAR(150),
    IN `_stock` INT,
    IN `_price` DOUBLE(6, 2),
    IN `_description` TEXT
)
    BEGIN
        INSERT INTO funkos (name, productTypeID, categoryID, 
            exclusivity, urlImage, stock, price, description) VALUES (`_name`, `_productTypeID`, `_categoryID`, 
            `_exclusivity`, `_urlImage`,`_stock`,`_price`, `_description`);
    END$$



DROP PROCEDURE IF EXISTS deleteFunko$$
CREATE PROCEDURE deleteFunko (IN _id INT)

    BEGIN   
        DELETE FROM funkos WHERE funkos.id = _id;
    END $$
DELIMITER ;
USE funkoshop;
DELIMITER $$

DROP PROCEDURE IF EXISTS searchFunko$$
CREATE PROCEDURE searchFunko (IN _name VARCHAR(70))
    BEGIN
        SELECT * FROM funkos WHERE funkos.name LIKE CONCAT("%", _name ,"%");
    END $$

DROP PROCEDURE IF EXISTS createFunko$$
CREATE PROCEDURE  createFunko (
    IN _name VARCHAR(50),
    IN _productTypeID INT,
    IN _categoryID INT,
    IN _exclusivity INT, 
    IN _urlFirstImage VARCHAR(150),
    IN _urlSecondImage VARCHAR(150),
    IN _stock INT,
    IN _price DOUBLE(6, 2),
    IN _description TEXT
)
    BEGIN
        INSERT INTO funkos (
            name, 
            productTypeID, 
            categoryID, 
            exclusivity, 
            urlFirstImage, 
            urlSecondImage,
            stock, 
            price, 
            description) VALUES (
                _name, 
                _productTypeID, 
                _categoryID, 
                _exclusivity, 
                _urlFirstImage, 
                _urlSecondImage,
                _stock, 
                _price, 
                _description
            );
    END$$

DROP FUNCTION IF EXISTS editFunko$$
CREATE FUNCTION editFunko(
    _id INT,
    _name VARCHAR(50),
    _productTypeID INT,
    _categoryID INT,
    _exclusivity INT, 
    _urlFirstImage VARCHAR(150),
    _urlSecondImage VARCHAR(150),
    _stock INT,
    _price DOUBLE(6, 2),
    _description TEXT
)RETURNS INT(1)

BEGIN   
    DECLARE amount int;
    SELECT COUNT(funkos.id) INTO amount FROM funkos WHERE id = _id;

    IF amount > 0 THEN
        UPDATE funkos SET 
            name = _name,
            productTypeID = _productTypeID,
            categoryID = _categoryID,
            exclusivity = _exclusivity, 
            urlFirstImage = __urlFirstImage,
            urlSecondImage = _urlSecondImage,
            stock = _stock,
            price = _price,
            description = _description
        WHERE funkos.id = _id;
    END IF;
    RETURN amount;
END$$

DROP PROCEDURE IF EXISTS deleteFunko$$
CREATE PROCEDURE deleteFunko (IN _id INT)

    BEGIN   
        DELETE FROM funkos WHERE funkos.id = _id;
    END $$

DELIMITER ;

DROP PROCEDURE IF EXISTS categoryFilterAdmin$$
CREATE PROCEDURE categoryFilterAdmin(IN _categoryID INT)

    BEGIN
        SELECT funkos.id, funkos.productTypeID, funkos.categoryID, funkos.exclusivity,
                funkos.urlFirstImage, funkos.urlSecondImage, funkos.stock, funkos.price
        FROM funkos WHERE funkos.categoryID = _categoryID;
    END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS categoryFilter$$
CREATE PROCEDURE categoryFilter(IN _categoryID INT)

    BEGIN
        SELECT funkos.id, funkos.productTypeID, funkos.categoryID, funkos.exclusivity,
                funkos.urlFirstImage, funkos.urlSecondImage, funkos.price, funkos.description
        FROM funkos WHERE funkos.categoryID = _categoryID AND funkos.stock >= 1;
    END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS productTypeFilterAdmin$$
CREATE PROCEDURE productTypeFilterAdmin(IN _productTypeID INT)

    BEGIN
        SELECT funkos.id, funkos.productTypeID, funkos.categoryID, funkos.exclusivity,
                funkos.urlFirstImage, funkos.urlSecondImage, funkos.stock, funkos.price
        FROM funkos WHERE funkos.productTypeID = _productTypeID;
    END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS productTypeFilter$$
CREATE PROCEDURE productTypeFilter(IN _productTypeID INT)

    BEGIN
        SELECT funkos.id, funkos.productTypeID, funkos.categoryID, funkos.exclusivity,
                funkos.urlFirstImage, funkos.urlSecondImage, funkos.price, funkos.description
        FROM funkos WHERE funkos.productTypeID = _productTypeID AND funkos.stock >= 1;
    END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS priceFilter$$
CREATE PROCEDURE priceFilter(IN _price DOUBLE(6, 2))

    BEGIN
        SELECT funkos.id, funkos.productTypeID, funkos.categoryID, funkos.exclusivity,
                funkos.urlFirstImage, funkos.urlSecondImage, funkos.price, funkos.description
        FROM funkos WHERE funkos.price = _price AND funkos.stock >= 1;
    END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS priceFilterASC$$
CREATE PROCEDURE priceFilterASC()

    BEGIN
        SELECT funkos.id, funkos.productTypeID, funkos.categoryID, funkos.exclusivity,
                funkos.urlFirstImage, funkos.urlSecondImage, funkos.price, funkos.description
        FROM funkos ORDER BY funkos.price ASC;
    END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS priceFilterDESC$$
CREATE PROCEDURE priceFilterDESC()

    BEGIN
        SELECT funkos.id, funkos.productTypeID, funkos.categoryID, funkos.exclusivity,
                funkos.urlFirstImage, funkos.urlSecondImage, funkos.price, funkos.description
        FROM funkos ORDER BY funkos.price DESC;
    END$$
DELIMITER ;
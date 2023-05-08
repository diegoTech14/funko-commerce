USE funkoshop;

DELIMITER $$

CREATE PROCEDURE createCategory (IN _name VARCHAR(50))
    BEGIN   
        INSERT INTO categories (categoryName) VALUES (_name);
    END $$

CREATE PROCEDURE deleteCategory (IN _id INT)
    BEGIN   
        DELETE FROM categories WHERE categories.id = _id;
    END $$

CREATE PROCEDURE editCategory(IN _id INT, IN _name VARCHAR(50))
    BEGIN
        DECLARE _amount INT;
        SELECT COUNT(categories.id) INTO _amount FROM categories WHERE categories.id = _id;
        IF _amount > 0 THEN
            UPDATE categories SET
                categories.name = _name
            WHERE categories.id = _id;
        END IF;
    END $$

DELIMITER ;
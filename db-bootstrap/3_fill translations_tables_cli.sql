-- Procedures to fill `translations` and translation_language tables  

-- ANRS
DROP PROCEDURE IF EXISTS duplicate_data_anrs;
DELIMITER ;;
CREATE PROCEDURE duplicate_data_anrs ()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE j INT DEFAULT 0;
	DECLARE column_name_label_to_copy TEXT DEFAULT NULL;
	DECLARE column_name_description_to_copy TEXT DEFAULT NULL;
    DECLARE iso_from_entity TEXT DEFAULT NULL;
    DECLARE entity_table_length INT DEFAULT 0;
    
    SET entity_table_length = (SELECT COUNT(*) FROM `anrs`);
    
    WHILE i < 5 DO
        SET column_name_label_to_copy = CONCAT('label', i);
        SET column_name_description_to_copy = CONCAT('description', i);

        CASE
            WHEN i = 1 THEN SET iso_from_entity = 'FR';
            WHEN i = 2 THEN SET iso_from_entity = 'EN';
            WHEN i = 3 THEN SET iso_from_entity = 'DE';
            WHEN i = 4 THEN SET iso_from_entity = 'NL';
            ELSE
                BEGIN
                END;
        END CASE;
    
    	SET j = 0;
        WHILE j < entity_table_length DO
        
            SET @current_entity_id = (SELECT `id` FROM anrs LIMIT 1 OFFSET j);
            SET @current_entity_label_id = (SELECT `label_translation_id` FROM anrs WHERE `id` = @current_entity_id);
            SET @current_entity_description_id = (SELECT `description_translation_id` FROM anrs WHERE `id` = @current_entity_id);
            SET @entity_label_value = "";
            SET @entity_description_value = "";
            
            SET @entity_label_value_query = CONCAT('SELECT ', column_name_label_to_copy,' INTO @entity_label_value FROM `anrs` LIMIT 1 OFFSET ', j);
            PREPARE statement FROM @entity_label_value_query;
            EXECUTE statement;
            DEALLOCATE PREPARE statement;

            SET @entity_description_value_query = CONCAT('SELECT ', column_name_description_to_copy,' INTO @entity_description_value FROM `anrs` LIMIT 1 OFFSET ', j);
            PREPARE statement FROM @entity_description_value_query;
            EXECUTE statement;
            DEALLOCATE PREPARE statement;
            
            SET @queryLabel = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @entity_label_value, '\')') ;
            SET @queryDescription = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @entity_description_value, '\')') ;
            
            PREPARE statement FROM @queryLabel; 
            EXECUTE statement; 
            DEALLOCATE PREPARE statement;
            SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
            
            SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `anrs_string_id`) VALUES (', @new_translation_id ,',', @current_entity_label_id ,')');
            PREPARE statement FROM @query; 
            EXECUTE statement; 
            DEALLOCATE PREPARE statement;

            PREPARE statement FROM @queryDescription; 
            EXECUTE statement; 
            DEALLOCATE PREPARE statement;
            SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
            
            SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `anrs_string_id`) VALUES (', @new_translation_id ,',', @current_entity_description_id ,')');
            PREPARE statement FROM @query; 
            EXECUTE statement; 
            DEALLOCATE PREPARE statement;
            
            SET j = j + 1;
        END WHILE;

        SET i = i + 1;

    END WHILE;

END;;
DELIMITER ;


-- ASSETS
DROP PROCEDURE IF EXISTS duplicate_data_assets;
DELIMITER ;;
CREATE PROCEDURE `duplicate_data_assets`()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE j INT DEFAULT 0;
    DECLARE iso_from_entity TEXT DEFAULT NULL;
    DECLARE entity_table_length INT DEFAULT 0;
    
    SET entity_table_length = (SELECT COUNT(*) FROM `assets`);
    
   	SET j = 0;
   	SET iso_from_entity = 'FR';
    
    WHILE j < entity_table_length DO
    
    	SET @current_entity_id = (SELECT `id` FROM assets LIMIT 1 OFFSET j);
	    SET @current_entity_description_id = (SELECT `description_translation_id` FROM assets WHERE `id` = @current_entity_id);
    
   		SET @description_content = (SELECT `description1` FROM `assets` LIMIT 1 OFFSET j);
	    SET @description_content_replaced = REPLACE(@description_content, "'","''");
    
    	SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @description_content_replaced, '\')') ;
	    PREPARE statement FROM @query;
	    EXECUTE statement; 
	    DEALLOCATE PREPARE statement;
    
   		SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
   	
   		SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `assets_string_id`) VALUES (', @new_translation_id ,',', @current_entity_description_id ,')');
		

	   	PREPARE statement FROM @query; 
		EXECUTE statement; 
	 	DEALLOCATE PREPARE statement;
	 	
	 	SET j = j + 1;
 	
 	END WHILE;
 	
 	
	SET j = 0;
 	SET iso_from_entity = 'EN';
 	 WHILE j < entity_table_length DO
    
    	SET @current_entity_id = (SELECT `id` FROM assets LIMIT 1 OFFSET j);
	    SET @current_entity_description_id = (SELECT `description_translation_id` FROM assets WHERE `id` = @current_entity_id);
    
   		SET @description_content = (SELECT `description2` FROM `assets` LIMIT 1 OFFSET j);
	    SET @description_content_replaced = REPLACE(@description_content, "'","''");
    
    	SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @description_content_replaced, '\')') ;
	    PREPARE statement FROM @query;
	    EXECUTE statement; 
	    DEALLOCATE PREPARE statement;
    
   		SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
   	
   		SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `assets_string_id`) VALUES (', @new_translation_id ,',', @current_entity_description_id ,')');
		

	   	PREPARE statement FROM @query; 
		EXECUTE statement; 
	 	DEALLOCATE PREPARE statement;
	 	
	 	SET j = j + 1;
 	
 	END WHILE;
 	
 	
 	SET j = 0;
   	SET iso_from_entity = 'DE';
 	 WHILE j < entity_table_length DO
    
    	SET @current_entity_id = (SELECT `id` FROM assets LIMIT 1 OFFSET j);
	    SET @current_entity_description_id = (SELECT `description_translation_id` FROM assets WHERE `id` = @current_entity_id);
    
   		SET @description_content = (SELECT `description3` FROM `assets` LIMIT 1 OFFSET j);
	    SET @description_content_replaced = REPLACE(@description_content, "'","''");
    
    	SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @description_content_replaced, '\')') ;
	    PREPARE statement FROM @query;
	    EXECUTE statement; 
	    DEALLOCATE PREPARE statement;
    
   		SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
   	
   		SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `assets_string_id`) VALUES (', @new_translation_id ,',', @current_entity_description_id ,')');
		

	   	PREPARE statement FROM @query; 
		EXECUTE statement; 
	 	DEALLOCATE PREPARE statement;
	 	
	 	SET j = j + 1;
 	END WHILE;
 	
 	SET j = 0;
   	SET iso_from_entity = 'NL';
 	 WHILE j < entity_table_length DO
    
    	SET @current_entity_id = (SELECT `id` FROM assets LIMIT 1 OFFSET j);
	    SET @current_entity_description_id = (SELECT `description_translation_id` FROM assets WHERE `id` = @current_entity_id);
    
   		SET @description_content = (SELECT `description4` FROM `assets` LIMIT 1 OFFSET j);
	    SET @description_content_replaced = REPLACE(@description_content, "'","''");
    
    	SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @description_content_replaced, '\')') ;
	    PREPARE statement FROM @query;
	    EXECUTE statement; 
	    DEALLOCATE PREPARE statement;
    
   		SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
   	
   		SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `assets_string_id`) VALUES (', @new_translation_id ,',', @current_entity_description_id ,')');
		

	   	PREPARE statement FROM @query; 
		EXECUTE statement; 
	 	DEALLOCATE PREPARE statement;
	 	
	 	SET j = j + 1;
 	
 	END WHILE;
 	
 	SET j = 0;
   	SET iso_from_entity = 'FR';
 	WHILE j < entity_table_length DO
    
    	SET @current_entity_id = (SELECT `id` FROM assets LIMIT 1 OFFSET j);
	    SET @current_entity_label_id = (SELECT `label_translation_id` FROM assets WHERE `id` = @current_entity_id);
    
   		SET @label_content = (SELECT `label1` FROM `assets` LIMIT 1 OFFSET j);
	    SET @label_content_replaced = REPLACE(@label_content, "'","''");
    
    	SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @label_content_replaced, '\')') ;
	    PREPARE statement FROM @query;
	    EXECUTE statement; 
	    DEALLOCATE PREPARE statement;
    
   		SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
   	
   		SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `assets_string_id`) VALUES (', @new_translation_id ,',', @current_entity_label_id ,')');
		

	   	PREPARE statement FROM @query; 
		EXECUTE statement; 
	 	DEALLOCATE PREPARE statement;
	 	
	 	SET j = j + 1;
 	
 	END WHILE;
 	
 	
	SET j = 0;
 	SET iso_from_entity = 'EN';
 	 WHILE j < entity_table_length DO
    
    	SET @current_entity_id = (SELECT `id` FROM assets LIMIT 1 OFFSET j);
	    SET @current_entity_label_id = (SELECT `label_translation_id` FROM assets WHERE `id` = @current_entity_id);
    
   		SET @label_content = (SELECT `label2` FROM `assets` LIMIT 1 OFFSET j);
	    SET @label_content_replaced = REPLACE(@label_content, "'","''");
    
    	SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @label_content_replaced, '\')') ;
	    PREPARE statement FROM @query;
	    EXECUTE statement; 
	    DEALLOCATE PREPARE statement;
    
   		SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
   	
   		SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `assets_string_id`) VALUES (', @new_translation_id ,',', @current_entity_label_id ,')');
		

	   	PREPARE statement FROM @query; 
		EXECUTE statement; 
	 	DEALLOCATE PREPARE statement;
	 	
	 	SET j = j + 1;
 	
 	END WHILE;
 	
 	
 	SET j = 0;
   	SET iso_from_entity = 'DE';
 	 WHILE j < entity_table_length DO
    
    	SET @current_entity_id = (SELECT `id` FROM assets LIMIT 1 OFFSET j);
	    SET @current_entity_label_id = (SELECT `label_translation_id` FROM assets WHERE `id` = @current_entity_id);
    
   		SET @label_content = (SELECT `label3` FROM `assets` LIMIT 1 OFFSET j);
	    SET @label_content_replaced = REPLACE(@label_content, "'","''");
    
    	SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @label_content_replaced, '\')') ;
	    PREPARE statement FROM @query;
	    EXECUTE statement; 
	    DEALLOCATE PREPARE statement;
    
   		SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
   	
   		SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `assets_string_id`) VALUES (', @new_translation_id ,',', @current_entity_label_id ,')');
		

	   	PREPARE statement FROM @query; 
		EXECUTE statement; 
	 	DEALLOCATE PREPARE statement;
	 	
	 	SET j = j + 1;
 	END WHILE;
 	
 	SET j = 0;
   	SET iso_from_entity = 'NL';
 	 WHILE j < entity_table_length DO
    
    	SET @current_entity_id = (SELECT `id` FROM assets LIMIT 1 OFFSET j);
	    SET @current_entity_label_id = (SELECT `label_translation_id` FROM assets WHERE `id` = @current_entity_id);
    
   		SET @label_content = (SELECT `label4` FROM `assets` LIMIT 1 OFFSET j);
	    SET @label_content_replaced = REPLACE(@label_content, "'","''");
    
    	SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @label_content_replaced, '\')') ;
	    PREPARE statement FROM @query;
	    EXECUTE statement; 
	    DEALLOCATE PREPARE statement;
    
   		SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
   	
   		SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `assets_string_id`) VALUES (', @new_translation_id ,',', @current_entity_label_id ,')');
		

	   	PREPARE statement FROM @query; 
		EXECUTE statement; 
	 	DEALLOCATE PREPARE statement;
	 	
	 	SET j = j + 1;
 	
 	END WHILE;

END;;
DELIMITER ;

-- GUIDES
DROP PROCEDURE IF EXISTS duplicate_data_guides;

-- GUIDES_ITEMS
DROP PROCEDURE IF EXISTS duplicate_data_guides_items;

-- MEASURES
DROP PROCEDURE IF EXISTS duplicate_data_measures;
DELIMITER ;;
CREATE PROCEDURE `duplicate_data_measures`()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE j INT DEFAULT 0;
    DECLARE iso_from_entity TEXT DEFAULT NULL;
    DECLARE entity_table_length INT DEFAULT 0;
    
    SET entity_table_length = (SELECT COUNT(*) FROM `measures`);
    
   	SET j = 0;
   	SET iso_from_entity = 'FR';
    
    WHILE j < entity_table_length DO
    
    	SET @current_entity_id = (SELECT `id` FROM measures LIMIT 1 OFFSET j);
	    SET @current_entity_description_id = (SELECT `description_translation_id` FROM measures WHERE `id` = @current_entity_id);
    
   		SET @description_content = (SELECT `description1` FROM `measures` LIMIT 1 OFFSET j);
	    SET @description_content_replaced = REPLACE(@description_content, "'","''");
    
    	SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @description_content_replaced, '\')') ;
	    PREPARE statement FROM @query;
	    EXECUTE statement; 
	    DEALLOCATE PREPARE statement;
    
   		SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
   	
   		SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `measures_string_id`) VALUES (', @new_translation_id ,',', @current_entity_description_id ,')');
		

	   	PREPARE statement FROM @query; 
		EXECUTE statement; 
	 	DEALLOCATE PREPARE statement;
	 	
	 	SET j = j + 1;
 	
 	END WHILE;
 	
 	
	SET j = 0;
 	SET iso_from_entity = 'EN';
 	 WHILE j < entity_table_length DO
    
    	SET @current_entity_id = (SELECT `id` FROM measures LIMIT 1 OFFSET j);
	    SET @current_entity_description_id = (SELECT `description_translation_id` FROM measures WHERE `id` = @current_entity_id);
    
   		SET @description_content = (SELECT `description2` FROM `measures` LIMIT 1 OFFSET j);
	    SET @description_content_replaced = REPLACE(@description_content, "'","''");
    
    	SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @description_content_replaced, '\')') ;
	    PREPARE statement FROM @query;
	    EXECUTE statement; 
	    DEALLOCATE PREPARE statement;
    
   		SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
   	
   		SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `measures_string_id`) VALUES (', @new_translation_id ,',', @current_entity_description_id ,')');
		

	   	PREPARE statement FROM @query; 
		EXECUTE statement; 
	 	DEALLOCATE PREPARE statement;
	 	
	 	SET j = j + 1;
 	
 	END WHILE;
 	
 	
 	SET j = 0;
   	SET iso_from_entity = 'DE';
 	 WHILE j < entity_table_length DO
    
    	SET @current_entity_id = (SELECT `id` FROM measures LIMIT 1 OFFSET j);
	    SET @current_entity_description_id = (SELECT `description_translation_id` FROM measures WHERE `id` = @current_entity_id);
    
   		SET @description_content = (SELECT `description3` FROM `measures` LIMIT 1 OFFSET j);
	    SET @description_content_replaced = REPLACE(@description_content, "'","''");
    
    	SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @description_content_replaced, '\')') ;
	    PREPARE statement FROM @query;
	    EXECUTE statement; 
	    DEALLOCATE PREPARE statement;
    
   		SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
   	
   		SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `measures_string_id`) VALUES (', @new_translation_id ,',', @current_entity_description_id ,')');
		

	   	PREPARE statement FROM @query; 
		EXECUTE statement; 
	 	DEALLOCATE PREPARE statement;
	 	
	 	SET j = j + 1;
 	END WHILE;
 	
 	SET j = 0;
   	SET iso_from_entity = 'NL';
 	 WHILE j < entity_table_length DO
    
    	SET @current_entity_id = (SELECT `id` FROM measures LIMIT 1 OFFSET j);
	    SET @current_entity_description_id = (SELECT `description_translation_id` FROM measures WHERE `id` = @current_entity_id);
    
   		SET @description_content = (SELECT `description4` FROM `measures` LIMIT 1 OFFSET j);
	    SET @description_content_replaced = REPLACE(@description_content, "'","''");
    
    	SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @description_content_replaced, '\')') ;
	    PREPARE statement FROM @query;
	    EXECUTE statement; 
	    DEALLOCATE PREPARE statement;
    
   		SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
   	
   		SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `measures_string_id`) VALUES (', @new_translation_id ,',', @current_entity_description_id ,')');
		

	   	PREPARE statement FROM @query; 
		EXECUTE statement; 
	 	DEALLOCATE PREPARE statement;
	 	
	 	SET j = j + 1;
 	
 	END WHILE;
END;;
DELIMITER ;

-- MODELS
DROP PROCEDURE IF EXISTS fill_models_data;

-- OBJECTS
DROP PROCEDURE IF EXISTS duplicate_data_objects;
DELIMITER ;;
CREATE PROCEDURE `duplicate_data_objects`()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE j INT DEFAULT 0;
    DECLARE iso_from_entity TEXT DEFAULT NULL;
    DECLARE entity_table_length INT DEFAULT 0;
    
    SET entity_table_length = (SELECT COUNT(*) FROM `objects`);
    
   	SET j = 0;
   	SET iso_from_entity = 'FR';
    
    WHILE j < entity_table_length DO
    
    	SET @current_entity_id = (SELECT `id` FROM objects LIMIT 1 OFFSET j);
	    SET @current_entity_name_id = (SELECT `name_translation_id` FROM objects WHERE `id` = @current_entity_id);
    
   		SET @name_content = (SELECT `name1` FROM `objects` LIMIT 1 OFFSET j);
	    SET @name_content_replaced = REPLACE(@name_content, "'","''");
    
    	SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @name_content_replaced, '\')') ;
	    PREPARE statement FROM @query;
	    EXECUTE statement; 
	    DEALLOCATE PREPARE statement;
    
   		SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
   	
   		SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `objects_string_id`) VALUES (', @new_translation_id ,',', @current_entity_name_id ,')');
		

	   	PREPARE statement FROM @query; 
		EXECUTE statement; 
	 	DEALLOCATE PREPARE statement;
	 	
	 	SET j = j + 1;
 	
 	END WHILE;
 	
 	
	SET j = 0;
 	SET iso_from_entity = 'EN';
 	 WHILE j < entity_table_length DO
    
    	SET @current_entity_id = (SELECT `id` FROM objects LIMIT 1 OFFSET j);
	    SET @current_entity_name_id = (SELECT `name_translation_id` FROM objects WHERE `id` = @current_entity_id);
    
   		SET @name_content = (SELECT `name2` FROM `objects` LIMIT 1 OFFSET j);
	    SET @name_content_replaced = REPLACE(@name_content, "'","''");
    
    	SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @name_content_replaced, '\')') ;
	    PREPARE statement FROM @query;
	    EXECUTE statement; 
	    DEALLOCATE PREPARE statement;
    
   		SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
   	
   		SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `objects_string_id`) VALUES (', @new_translation_id ,',', @current_entity_name_id ,')');
		

	   	PREPARE statement FROM @query; 
		EXECUTE statement; 
	 	DEALLOCATE PREPARE statement;
	 	
	 	SET j = j + 1;
 	
 	END WHILE;
 	
 	
 	SET j = 0;
   	SET iso_from_entity = 'DE';
 	 WHILE j < entity_table_length DO
    
    	SET @current_entity_id = (SELECT `id` FROM objects LIMIT 1 OFFSET j);
	    SET @current_entity_name_id = (SELECT `name_translation_id` FROM objects WHERE `id` = @current_entity_id);
    
   		SET @name_content = (SELECT `name3` FROM `objects` LIMIT 1 OFFSET j);
	    SET @name_content_replaced = REPLACE(@name_content, "'","''");
    
    	SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @name_content_replaced, '\')') ;
	    PREPARE statement FROM @query;
	    EXECUTE statement; 
	    DEALLOCATE PREPARE statement;
    
   		SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
   	
   		SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `objects_string_id`) VALUES (', @new_translation_id ,',', @current_entity_name_id ,')');
		

	   	PREPARE statement FROM @query; 
		EXECUTE statement; 
	 	DEALLOCATE PREPARE statement;
	 	
	 	SET j = j + 1;
 	END WHILE;
 	
 	SET j = 0;
   	SET iso_from_entity = 'NL';
 	 WHILE j < entity_table_length DO
    
    	SET @current_entity_id = (SELECT `id` FROM objects LIMIT 1 OFFSET j);
	    SET @current_entity_name_id = (SELECT `name_translation_id` FROM objects WHERE `id` = @current_entity_id);
    
   		SET @name_content = (SELECT `name4` FROM `objects` LIMIT 1 OFFSET j);
	    SET @name_content_replaced = REPLACE(@name_content, "'","''");
    
    	SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @name_content_replaced, '\')') ;
	    PREPARE statement FROM @query;
	    EXECUTE statement; 
	    DEALLOCATE PREPARE statement;
    
   		SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
   	
   		SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `objects_string_id`) VALUES (', @new_translation_id ,',', @current_entity_name_id ,')');
		

	   	PREPARE statement FROM @query; 
		EXECUTE statement; 
	 	DEALLOCATE PREPARE statement;
	 	
	 	SET j = j + 1;
 	
 	END WHILE;
 	
 	SET j = 0;
   	SET iso_from_entity = 'FR';
 	WHILE j < entity_table_length DO
    
    	SET @current_entity_id = (SELECT `id` FROM objects LIMIT 1 OFFSET j);
	    SET @current_entity_label_id = (SELECT `label_translation_id` FROM objects WHERE `id` = @current_entity_id);
    
   		SET @label_content = (SELECT `label1` FROM `objects` LIMIT 1 OFFSET j);
	    SET @label_content_replaced = REPLACE(@label_content, "'","''");
    
    	SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @label_content_replaced, '\')') ;
	    PREPARE statement FROM @query;
	    EXECUTE statement; 
	    DEALLOCATE PREPARE statement;
    
   		SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
   	
   		SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `objects_string_id`) VALUES (', @new_translation_id ,',', @current_entity_label_id ,')');
		

	   	PREPARE statement FROM @query; 
		EXECUTE statement; 
	 	DEALLOCATE PREPARE statement;
	 	
	 	SET j = j + 1;
 	
 	END WHILE;
 	
 	
	SET j = 0;
 	SET iso_from_entity = 'EN';
 	 WHILE j < entity_table_length DO
    
    	SET @current_entity_id = (SELECT `id` FROM objects LIMIT 1 OFFSET j);
	    SET @current_entity_label_id = (SELECT `label_translation_id` FROM objects WHERE `id` = @current_entity_id);
    
   		SET @label_content = (SELECT `label2` FROM `objects` LIMIT 1 OFFSET j);
	    SET @label_content_replaced = REPLACE(@label_content, "'","''");
    
    	SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @label_content_replaced, '\')') ;
	    PREPARE statement FROM @query;
	    EXECUTE statement; 
	    DEALLOCATE PREPARE statement;
    
   		SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
   	
   		SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `objects_string_id`) VALUES (', @new_translation_id ,',', @current_entity_label_id ,')');
		

	   	PREPARE statement FROM @query; 
		EXECUTE statement; 
	 	DEALLOCATE PREPARE statement;
	 	
	 	SET j = j + 1;
 	
 	END WHILE;
 	
 	
 	SET j = 0;
   	SET iso_from_entity = 'DE';
 	 WHILE j < entity_table_length DO
    
    	SET @current_entity_id = (SELECT `id` FROM objects LIMIT 1 OFFSET j);
	    SET @current_entity_label_id = (SELECT `label_translation_id` FROM objects WHERE `id` = @current_entity_id);
    
   		SET @label_content = (SELECT `label3` FROM `objects` LIMIT 1 OFFSET j);
	    SET @label_content_replaced = REPLACE(@label_content, "'","''");
    
    	SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @label_content_replaced, '\')') ;
	    PREPARE statement FROM @query;
	    EXECUTE statement; 
	    DEALLOCATE PREPARE statement;
    
   		SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
   	
   		SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `objects_string_id`) VALUES (', @new_translation_id ,',', @current_entity_label_id ,')');
		

	   	PREPARE statement FROM @query; 
		EXECUTE statement; 
	 	DEALLOCATE PREPARE statement;
	 	
	 	SET j = j + 1;
 	END WHILE;
 	
 	SET j = 0;
   	SET iso_from_entity = 'NL';
 	 WHILE j < entity_table_length DO
    
    	SET @current_entity_id = (SELECT `id` FROM objects LIMIT 1 OFFSET j);
	    SET @current_entity_label_id = (SELECT `label_translation_id` FROM objects WHERE `id` = @current_entity_id);
    
   		SET @label_content = (SELECT `label4` FROM `objects` LIMIT 1 OFFSET j);
	    SET @label_content_replaced = REPLACE(@label_content, "'","''");
    
    	SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @label_content_replaced, '\')') ;
	    PREPARE statement FROM @query;
	    EXECUTE statement; 
	    DEALLOCATE PREPARE statement;
    
   		SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
   	
   		SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `objects_string_id`) VALUES (', @new_translation_id ,',', @current_entity_label_id ,')');
		

	   	PREPARE statement FROM @query; 
		EXECUTE statement; 
	 	DEALLOCATE PREPARE statement;
	 	
	 	SET j = j + 1;
 	
 	END WHILE;

END;;
DELIMITER ;

-- OBJECTS_CATEGORIES
DROP PROCEDURE IF EXISTS duplicate_data_objects_categories;
DELIMITER ;;
CREATE PROCEDURE duplicate_data_objects_categories ()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE j INT DEFAULT 0;
	DECLARE column_name_to_copy TEXT DEFAULT NULL;
    DECLARE iso_from_entity TEXT DEFAULT NULL;
    DECLARE entity_table_length INT DEFAULT 0;
    
    SET entity_table_length = (SELECT COUNT(*) FROM `objects_categories`);
    
    WHILE i < 5 DO
        SET column_name_to_copy = CONCAT('label', i);

        CASE
            WHEN i = 1 THEN SET iso_from_entity = 'FR';
            WHEN i = 2 THEN SET iso_from_entity = 'EN';
            WHEN i = 3 THEN SET iso_from_entity = 'DE';
            WHEN i = 4 THEN SET iso_from_entity = 'NL';
            ELSE
                BEGIN
                END;
        END CASE;
    
    	SET j = 0;
        WHILE j < entity_table_length DO
        
            SET @current_entity_id = (SELECT `id` FROM objects_categories LIMIT 1 OFFSET j);
            SET @current_entity_label_id = (SELECT `label_translation_id` FROM objects_categories WHERE `id` = @current_entity_id);
            SET @entity_label_value = "";
            
            SET @entity_label_value_query = CONCAT('SELECT ', column_name_to_copy,' INTO @entity_label_value FROM `objects_categories` LIMIT 1 OFFSET ', j);
            PREPARE statement FROM @entity_label_value_query;
            EXECUTE statement;
            DEALLOCATE PREPARE statement;
                                
            SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @entity_label_value, '\')') ;
            
            PREPARE statement FROM @query; 
            EXECUTE statement; 
            DEALLOCATE PREPARE statement;
            
            SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
            
            SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `objects_categories_string_id`) VALUES (', @new_translation_id ,',', @current_entity_label_id ,')');
            
            PREPARE statement FROM @query; 
            EXECUTE statement; 
            DEALLOCATE PREPARE statement;
            
            SET j = j + 1;
        END WHILE;

        SET i = i + 1;

    END WHILE;

END;;
DELIMITER ;

-- QUESTIONS
DROP PROCEDURE IF EXISTS duplicate_data_questions;
DELIMITER ;;
CREATE PROCEDURE `duplicate_data_questions`()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE j INT DEFAULT 0;
    DECLARE iso_from_entity TEXT DEFAULT NULL;
    DECLARE entity_table_length INT DEFAULT 0;
    
    SET entity_table_length = (SELECT COUNT(*) FROM `questions`);
    
   	SET j = 0;
   	SET iso_from_entity = 'FR';
    
    WHILE j < entity_table_length DO
    
    	SET @current_entity_id = (SELECT `id` FROM questions LIMIT 1 OFFSET j);
	    SET @current_entity_label_id = (SELECT `label_translation_id` FROM questions WHERE `id` = @current_entity_id);
    
   		SET @label_content = (SELECT `label1` FROM `questions` LIMIT 1 OFFSET j);
	    SET @label_content_replaced = REPLACE(@label_content, "'","''");
    
    	SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @label_content_replaced, '\')') ;
	    PREPARE statement FROM @query;
	    EXECUTE statement; 
	    DEALLOCATE PREPARE statement;
    
   		SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
   	
   		SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `questions_string_id`) VALUES (', @new_translation_id ,',', @current_entity_label_id ,')');
		

	   	PREPARE statement FROM @query; 
		EXECUTE statement; 
	 	DEALLOCATE PREPARE statement;
	 	
	 	SET j = j + 1;
 	
 	END WHILE;
 	
 	
	SET j = 0;
 	SET iso_from_entity = 'EN';
 	 WHILE j < entity_table_length DO
    
    	SET @current_entity_id = (SELECT `id` FROM questions LIMIT 1 OFFSET j);
	    SET @current_entity_label_id = (SELECT `label_translation_id` FROM questions WHERE `id` = @current_entity_id);
    
   		SET @label_content = (SELECT `label2` FROM `questions` LIMIT 1 OFFSET j);
	    SET @label_content_replaced = REPLACE(@label_content, "'","''");
    
    	SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @label_content_replaced, '\')') ;
	    PREPARE statement FROM @query;
	    EXECUTE statement; 
	    DEALLOCATE PREPARE statement;
    
   		SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
   	
   		SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `questions_string_id`) VALUES (', @new_translation_id ,',', @current_entity_label_id ,')');
		

	   	PREPARE statement FROM @query; 
		EXECUTE statement; 
	 	DEALLOCATE PREPARE statement;
	 	
	 	SET j = j + 1;
 	
 	END WHILE;
 	
 	
 	SET j = 0;
   	SET iso_from_entity = 'DE';
 	 WHILE j < entity_table_length DO
    
    	SET @current_entity_id = (SELECT `id` FROM questions LIMIT 1 OFFSET j);
	    SET @current_entity_label_id = (SELECT `label_translation_id` FROM questions WHERE `id` = @current_entity_id);
    
   		SET @label_content = (SELECT `label3` FROM `questions` LIMIT 1 OFFSET j);
	    SET @label_content_replaced = REPLACE(@label_content, "'","''");
    
    	SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @label_content_replaced, '\')') ;
	    PREPARE statement FROM @query;
	    EXECUTE statement; 
	    DEALLOCATE PREPARE statement;
    
   		SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
   	
   		SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `questions_string_id`) VALUES (', @new_translation_id ,',', @current_entity_label_id ,')');
		

	   	PREPARE statement FROM @query; 
		EXECUTE statement; 
	 	DEALLOCATE PREPARE statement;
	 	
	 	SET j = j + 1;
 	END WHILE;
 	
 	SET j = 0;
   	SET iso_from_entity = 'NL';
 	 WHILE j < entity_table_length DO
    
    	SET @current_entity_id = (SELECT `id` FROM questions LIMIT 1 OFFSET j);
	    SET @current_entity_label_id = (SELECT `label_translation_id` FROM questions WHERE `id` = @current_entity_id);
    
   		SET @label_content = (SELECT `label4` FROM `questions` LIMIT 1 OFFSET j);
	    SET @label_content_replaced = REPLACE(@label_content, "'","''");
    
    	SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @label_content_replaced, '\')') ;
	    PREPARE statement FROM @query;
	    EXECUTE statement; 
	    DEALLOCATE PREPARE statement;
    
   		SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
   	
   		SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `questions_string_id`) VALUES (', @new_translation_id ,',', @current_entity_label_id ,')');
		

	   	PREPARE statement FROM @query; 
		EXECUTE statement; 
	 	DEALLOCATE PREPARE statement;
	 	
	 	SET j = j + 1;
 	
 	END WHILE;
END;;
DELIMITER ;

-- QUESTIONS_CHOICES
DROP PROCEDURE IF EXISTS duplicate_data_questions_choices;
DELIMITER ;;
CREATE PROCEDURE duplicate_data_questions_choices ()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE j INT DEFAULT 0;
	DECLARE column_name_to_copy TEXT DEFAULT NULL;
    DECLARE iso_from_entity TEXT DEFAULT NULL;
    DECLARE entity_table_length INT DEFAULT 0;
    
    SET entity_table_length = (SELECT COUNT(*) FROM `questions_choices`);
    
    WHILE i < 5 DO
        SET column_name_to_copy = CONCAT('label', i);

        CASE
            WHEN i = 1 THEN SET iso_from_entity = 'FR';
            WHEN i = 2 THEN SET iso_from_entity = 'EN';
            WHEN i = 3 THEN SET iso_from_entity = 'DE';
            WHEN i = 4 THEN SET iso_from_entity = 'NL';
            ELSE
                BEGIN
                END;
        END CASE;
    
    	SET j = 0;
        WHILE j < entity_table_length DO
        
            SET @current_entity_id = (SELECT `id` FROM questions_choices LIMIT 1 OFFSET j);
            SET @current_entity_label_id = (SELECT `label_translation_id` FROM questions_choices WHERE `id` = @current_entity_id);
            SET @entity_label_value = "";
            
            SET @entity_label_value_query = CONCAT('SELECT ', column_name_to_copy,' INTO @entity_label_value FROM `questions_choices` LIMIT 1 OFFSET ', j);
            PREPARE statement FROM @entity_label_value_query;
            EXECUTE statement;
            DEALLOCATE PREPARE statement;
                                
            SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @entity_label_value, '\')') ;
            
            PREPARE statement FROM @query; 
            EXECUTE statement; 
            DEALLOCATE PREPARE statement;
            
            SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
            
            SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `questions_choices_string_id`) VALUES (', @new_translation_id ,',', @current_entity_label_id ,')');
            
            PREPARE statement FROM @query; 
            EXECUTE statement; 
            DEALLOCATE PREPARE statement;
            
            SET j = j + 1;
        END WHILE;

        SET i = i + 1;

    END WHILE;

END;;
DELIMITER ;

-- ROLF_RISKS
DROP PROCEDURE IF EXISTS duplicate_data_rolf_risks;
DELIMITER ;;
CREATE PROCEDURE `duplicate_data_rolf_risks`()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE j INT DEFAULT 0;
    DECLARE iso_from_entity TEXT DEFAULT NULL;
    DECLARE entity_table_length INT DEFAULT 0;
    
    SET entity_table_length = (SELECT COUNT(*) FROM `rolf_risks`);
    
   	SET j = 0;
   	SET iso_from_entity = 'FR';
    
    WHILE j < entity_table_length DO
    
    	SET @current_entity_id = (SELECT `id` FROM rolf_risks LIMIT 1 OFFSET j);
	    SET @current_entity_description_id = (SELECT `description_translation_id` FROM rolf_risks WHERE `id` = @current_entity_id);
    
   		SET @description_content = (SELECT `description1` FROM `rolf_risks` LIMIT 1 OFFSET j);
	    SET @description_content_replaced = REPLACE(@description_content, "'","''");
    
    	IF @description_content_replaced IS NULL THEN 
			SET @query = CONCAT('INSERT INTO `translations`(`ISO`) VALUES (\'', iso_from_entity ,'\')') ;
		ELSE 
			SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @description_content_replaced, '\')') ;
		END IF; 
	    PREPARE statement FROM @query;
	    EXECUTE statement; 
	    DEALLOCATE PREPARE statement;
    
   		SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
   	
   		SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `rolf_risks_string_id`) VALUES (', @new_translation_id ,',', @current_entity_description_id ,')');
		

	   	PREPARE statement FROM @query; 
		EXECUTE statement; 
	 	DEALLOCATE PREPARE statement;
	 	
	 	SET j = j + 1;
 	
 	END WHILE;
 	
 	
	SET j = 0;
 	SET iso_from_entity = 'EN';
 	 WHILE j < entity_table_length DO
    
    	SET @current_entity_id = (SELECT `id` FROM rolf_risks LIMIT 1 OFFSET j);
	    SET @current_entity_description_id = (SELECT `description_translation_id` FROM rolf_risks WHERE `id` = @current_entity_id);
    
   		SET @description_content = (SELECT `description2` FROM `rolf_risks` LIMIT 1 OFFSET j);
	    SET @description_content_replaced = REPLACE(@description_content, "'","''");
    
    	IF @description_content_replaced IS NULL THEN 
			SET @query = CONCAT('INSERT INTO `translations`(`ISO`) VALUES (\'', iso_from_entity ,'\')') ;
		ELSE 
			SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @description_content_replaced, '\')') ;
		END IF; 
    
	    PREPARE statement FROM @query;
	    EXECUTE statement; 
	    DEALLOCATE PREPARE statement;
    
   		SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
   	
   		SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `rolf_risks_string_id`) VALUES (', @new_translation_id ,',', @current_entity_description_id ,')');
		

	   	PREPARE statement FROM @query; 
		EXECUTE statement; 
	 	DEALLOCATE PREPARE statement;
	 	
	 	SET j = j + 1;
 	
 	END WHILE;
 	
 	
 	SET j = 0;
   	SET iso_from_entity = 'DE';
 	 WHILE j < entity_table_length DO
    
    	SET @current_entity_id = (SELECT `id` FROM rolf_risks LIMIT 1 OFFSET j);
	    SET @current_entity_description_id = (SELECT `description_translation_id` FROM rolf_risks WHERE `id` = @current_entity_id);
    
   		SET @description_content = (SELECT `description3` FROM `rolf_risks` LIMIT 1 OFFSET j);
	    SET @description_content_replaced = REPLACE(@description_content, "'","''");
    
    	IF @description_content_replaced IS NULL THEN 
			SET @query = CONCAT('INSERT INTO `translations`(`ISO`) VALUES (\'', iso_from_entity ,'\')') ;
		ELSE 
			SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @description_content_replaced, '\')') ;
		END IF; 
		
	    PREPARE statement FROM @query;
	    EXECUTE statement; 
	    DEALLOCATE PREPARE statement;
    
   		SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
   	
   		SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `rolf_risks_string_id`) VALUES (', @new_translation_id ,',', @current_entity_description_id ,')');
		

	   	PREPARE statement FROM @query; 
		EXECUTE statement; 
	 	DEALLOCATE PREPARE statement;
	 	
	 	SET j = j + 1;
 	END WHILE;
 	
 	SET j = 0;
   	SET iso_from_entity = 'NL';
 	 WHILE j < entity_table_length DO
    
    	SET @current_entity_id = (SELECT `id` FROM rolf_risks LIMIT 1 OFFSET j);
	    SET @current_entity_description_id = (SELECT `description_translation_id` FROM rolf_risks WHERE `id` = @current_entity_id);
    
   		SET @description_content = (SELECT `description4` FROM `rolf_risks` LIMIT 1 OFFSET j);
	    SET @description_content_replaced = REPLACE(@description_content, "'","''");
    
    	IF @description_content_replaced IS NULL THEN 
			SET @query = CONCAT('INSERT INTO `translations`(`ISO`) VALUES (\'', iso_from_entity ,'\')') ;
		ELSE 
			SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @description_content_replaced, '\')') ;
		END IF;
		
	    PREPARE statement FROM @query;
	    EXECUTE statement; 
	    DEALLOCATE PREPARE statement;
    
   		SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
   	
   		SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `rolf_risks_string_id`) VALUES (', @new_translation_id ,',', @current_entity_description_id ,')');
		

	   	PREPARE statement FROM @query; 
		EXECUTE statement; 
	 	DEALLOCATE PREPARE statement;
	 	
	 	SET j = j + 1;
 	
 	END WHILE;
 	
 	SET j = 0;
   	SET iso_from_entity = 'FR';
 	WHILE j < entity_table_length DO
    
    	SET @current_entity_id = (SELECT `id` FROM rolf_risks LIMIT 1 OFFSET j);
	    SET @current_entity_label_id = (SELECT `label_translation_id` FROM rolf_risks WHERE `id` = @current_entity_id);
    
   		SET @label_content = (SELECT `label1` FROM `rolf_risks` LIMIT 1 OFFSET j);
	    SET @label_content_replaced = REPLACE(@label_content, "'","''");
    
    	IF @label_content_replaced IS NULL THEN 
			SET @query = CONCAT('INSERT INTO `translations`(`ISO`) VALUES (\'', iso_from_entity ,'\')') ;
		ELSE 
			SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @label_content_replaced, '\')') ;
		END IF;
	    PREPARE statement FROM @query;
	    EXECUTE statement; 
	    DEALLOCATE PREPARE statement;
    
   		SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
   	
   		SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `rolf_risks_string_id`) VALUES (', @new_translation_id ,',', @current_entity_label_id ,')');
		

	   	PREPARE statement FROM @query; 
		EXECUTE statement; 
	 	DEALLOCATE PREPARE statement;
	 	
	 	SET j = j + 1;
 	
 	END WHILE;
 	
 	
	SET j = 0;
 	SET iso_from_entity = 'EN';
 	 WHILE j < entity_table_length DO
    
    	SET @current_entity_id = (SELECT `id` FROM rolf_risks LIMIT 1 OFFSET j);
	    SET @current_entity_label_id = (SELECT `label_translation_id` FROM rolf_risks WHERE `id` = @current_entity_id);
    
   		SET @label_content = (SELECT `label2` FROM `rolf_risks` LIMIT 1 OFFSET j);
	    SET @label_content_replaced = REPLACE(@label_content, "'","''");
    
    	IF @label_content_replaced IS NULL THEN 
			SET @query = CONCAT('INSERT INTO `translations`(`ISO`) VALUES (\'', iso_from_entity ,'\')') ;
		ELSE 
			SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @label_content_replaced, '\')') ;
		END IF;
	    PREPARE statement FROM @query;
	    EXECUTE statement; 
	    DEALLOCATE PREPARE statement;
    
   		SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
   	
   		SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `rolf_risks_string_id`) VALUES (', @new_translation_id ,',', @current_entity_label_id ,')');
		

	   	PREPARE statement FROM @query; 
		EXECUTE statement; 
	 	DEALLOCATE PREPARE statement;
	 	
	 	SET j = j + 1;
 	
 	END WHILE;
 	
 	
 	SET j = 0;
   	SET iso_from_entity = 'DE';
 	 WHILE j < entity_table_length DO
    
    	SET @current_entity_id = (SELECT `id` FROM rolf_risks LIMIT 1 OFFSET j);
	    SET @current_entity_label_id = (SELECT `label_translation_id` FROM rolf_risks WHERE `id` = @current_entity_id);
    
   		SET @label_content = (SELECT `label3` FROM `rolf_risks` LIMIT 1 OFFSET j);
	    SET @label_content_replaced = REPLACE(@label_content, "'","''");
    
		IF @label_content_replaced IS NULL THEN 
			SET @query = CONCAT('INSERT INTO `translations`(`ISO`) VALUES (\'', iso_from_entity ,'\')') ;
		ELSE 
			SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @label_content_replaced, '\')') ;
		END IF;
	    PREPARE statement FROM @query;
	    EXECUTE statement; 
	    DEALLOCATE PREPARE statement;
    
   		SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
   	
   		SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `rolf_risks_string_id`) VALUES (', @new_translation_id ,',', @current_entity_label_id ,')');
		

	   	PREPARE statement FROM @query; 
		EXECUTE statement; 
	 	DEALLOCATE PREPARE statement;
	 	
	 	SET j = j + 1;
 	END WHILE;
 	
 	SET j = 0;
   	SET iso_from_entity = 'NL';
 	 WHILE j < entity_table_length DO
    
    	SET @current_entity_id = (SELECT `id` FROM rolf_risks LIMIT 1 OFFSET j);
	    SET @current_entity_label_id = (SELECT `label_translation_id` FROM rolf_risks WHERE `id` = @current_entity_id);
    
   		SET @label_content = (SELECT `label4` FROM `rolf_risks` LIMIT 1 OFFSET j);
	    SET @label_content_replaced = REPLACE(@label_content, "'","''");
    
		IF @label_content_replaced IS NULL THEN 
			SET @query = CONCAT('INSERT INTO `translations`(`ISO`) VALUES (\'', iso_from_entity ,'\')') ;
		ELSE 
			SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @label_content_replaced, '\')') ;
		END IF;
	    PREPARE statement FROM @query;
	    EXECUTE statement; 
	    DEALLOCATE PREPARE statement;
    
   		SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
   	
   		SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `rolf_risks_string_id`) VALUES (', @new_translation_id ,',', @current_entity_label_id ,')');
		

	   	PREPARE statement FROM @query; 
		EXECUTE statement; 
	 	DEALLOCATE PREPARE statement;
	 	
	 	SET j = j + 1;
 	
 	END WHILE;

END;;
DELIMITER ;

-- ROLF_TAGS
DROP PROCEDURE IF EXISTS duplicate_data_rolf_tags;
DELIMITER ;;
CREATE PROCEDURE `duplicate_data_rolf_tags`()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE j INT DEFAULT 0;
    DECLARE iso_from_entity TEXT DEFAULT NULL;
    DECLARE entity_table_length INT DEFAULT 0;
    
    SET entity_table_length = (SELECT COUNT(*) FROM `rolf_tags`);
    
   	SET j = 0;
   	SET iso_from_entity = 'FR';
    
    WHILE j < entity_table_length DO
    
    	SET @current_entity_id = (SELECT `id` FROM rolf_tags LIMIT 1 OFFSET j);
	    SET @current_entity_label_id = (SELECT `label_translation_id` FROM rolf_tags WHERE `id` = @current_entity_id);
    
   		SET @label_content = (SELECT `label1` FROM `rolf_tags` LIMIT 1 OFFSET j);
	    SET @label_content_replaced = REPLACE(@label_content, "'","''");
    
    	SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @label_content_replaced, '\')') ;
	    PREPARE statement FROM @query;
	    EXECUTE statement; 
	    DEALLOCATE PREPARE statement;
    
   		SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
   	
   		SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `rolf_tags_string_id`) VALUES (', @new_translation_id ,',', @current_entity_label_id ,')');
		

	   	PREPARE statement FROM @query; 
		EXECUTE statement; 
	 	DEALLOCATE PREPARE statement;
	 	
	 	SET j = j + 1;
 	
 	END WHILE;
 	
 	
	SET j = 0;
 	SET iso_from_entity = 'EN';
 	 WHILE j < entity_table_length DO
    
    	SET @current_entity_id = (SELECT `id` FROM rolf_tags LIMIT 1 OFFSET j);
	    SET @current_entity_label_id = (SELECT `label_translation_id` FROM rolf_tags WHERE `id` = @current_entity_id);
    
   		SET @label_content = (SELECT `label2` FROM `rolf_tags` LIMIT 1 OFFSET j);
	    SET @label_content_replaced = REPLACE(@label_content, "'","''");
    
    	SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @label_content_replaced, '\')') ;
	    PREPARE statement FROM @query;
	    EXECUTE statement; 
	    DEALLOCATE PREPARE statement;
    
   		SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
   	
   		SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `rolf_tags_string_id`) VALUES (', @new_translation_id ,',', @current_entity_label_id ,')');
		

	   	PREPARE statement FROM @query; 
		EXECUTE statement; 
	 	DEALLOCATE PREPARE statement;
	 	
	 	SET j = j + 1;
 	
 	END WHILE;
 	
 	
 	SET j = 0;
   	SET iso_from_entity = 'DE';
 	 WHILE j < entity_table_length DO
    
    	SET @current_entity_id = (SELECT `id` FROM rolf_tags LIMIT 1 OFFSET j);
	    SET @current_entity_label_id = (SELECT `label_translation_id` FROM rolf_tags WHERE `id` = @current_entity_id);
    
   		SET @label_content = (SELECT `label3` FROM `rolf_tags` LIMIT 1 OFFSET j);
	    SET @label_content_replaced = REPLACE(@label_content, "'","''");
    
    	SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @label_content_replaced, '\')') ;
	    PREPARE statement FROM @query;
	    EXECUTE statement; 
	    DEALLOCATE PREPARE statement;
    
   		SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
   	
   		SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `rolf_tags_string_id`) VALUES (', @new_translation_id ,',', @current_entity_label_id ,')');
		

	   	PREPARE statement FROM @query; 
		EXECUTE statement; 
	 	DEALLOCATE PREPARE statement;
	 	
	 	SET j = j + 1;
 	END WHILE;
 	
 	SET j = 0;
   	SET iso_from_entity = 'NL';
 	 WHILE j < entity_table_length DO
    
    	SET @current_entity_id = (SELECT `id` FROM rolf_tags LIMIT 1 OFFSET j);
	    SET @current_entity_label_id = (SELECT `label_translation_id` FROM rolf_tags WHERE `id` = @current_entity_id);
    
   		SET @label_content = (SELECT `label4` FROM `rolf_tags` LIMIT 1 OFFSET j);
	    SET @label_content_replaced = REPLACE(@label_content, "'","''");
    
    	SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @label_content_replaced, '\')') ;
	    PREPARE statement FROM @query;
	    EXECUTE statement; 
	    DEALLOCATE PREPARE statement;
    
   		SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
   	
   		SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `rolf_tags_string_id`) VALUES (', @new_translation_id ,',', @current_entity_label_id ,')');
		

	   	PREPARE statement FROM @query; 
		EXECUTE statement; 
	 	DEALLOCATE PREPARE statement;
	 	
	 	SET j = j + 1;
 	
 	END WHILE;
END;;
DELIMITER ;

-- SCALES_COMMENTS
DROP PROCEDURE IF EXISTS duplicate_data_scales_comments;
DELIMITER ;;
CREATE PROCEDURE `duplicate_data_scales_comments`()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE j INT DEFAULT 0;
    DECLARE iso_from_entity TEXT DEFAULT NULL;
    DECLARE entity_table_length INT DEFAULT 0;
    
    SET entity_table_length = (SELECT COUNT(*) FROM `scales_comments`);
    
   	SET j = 0;
   	SET iso_from_entity = 'FR';
    
    WHILE j < entity_table_length DO
    
    	SET @current_entity_id = (SELECT `id` FROM scales_comments LIMIT 1 OFFSET j);
	    SET @current_entity_comment_id = (SELECT `comment_translation_id` FROM scales_comments WHERE `id` = @current_entity_id);
    
   		SET @comment_content = (SELECT `comment1` FROM `scales_comments` LIMIT 1 OFFSET j);
	    SET @comment_content_replaced = REPLACE(@comment_content, "'","''");
    
    	SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @comment_content_replaced, '\')') ;
	    PREPARE statement FROM @query;
	    EXECUTE statement; 
	    DEALLOCATE PREPARE statement;
    
   		SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
   	
   		SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `scales_comments_string_id`) VALUES (', @new_translation_id ,',', @current_entity_comment_id ,')');
		

	   	PREPARE statement FROM @query; 
		EXECUTE statement; 
	 	DEALLOCATE PREPARE statement;
	 	
	 	SET j = j + 1;
 	
 	END WHILE;
 	
 	
	SET j = 0;
 	SET iso_from_entity = 'EN';
 	 WHILE j < entity_table_length DO
    
    	SET @current_entity_id = (SELECT `id` FROM scales_comments LIMIT 1 OFFSET j);
	    SET @current_entity_comment_id = (SELECT `comment_translation_id` FROM scales_comments WHERE `id` = @current_entity_id);
    
   		SET @comment_content = (SELECT `comment2` FROM `scales_comments` LIMIT 1 OFFSET j);
	    SET @comment_content_replaced = REPLACE(@comment_content, "'","''");
    
    	SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @comment_content_replaced, '\')') ;
	    PREPARE statement FROM @query;
	    EXECUTE statement; 
	    DEALLOCATE PREPARE statement;
    
   		SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
   	
   		SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `scales_comments_string_id`) VALUES (', @new_translation_id ,',', @current_entity_comment_id ,')');
		

	   	PREPARE statement FROM @query; 
		EXECUTE statement; 
	 	DEALLOCATE PREPARE statement;
	 	
	 	SET j = j + 1;
 	
 	END WHILE;
 	
 	
 	SET j = 0;
   	SET iso_from_entity = 'DE';
 	 WHILE j < entity_table_length DO
    
    	SET @current_entity_id = (SELECT `id` FROM scales_comments LIMIT 1 OFFSET j);
	    SET @current_entity_comment_id = (SELECT `comment_translation_id` FROM scales_comments WHERE `id` = @current_entity_id);
    
   		SET @comment_content = (SELECT `comment3` FROM `scales_comments` LIMIT 1 OFFSET j);
	    SET @comment_content_replaced = REPLACE(@comment_content, "'","''");
    
    	SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @comment_content_replaced, '\')') ;
	    PREPARE statement FROM @query;
	    EXECUTE statement; 
	    DEALLOCATE PREPARE statement;
    
   		SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
   	
   		SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `scales_comments_string_id`) VALUES (', @new_translation_id ,',', @current_entity_comment_id ,')');
		

	   	PREPARE statement FROM @query; 
		EXECUTE statement; 
	 	DEALLOCATE PREPARE statement;
	 	
	 	SET j = j + 1;
 	END WHILE;
 	
 	SET j = 0;
   	SET iso_from_entity = 'NL';
 	 WHILE j < entity_table_length DO
    
    	SET @current_entity_id = (SELECT `id` FROM scales_comments LIMIT 1 OFFSET j);
	    SET @current_entity_comment_id = (SELECT `comment_translation_id` FROM scales_comments WHERE `id` = @current_entity_id);
    
   		SET @comment_content = (SELECT `comment4` FROM `scales_comments` LIMIT 1 OFFSET j);
	    SET @comment_content_replaced = REPLACE(@comment_content, "'","''");
    
    	SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @comment_content_replaced, '\')') ;
	    PREPARE statement FROM @query;
	    EXECUTE statement; 
	    DEALLOCATE PREPARE statement;
    
   		SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
   	
   		SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `scales_comments_string_id`) VALUES (', @new_translation_id ,',', @current_entity_comment_id ,')');
		

	   	PREPARE statement FROM @query; 
		EXECUTE statement; 
	 	DEALLOCATE PREPARE statement;
	 	
	 	SET j = j + 1;
 	
 	END WHILE;
END;;
DELIMITER ;

-- SCALES_IMPACT_TYPES
DROP PROCEDURE IF EXISTS duplicate_data_scales_impact_types;
DELIMITER ;;
CREATE PROCEDURE duplicate_data_scales_impact_types ()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE j INT DEFAULT 0;
	DECLARE column_name_to_copy TEXT DEFAULT NULL;
    DECLARE iso_from_entity TEXT DEFAULT NULL;
    DECLARE entity_table_length INT DEFAULT 0;
    
    SET entity_table_length = (SELECT COUNT(*) FROM `scales_impact_types`);
    
    WHILE i < 5 DO
        SET column_name_to_copy = CONCAT('label', i);

        CASE
            WHEN i = 1 THEN SET iso_from_entity = 'FR';
            WHEN i = 2 THEN SET iso_from_entity = 'EN';
            WHEN i = 3 THEN SET iso_from_entity = 'DE';
            WHEN i = 4 THEN SET iso_from_entity = 'NL';
            ELSE
                BEGIN
                END;
        END CASE;
    
    	SET j = 0;
        WHILE j < entity_table_length DO
        
            SET @current_entity_id = (SELECT `id` FROM scales_impact_types LIMIT 1 OFFSET j);
            SET @current_entity_label_id = (SELECT `label_translation_id` FROM scales_impact_types WHERE `id` = @current_entity_id);
            SET @entity_label_value = "";
            
            SET @entity_label_value_query = CONCAT('SELECT ', column_name_to_copy,' INTO @entity_label_value FROM `scales_impact_types` LIMIT 1 OFFSET ', j);
            PREPARE statement FROM @entity_label_value_query;
            EXECUTE statement;
            DEALLOCATE PREPARE statement;
                                
            SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @entity_label_value, '\')') ;
            
            PREPARE statement FROM @query; 
            EXECUTE statement; 
            DEALLOCATE PREPARE statement;
            
            SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
            
            SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `scales_impact_types_string_id`) VALUES (', @new_translation_id ,',', @current_entity_label_id ,')');
            
            PREPARE statement FROM @query; 
            EXECUTE statement; 
            DEALLOCATE PREPARE statement;
            
            SET j = j + 1;
        END WHILE;

        SET i = i + 1;

    END WHILE;

END;;
DELIMITER ;

-- THEMES
DROP PROCEDURE IF EXISTS duplicate_data_themes;
DELIMITER ;;
CREATE PROCEDURE duplicate_data_themes ()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE j INT DEFAULT 0;
	DECLARE column_name_to_copy TEXT DEFAULT NULL;
    DECLARE iso_from_entity TEXT DEFAULT NULL;
    DECLARE entity_table_length INT DEFAULT 0;
    
    SET entity_table_length = (SELECT COUNT(*) FROM `themes`);
    
    WHILE i < 5 DO
        SET column_name_to_copy = CONCAT('label', i);

        CASE
            WHEN i = 1 THEN SET iso_from_entity = 'FR';
            WHEN i = 2 THEN SET iso_from_entity = 'EN';
            WHEN i = 3 THEN SET iso_from_entity = 'DE';
            WHEN i = 4 THEN SET iso_from_entity = 'NL';
            ELSE
                BEGIN
                END;
        END CASE;
    
    	SET j = 0;
        WHILE j < entity_table_length DO
        
            SET @current_entity_id = (SELECT `id` FROM themes LIMIT 1 OFFSET j);
            SET @current_entity_label_id = (SELECT `label_translation_id` FROM themes WHERE `id` = @current_entity_id);
            SET @entity_label_value = "";
            
            SET @entity_label_value_query = CONCAT('SELECT ', column_name_to_copy,' INTO @entity_label_value FROM `themes` LIMIT 1 OFFSET ', j);
            PREPARE statement FROM @entity_label_value_query;
            EXECUTE statement;
            DEALLOCATE PREPARE statement;
            
            SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @entity_label_value, '\')') ;
            
            
            PREPARE statement FROM @query; 
            EXECUTE statement; 
            DEALLOCATE PREPARE statement;
            
            SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
            
            SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `themes_string_id`) VALUES (', @new_translation_id ,',', @current_entity_label_id ,')');
            
            PREPARE statement FROM @query; 
            EXECUTE statement; 
            DEALLOCATE PREPARE statement;
            
            SET j = j + 1;
        END WHILE;

        SET i = i + 1;

    END WHILE;

END;;
DELIMITER ;

-- THREATS
DROP PROCEDURE IF EXISTS duplicate_data_threats;
DELIMITER ;;
CREATE PROCEDURE `duplicate_data_threats`()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE j INT DEFAULT 0;
    DECLARE iso_from_entity TEXT DEFAULT NULL;
    DECLARE entity_table_length INT DEFAULT 0;
    
    SET entity_table_length = (SELECT COUNT(*) FROM `threats`);
    
   	SET j = 0;
   	SET iso_from_entity = 'FR';
    
    WHILE j < entity_table_length DO
    
    	SET @current_entity_id = (SELECT `id` FROM threats LIMIT 1 OFFSET j);
	    SET @current_entity_description_id = (SELECT `description_translation_id` FROM threats WHERE `id` = @current_entity_id);
    
   		SET @description_content = (SELECT `description1` FROM `threats` LIMIT 1 OFFSET j);
	    SET @description_content_replaced = REPLACE(@description_content, "'","''");
    
    	SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @description_content_replaced, '\')') ;
	    PREPARE statement FROM @query;
	    EXECUTE statement; 
	    DEALLOCATE PREPARE statement;
    
   		SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
   	
   		SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `threats_string_id`) VALUES (', @new_translation_id ,',', @current_entity_description_id ,')');
		

	   	PREPARE statement FROM @query; 
		EXECUTE statement; 
	 	DEALLOCATE PREPARE statement;
	 	
	 	SET j = j + 1;
 	
 	END WHILE;
 	
 	
	SET j = 0;
 	SET iso_from_entity = 'EN';
 	 WHILE j < entity_table_length DO
    
    	SET @current_entity_id = (SELECT `id` FROM threats LIMIT 1 OFFSET j);
	    SET @current_entity_description_id = (SELECT `description_translation_id` FROM threats WHERE `id` = @current_entity_id);
    
   		SET @description_content = (SELECT `description2` FROM `threats` LIMIT 1 OFFSET j);
	    SET @description_content_replaced = REPLACE(@description_content, "'","''");
    
    	SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @description_content_replaced, '\')') ;
	    PREPARE statement FROM @query;
	    EXECUTE statement; 
	    DEALLOCATE PREPARE statement;
    
   		SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
   	
   		SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `threats_string_id`) VALUES (', @new_translation_id ,',', @current_entity_description_id ,')');
		

	   	PREPARE statement FROM @query; 
		EXECUTE statement; 
	 	DEALLOCATE PREPARE statement;
	 	
	 	SET j = j + 1;
 	
 	END WHILE;
 	
 	
 	SET j = 0;
   	SET iso_from_entity = 'DE';
 	 WHILE j < entity_table_length DO
    
    	SET @current_entity_id = (SELECT `id` FROM threats LIMIT 1 OFFSET j);
	    SET @current_entity_description_id = (SELECT `description_translation_id` FROM threats WHERE `id` = @current_entity_id);
    
   		SET @description_content = (SELECT `description3` FROM `threats` LIMIT 1 OFFSET j);
	    SET @description_content_replaced = REPLACE(@description_content, "'","''");
    
    	SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @description_content_replaced, '\')') ;
	    PREPARE statement FROM @query;
	    EXECUTE statement; 
	    DEALLOCATE PREPARE statement;
    
   		SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
   	
   		SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `threats_string_id`) VALUES (', @new_translation_id ,',', @current_entity_description_id ,')');
		

	   	PREPARE statement FROM @query; 
		EXECUTE statement; 
	 	DEALLOCATE PREPARE statement;
	 	
	 	SET j = j + 1;
 	END WHILE;
 	
 	SET j = 0;
   	SET iso_from_entity = 'NL';
 	 WHILE j < entity_table_length DO
    
    	SET @current_entity_id = (SELECT `id` FROM threats LIMIT 1 OFFSET j);
	    SET @current_entity_description_id = (SELECT `description_translation_id` FROM threats WHERE `id` = @current_entity_id);
    
   		SET @description_content = (SELECT `description4` FROM `threats` LIMIT 1 OFFSET j);
	    SET @description_content_replaced = REPLACE(@description_content, "'","''");
    
    	SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @description_content_replaced, '\')') ;
	    PREPARE statement FROM @query;
	    EXECUTE statement; 
	    DEALLOCATE PREPARE statement;
    
   		SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
   	
   		SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `threats_string_id`) VALUES (', @new_translation_id ,',', @current_entity_description_id ,')');
		

	   	PREPARE statement FROM @query; 
		EXECUTE statement; 
	 	DEALLOCATE PREPARE statement;
	 	
	 	SET j = j + 1;
 	
 	END WHILE;
 	
 	SET j = 0;
   	SET iso_from_entity = 'FR';
 	WHILE j < entity_table_length DO
    
    	SET @current_entity_id = (SELECT `id` FROM threats LIMIT 1 OFFSET j);
	    SET @current_entity_label_id = (SELECT `label_translation_id` FROM threats WHERE `id` = @current_entity_id);
    
   		SET @label_content = (SELECT `label1` FROM `threats` LIMIT 1 OFFSET j);
	    SET @label_content_replaced = REPLACE(@label_content, "'","''");
    
    	SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @label_content_replaced, '\')') ;
	    PREPARE statement FROM @query;
	    EXECUTE statement; 
	    DEALLOCATE PREPARE statement;
    
   		SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
   	
   		SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `threats_string_id`) VALUES (', @new_translation_id ,',', @current_entity_label_id ,')');
		

	   	PREPARE statement FROM @query; 
		EXECUTE statement; 
	 	DEALLOCATE PREPARE statement;
	 	
	 	SET j = j + 1;
 	
 	END WHILE;
 	
 	
	SET j = 0;
 	SET iso_from_entity = 'EN';
 	 WHILE j < entity_table_length DO
    
    	SET @current_entity_id = (SELECT `id` FROM threats LIMIT 1 OFFSET j);
	    SET @current_entity_label_id = (SELECT `label_translation_id` FROM threats WHERE `id` = @current_entity_id);
    
   		SET @label_content = (SELECT `label2` FROM `threats` LIMIT 1 OFFSET j);
	    SET @label_content_replaced = REPLACE(@label_content, "'","''");
    
    	SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @label_content_replaced, '\')') ;
	    PREPARE statement FROM @query;
	    EXECUTE statement; 
	    DEALLOCATE PREPARE statement;
    
   		SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
   	
   		SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `threats_string_id`) VALUES (', @new_translation_id ,',', @current_entity_label_id ,')');
		

	   	PREPARE statement FROM @query; 
		EXECUTE statement; 
	 	DEALLOCATE PREPARE statement;
	 	
	 	SET j = j + 1;
 	
 	END WHILE;
 	
 	
 	SET j = 0;
   	SET iso_from_entity = 'DE';
 	 WHILE j < entity_table_length DO
    
    	SET @current_entity_id = (SELECT `id` FROM threats LIMIT 1 OFFSET j);
	    SET @current_entity_label_id = (SELECT `label_translation_id` FROM threats WHERE `id` = @current_entity_id);
    
   		SET @label_content = (SELECT `label3` FROM `threats` LIMIT 1 OFFSET j);
	    SET @label_content_replaced = REPLACE(@label_content, "'","''");
    
    	SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @label_content_replaced, '\')') ;
	    PREPARE statement FROM @query;
	    EXECUTE statement; 
	    DEALLOCATE PREPARE statement;
    
   		SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
   	
   		SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `threats_string_id`) VALUES (', @new_translation_id ,',', @current_entity_label_id ,')');
		

	   	PREPARE statement FROM @query; 
		EXECUTE statement; 
	 	DEALLOCATE PREPARE statement;
	 	
	 	SET j = j + 1;
 	END WHILE;
 	
 	SET j = 0;
   	SET iso_from_entity = 'NL';
 	 WHILE j < entity_table_length DO
    
    	SET @current_entity_id = (SELECT `id` FROM threats LIMIT 1 OFFSET j);
	    SET @current_entity_label_id = (SELECT `label_translation_id` FROM threats WHERE `id` = @current_entity_id);
    
   		SET @label_content = (SELECT `label4` FROM `threats` LIMIT 1 OFFSET j);
	    SET @label_content_replaced = REPLACE(@label_content, "'","''");
    
    	SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @label_content_replaced, '\')') ;
	    PREPARE statement FROM @query;
	    EXECUTE statement; 
	    DEALLOCATE PREPARE statement;
    
   		SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
   	
   		SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `threats_string_id`) VALUES (', @new_translation_id ,',', @current_entity_label_id ,')');
		

	   	PREPARE statement FROM @query; 
		EXECUTE statement; 
	 	DEALLOCATE PREPARE statement;
	 	
	 	SET j = j + 1;
 	
 	END WHILE;

END;;
DELIMITER ;

-- VULNERABILITIES
DROP PROCEDURE IF EXISTS duplicate_data_vulnerabilities;
DELIMITER ;;
CREATE PROCEDURE `duplicate_data_vulnerabilities`()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE j INT DEFAULT 0;
    DECLARE iso_from_entity TEXT DEFAULT NULL;
    DECLARE entity_table_length INT DEFAULT 0;
    
    SET entity_table_length = (SELECT COUNT(*) FROM `vulnerabilities`);
    
   	SET j = 0;
   	SET iso_from_entity = 'FR';
    
    WHILE j < entity_table_length DO
    
    	SET @current_entity_id = (SELECT `id` FROM vulnerabilities LIMIT 1 OFFSET j);
	    SET @current_entity_description_id = (SELECT `description_translation_id` FROM vulnerabilities WHERE `id` = @current_entity_id);
    
   		SET @description_content = (SELECT `description1` FROM `vulnerabilities` LIMIT 1 OFFSET j);
	    SET @description_content_replaced = REPLACE(@description_content, "'","''");
    
    	IF @description_content_replaced IS NULL THEN 
			SET @query = CONCAT('INSERT INTO `translations`(`ISO`) VALUES (\'', iso_from_entity ,'\')') ;
		ELSE 
			SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @description_content_replaced, '\')') ;
		END IF; 
	    PREPARE statement FROM @query;
	    EXECUTE statement; 
	    DEALLOCATE PREPARE statement;
    
   		SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
   	
   		SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `vulnerabilities_string_id`) VALUES (', @new_translation_id ,',', @current_entity_description_id ,')');
		

	   	PREPARE statement FROM @query; 
		EXECUTE statement; 
	 	DEALLOCATE PREPARE statement;
	 	
	 	SET j = j + 1;
 	
 	END WHILE;
 	
 	
	SET j = 0;
 	SET iso_from_entity = 'EN';
 	 WHILE j < entity_table_length DO
    
    	SET @current_entity_id = (SELECT `id` FROM vulnerabilities LIMIT 1 OFFSET j);
	    SET @current_entity_description_id = (SELECT `description_translation_id` FROM vulnerabilities WHERE `id` = @current_entity_id);
    
   		SET @description_content = (SELECT `description2` FROM `vulnerabilities` LIMIT 1 OFFSET j);
	    SET @description_content_replaced = REPLACE(@description_content, "'","''");
    
    	IF @description_content_replaced IS NULL THEN 
			SET @query = CONCAT('INSERT INTO `translations`(`ISO`) VALUES (\'', iso_from_entity ,'\')') ;
		ELSE 
			SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @description_content_replaced, '\')') ;
		END IF; 
    
	    PREPARE statement FROM @query;
	    EXECUTE statement; 
	    DEALLOCATE PREPARE statement;
    
   		SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
   	
   		SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `vulnerabilities_string_id`) VALUES (', @new_translation_id ,',', @current_entity_description_id ,')');
		

	   	PREPARE statement FROM @query; 
		EXECUTE statement; 
	 	DEALLOCATE PREPARE statement;
	 	
	 	SET j = j + 1;
 	
 	END WHILE;
 	
 	
 	SET j = 0;
   	SET iso_from_entity = 'DE';
 	 WHILE j < entity_table_length DO
    
    	SET @current_entity_id = (SELECT `id` FROM vulnerabilities LIMIT 1 OFFSET j);
	    SET @current_entity_description_id = (SELECT `description_translation_id` FROM vulnerabilities WHERE `id` = @current_entity_id);
    
   		SET @description_content = (SELECT `description3` FROM `vulnerabilities` LIMIT 1 OFFSET j);
	    SET @description_content_replaced = REPLACE(@description_content, "'","''");
    
    	IF @description_content_replaced IS NULL THEN 
			SET @query = CONCAT('INSERT INTO `translations`(`ISO`) VALUES (\'', iso_from_entity ,'\')') ;
		ELSE 
			SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @description_content_replaced, '\')') ;
		END IF; 
		
	    PREPARE statement FROM @query;
	    EXECUTE statement; 
	    DEALLOCATE PREPARE statement;
    
   		SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
   	
   		SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `vulnerabilities_string_id`) VALUES (', @new_translation_id ,',', @current_entity_description_id ,')');
		

	   	PREPARE statement FROM @query; 
		EXECUTE statement; 
	 	DEALLOCATE PREPARE statement;
	 	
	 	SET j = j + 1;
 	END WHILE;
 	
 	SET j = 0;
   	SET iso_from_entity = 'NL';
 	 WHILE j < entity_table_length DO
    
    	SET @current_entity_id = (SELECT `id` FROM vulnerabilities LIMIT 1 OFFSET j);
	    SET @current_entity_description_id = (SELECT `description_translation_id` FROM vulnerabilities WHERE `id` = @current_entity_id);
    
   		SET @description_content = (SELECT `description4` FROM `vulnerabilities` LIMIT 1 OFFSET j);
	    SET @description_content_replaced = REPLACE(@description_content, "'","''");
    
    	IF @description_content_replaced IS NULL THEN 
			SET @query = CONCAT('INSERT INTO `translations`(`ISO`) VALUES (\'', iso_from_entity ,'\')') ;
		ELSE 
			SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @description_content_replaced, '\')') ;
		END IF;
		
	    PREPARE statement FROM @query;
	    EXECUTE statement; 
	    DEALLOCATE PREPARE statement;
    
   		SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
   	
   		SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `vulnerabilities_string_id`) VALUES (', @new_translation_id ,',', @current_entity_description_id ,')');
		

	   	PREPARE statement FROM @query; 
		EXECUTE statement; 
	 	DEALLOCATE PREPARE statement;
	 	
	 	SET j = j + 1;
 	
 	END WHILE;
 	
 	SET j = 0;
   	SET iso_from_entity = 'FR';
 	WHILE j < entity_table_length DO
    
    	SET @current_entity_id = (SELECT `id` FROM vulnerabilities LIMIT 1 OFFSET j);
	    SET @current_entity_label_id = (SELECT `label_translation_id` FROM vulnerabilities WHERE `id` = @current_entity_id);
    
   		SET @label_content = (SELECT `label1` FROM `vulnerabilities` LIMIT 1 OFFSET j);
	    SET @label_content_replaced = REPLACE(@label_content, "'","''");
    
    	IF @label_content_replaced IS NULL THEN 
			SET @query = CONCAT('INSERT INTO `translations`(`ISO`) VALUES (\'', iso_from_entity ,'\')') ;
		ELSE 
			SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @label_content_replaced, '\')') ;
		END IF;
	    PREPARE statement FROM @query;
	    EXECUTE statement; 
	    DEALLOCATE PREPARE statement;
    
   		SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
   	
   		SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `vulnerabilities_string_id`) VALUES (', @new_translation_id ,',', @current_entity_label_id ,')');
		

	   	PREPARE statement FROM @query; 
		EXECUTE statement; 
	 	DEALLOCATE PREPARE statement;
	 	
	 	SET j = j + 1;
 	
 	END WHILE;
 	
 	
	SET j = 0;
 	SET iso_from_entity = 'EN';
 	 WHILE j < entity_table_length DO
    
    	SET @current_entity_id = (SELECT `id` FROM vulnerabilities LIMIT 1 OFFSET j);
	    SET @current_entity_label_id = (SELECT `label_translation_id` FROM vulnerabilities WHERE `id` = @current_entity_id);
    
   		SET @label_content = (SELECT `label2` FROM `vulnerabilities` LIMIT 1 OFFSET j);
	    SET @label_content_replaced = REPLACE(@label_content, "'","''");
    
    	IF @label_content_replaced IS NULL THEN 
			SET @query = CONCAT('INSERT INTO `translations`(`ISO`) VALUES (\'', iso_from_entity ,'\')') ;
		ELSE 
			SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @label_content_replaced, '\')') ;
		END IF;
	    PREPARE statement FROM @query;
	    EXECUTE statement; 
	    DEALLOCATE PREPARE statement;
    
   		SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
   	
   		SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `vulnerabilities_string_id`) VALUES (', @new_translation_id ,',', @current_entity_label_id ,')');
		

	   	PREPARE statement FROM @query; 
		EXECUTE statement; 
	 	DEALLOCATE PREPARE statement;
	 	
	 	SET j = j + 1;
 	
 	END WHILE;
 	
 	SET j = 0;
   	SET iso_from_entity = 'DE';
 	 WHILE j < entity_table_length DO
    
    	SET @current_entity_id = (SELECT `id` FROM vulnerabilities LIMIT 1 OFFSET j);
	    SET @current_entity_label_id = (SELECT `label_translation_id` FROM vulnerabilities WHERE `id` = @current_entity_id);
    
   		SET @label_content = (SELECT `label3` FROM `vulnerabilities` LIMIT 1 OFFSET j);
	    SET @label_content_replaced = REPLACE(@label_content, "'","''");
    
		IF @label_content_replaced IS NULL THEN 
			SET @query = CONCAT('INSERT INTO `translations`(`ISO`) VALUES (\'', iso_from_entity ,'\')') ;
		ELSE 
			SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @label_content_replaced, '\')') ;
		END IF;
	    PREPARE statement FROM @query;
	    EXECUTE statement; 
	    DEALLOCATE PREPARE statement;
    
   		SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
   	
   		SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `vulnerabilities_string_id`) VALUES (', @new_translation_id ,',', @current_entity_label_id ,')');
		

	   	PREPARE statement FROM @query; 
		EXECUTE statement; 
	 	DEALLOCATE PREPARE statement;
	 	
	 	SET j = j + 1;
 	END WHILE;
 	
 	SET j = 0;
   	SET iso_from_entity = 'NL';
 	 WHILE j < entity_table_length DO
    
    	SET @current_entity_id = (SELECT `id` FROM vulnerabilities LIMIT 1 OFFSET j);
	    SET @current_entity_label_id = (SELECT `label_translation_id` FROM vulnerabilities WHERE `id` = @current_entity_id);
    
   		SET @label_content = (SELECT `label4` FROM `vulnerabilities` LIMIT 1 OFFSET j);
	    SET @label_content_replaced = REPLACE(@label_content, "'","''");
    
		IF @label_content_replaced IS NULL THEN 
			SET @query = CONCAT('INSERT INTO `translations`(`ISO`) VALUES (\'', iso_from_entity ,'\')') ;
		ELSE 
			SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @label_content_replaced, '\')') ;
		END IF;
	    PREPARE statement FROM @query;
	    EXECUTE statement; 
	    DEALLOCATE PREPARE statement;
    
   		SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);
   	
   		SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `vulnerabilities_string_id`) VALUES (', @new_translation_id ,',', @current_entity_label_id ,')');
		

	   	PREPARE statement FROM @query; 
		EXECUTE statement; 
	 	DEALLOCATE PREPARE statement;
	 	
	 	SET j = j + 1;
 	
 	END WHILE;

END;;
DELIMITER ;


-- INSTANCES_RISKS_OP
DROP PROCEDURE IF EXISTS duplicate_data_instances_risks_op;
DELIMITER ;;
CREATE PROCEDURE `duplicate_data_instances_risks_op`()
	BEGIN
		DECLARE i INT DEFAULT 1;
		DECLARE j INT DEFAULT 0;
		DECLARE iso_from_entity TEXT DEFAULT NULL;
		DECLARE entity_table_length INT DEFAULT 0;

		SET entity_table_length = (SELECT COUNT(*) FROM `instances_risks_op`);

		SET j = 0;
		SET iso_from_entity = 'FR';

		WHILE j < entity_table_length DO

			SET @current_entity_id = (SELECT `id` FROM instances_risks_op LIMIT 1 OFFSET j);
			SET @current_entity_description_id = (SELECT `risk_cache_description_translation_id` FROM instances_risks_op WHERE `id` = @current_entity_id);

			SET @description_content = (SELECT `risk_cache_description1` FROM `instances_risks_op` LIMIT 1 OFFSET j);
			SET @description_content_replaced = REPLACE(@description_content, "'","''");

			IF @description_content_replaced IS NULL THEN
				SET @query = CONCAT('INSERT INTO `translations`(`ISO`) VALUES (\'', iso_from_entity ,'\')') ;
			ELSE
				SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @description_content_replaced, '\')') ;
			END IF;
			PREPARE statement FROM @query;
			EXECUTE statement;
			DEALLOCATE PREPARE statement;

			SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);

			SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `instances_risks_ops_string_id`) VALUES (', @new_translation_id ,',', @current_entity_description_id ,')');


			PREPARE statement FROM @query;
			EXECUTE statement;
			DEALLOCATE PREPARE statement;

			SET j = j + 1;

		END WHILE;


		SET j = 0;
		SET iso_from_entity = 'EN';
		WHILE j < entity_table_length DO

			SET @current_entity_id = (SELECT `id` FROM instances_risks_op LIMIT 1 OFFSET j);
			SET @current_entity_description_id = (SELECT `risk_cache_description_translation_id` FROM instances_risks_op WHERE `id` = @current_entity_id);

			SET @description_content = (SELECT `risk_cache_description2` FROM `instances_risks_op` LIMIT 1 OFFSET j);
			SET @description_content_replaced = REPLACE(@description_content, "'","''");

			IF @description_content_replaced IS NULL THEN
				SET @query = CONCAT('INSERT INTO `translations`(`ISO`) VALUES (\'', iso_from_entity ,'\')') ;
			ELSE
				SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @description_content_replaced, '\')') ;
			END IF;

			PREPARE statement FROM @query;
			EXECUTE statement;
			DEALLOCATE PREPARE statement;

			SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);

			SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `instances_risks_ops_string_id`) VALUES (', @new_translation_id ,',', @current_entity_description_id ,')');


			PREPARE statement FROM @query;
			EXECUTE statement;
			DEALLOCATE PREPARE statement;

			SET j = j + 1;


		END WHILE;


		SET j = 0;
		SET iso_from_entity = 'DE';
		WHILE j < entity_table_length DO

			SET @current_entity_id = (SELECT `id` FROM instances_risks_op LIMIT 1 OFFSET j);
			SET @current_entity_description_id = (SELECT `risk_cache_description_translation_id` FROM instances_risks_op WHERE `id` = @current_entity_id);

			SET @description_content = (SELECT `risk_cache_description3` FROM `instances_risks_op` LIMIT 1 OFFSET j);
			SET @description_content_replaced = REPLACE(@description_content, "'","''");

			IF @description_content_replaced IS NULL THEN
				SET @query = CONCAT('INSERT INTO `translations`(`ISO`) VALUES (\'', iso_from_entity ,'\')') ;
			ELSE
				SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @description_content_replaced, '\')') ;
			END IF;

			PREPARE statement FROM @query;
			EXECUTE statement;
			DEALLOCATE PREPARE statement;

			SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);

			SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `instances_risks_ops_string_id`) VALUES (', @new_translation_id ,',', @current_entity_description_id ,')');


			PREPARE statement FROM @query;
			EXECUTE statement;
			DEALLOCATE PREPARE statement;

			SET j = j + 1;

		END WHILE;

		SET j = 0;
		SET iso_from_entity = 'NL';
		WHILE j < entity_table_length DO

			SET @current_entity_id = (SELECT `id` FROM instances_risks_op LIMIT 1 OFFSET j);
			SET @current_entity_description_id = (SELECT `risk_cache_description_translation_id` FROM instances_risks_op WHERE `id` = @current_entity_id);

			SET @description_content = (SELECT `risk_cache_description4` FROM `instances_risks_op` LIMIT 1 OFFSET j);
			SET @description_content_replaced = REPLACE(@description_content, "'","''");

			IF @description_content_replaced IS NULL THEN
				SET @query = CONCAT('INSERT INTO `translations`(`ISO`) VALUES (\'', iso_from_entity ,'\')') ;
			ELSE
				SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @description_content_replaced, '\')') ;
			END IF;

			PREPARE statement FROM @query;
			EXECUTE statement;
			DEALLOCATE PREPARE statement;

			SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);

			SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `instances_risks_ops_string_id`) VALUES (', @new_translation_id ,',', @current_entity_description_id ,')');


			PREPARE statement FROM @query;
			EXECUTE statement;
			DEALLOCATE PREPARE statement;

			SET j = j + 1;


		END WHILE;

		SET j = 0;
		SET iso_from_entity = 'FR';
		WHILE j < entity_table_length DO

			SET @current_entity_id = (SELECT `id` FROM vulnerabilities LIMIT 1 OFFSET j);
			SET @current_entity_label_id = (SELECT `label_translation_id` FROM instances_risks_op WHERE `id` = @current_entity_id);

			SET @label_content = (SELECT `risk_cache_label1` FROM `instances_risks_op` LIMIT 1 OFFSET j);
			SET @label_content_replaced = REPLACE(@label_content, "'","''");

			IF @label_content_replaced IS NULL THEN
				SET @query = CONCAT('INSERT INTO `translations`(`ISO`) VALUES (\'', iso_from_entity ,'\')') ;
			ELSE
				SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @label_content_replaced, '\')') ;
			END IF;
			PREPARE statement FROM @query;
			EXECUTE statement;
			DEALLOCATE PREPARE statement;

			SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);

			SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `instances_risks_ops_string_id`) VALUES (', @new_translation_id ,',', @current_entity_label_id ,')');


			PREPARE statement FROM @query;
			EXECUTE statement;
			DEALLOCATE PREPARE statement;

			SET j = j + 1;

		END WHILE;


		SET j = 0;
		SET iso_from_entity = 'EN';
		WHILE j < entity_table_length DO

			SET @current_entity_id = (SELECT `id` FROM vulnerabilities LIMIT 1 OFFSET j);
			SET @current_entity_label_id = (SELECT `label_translation_id` FROM instances_risks_op WHERE `id` = @current_entity_id);

			SET @label_content = (SELECT `risk_cache_label2` FROM `instances_risks_op` LIMIT 1 OFFSET j);
			SET @label_content_replaced = REPLACE(@label_content, "'","''");

			IF @label_content_replaced IS NULL THEN
				SET @query = CONCAT('INSERT INTO `translations`(`ISO`) VALUES (\'', iso_from_entity ,'\')') ;
			ELSE
				SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @label_content_replaced, '\')') ;
			END IF;
			PREPARE statement FROM @query;
			EXECUTE statement;
			DEALLOCATE PREPARE statement;

			SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);

			SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `instances_risks_ops_string_id`) VALUES (', @new_translation_id ,',', @current_entity_label_id ,')');


			PREPARE statement FROM @query;
			EXECUTE statement;
			DEALLOCATE PREPARE statement;

			SET j = j + 1;

		END WHILE;

		SET j = 0;
		SET iso_from_entity = 'DE';
		WHILE j < entity_table_length DO

			SET @current_entity_id = (SELECT `id` FROM vulnerabilities LIMIT 1 OFFSET j);
			SET @current_entity_label_id = (SELECT `label_translation_id` FROM instances_risks_op WHERE `id` = @current_entity_id);

			SET @label_content = (SELECT `risk_cache_label3` FROM `instances_risks_op` LIMIT 1 OFFSET j);
			SET @label_content_replaced = REPLACE(@label_content, "'","''");

			IF @label_content_replaced IS NULL THEN
				SET @query = CONCAT('INSERT INTO `translations`(`ISO`) VALUES (\'', iso_from_entity ,'\')') ;
			ELSE
				SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @label_content_replaced, '\')') ;
			END IF;
			PREPARE statement FROM @query;
			EXECUTE statement;
			DEALLOCATE PREPARE statement;

			SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);

			SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `instances_risks_ops_string_id`) VALUES (', @new_translation_id ,',', @current_entity_label_id ,')');


			PREPARE statement FROM @query;
			EXECUTE statement;
			DEALLOCATE PREPARE statement;

			SET j = j + 1;
		END WHILE;

		SET j = 0;
		SET iso_from_entity = 'NL';
		WHILE j < entity_table_length DO

			SET @current_entity_id = (SELECT `id` FROM vulnerabilities LIMIT 1 OFFSET j);
			SET @current_entity_label_id = (SELECT `label_translation_id` FROM instances_risks_op WHERE `id` = @current_entity_id);

			SET @label_content = (SELECT `risk_cache_label4` FROM `instances_risks_op` LIMIT 1 OFFSET j);
			SET @label_content_replaced = REPLACE(@label_content, "'","''");

			IF @label_content_replaced IS NULL THEN
				SET @query = CONCAT('INSERT INTO `translations`(`ISO`) VALUES (\'', iso_from_entity ,'\')') ;
			ELSE
				SET @query = CONCAT('INSERT INTO `translations`(`ISO`, `content`) VALUES (\'', iso_from_entity ,'\',\'', @label_content_replaced, '\')') ;
			END IF;
			PREPARE statement FROM @query;
			EXECUTE statement;
			DEALLOCATE PREPARE statement;

			SET @new_translation_id = (SELECT `id` FROM `translations` ORDER BY `id` DESC LIMIT 1);

			SET @query = CONCAT('INSERT INTO `translation_languages` (`translation_id`, `instances_risks_ops_string_id`) VALUES (', @new_translation_id ,',', @current_entity_label_id ,')');


			PREPARE statement FROM @query;
			EXECUTE statement;
			DEALLOCATE PREPARE statement;

			SET j = j + 1;

		END WHILE;

	END;;
DELIMITER ;

-- Call procedures that duplicate data
CALL `duplicate_data_anrs`;
CALL `duplicate_data_assets`;
CALL `duplicate_data_measures`;
CALL `duplicate_data_objects`;
CALL `duplicate_data_objects_categories`;
CALL `duplicate_data_questions`;
CALL `duplicate_data_questions_choices`;
CALL `duplicate_data_rolf_risks`;
CALL `duplicate_data_rolf_tags`;
CALL `duplicate_data_scales_comments`;
CALL `duplicate_data_scales_impact_types`;
CALL `duplicate_data_themes`;
CALL `duplicate_data_threats`;
CALL `duplicate_data_vulnerabilities`;
CALL `duplicate_data_instances_risks_op`;


-- Procedure to delete old hard-codded translations columns in tables
DROP PROCEDURE IF EXISTS delete_old_translation_columns;
DELIMITER ;;
CREATE PROCEDURE delete_old_translation_columns ()
BEGIN
	ALTER TABLE anrs DROP COLUMN label1, DROP COLUMN label2, DROP COLUMN label3, DROP COLUMN label4, DROP COLUMN description1, DROP COLUMN description2, DROP COLUMN description3, DROP COLUMN description4;
	ALTER TABLE assets DROP COLUMN label1, DROP COLUMN label2, DROP COLUMN label3, DROP COLUMN label4, DROP COLUMN description1, DROP COLUMN description2, DROP COLUMN description3, DROP COLUMN description4;
	ALTER TABLE instances DROP COLUMN label1, DROP COLUMN label2, DROP COLUMN label3, DROP COLUMN label4, DROP COLUMN name1, DROP COLUMN name2, DROP COLUMN name3, DROP COLUMN name4;
	ALTER TABLE measures DROP COLUMN description1, DROP COLUMN description2, DROP COLUMN description3, DROP COLUMN description4;
	ALTER TABLE objects DROP COLUMN label1, DROP COLUMN label2, DROP COLUMN label3, DROP COLUMN label4, DROP COLUMN name1, DROP COLUMN name2, DROP COLUMN name3, DROP COLUMN name4;
	ALTER TABLE objects_categories DROP COLUMN label1, DROP COLUMN label2, DROP COLUMN label3, DROP COLUMN label4;
	ALTER TABLE questions DROP COLUMN label1, DROP COLUMN label2, DROP COLUMN label3, DROP COLUMN label4;
	ALTER TABLE questions_choices DROP COLUMN label1, DROP COLUMN label2, DROP COLUMN label3, DROP COLUMN label4;
	ALTER TABLE rolf_tags DROP COLUMN label1, DROP COLUMN label2, DROP COLUMN label3, DROP COLUMN label4;
	ALTER TABLE scales_comments DROP COLUMN comment1, DROP COLUMN comment2, DROP COLUMN comment3, DROP COLUMN comment4;
	ALTER TABLE scales_impact_types DROP COLUMN label1, DROP COLUMN label2, DROP COLUMN label3, DROP COLUMN label4;
	ALTER TABLE themes DROP COLUMN label1, DROP COLUMN label2, DROP COLUMN label3, DROP COLUMN label4;
	ALTER TABLE threats DROP COLUMN label1, DROP COLUMN label2, DROP COLUMN label3, DROP COLUMN label4, DROP COLUMN description1, DROP COLUMN description2, DROP COLUMN description3, DROP COLUMN description4;
	ALTER TABLE rolf_risks DROP COLUMN label1, DROP COLUMN label2, DROP COLUMN label3, DROP COLUMN label4, DROP COLUMN description1, DROP COLUMN description2, DROP COLUMN description3, DROP COLUMN description4;
	ALTER TABLE vulnerabilities DROP COLUMN label1, DROP COLUMN label2, DROP COLUMN label3, DROP COLUMN label4, DROP COLUMN description1, DROP COLUMN description2, DROP COLUMN description3, DROP COLUMN description4;
END;;
DELIMITER ;

CALL delete_old_translation_columns;
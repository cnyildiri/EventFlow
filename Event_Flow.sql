-- MySQL Script generated by MySQL Workbench
-- Wed Oct  9 10:24:14 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

/*
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema event_flow
-- -----------------------------------------------------

CREATE SCHEMA IF NOT EXISTS `event_flow` DEFAULT CHARACTER SET utf8 ;
USE `event_flow` ;

-- -----------------------------------------------------
-- Table `event_flow`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `event_flow`.`User` ;

CREATE TABLE IF NOT EXISTS `event_flow`.`User` (
  `user_id` INT NOT NULL,
  `user_name` VARCHAR(45) NOT NULL,
  `user_email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC) VISIBLE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `event_flow`.`Event`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `event_flow`.`Event` ;

CREATE TABLE IF NOT EXISTS `event_flow`.`Event` (
  `event_id` INT NOT NULL,
  `event_location` VARCHAR(45) NOT NULL,
  `event_description` VARCHAR(100) NOT NULL,
  `total_attendees` INT NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`event_id`),
  UNIQUE INDEX `event_id_UNIQUE` (`event_id` ASC) VISIBLE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `event_flow`.`Reservation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `event_flow`.`Reservation` ;

CREATE TABLE IF NOT EXISTS `event_flow`.`Reservation` (
  `reservation_id` INT NOT NULL,
  `reservation_time` VARCHAR(45) NOT NULL,
  `reservation_date` VARCHAR(45) NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `User_user_id` INT NOT NULL,
  `Event_event_id` INT NOT NULL,
  PRIMARY KEY (`reservation_id`, `User_user_id`, `Event_event_id`),
  UNIQUE INDEX `reservation_id_UNIQUE` (`reservation_id` ASC) VISIBLE,
  INDEX `fk_Reservation_User1_idx` (`User_user_id` ASC) VISIBLE,
  INDEX `fk_Reservation_Event1_idx` (`Event_event_id` ASC) VISIBLE,
  CONSTRAINT `fk_Reservation_User1`
    FOREIGN KEY (`User_user_id`)
    REFERENCES `event_flow`.`User` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reservation_Event1`
    FOREIGN KEY (`Event_event_id`)
    REFERENCES `event_flow`.`Event` (`event_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `event_flow`.`User_has_Event`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `event_flow`.`User_has_Event` ;

CREATE TABLE IF NOT EXISTS `event_flow`.`User_has_Event` (
  `User_user_id` INT NOT NULL,
  `Event_event_id` INT NOT NULL,
  PRIMARY KEY (`User_user_id`, `Event_event_id`),
  INDEX `fk_User_has_Event_Event1_idx` (`Event_event_id` ASC) VISIBLE,
  INDEX `fk_User_has_Event_User_idx` (`User_user_id` ASC) VISIBLE,
  CONSTRAINT `fk_User_has_Event_User`
    FOREIGN KEY (`User_user_id`)
    REFERENCES `event_flow`.`User` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_has_Event_Event1`
    FOREIGN KEY (`Event_event_id`)
    REFERENCES `event_flow`.`Event` (`event_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

CREATE USER 'eventFlowAdmins'@'localhost' IDENTIFIED BY 'Ev3ntf10wg0@ts';
GRANT ALL PRIVILEGES ON event_flow.* TO 'eventFlowAdmins'@'localhost';

Drop foreign key constraints involving user_id, event_id, and reservation_id

ALTER TABLE `event_flow`.`Reservation`
DROP FOREIGN KEY `fk_Reservation_User1`;

ALTER TABLE `event_flow`.`Reservation`
DROP FOREIGN KEY `fk_Reservation_Event1`;

ALTER TABLE `event_flow`.`User_has_Event`
DROP FOREIGN KEY `fk_User_has_Event_User`;

ALTER TABLE `event_flow`.`User_has_Event`
DROP FOREIGN KEY `fk_User_has_Event_Event1`;

-- Modify user_id, event_id, and reservation_id columns to be AUTO_INCREMENT
ALTER TABLE `event_flow`.`User`
MODIFY COLUMN `user_id` INT NOT NULL AUTO_INCREMENT;

ALTER TABLE `event_flow`.`Event`
MODIFY COLUMN `event_id` INT NOT NULL AUTO_INCREMENT;

ALTER TABLE `event_flow`.`Reservation`
MODIFY COLUMN `reservation_id` INT NOT NULL AUTO_INCREMENT;

-- Re-add the foreign key constraints
ALTER TABLE `event_flow`.`Reservation`
ADD CONSTRAINT `fk_Reservation_User1`
FOREIGN KEY (`User_user_id`)
REFERENCES `event_flow`.`User` (`user_id`)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE `event_flow`.`Reservation`
ADD CONSTRAINT `fk_Reservation_Event1`
FOREIGN KEY (`Event_event_id`)
REFERENCES `event_flow`.`Event` (`event_id`)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE `event_flow`.`User_has_Event`
ADD CONSTRAINT `fk_User_has_Event_User`
FOREIGN KEY (`User_user_id`)
REFERENCES `event_flow`.`User` (`user_id`)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE `event_flow`.`User_has_Event`
ADD CONSTRAINT `fk_User_has_Event_Event1`
FOREIGN KEY (`Event_event_id`)
REFERENCES `event_flow`.`Event` (`event_id`)
ON DELETE NO ACTION
ON UPDATE NO ACTION;


-- Insert a user into the User table
INSERT INTO `event_flow`.`User` (`user_name`, `user_email`)
VALUES ('John Doe', 'johndoe@example.com');

-- Insert an event into the Event table
INSERT INTO `event_flow`.`Event` (`event_location`, `event_description`, `total_attendees`, `title`)
VALUES ('Conference Room A', 'Annual company meeting', 50, 'Company Meeting');

-- Insert a reservation into the Reservation table
-- Use the user_id and event_id values from the entries added above.
-- Assuming they were the first entries, they should be `1` for both, but confirm with a SELECT if needed.

INSERT INTO `event_flow`.`Reservation` (`reservation_time`, `reservation_date`, `status`, `User_user_id`, `Event_event_id`)
VALUES ('13:00', '2024-11-10', 'Confirmed', 1, 1);

-- Insert a relationship between User and Event in the User_has_Event table
INSERT INTO `event_flow`.`User_has_Event` (`User_user_id`, `Event_event_id`)
VALUES (1, 1);
*/


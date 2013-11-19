SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `patient_billing` DEFAULT CHARACTER SET latin1 ;
USE `patient_billing` ;

-- -----------------------------------------------------
-- Table `patient_billing`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`users` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`users` (
  `user_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `system_id` VARCHAR(50) NOT NULL DEFAULT '' ,
  `username` VARCHAR(50) NULL DEFAULT NULL ,
  `password` VARCHAR(128) NULL DEFAULT NULL ,
  `salt` VARCHAR(128) NULL DEFAULT NULL ,
  `secret_question` VARCHAR(255) NULL DEFAULT NULL ,
  `secret_answer` VARCHAR(255) NULL DEFAULT NULL ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `changed_by` INT(11) NULL DEFAULT NULL ,
  `date_changed` DATETIME NULL DEFAULT NULL ,
  `person_id` INT(11) NULL DEFAULT NULL ,
  `retired` TINYINT(4) NOT NULL DEFAULT '0' ,
  `retired_by` INT(11) NULL DEFAULT NULL ,
  `date_retired` DATETIME NULL DEFAULT NULL ,
  `retire_reason` VARCHAR(255) NULL DEFAULT NULL ,
  `uuid` CHAR(38) NOT NULL ,
  PRIMARY KEY (`user_id`) ,
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) ,
  INDEX `person_id_for_user` (`person_id` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 49
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`active_list_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`active_list_type` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`active_list_type` (
  `active_list_type_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(50) NOT NULL ,
  `description` VARCHAR(255) NULL DEFAULT NULL ,
  `creator` INT(11) NOT NULL ,
  `date_created` DATETIME NOT NULL ,
  `retired` SMALLINT(6) NOT NULL DEFAULT '0' ,
  `retired_by` INT(11) NULL DEFAULT NULL ,
  `date_retired` DATETIME NULL DEFAULT NULL ,
  `retire_reason` VARCHAR(255) NULL DEFAULT NULL ,
  `uuid` CHAR(38) NOT NULL ,
  PRIMARY KEY (`active_list_type_id`) )
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `patient_billing`.`concept_class`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`concept_class` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`concept_class` (
  `concept_class_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(255) NOT NULL DEFAULT '' ,
  `description` VARCHAR(255) NOT NULL DEFAULT '' ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `retired` SMALLINT(6) NOT NULL DEFAULT '0' ,
  `retired_by` INT(11) NULL DEFAULT NULL ,
  `date_retired` DATETIME NULL DEFAULT NULL ,
  `retire_reason` VARCHAR(255) NULL DEFAULT NULL ,
  `uuid` CHAR(38) NOT NULL ,
  PRIMARY KEY (`concept_class_id`) ,
  UNIQUE INDEX `concept_class_uuid_index` (`uuid` ASC) ,
  INDEX `concept_class_retired_status` (`retired` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 21
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`concept_datatype`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`concept_datatype` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`concept_datatype` (
  `concept_datatype_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(255) NOT NULL DEFAULT '' ,
  `hl7_abbreviation` VARCHAR(3) NULL DEFAULT NULL ,
  `description` VARCHAR(255) NOT NULL DEFAULT '' ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `retired` SMALLINT(6) NOT NULL DEFAULT '0' ,
  `retired_by` INT(11) NULL DEFAULT NULL ,
  `date_retired` DATETIME NULL DEFAULT NULL ,
  `retire_reason` VARCHAR(255) NULL DEFAULT NULL ,
  `uuid` CHAR(38) NOT NULL ,
  PRIMARY KEY (`concept_datatype_id`) ,
  UNIQUE INDEX `concept_datatype_uuid_index` (`uuid` ASC) ,
  INDEX `concept_datatype_retired_status` (`retired` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 14
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`concept`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`concept` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`concept` (
  `concept_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `retired` SMALLINT(6) NOT NULL DEFAULT '0' ,
  `short_name` VARCHAR(255) NULL DEFAULT NULL ,
  `description` TEXT NULL DEFAULT NULL ,
  `form_text` TEXT NULL DEFAULT NULL ,
  `datatype_id` INT(11) NOT NULL DEFAULT '0' ,
  `class_id` INT(11) NOT NULL DEFAULT '0' ,
  `is_set` SMALLINT(6) NOT NULL DEFAULT '0' ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `default_charge` INT(11) NULL DEFAULT NULL ,
  `version` VARCHAR(50) NULL DEFAULT NULL ,
  `changed_by` INT(11) NULL DEFAULT NULL ,
  `date_changed` DATETIME NULL DEFAULT NULL ,
  `retired_by` INT(11) NULL DEFAULT NULL ,
  `date_retired` DATETIME NULL DEFAULT NULL ,
  `retire_reason` VARCHAR(255) NULL DEFAULT NULL ,
  `uuid` CHAR(38) NOT NULL ,
  PRIMARY KEY (`concept_id`) ,
  UNIQUE INDEX `concept_uuid_index` (`uuid` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 9098
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`person`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`person` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`person` (
  `person_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `gender` VARCHAR(50) NULL DEFAULT '' ,
  `birthdate` DATE NULL DEFAULT NULL ,
  `birthdate_estimated` SMALLINT(6) NOT NULL DEFAULT '0' ,
  `dead` SMALLINT(6) NOT NULL DEFAULT '0' ,
  `death_date` DATETIME NULL DEFAULT NULL ,
  `cause_of_death` INT(11) NULL DEFAULT NULL ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `changed_by` INT(11) NULL DEFAULT NULL ,
  `date_changed` DATETIME NULL DEFAULT NULL ,
  `voided` SMALLINT(6) NOT NULL DEFAULT '0' ,
  `voided_by` INT(11) NULL DEFAULT NULL ,
  `date_voided` DATETIME NULL DEFAULT NULL ,
  `void_reason` VARCHAR(255) NULL DEFAULT NULL ,
  `uuid` CHAR(38) NOT NULL ,
  PRIMARY KEY (`person_id`) ,
  UNIQUE INDEX `person_uuid_index` (`uuid` ASC) ,
  INDEX `person_birthdate` (`birthdate` ASC) ,
  INDEX `person_death_date` (`death_date` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 21
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`drug`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`drug` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`drug` (
  `drug_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `concept_id` INT(11) NOT NULL DEFAULT '0' ,
  `name` VARCHAR(50) NULL DEFAULT NULL ,
  `combination` SMALLINT(6) NOT NULL DEFAULT '0' ,
  `dosage_form` INT(11) NULL DEFAULT NULL ,
  `dose_strength` DOUBLE NULL DEFAULT NULL ,
  `maximum_daily_dose` DOUBLE NULL DEFAULT NULL ,
  `minimum_daily_dose` DOUBLE NULL DEFAULT NULL ,
  `route` INT(11) NULL DEFAULT NULL ,
  `units` VARCHAR(50) NULL DEFAULT NULL ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `retired` SMALLINT(6) NOT NULL DEFAULT '0' ,
  `retired_by` INT(11) NULL DEFAULT NULL ,
  `date_retired` DATETIME NULL DEFAULT NULL ,
  `retire_reason` VARCHAR(255) NULL DEFAULT NULL ,
  `uuid` CHAR(38) NOT NULL ,
  PRIMARY KEY (`drug_id`) ,
  UNIQUE INDEX `drug_uuid_index` (`uuid` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 931
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`encounter_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`encounter_type` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`encounter_type` (
  `encounter_type_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(50) NOT NULL DEFAULT '' ,
  `description` TEXT NULL DEFAULT NULL ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `retired` SMALLINT(6) NOT NULL DEFAULT '0' ,
  `retired_by` INT(11) NULL DEFAULT NULL ,
  `date_retired` DATETIME NULL DEFAULT NULL ,
  `retire_reason` VARCHAR(255) NULL DEFAULT NULL ,
  `uuid` CHAR(38) NOT NULL ,
  PRIMARY KEY (`encounter_type_id`) ,
  UNIQUE INDEX `encounter_type_uuid_index` (`uuid` ASC) ,
  INDEX `retired_status` (`retired` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 142
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`form`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`form` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`form` (
  `form_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(255) NOT NULL DEFAULT '' ,
  `version` VARCHAR(50) NOT NULL DEFAULT '' ,
  `build` INT(11) NULL DEFAULT NULL ,
  `published` SMALLINT(6) NOT NULL DEFAULT '0' ,
  `description` TEXT NULL DEFAULT NULL ,
  `encounter_type` INT(11) NULL DEFAULT NULL ,
  `template` MEDIUMTEXT NULL DEFAULT NULL ,
  `xslt` MEDIUMTEXT NULL DEFAULT NULL ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `changed_by` INT(11) NULL DEFAULT NULL ,
  `date_changed` DATETIME NULL DEFAULT NULL ,
  `retired` SMALLINT(6) NOT NULL DEFAULT '0' ,
  `retired_by` INT(11) NULL DEFAULT NULL ,
  `date_retired` DATETIME NULL DEFAULT NULL ,
  `retired_reason` VARCHAR(255) NULL DEFAULT NULL ,
  `uuid` CHAR(38) NOT NULL ,
  PRIMARY KEY (`form_id`) ,
  UNIQUE INDEX `form_uuid_index` (`uuid` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`location` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`location` (
  `location_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(255) NOT NULL DEFAULT '' ,
  `description` VARCHAR(255) NULL DEFAULT NULL ,
  `address1` VARCHAR(50) NULL DEFAULT NULL ,
  `address2` VARCHAR(50) NULL DEFAULT NULL ,
  `city_village` VARCHAR(50) NULL DEFAULT NULL ,
  `state_province` VARCHAR(50) NULL DEFAULT NULL ,
  `postal_code` VARCHAR(50) NULL DEFAULT NULL ,
  `country` VARCHAR(50) NULL DEFAULT NULL ,
  `latitude` VARCHAR(50) NULL DEFAULT NULL ,
  `longitude` VARCHAR(50) NULL DEFAULT NULL ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `county_district` VARCHAR(50) NULL DEFAULT NULL ,
  `neighborhood_cell` VARCHAR(50) NULL DEFAULT NULL ,
  `region` VARCHAR(50) NULL DEFAULT NULL ,
  `subregion` VARCHAR(50) NULL DEFAULT NULL ,
  `township_division` VARCHAR(50) NULL DEFAULT NULL ,
  `retired` TINYINT(1) NOT NULL DEFAULT '0' ,
  `retired_by` INT(11) NULL DEFAULT NULL ,
  `date_retired` DATETIME NULL DEFAULT NULL ,
  `retire_reason` VARCHAR(255) NULL DEFAULT NULL ,
  `location_type_id` INT(11) NULL DEFAULT NULL ,
  `parent_location` INT(11) NULL DEFAULT NULL ,
  `uuid` CHAR(38) NOT NULL ,
  PRIMARY KEY (`location_id`) ,
  UNIQUE INDEX `location_uuid_index` (`uuid` ASC) ,
  INDEX `name_of_location` (`name` ASC) ,
  INDEX `retired_status` (`retired` ASC) ,
  INDEX `type_of_location` (`location_type_id` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 787
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`tribe`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`tribe` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`tribe` (
  `tribe_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `retired` TINYINT(1) NOT NULL DEFAULT '0' ,
  `name` VARCHAR(50) NOT NULL DEFAULT '' ,
  PRIMARY KEY (`tribe_id`) )
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`patient`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`patient` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`patient` (
  `patient_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `tribe` INT(11) NULL DEFAULT NULL ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `changed_by` INT(11) NULL DEFAULT NULL ,
  `date_changed` DATETIME NULL DEFAULT NULL ,
  `voided` SMALLINT(6) NOT NULL DEFAULT '0' ,
  `voided_by` INT(11) NULL DEFAULT NULL ,
  `date_voided` DATETIME NULL DEFAULT NULL ,
  `void_reason` VARCHAR(255) NULL DEFAULT NULL ,
  PRIMARY KEY (`patient_id`) )
ENGINE = InnoDB
AUTO_INCREMENT = 21
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`encounter`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`encounter` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`encounter` (
  `encounter_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `encounter_type` INT(11) NOT NULL ,
  `patient_id` INT(11) NOT NULL DEFAULT '0' ,
  `provider_id` INT(11) NOT NULL DEFAULT '0' ,
  `location_id` INT(11) NULL DEFAULT NULL ,
  `form_id` INT(11) NULL DEFAULT NULL ,
  `encounter_datetime` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `voided` SMALLINT(6) NOT NULL DEFAULT '0' ,
  `voided_by` INT(11) NULL DEFAULT NULL ,
  `date_voided` DATETIME NULL DEFAULT NULL ,
  `void_reason` VARCHAR(255) NULL DEFAULT NULL ,
  `uuid` CHAR(38) NOT NULL ,
  `changed_by` INT(11) NULL DEFAULT NULL ,
  `date_changed` DATETIME NULL DEFAULT NULL ,
  PRIMARY KEY (`encounter_id`) ,
  UNIQUE INDEX `encounter_uuid_index` (`uuid` ASC) ,
  INDEX `encounter_datetime_idx` (`encounter_datetime` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`concept_name`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`concept_name` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`concept_name` (
  `concept_id` INT(11) NULL DEFAULT NULL ,
  `name` VARCHAR(255) NOT NULL DEFAULT '' ,
  `locale` VARCHAR(50) NOT NULL DEFAULT '' ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `concept_name_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `voided` SMALLINT(6) NOT NULL DEFAULT '0' ,
  `voided_by` INT(11) NULL DEFAULT NULL ,
  `date_voided` DATETIME NULL DEFAULT NULL ,
  `void_reason` VARCHAR(255) NULL DEFAULT NULL ,
  `uuid` CHAR(38) NOT NULL ,
  `concept_name_type` VARCHAR(50) NULL DEFAULT NULL ,
  `locale_preferred` SMALLINT(6) NULL DEFAULT '0' ,
  PRIMARY KEY (`concept_name_id`) ,
  UNIQUE INDEX `concept_name_id` (`concept_name_id` ASC) ,
  UNIQUE INDEX `concept_name_uuid_index` (`uuid` ASC) ,
  INDEX `name_of_concept` (`name` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 12255
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`order_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`order_type` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`order_type` (
  `order_type_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(255) NOT NULL DEFAULT '' ,
  `description` VARCHAR(255) NOT NULL DEFAULT '' ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `retired` SMALLINT(6) NOT NULL DEFAULT '0' ,
  `retired_by` INT(11) NULL DEFAULT NULL ,
  `date_retired` DATETIME NULL DEFAULT NULL ,
  `retire_reason` VARCHAR(255) NULL DEFAULT NULL ,
  `uuid` CHAR(38) NOT NULL ,
  PRIMARY KEY (`order_type_id`) ,
  UNIQUE INDEX `order_type_uuid_index` (`uuid` ASC) ,
  INDEX `retired_status` (`retired` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`orders` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`orders` (
  `order_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `order_type_id` INT(11) NOT NULL DEFAULT '0' ,
  `concept_id` INT(11) NOT NULL DEFAULT '0' ,
  `orderer` INT(11) NULL DEFAULT '0' ,
  `encounter_id` INT(11) NULL DEFAULT NULL ,
  `instructions` TEXT NULL DEFAULT NULL ,
  `start_date` DATETIME NULL DEFAULT NULL ,
  `auto_expire_date` DATETIME NULL DEFAULT NULL ,
  `discontinued` SMALLINT(6) NOT NULL DEFAULT '0' ,
  `discontinued_date` DATETIME NULL DEFAULT NULL ,
  `discontinued_by` INT(11) NULL DEFAULT NULL ,
  `discontinued_reason` INT(11) NULL DEFAULT NULL ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `voided` SMALLINT(6) NOT NULL DEFAULT '0' ,
  `voided_by` INT(11) NULL DEFAULT NULL ,
  `date_voided` DATETIME NULL DEFAULT NULL ,
  `void_reason` VARCHAR(255) NULL DEFAULT NULL ,
  `patient_id` INT(11) NOT NULL ,
  `accession_number` VARCHAR(255) NULL DEFAULT NULL ,
  `uuid` CHAR(38) NOT NULL ,
  `discontinued_reason_non_coded` VARCHAR(255) NULL DEFAULT NULL ,
  PRIMARY KEY (`order_id`) ,
  UNIQUE INDEX `orders_uuid_index` (`uuid` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 13
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`obs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`obs` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`obs` (
  `obs_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `person_id` INT(11) NOT NULL ,
  `concept_id` INT(11) NOT NULL DEFAULT '0' ,
  `encounter_id` INT(11) NULL DEFAULT NULL ,
  `order_id` INT(11) NULL DEFAULT NULL ,
  `obs_datetime` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `location_id` INT(11) NULL DEFAULT NULL ,
  `obs_group_id` INT(11) NULL DEFAULT NULL ,
  `accession_number` VARCHAR(255) NULL DEFAULT NULL ,
  `value_group_id` INT(11) NULL DEFAULT NULL ,
  `value_boolean` TINYINT(1) NULL DEFAULT NULL ,
  `value_coded` INT(11) NULL DEFAULT NULL ,
  `value_coded_name_id` INT(11) NULL DEFAULT NULL ,
  `value_drug` INT(11) NULL DEFAULT NULL ,
  `value_datetime` DATETIME NULL DEFAULT NULL ,
  `value_numeric` DOUBLE NULL DEFAULT NULL ,
  `value_modifier` VARCHAR(2) NULL DEFAULT NULL ,
  `value_text` TEXT NULL DEFAULT NULL ,
  `date_started` DATETIME NULL DEFAULT NULL ,
  `date_stopped` DATETIME NULL DEFAULT NULL ,
  `comments` VARCHAR(255) NULL DEFAULT NULL ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `voided` SMALLINT(6) NOT NULL DEFAULT '0' ,
  `voided_by` INT(11) NULL DEFAULT NULL ,
  `date_voided` DATETIME NULL DEFAULT NULL ,
  `void_reason` VARCHAR(255) NULL DEFAULT NULL ,
  `value_complex` VARCHAR(255) NULL DEFAULT NULL ,
  `uuid` CHAR(38) NOT NULL ,
  PRIMARY KEY (`obs_id`) ,
  UNIQUE INDEX `obs_uuid_index` (`uuid` ASC) ,
  INDEX `obs_datetime_idx` (`obs_datetime` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`active_list`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`active_list` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`active_list` (
  `active_list_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `active_list_type_id` INT(11) NOT NULL ,
  `person_id` INT(11) NOT NULL ,
  `concept_id` INT(11) NOT NULL ,
  `start_obs_id` INT(11) NULL DEFAULT NULL ,
  `stop_obs_id` INT(11) NULL DEFAULT NULL ,
  `start_date` DATETIME NOT NULL ,
  `end_date` DATETIME NULL DEFAULT NULL ,
  `comments` VARCHAR(255) NULL DEFAULT NULL ,
  `creator` INT(11) NOT NULL ,
  `date_created` DATETIME NOT NULL ,
  `voided` SMALLINT(6) NOT NULL DEFAULT '0' ,
  `voided_by` INT(11) NULL DEFAULT NULL ,
  `date_voided` DATETIME NULL DEFAULT NULL ,
  `void_reason` VARCHAR(255) NULL DEFAULT NULL ,
  `uuid` CHAR(38) NOT NULL ,
  PRIMARY KEY (`active_list_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `patient_billing`.`active_list_allergy`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`active_list_allergy` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`active_list_allergy` (
  `active_list_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `allergy_type` VARCHAR(50) NULL DEFAULT NULL ,
  `reaction_concept_id` INT(11) NULL DEFAULT NULL ,
  `severity` VARCHAR(50) NULL DEFAULT NULL ,
  PRIMARY KEY (`active_list_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `patient_billing`.`active_list_problem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`active_list_problem` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`active_list_problem` (
  `active_list_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `status` VARCHAR(50) NULL DEFAULT NULL ,
  `sort_weight` DOUBLE NULL DEFAULT NULL ,
  PRIMARY KEY (`active_list_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `patient_billing`.`billing_account`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`billing_account` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`billing_account` (
  `account_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `patient_id` INT(11) NOT NULL ,
  `payment_method` VARCHAR(50) NULL DEFAULT NULL ,
  `price_type` VARCHAR(50) NULL DEFAULT NULL ,
  `creator` INT(11) NOT NULL ,
  `voided` TINYINT(1) NOT NULL DEFAULT '0' ,
  `voided_by` INT(11) NULL DEFAULT NULL ,
  `date_voided` DATETIME NULL DEFAULT NULL ,
  `void_reason` VARCHAR(50) NULL DEFAULT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`account_id`) )
ENGINE = InnoDB
AUTO_INCREMENT = 17
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `patient_billing`.`billing_medical_scheme_provider`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`billing_medical_scheme_provider` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`billing_medical_scheme_provider` (
  `medical_scheme_provider_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `company_name` VARCHAR(50) NOT NULL ,
  `company_address` VARCHAR(50) NOT NULL ,
  `provider_type` VARCHAR(50) NOT NULL ,
  `phone_number_1` VARCHAR(30) NOT NULL ,
  `phone_number_2` VARCHAR(30) NULL DEFAULT NULL ,
  `email_address` VARCHAR(30) NULL DEFAULT NULL ,
  `creator` INT(11) NOT NULL ,
  `voided` TINYINT(1) NOT NULL DEFAULT '0' ,
  `voided_by` INT(11) NULL DEFAULT NULL ,
  `void_reason` VARCHAR(50) NULL DEFAULT NULL ,
  `date_voided` DATETIME NULL DEFAULT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`medical_scheme_provider_id`) )
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `patient_billing`.`billing_medical_scheme`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`billing_medical_scheme` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`billing_medical_scheme` (
  `medical_scheme_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(50) NOT NULL ,
  `medical_scheme_provider_id` INT(11) NOT NULL ,
  `creator` INT(11) NOT NULL ,
  `voided` TINYINT(1) NOT NULL DEFAULT '0' ,
  `voided_by` INT(11) NULL DEFAULT NULL ,
  `date_voided` DATETIME NULL DEFAULT NULL ,
  `void_reason` VARCHAR(50) NULL DEFAULT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`medical_scheme_id`) )
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `patient_billing`.`billing_accounts_medical_schemes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`billing_accounts_medical_schemes` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`billing_accounts_medical_schemes` (
  `medical_scheme_id` INT(11) NOT NULL ,
  `account_id` INT(11) NOT NULL ,
  PRIMARY KEY (`medical_scheme_id`, `account_id`) ,
  INDEX `fk_billing_accounts_medical_schemes_1` (`medical_scheme_id` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `patient_billing`.`billing_department`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`billing_department` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`billing_department` (
  `department_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(50) NOT NULL ,
  `creator` INT(11) NOT NULL ,
  `voided` TINYINT(1) NOT NULL DEFAULT '0' ,
  `voided_by` INT(11) NULL DEFAULT NULL ,
  `date_voided` DATETIME NULL DEFAULT NULL ,
  `void_reason` VARCHAR(50) NULL DEFAULT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`department_id`) )
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `patient_billing`.`billing_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`billing_category` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`billing_category` (
  `category_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(50) NOT NULL ,
  `department_id` INT(11) NOT NULL ,
  `creator` INT(11) NOT NULL ,
  `voided` TINYINT(1) NOT NULL DEFAULT '0' ,
  `voided_by` INT(11) NULL DEFAULT NULL ,
  `date_voided` DATETIME NULL DEFAULT NULL ,
  `void_reason` VARCHAR(50) NULL DEFAULT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`category_id`) )
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `patient_billing`.`billing_invoice`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`billing_invoice` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`billing_invoice` (
  `invoice_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `account_id` INT(11) NOT NULL ,
  `invoice_type` CHAR(1) NOT NULL ,
  `payment_method` VARCHAR(50) NOT NULL ,
  `total_amount` DECIMAL(10,0) NOT NULL DEFAULT '0' ,
  `tendered_amount` DECIMAL(10,0) NOT NULL DEFAULT '0' ,
  `change_amount` DECIMAL(10,0) NOT NULL DEFAULT '0' ,
  `paid` TINYINT(1) NOT NULL DEFAULT '0' ,
  `location_id` INT(11) NOT NULL ,
  `creator` INT(11) NOT NULL ,
  `voided` TINYINT(1) NOT NULL DEFAULT '0' ,
  `voided_by` INT(11) NULL DEFAULT NULL ,
  `date_voided` DATETIME NULL DEFAULT NULL ,
  `void_reason` VARCHAR(50) NULL DEFAULT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`invoice_id`) )
ENGINE = InnoDB
AUTO_INCREMENT = 26
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `patient_billing`.`billing_product_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`billing_product_type` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`billing_product_type` (
  `product_type_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(50) NOT NULL ,
  `creator` INT(11) NOT NULL ,
  `voided` TINYINT(1) NOT NULL DEFAULT '0' ,
  `voided_by` INT(11) NULL DEFAULT NULL ,
  `void_reason` VARCHAR(50) NULL DEFAULT NULL ,
  `date_voided` DATETIME NULL DEFAULT NULL ,
  `created_at` DATETIME NULL DEFAULT NULL ,
  `updated_at` DATETIME NULL DEFAULT NULL ,
  PRIMARY KEY (`product_type_id`) )
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `patient_billing`.`billing_product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`billing_product` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`billing_product` (
  `product_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `product_type_id` INT(11) NOT NULL ,
  `category_id` INT(11) NOT NULL ,
  `name` VARCHAR(100) NOT NULL ,
  `creator` INT(11) NOT NULL ,
  `voided` TINYINT(1) NOT NULL DEFAULT '0' ,
  `voided_by` INT(11) NULL DEFAULT NULL ,
  `date_voided` DATETIME NULL DEFAULT NULL ,
  `void_reason` VARCHAR(50) NULL DEFAULT NULL ,
  `created_at` DATETIME NULL DEFAULT NULL ,
  `updated_at` DATETIME NULL DEFAULT NULL ,
  PRIMARY KEY (`product_id`) )
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `patient_billing`.`billing_rules`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`billing_rules` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`billing_rules` (
  `rule_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(50) NOT NULL ,
  `rate` FLOAT NOT NULL ,
  `medical_scheme_id` INT(11) NOT NULL ,
  `creator` INT(11) NOT NULL ,
  `voided` TINYINT(1) NOT NULL DEFAULT '0' ,
  `voided_by` DATETIME NULL DEFAULT NULL ,
  `void_reason` DATETIME NULL DEFAULT NULL ,
  `date_voided` DATETIME NULL DEFAULT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`rule_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `patient_billing`.`billing_invoice_line`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`billing_invoice_line` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`billing_invoice_line` (
  `invoice_line_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `invoice_id` INT(11) NOT NULL ,
  `product_id` INT(11) NOT NULL ,
  `price_id` INT(11) NOT NULL ,
  `quantity` DECIMAL(10,0) NOT NULL ,
  `price_per_unit` DECIMAL(10,0) NOT NULL ,
  `rule_id` INT(11) NULL DEFAULT NULL ,
  `discount_amount` DECIMAL(10,0) NOT NULL DEFAULT '0' ,
  `final_amount` DECIMAL(10,0) NOT NULL ,
  `voided` TINYINT(1) NOT NULL DEFAULT '0' ,
  `voided_by` INT(11) NULL DEFAULT NULL ,
  `void_reason` VARCHAR(50) NULL DEFAULT NULL ,
  `date_voided` DATETIME NULL DEFAULT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`invoice_line_id`) )
ENGINE = InnoDB
AUTO_INCREMENT = 31
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `patient_billing`.`billing_payment_method`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`billing_payment_method` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`billing_payment_method` (
  `payment_method_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(50) NOT NULL ,
  `creator` INT(11) NOT NULL ,
  `voided` TINYINT(1) NOT NULL DEFAULT '0' ,
  `voided_by` INT(11) NULL DEFAULT NULL ,
  `void_reason` VARCHAR(50) NULL DEFAULT NULL ,
  `date_voided` DATETIME NULL DEFAULT NULL ,
  `created_at` DATETIME NULL DEFAULT NULL ,
  `updated_at` DATETIME NULL DEFAULT NULL ,
  PRIMARY KEY (`payment_method_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `patient_billing`.`billing_price`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`billing_price` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`billing_price` (
  `price_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `product_id` INT(11) NOT NULL ,
  `price_type` VARCHAR(50) NOT NULL ,
  `amount` DECIMAL(10,0) NOT NULL ,
  `creator` INT(11) NOT NULL ,
  `voided` TINYINT(1) NOT NULL DEFAULT '0' ,
  `voided_by` INT(11) NULL DEFAULT NULL ,
  `date_voided` DATETIME NULL DEFAULT NULL ,
  `void_reason` VARCHAR(50) NULL DEFAULT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`price_id`) )
ENGINE = InnoDB
AUTO_INCREMENT = 14
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `patient_billing`.`billing_price_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`billing_price_type` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`billing_price_type` (
  `price_type_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(50) NOT NULL ,
  `creator` INT(11) NOT NULL ,
  `voided` TINYINT(1) NOT NULL DEFAULT '0' ,
  `voided_by` INT(11) NULL DEFAULT NULL ,
  `void_reason` VARCHAR(50) NULL DEFAULT NULL ,
  `date_voided` DATETIME NULL DEFAULT NULL ,
  `created_at` DATETIME NULL DEFAULT NULL ,
  `updated_at` DATETIME NULL DEFAULT NULL ,
  PRIMARY KEY (`price_type_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `patient_billing`.`billing_scheme_provider_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`billing_scheme_provider_type` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`billing_scheme_provider_type` (
  `scheme_provider_type_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(50) NOT NULL ,
  `creator` INT(11) NOT NULL ,
  `voided` TINYINT(1) NOT NULL DEFAULT '0' ,
  `voided_by` INT(11) NULL DEFAULT NULL ,
  `void_reason` VARCHAR(50) NULL DEFAULT NULL ,
  `date_voided` DATETIME NULL DEFAULT NULL ,
  `created_at` DATETIME NULL DEFAULT NULL ,
  `updated_at` DATETIME NULL DEFAULT NULL ,
  PRIMARY KEY (`scheme_provider_type_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `patient_billing`.`birth_report`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`birth_report` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`birth_report` (
  `birth_report_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `person_id` INT(11) NULL DEFAULT NULL ,
  `submitted` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP ,
  `acknowledged` DATETIME NULL DEFAULT NULL ,
  PRIMARY KEY (`birth_report_id`) ,
  UNIQUE INDEX `idbirth_report_UNIQUE` (`birth_report_id` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = 'A tracker for birth report transactions. Each submitted repo';


-- -----------------------------------------------------
-- Table `patient_billing`.`cohort`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`cohort` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`cohort` (
  `cohort_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(255) NOT NULL ,
  `description` VARCHAR(1000) NULL DEFAULT NULL ,
  `creator` INT(11) NOT NULL ,
  `date_created` DATETIME NOT NULL ,
  `voided` SMALLINT(6) NOT NULL DEFAULT '0' ,
  `voided_by` INT(11) NULL DEFAULT NULL ,
  `date_voided` DATETIME NULL DEFAULT NULL ,
  `void_reason` VARCHAR(255) NULL DEFAULT NULL ,
  `changed_by` INT(11) NULL DEFAULT NULL ,
  `date_changed` DATETIME NULL DEFAULT NULL ,
  `uuid` CHAR(38) NOT NULL ,
  PRIMARY KEY (`cohort_id`) ,
  UNIQUE INDEX `cohort_uuid_index` (`uuid` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`cohort_member`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`cohort_member` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`cohort_member` (
  `cohort_id` INT(11) NOT NULL DEFAULT '0' ,
  `patient_id` INT(11) NOT NULL DEFAULT '0' ,
  PRIMARY KEY (`cohort_id`, `patient_id`) ,
  INDEX `cohort` (`cohort_id` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`mime_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`mime_type` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`mime_type` (
  `mime_type_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `mime_type` VARCHAR(75) NOT NULL DEFAULT '' ,
  `description` TEXT NULL DEFAULT NULL ,
  PRIMARY KEY (`mime_type_id`) ,
  INDEX `mime_type_id` (`mime_type_id` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`complex_obs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`complex_obs` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`complex_obs` (
  `obs_id` INT(11) NOT NULL DEFAULT '0' ,
  `mime_type_id` INT(11) NOT NULL DEFAULT '0' ,
  `urn` TEXT NULL DEFAULT NULL ,
  `complex_value` LONGTEXT NULL DEFAULT NULL ,
  PRIMARY KEY (`obs_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`concept_answer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`concept_answer` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`concept_answer` (
  `concept_answer_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `concept_id` INT(11) NOT NULL DEFAULT '0' ,
  `answer_concept` INT(11) NULL DEFAULT NULL ,
  `answer_drug` INT(11) NULL DEFAULT NULL ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `uuid` CHAR(38) NOT NULL ,
  `sort_weight` DOUBLE NULL DEFAULT NULL ,
  PRIMARY KEY (`concept_answer_id`) ,
  UNIQUE INDEX `concept_answer_uuid_index` (`uuid` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 9986
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`concept_complex`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`concept_complex` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`concept_complex` (
  `concept_id` INT(11) NOT NULL ,
  `handler` VARCHAR(255) NULL DEFAULT NULL ,
  PRIMARY KEY (`concept_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `patient_billing`.`concept_derived`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`concept_derived` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`concept_derived` (
  `concept_id` INT(11) NOT NULL DEFAULT '0' ,
  `rule` MEDIUMTEXT NULL DEFAULT NULL ,
  `compile_date` DATETIME NULL DEFAULT NULL ,
  `compile_status` VARCHAR(255) NULL DEFAULT NULL ,
  `class_name` VARCHAR(1024) NULL DEFAULT NULL ,
  PRIMARY KEY (`concept_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`concept_description`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`concept_description` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`concept_description` (
  `concept_description_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `concept_id` INT(11) NOT NULL DEFAULT '0' ,
  `description` TEXT NOT NULL ,
  `locale` VARCHAR(50) NOT NULL DEFAULT '' ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `changed_by` INT(11) NULL DEFAULT NULL ,
  `date_changed` DATETIME NULL DEFAULT NULL ,
  `uuid` CHAR(38) NOT NULL ,
  PRIMARY KEY (`concept_description_id`) ,
  UNIQUE INDEX `concept_description_uuid_index` (`uuid` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 6560
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`concept_source`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`concept_source` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`concept_source` (
  `concept_source_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(50) NOT NULL DEFAULT '' ,
  `description` TEXT NOT NULL ,
  `hl7_code` VARCHAR(50) NULL DEFAULT NULL ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `retired` TINYINT(1) NOT NULL ,
  `retired_by` INT(11) NULL DEFAULT NULL ,
  `date_retired` DATETIME NULL DEFAULT NULL ,
  `retire_reason` VARCHAR(255) NULL DEFAULT NULL ,
  `uuid` CHAR(38) NOT NULL ,
  PRIMARY KEY (`concept_source_id`) ,
  UNIQUE INDEX `concept_source_uuid_index` (`uuid` ASC) ,
  INDEX `unique_hl7_code` (`hl7_code` ASC, `retired` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`concept_map`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`concept_map` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`concept_map` (
  `concept_map_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `source` INT(11) NULL DEFAULT NULL ,
  `source_code` VARCHAR(255) NULL DEFAULT NULL ,
  `comment` VARCHAR(255) NULL DEFAULT NULL ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `concept_id` INT(11) NOT NULL DEFAULT '0' ,
  `uuid` CHAR(38) NOT NULL ,
  PRIMARY KEY (`concept_map_id`) ,
  UNIQUE INDEX `concept_map_uuid_index` (`uuid` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 1843
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`concept_name_tag`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`concept_name_tag` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`concept_name_tag` (
  `concept_name_tag_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `tag` VARCHAR(50) NOT NULL ,
  `description` TEXT NOT NULL ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `voided` SMALLINT(6) NOT NULL DEFAULT '0' ,
  `voided_by` INT(11) NULL DEFAULT NULL ,
  `date_voided` DATETIME NULL DEFAULT NULL ,
  `void_reason` VARCHAR(255) NULL DEFAULT NULL ,
  `uuid` CHAR(38) NOT NULL ,
  PRIMARY KEY (`concept_name_tag_id`) ,
  UNIQUE INDEX `concept_name_tag_id` (`concept_name_tag_id` ASC) ,
  UNIQUE INDEX `concept_name_tag_id_2` (`concept_name_tag_id` ASC) ,
  UNIQUE INDEX `concept_name_tag_unique_tags` (`tag` ASC) ,
  UNIQUE INDEX `concept_name_tag_uuid_index` (`uuid` ASC) ,
  INDEX `user_who_created_name_tag` (`creator` ASC) ,
  INDEX `user_who_voided_name_tag` (`voided_by` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 399
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`concept_name_tag_map`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`concept_name_tag_map` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`concept_name_tag_map` (
  `concept_name_id` INT(11) NOT NULL ,
  `concept_name_tag_id` INT(11) NOT NULL )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`concept_numeric`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`concept_numeric` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`concept_numeric` (
  `concept_id` INT(11) NOT NULL DEFAULT '0' ,
  `hi_absolute` DOUBLE NULL DEFAULT NULL ,
  `hi_critical` DOUBLE NULL DEFAULT NULL ,
  `hi_normal` DOUBLE NULL DEFAULT NULL ,
  `low_absolute` DOUBLE NULL DEFAULT NULL ,
  `low_critical` DOUBLE NULL DEFAULT NULL ,
  `low_normal` DOUBLE NULL DEFAULT NULL ,
  `units` VARCHAR(50) NULL DEFAULT NULL ,
  `precise` SMALLINT(6) NOT NULL DEFAULT '0' ,
  PRIMARY KEY (`concept_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`concept_proposal`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`concept_proposal` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`concept_proposal` (
  `concept_proposal_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `concept_id` INT(11) NULL DEFAULT NULL ,
  `encounter_id` INT(11) NULL DEFAULT NULL ,
  `original_text` VARCHAR(255) NOT NULL DEFAULT '' ,
  `final_text` VARCHAR(255) NULL DEFAULT NULL ,
  `obs_id` INT(11) NULL DEFAULT NULL ,
  `obs_concept_id` INT(11) NULL DEFAULT NULL ,
  `state` VARCHAR(32) NOT NULL DEFAULT 'UNMAPPED' COMMENT 'Valid values are: UNMAPPED, SYNONYM, CONCEPT, REJECT' ,
  `comments` VARCHAR(255) NULL DEFAULT NULL COMMENT 'Comment from concept admin/mapper' ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `changed_by` INT(11) NULL DEFAULT NULL ,
  `date_changed` DATETIME NULL DEFAULT NULL ,
  `locale` VARCHAR(50) NOT NULL DEFAULT '' ,
  `uuid` CHAR(38) NOT NULL ,
  PRIMARY KEY (`concept_proposal_id`) ,
  UNIQUE INDEX `concept_proposal_uuid_index` (`uuid` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`concept_proposal_tag_map`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`concept_proposal_tag_map` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`concept_proposal_tag_map` (
  `concept_proposal_id` INT(11) NOT NULL ,
  `concept_name_tag_id` INT(11) NOT NULL )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`concept_set`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`concept_set` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`concept_set` (
  `concept_set_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `concept_id` INT(11) NOT NULL DEFAULT '0' ,
  `concept_set` INT(11) NOT NULL DEFAULT '0' ,
  `sort_weight` DOUBLE NULL DEFAULT NULL ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `uuid` CHAR(38) NOT NULL ,
  PRIMARY KEY (`concept_set_id`) ,
  UNIQUE INDEX `concept_set_uuid_index` (`uuid` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 3456
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`concept_set_derived`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`concept_set_derived` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`concept_set_derived` (
  `concept_id` INT(11) NOT NULL DEFAULT '0' ,
  `concept_set` INT(11) NOT NULL DEFAULT '0' ,
  `sort_weight` DOUBLE NULL DEFAULT NULL ,
  PRIMARY KEY (`concept_id`, `concept_set`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`program`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`program` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`program` (
  `program_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `concept_id` INT(11) NOT NULL DEFAULT '0' ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `changed_by` INT(11) NULL DEFAULT NULL ,
  `date_changed` DATETIME NULL DEFAULT NULL ,
  `retired` SMALLINT(6) NOT NULL DEFAULT '0' ,
  `name` VARCHAR(50) NOT NULL ,
  `description` VARCHAR(500) NULL DEFAULT NULL ,
  `uuid` CHAR(38) NOT NULL ,
  PRIMARY KEY (`program_id`) ,
  UNIQUE INDEX `program_uuid_index` (`uuid` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 17
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`program_workflow`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`program_workflow` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`program_workflow` (
  `program_workflow_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `program_id` INT(11) NOT NULL DEFAULT '0' ,
  `concept_id` INT(11) NOT NULL DEFAULT '0' ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `retired` SMALLINT(6) NOT NULL DEFAULT '0' ,
  `changed_by` INT(11) NULL DEFAULT NULL ,
  `date_changed` DATETIME NULL DEFAULT NULL ,
  `uuid` CHAR(38) NOT NULL ,
  PRIMARY KEY (`program_workflow_id`) ,
  UNIQUE INDEX `program_workflow_uuid_index` (`uuid` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 25
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`program_workflow_state`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`program_workflow_state` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`program_workflow_state` (
  `program_workflow_state_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `program_workflow_id` INT(11) NOT NULL DEFAULT '0' ,
  `concept_id` INT(11) NOT NULL DEFAULT '0' ,
  `initial` SMALLINT(6) NOT NULL DEFAULT '0' ,
  `terminal` SMALLINT(6) NOT NULL DEFAULT '0' ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `retired` SMALLINT(6) NOT NULL DEFAULT '0' ,
  `changed_by` INT(11) NULL DEFAULT NULL ,
  `date_changed` DATETIME NULL DEFAULT NULL ,
  `uuid` CHAR(38) NOT NULL ,
  PRIMARY KEY (`program_workflow_state_id`) ,
  UNIQUE INDEX `program_workflow_state_uuid_index` (`uuid` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 144
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`concept_state_conversion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`concept_state_conversion` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`concept_state_conversion` (
  `concept_state_conversion_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `concept_id` INT(11) NULL DEFAULT '0' ,
  `program_workflow_id` INT(11) NULL DEFAULT '0' ,
  `program_workflow_state_id` INT(11) NULL DEFAULT '0' ,
  `uuid` CHAR(38) NOT NULL ,
  PRIMARY KEY (`concept_state_conversion_id`) ,
  UNIQUE INDEX `concept_state_conversion_uuid_index` (`uuid` ASC) ,
  INDEX `affected_workflow` (`program_workflow_id` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`concept_synonym`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`concept_synonym` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`concept_synonym` (
  `concept_id` INT(11) NOT NULL DEFAULT '0' ,
  `synonym` VARCHAR(255) NOT NULL DEFAULT '' ,
  `locale` VARCHAR(255) NULL DEFAULT NULL ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  PRIMARY KEY (`synonym`, `concept_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`concept_word`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`concept_word` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`concept_word` (
  `concept_word_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `concept_id` INT(11) NOT NULL DEFAULT '0' ,
  `word` VARCHAR(50) NOT NULL DEFAULT '' ,
  `locale` VARCHAR(20) NOT NULL DEFAULT '' ,
  `concept_name_id` INT(11) NOT NULL ,
  PRIMARY KEY (`concept_word_id`) ,
  INDEX `word_in_concept_name` (`word` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 28508
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`region`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`region` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`region` (
  `region_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(255) NOT NULL DEFAULT '' ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `retired` TINYINT(1) NOT NULL DEFAULT '0' ,
  `retired_by` INT(11) NULL DEFAULT NULL ,
  `date_retired` DATETIME NULL DEFAULT NULL ,
  `retire_reason` VARCHAR(255) NULL DEFAULT NULL ,
  PRIMARY KEY (`region_id`) ,
  INDEX `retired_status` (`retired` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`district`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`district` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`district` (
  `district_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(255) NOT NULL DEFAULT '' ,
  `region_id` INT(11) NOT NULL DEFAULT '0' ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `retired` TINYINT(1) NOT NULL DEFAULT '0' ,
  `retired_by` INT(11) NULL DEFAULT NULL ,
  `date_retired` DATETIME NULL DEFAULT NULL ,
  `retire_reason` VARCHAR(255) NULL DEFAULT NULL ,
  PRIMARY KEY (`district_id`) ,
  INDEX `retired_status` (`retired` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 33
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`drug_substance`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`drug_substance` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`drug_substance` (
  `drug_substance_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `concept_id` INT(11) NOT NULL DEFAULT '0' ,
  `name` VARCHAR(50) NULL DEFAULT NULL ,
  `dose_strength` DOUBLE NULL DEFAULT NULL ,
  `maximum_daily_dose` DOUBLE NULL DEFAULT NULL ,
  `minimum_daily_dose` DOUBLE NULL DEFAULT NULL ,
  `route` INT(11) NULL DEFAULT NULL ,
  `units` VARCHAR(50) NULL DEFAULT NULL ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `retired` TINYINT(1) NOT NULL DEFAULT '0' ,
  `retired_by` INT(11) NULL DEFAULT NULL ,
  `date_retired` DATETIME NULL DEFAULT NULL ,
  `retire_reason` DATETIME NULL DEFAULT NULL ,
  PRIMARY KEY (`drug_substance_id`) ,
  INDEX `drug_ingredient_creator` (`creator` ASC) ,
  INDEX `primary_drug_ingredient_concept` (`concept_id` ASC) ,
  INDEX `route_concept` (`route` ASC) ,
  INDEX `user_who_retired_drug` (`retired_by` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`drug_ingredient`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`drug_ingredient` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`drug_ingredient` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `drug_id` INT(11) NOT NULL ,
  `drug_substance_id` INT(11) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`drug_order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`drug_order` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`drug_order` (
  `order_id` INT(11) NOT NULL DEFAULT '0' ,
  `drug_inventory_id` INT(11) NULL DEFAULT '0' ,
  `dose` DOUBLE NULL DEFAULT NULL ,
  `equivalent_daily_dose` DOUBLE NULL DEFAULT NULL ,
  `units` VARCHAR(255) NULL DEFAULT NULL ,
  `frequency` VARCHAR(255) NULL DEFAULT NULL ,
  `prn` SMALLINT(6) NOT NULL DEFAULT '0' ,
  `complex` SMALLINT(6) NOT NULL DEFAULT '0' ,
  `quantity` INT(11) NULL DEFAULT NULL ,
  PRIMARY KEY (`order_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`external_source`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`external_source` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`external_source` (
  `external_source_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `source` INT(11) NOT NULL DEFAULT '0' ,
  `source_code` VARCHAR(255) NOT NULL ,
  `name` VARCHAR(255) NULL DEFAULT NULL ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  PRIMARY KEY (`external_source_id`) )
ENGINE = InnoDB
AUTO_INCREMENT = 1022
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`field_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`field_type` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`field_type` (
  `field_type_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(50) NULL DEFAULT NULL ,
  `description` LONGTEXT NULL DEFAULT NULL ,
  `is_set` SMALLINT(6) NOT NULL DEFAULT '0' ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `uuid` CHAR(38) NOT NULL ,
  PRIMARY KEY (`field_type_id`) ,
  UNIQUE INDEX `field_type_uuid_index` (`uuid` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`field`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`field` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`field` (
  `field_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(255) NOT NULL DEFAULT '' ,
  `description` TEXT NULL DEFAULT NULL ,
  `field_type` INT(11) NULL DEFAULT NULL ,
  `concept_id` INT(11) NULL DEFAULT NULL ,
  `table_name` VARCHAR(50) NULL DEFAULT NULL ,
  `attribute_name` VARCHAR(50) NULL DEFAULT NULL ,
  `default_value` TEXT NULL DEFAULT NULL ,
  `select_multiple` SMALLINT(6) NOT NULL DEFAULT '0' ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `changed_by` INT(11) NULL DEFAULT NULL ,
  `date_changed` DATETIME NULL DEFAULT NULL ,
  `retired` SMALLINT(6) NOT NULL DEFAULT '0' ,
  `retired_by` INT(11) NULL DEFAULT NULL ,
  `date_retired` DATETIME NULL DEFAULT NULL ,
  `retire_reason` VARCHAR(255) NULL DEFAULT NULL ,
  `uuid` CHAR(38) NOT NULL ,
  PRIMARY KEY (`field_id`) ,
  UNIQUE INDEX `field_uuid_index` (`uuid` ASC) ,
  INDEX `field_retired_status` (`retired` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 702
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`field_answer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`field_answer` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`field_answer` (
  `field_id` INT(11) NOT NULL DEFAULT '0' ,
  `answer_id` INT(11) NOT NULL DEFAULT '0' ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `uuid` CHAR(38) NOT NULL ,
  PRIMARY KEY (`field_id`, `answer_id`) ,
  UNIQUE INDEX `field_answer_uuid_index` (`uuid` ASC) ,
  INDEX `answers_for_field` (`field_id` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`form2program_map`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`form2program_map` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`form2program_map` (
  `program` INT(11) NOT NULL ,
  `encounter_type` INT(11) NOT NULL ,
  `creator` INT(11) NOT NULL ,
  `date_created` DATETIME NOT NULL ,
  `changed_by` INT(11) NOT NULL ,
  `date_changed` DATETIME NOT NULL ,
  `applied` TINYINT(1) NOT NULL DEFAULT '0' ,
  PRIMARY KEY (`program`, `encounter_type`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`form_field`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`form_field` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`form_field` (
  `form_field_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `form_id` INT(11) NOT NULL DEFAULT '0' ,
  `field_id` INT(11) NOT NULL DEFAULT '0' ,
  `field_number` INT(11) NULL DEFAULT NULL ,
  `field_part` VARCHAR(5) NULL DEFAULT NULL ,
  `page_number` INT(11) NULL DEFAULT NULL ,
  `parent_form_field` INT(11) NULL DEFAULT NULL ,
  `min_occurs` INT(11) NULL DEFAULT NULL ,
  `max_occurs` INT(11) NULL DEFAULT NULL ,
  `required` SMALLINT(6) NOT NULL DEFAULT '0' ,
  `changed_by` INT(11) NULL DEFAULT NULL ,
  `date_changed` DATETIME NULL DEFAULT NULL ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `sort_weight` FLOAT(11,5) NULL DEFAULT NULL ,
  `uuid` CHAR(38) NOT NULL ,
  PRIMARY KEY (`form_field_id`) ,
  UNIQUE INDEX `form_field_uuid_index` (`uuid` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`formentry_archive`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`formentry_archive` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`formentry_archive` (
  `formentry_archive_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `form_data` MEDIUMTEXT NOT NULL ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  PRIMARY KEY (`formentry_archive_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`formentry_error`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`formentry_error` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`formentry_error` (
  `formentry_error_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `form_data` MEDIUMTEXT NOT NULL ,
  `error` VARCHAR(255) NOT NULL DEFAULT '' ,
  `error_details` TEXT NULL DEFAULT NULL ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  PRIMARY KEY (`formentry_error_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`formentry_queue`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`formentry_queue` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`formentry_queue` (
  `formentry_queue_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `form_data` MEDIUMTEXT NOT NULL ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  PRIMARY KEY (`formentry_queue_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`formentry_xsn`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`formentry_xsn` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`formentry_xsn` (
  `formentry_xsn_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `form_id` INT(11) NOT NULL ,
  `xsn_data` LONGBLOB NOT NULL ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `archived` INT(1) NOT NULL DEFAULT '0' ,
  `archived_by` INT(11) NULL DEFAULT NULL ,
  `date_archived` DATETIME NULL DEFAULT NULL ,
  PRIMARY KEY (`formentry_xsn_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`global_property`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`global_property` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`global_property` (
  `property` VARBINARY(255) NOT NULL DEFAULT '' ,
  `property_value` MEDIUMTEXT NULL DEFAULT NULL ,
  `description` TEXT NULL DEFAULT NULL ,
  `uuid` CHAR(38) NOT NULL ,
  PRIMARY KEY (`property`) ,
  UNIQUE INDEX `global_property_uuid_index` (`uuid` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`hl7_in_archive`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`hl7_in_archive` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`hl7_in_archive` (
  `hl7_in_archive_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `hl7_source` INT(11) NOT NULL DEFAULT '0' ,
  `hl7_source_key` VARCHAR(255) NULL DEFAULT NULL ,
  `hl7_data` MEDIUMTEXT NOT NULL ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `message_state` INT(1) NULL DEFAULT '2' ,
  `uuid` CHAR(38) NOT NULL ,
  PRIMARY KEY (`hl7_in_archive_id`) ,
  UNIQUE INDEX `hl7_in_archive_uuid_index` (`uuid` ASC) ,
  INDEX `hl7_in_archive_message_state_idx` (`message_state` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`hl7_in_error`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`hl7_in_error` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`hl7_in_error` (
  `hl7_in_error_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `hl7_source` INT(11) NOT NULL DEFAULT '0' ,
  `hl7_source_key` TEXT NULL DEFAULT NULL ,
  `hl7_data` MEDIUMTEXT NOT NULL ,
  `error` VARCHAR(255) NOT NULL DEFAULT '' ,
  `error_details` TEXT NULL DEFAULT NULL ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `uuid` CHAR(38) NOT NULL ,
  PRIMARY KEY (`hl7_in_error_id`) ,
  UNIQUE INDEX `hl7_in_error_uuid_index` (`uuid` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`hl7_source`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`hl7_source` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`hl7_source` (
  `hl7_source_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(255) NOT NULL DEFAULT '' ,
  `description` TINYTEXT NULL DEFAULT NULL ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `uuid` CHAR(38) NOT NULL ,
  PRIMARY KEY (`hl7_source_id`) ,
  UNIQUE INDEX `hl7_source_uuid_index` (`uuid` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`hl7_in_queue`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`hl7_in_queue` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`hl7_in_queue` (
  `hl7_in_queue_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `hl7_source` INT(11) NOT NULL DEFAULT '0' ,
  `hl7_source_key` TEXT NULL DEFAULT NULL ,
  `hl7_data` MEDIUMTEXT NOT NULL ,
  `message_state` INT(1) NOT NULL DEFAULT '0' ,
  `date_processed` DATETIME NULL DEFAULT NULL ,
  `error_msg` TEXT NULL DEFAULT NULL ,
  `date_created` DATETIME NULL DEFAULT NULL ,
  `uuid` CHAR(38) NOT NULL ,
  PRIMARY KEY (`hl7_in_queue_id`) ,
  UNIQUE INDEX `hl7_in_queue_uuid_index` (`uuid` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`htmlformentry_html_form`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`htmlformentry_html_form` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`htmlformentry_html_form` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `form_id` INT(11) NULL DEFAULT NULL ,
  `name` VARCHAR(100) NOT NULL ,
  `xml_data` MEDIUMTEXT NOT NULL ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `changed_by` INT(11) NULL DEFAULT NULL ,
  `date_changed` DATETIME NULL DEFAULT NULL ,
  `retired` TINYINT(1) NOT NULL DEFAULT '0' ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`liquibasechangelog`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`liquibasechangelog` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`liquibasechangelog` (
  `ID` VARCHAR(63) NOT NULL ,
  `AUTHOR` VARCHAR(63) NOT NULL ,
  `FILENAME` VARCHAR(200) NOT NULL ,
  `DATEEXECUTED` DATETIME NOT NULL ,
  `MD5SUM` VARCHAR(32) NULL DEFAULT NULL ,
  `DESCRIPTION` VARCHAR(255) NULL DEFAULT NULL ,
  `COMMENTS` VARCHAR(255) NULL DEFAULT NULL ,
  `TAG` VARCHAR(255) NULL DEFAULT NULL ,
  `LIQUIBASE` VARCHAR(10) NULL DEFAULT NULL ,
  PRIMARY KEY (`ID`, `AUTHOR`, `FILENAME`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `patient_billing`.`liquibasechangeloglock`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`liquibasechangeloglock` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`liquibasechangeloglock` (
  `ID` INT(11) NOT NULL ,
  `LOCKED` TINYINT(1) NOT NULL ,
  `LOCKGRANTED` DATETIME NULL DEFAULT NULL ,
  `LOCKEDBY` VARCHAR(255) NULL DEFAULT NULL ,
  PRIMARY KEY (`ID`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `patient_billing`.`location_tag`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`location_tag` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`location_tag` (
  `location_tag_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(50) NULL DEFAULT NULL ,
  `description` VARCHAR(255) NULL DEFAULT NULL ,
  `creator` INT(11) NOT NULL ,
  `date_created` DATETIME NOT NULL ,
  `retired` SMALLINT(6) NOT NULL DEFAULT '0' ,
  `retired_by` INT(11) NULL DEFAULT NULL ,
  `date_retired` DATETIME NULL DEFAULT NULL ,
  `retire_reason` VARCHAR(255) NULL DEFAULT NULL ,
  `uuid` CHAR(38) NOT NULL ,
  PRIMARY KEY (`location_tag_id`) ,
  UNIQUE INDEX `location_tag_uuid_index` (`uuid` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `patient_billing`.`location_tag_map`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`location_tag_map` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`location_tag_map` (
  `location_id` INT(11) NOT NULL ,
  `location_tag_id` INT(11) NOT NULL ,
  PRIMARY KEY (`location_id`, `location_tag_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `patient_billing`.`logic_rule_definition`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`logic_rule_definition` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`logic_rule_definition` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `uuid` CHAR(38) NOT NULL ,
  `name` VARCHAR(255) NOT NULL ,
  `description` VARCHAR(1000) NULL DEFAULT NULL ,
  `rule_content` VARCHAR(2048) NOT NULL ,
  `language` VARCHAR(255) NOT NULL ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `changed_by` INT(11) NULL DEFAULT NULL ,
  `date_changed` DATETIME NULL DEFAULT NULL ,
  `retired` TINYINT(1) NOT NULL DEFAULT '0' ,
  `retired_by` INT(11) NULL DEFAULT NULL ,
  `date_retired` DATETIME NULL DEFAULT NULL ,
  `retire_reason` VARCHAR(255) NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `name` (`name` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`logic_rule_token`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`logic_rule_token` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`logic_rule_token` (
  `logic_rule_token_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `creator` INT(11) NOT NULL ,
  `date_created` DATETIME NOT NULL DEFAULT '0002-11-30 00:00:00' ,
  `changed_by` INT(11) NULL DEFAULT NULL ,
  `date_changed` DATETIME NULL DEFAULT NULL ,
  `token` VARCHAR(512) NOT NULL ,
  `class_name` VARCHAR(512) NOT NULL ,
  `state` VARCHAR(512) NULL DEFAULT NULL ,
  `uuid` CHAR(38) NOT NULL ,
  PRIMARY KEY (`logic_rule_token_id`) ,
  UNIQUE INDEX `logic_rule_token_uuid` (`uuid` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`logic_rule_token_tag`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`logic_rule_token_tag` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`logic_rule_token_tag` (
  `logic_rule_token_id` INT(11) NOT NULL ,
  `tag` VARCHAR(512) NOT NULL )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`logic_token_registration`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`logic_token_registration` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`logic_token_registration` (
  `token_registration_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `creator` INT(11) NOT NULL ,
  `date_created` DATETIME NOT NULL DEFAULT '0002-11-30 00:00:00' ,
  `changed_by` INT(11) NULL DEFAULT NULL ,
  `date_changed` DATETIME NULL DEFAULT NULL ,
  `token` VARCHAR(512) NOT NULL ,
  `provider_class_name` VARCHAR(512) NOT NULL ,
  `provider_token` VARCHAR(512) NOT NULL ,
  `configuration` VARCHAR(2000) NULL DEFAULT NULL ,
  `uuid` CHAR(38) NOT NULL ,
  PRIMARY KEY (`token_registration_id`) ,
  UNIQUE INDEX `uuid` (`uuid` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`logic_token_registration_tag`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`logic_token_registration_tag` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`logic_token_registration_tag` (
  `token_registration_id` INT(11) NOT NULL ,
  `tag` VARCHAR(512) NOT NULL )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`merged_patients`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`merged_patients` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`merged_patients` (
  `patient_id` INT(11) NOT NULL ,
  `merged_to_id` INT(11) NOT NULL ,
  PRIMARY KEY (`patient_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`note`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`note` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`note` (
  `note_id` INT(11) NOT NULL DEFAULT '0' ,
  `note_type` VARCHAR(50) NULL DEFAULT NULL ,
  `patient_id` INT(11) NULL DEFAULT NULL ,
  `obs_id` INT(11) NULL DEFAULT NULL ,
  `encounter_id` INT(11) NULL DEFAULT NULL ,
  `text` TEXT NOT NULL ,
  `priority` INT(11) NULL DEFAULT NULL ,
  `parent` INT(11) NULL DEFAULT NULL ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `changed_by` INT(11) NULL DEFAULT NULL ,
  `date_changed` DATETIME NULL DEFAULT NULL ,
  `uuid` CHAR(38) NOT NULL ,
  PRIMARY KEY (`note_id`) ,
  UNIQUE INDEX `note_uuid_index` (`uuid` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`notification_alert`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`notification_alert` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`notification_alert` (
  `alert_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `text` VARCHAR(512) NOT NULL ,
  `satisfied_by_any` INT(1) NOT NULL DEFAULT '0' ,
  `alert_read` INT(1) NOT NULL DEFAULT '0' ,
  `date_to_expire` DATETIME NULL DEFAULT NULL ,
  `creator` INT(11) NOT NULL ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `changed_by` INT(11) NULL DEFAULT NULL ,
  `date_changed` DATETIME NULL DEFAULT NULL ,
  `uuid` CHAR(38) NOT NULL ,
  PRIMARY KEY (`alert_id`) ,
  UNIQUE INDEX `notification_alert_uuid_index` (`uuid` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`notification_alert_recipient`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`notification_alert_recipient` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`notification_alert_recipient` (
  `alert_id` INT(11) NOT NULL ,
  `user_id` INT(11) NOT NULL ,
  `alert_read` INT(1) NOT NULL DEFAULT '0' ,
  `date_changed` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP ,
  `uuid` CHAR(38) NOT NULL ,
  PRIMARY KEY (`alert_id`, `user_id`) ,
  INDEX `id_of_alert` (`alert_id` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`notification_template`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`notification_template` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`notification_template` (
  `template_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(50) NULL DEFAULT NULL ,
  `template` TEXT NULL DEFAULT NULL ,
  `subject` VARCHAR(100) NULL DEFAULT NULL ,
  `sender` VARCHAR(255) NULL DEFAULT NULL ,
  `recipients` VARCHAR(512) NULL DEFAULT NULL ,
  `ordinal` INT(11) NULL DEFAULT '0' ,
  `uuid` CHAR(38) NOT NULL ,
  PRIMARY KEY (`template_id`) ,
  UNIQUE INDEX `notification_template_uuid_index` (`uuid` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`order_extension`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`order_extension` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`order_extension` (
  `order_extension_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `order_id` INT(11) NOT NULL ,
  `value` VARCHAR(50) NOT NULL DEFAULT '' ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `voided` TINYINT(1) NOT NULL DEFAULT '0' ,
  `voided_by` INT(11) NULL DEFAULT NULL ,
  `date_voided` DATETIME NULL DEFAULT NULL ,
  `void_reason` VARCHAR(255) NULL DEFAULT NULL ,
  PRIMARY KEY (`order_extension_id`) ,
  INDEX `retired_status` (`voided` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`patient_identifier_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`patient_identifier_type` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`patient_identifier_type` (
  `patient_identifier_type_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(50) NOT NULL DEFAULT '' ,
  `description` TEXT NOT NULL ,
  `format` VARCHAR(50) NULL DEFAULT NULL ,
  `check_digit` SMALLINT(6) NOT NULL DEFAULT '0' ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `required` SMALLINT(6) NOT NULL DEFAULT '0' ,
  `format_description` VARCHAR(255) NULL DEFAULT NULL ,
  `validator` VARCHAR(200) NULL DEFAULT NULL ,
  `retired` SMALLINT(6) NOT NULL DEFAULT '0' ,
  `retired_by` INT(11) NULL DEFAULT NULL ,
  `date_retired` DATETIME NULL DEFAULT NULL ,
  `retire_reason` VARCHAR(255) NULL DEFAULT NULL ,
  `uuid` CHAR(38) NOT NULL ,
  PRIMARY KEY (`patient_identifier_type_id`) ,
  UNIQUE INDEX `patient_identifier_type_uuid_index` (`uuid` ASC) ,
  INDEX `retired_status` (`retired` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 23
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`patient_identifier`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`patient_identifier` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`patient_identifier` (
  `patient_identifier_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `patient_id` INT(11) NOT NULL DEFAULT '0' ,
  `identifier` VARCHAR(50) NOT NULL DEFAULT '' ,
  `identifier_type` INT(11) NOT NULL DEFAULT '0' ,
  `preferred` SMALLINT(6) NOT NULL DEFAULT '0' ,
  `location_id` INT(11) NOT NULL DEFAULT '0' ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `voided` SMALLINT(6) NOT NULL DEFAULT '0' ,
  `voided_by` INT(11) NULL DEFAULT NULL ,
  `date_voided` DATETIME NULL DEFAULT NULL ,
  `void_reason` VARCHAR(255) NULL DEFAULT NULL ,
  `uuid` CHAR(38) NOT NULL ,
  PRIMARY KEY (`patient_identifier_id`) ,
  UNIQUE INDEX `patient_identifier_uuid_index` (`uuid` ASC) ,
  INDEX `identifier_name` (`identifier` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 20
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`patient_program`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`patient_program` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`patient_program` (
  `patient_program_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `patient_id` INT(11) NOT NULL DEFAULT '0' ,
  `program_id` INT(11) NOT NULL DEFAULT '0' ,
  `date_enrolled` DATETIME NULL DEFAULT NULL ,
  `date_completed` DATETIME NULL DEFAULT NULL ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `changed_by` INT(11) NULL DEFAULT NULL ,
  `date_changed` DATETIME NULL DEFAULT NULL ,
  `voided` SMALLINT(6) NOT NULL DEFAULT '0' ,
  `voided_by` INT(11) NULL DEFAULT NULL ,
  `date_voided` DATETIME NULL DEFAULT NULL ,
  `void_reason` VARCHAR(255) NULL DEFAULT NULL ,
  `location_id` INT(11) NULL DEFAULT NULL ,
  `uuid` CHAR(38) NOT NULL ,
  PRIMARY KEY (`patient_program_id`) ,
  UNIQUE INDEX `patient_program_uuid_index` (`uuid` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 81
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`patient_report`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`patient_report` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`patient_report` (
  `patient_report_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `patient_id` INT(11) NULL DEFAULT NULL ,
  `delivery_mode` VARCHAR(255) NULL DEFAULT NULL ,
  `delivery_date` DATETIME NULL DEFAULT NULL ,
  `babies` INT(11) NULL DEFAULT NULL ,
  `birthdate` DATETIME NULL DEFAULT NULL ,
  `outcome` VARCHAR(255) NULL DEFAULT NULL ,
  `outcome_date` DATETIME NULL DEFAULT NULL ,
  `admission_ward` VARCHAR(255) NULL DEFAULT NULL ,
  `admission_date` DATETIME NULL DEFAULT NULL ,
  `diagnosis` VARCHAR(255) NULL DEFAULT NULL ,
  `diagnosis_date` DATETIME NULL DEFAULT NULL ,
  `source_ward` VARCHAR(255) NULL DEFAULT NULL ,
  `destination_ward` VARCHAR(255) NULL DEFAULT NULL ,
  `internal_transfer_date` DATETIME NULL DEFAULT NULL ,
  `referral_in` DATETIME NULL DEFAULT NULL ,
  `referral_out` DATETIME NULL DEFAULT NULL ,
  `baby_outcome` VARCHAR(255) NULL DEFAULT NULL ,
  `baby_outcome_date` DATETIME NULL DEFAULT NULL ,
  `procedure_done` VARCHAR(255) NULL DEFAULT NULL ,
  `procedure_date` DATETIME NULL DEFAULT NULL ,
  `discharged_home` DATETIME NULL DEFAULT NULL ,
  `obs_datetime` DATETIME NULL DEFAULT NULL ,
  `obs_id` INT(11) NULL DEFAULT NULL ,
  `last_ward_where_seen` VARCHAR(255) NULL DEFAULT NULL ,
  `last_ward_where_seen_date` DATETIME NULL DEFAULT NULL ,
  `bba_babies` INT(11) NULL DEFAULT NULL ,
  `bba_date` DATETIME NULL DEFAULT NULL ,
  `discharged` DATETIME NULL DEFAULT NULL ,
  `discharge_ward` VARCHAR(255) NULL DEFAULT NULL ,
  PRIMARY KEY (`patient_report_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `patient_billing`.`patient_state`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`patient_state` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`patient_state` (
  `patient_state_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `patient_program_id` INT(11) NOT NULL DEFAULT '0' ,
  `state` INT(11) NOT NULL DEFAULT '0' ,
  `start_date` DATE NULL DEFAULT NULL ,
  `end_date` DATE NULL DEFAULT NULL ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `changed_by` INT(11) NULL DEFAULT NULL ,
  `date_changed` DATETIME NULL DEFAULT NULL ,
  `voided` SMALLINT(6) NOT NULL DEFAULT '0' ,
  `voided_by` INT(11) NULL DEFAULT NULL ,
  `date_voided` DATETIME NULL DEFAULT NULL ,
  `void_reason` VARCHAR(255) NULL DEFAULT NULL ,
  `uuid` CHAR(38) NOT NULL ,
  PRIMARY KEY (`patient_state_id`) ,
  UNIQUE INDEX `patient_state_uuid_index` (`uuid` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 72
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`patientflags_flag`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`patientflags_flag` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`patientflags_flag` (
  `flag_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(255) NOT NULL ,
  `criteria` VARCHAR(5000) NOT NULL ,
  `message` VARCHAR(255) NOT NULL ,
  `enabled` TINYINT(1) NOT NULL ,
  `evaluator` VARCHAR(255) NOT NULL ,
  `description` VARCHAR(1000) NULL DEFAULT NULL ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `changed_by` INT(11) NULL DEFAULT NULL ,
  `date_changed` DATETIME NULL DEFAULT NULL ,
  `retired` TINYINT(1) NOT NULL DEFAULT '0' ,
  `retired_by` INT(11) NULL DEFAULT NULL ,
  `date_retired` DATETIME NULL DEFAULT NULL ,
  `retire_reason` VARCHAR(255) NULL DEFAULT NULL ,
  `uuid` CHAR(38) NOT NULL ,
  PRIMARY KEY (`flag_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`patientflags_tag`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`patientflags_tag` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`patientflags_tag` (
  `tag_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `tag` VARCHAR(255) NOT NULL ,
  `description` VARCHAR(1000) NULL DEFAULT NULL ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `changed_by` INT(11) NULL DEFAULT NULL ,
  `date_changed` DATETIME NULL DEFAULT NULL ,
  `retired` TINYINT(1) NOT NULL DEFAULT '0' ,
  `retired_by` INT(11) NULL DEFAULT NULL ,
  `date_retired` DATETIME NULL DEFAULT NULL ,
  `retire_reason` VARCHAR(255) NULL DEFAULT NULL ,
  `uuid` CHAR(38) NOT NULL ,
  PRIMARY KEY (`tag_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`patientflags_flag_tag`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`patientflags_flag_tag` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`patientflags_flag_tag` (
  `flag_id` INT(11) NOT NULL ,
  `tag_id` INT(11) NOT NULL )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`patients_for_location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`patients_for_location` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`patients_for_location` (
  `patient_id` INT(11) NOT NULL ,
  PRIMARY KEY (`patient_id`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`patients_to_merge`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`patients_to_merge` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`patients_to_merge` (
  `patient_id` INT(11) NULL DEFAULT NULL ,
  `to_merge_to_id` INT(11) NULL DEFAULT NULL )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`person_address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`person_address` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`person_address` (
  `person_address_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `person_id` INT(11) NULL DEFAULT NULL ,
  `preferred` SMALLINT(6) NOT NULL DEFAULT '0' ,
  `address1` VARCHAR(50) NULL DEFAULT NULL ,
  `address2` VARCHAR(50) NULL DEFAULT NULL ,
  `city_village` VARCHAR(50) NULL DEFAULT NULL ,
  `state_province` VARCHAR(50) NULL DEFAULT NULL ,
  `postal_code` VARCHAR(50) NULL DEFAULT NULL ,
  `country` VARCHAR(50) NULL DEFAULT NULL ,
  `latitude` VARCHAR(50) NULL DEFAULT NULL ,
  `longitude` VARCHAR(50) NULL DEFAULT NULL ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `voided` SMALLINT(6) NOT NULL DEFAULT '0' ,
  `voided_by` INT(11) NULL DEFAULT NULL ,
  `date_voided` DATETIME NULL DEFAULT NULL ,
  `void_reason` VARCHAR(255) NULL DEFAULT NULL ,
  `county_district` VARCHAR(50) NULL DEFAULT NULL ,
  `neighborhood_cell` VARCHAR(50) NULL DEFAULT NULL ,
  `region` VARCHAR(50) NULL DEFAULT NULL ,
  `subregion` VARCHAR(50) NULL DEFAULT NULL ,
  `township_division` VARCHAR(50) NULL DEFAULT NULL ,
  `uuid` CHAR(38) NOT NULL ,
  PRIMARY KEY (`person_address_id`) ,
  UNIQUE INDEX `person_address_uuid_index` (`uuid` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`privilege`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`privilege` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`privilege` (
  `privilege` VARCHAR(50) NOT NULL DEFAULT '' ,
  `description` VARCHAR(250) NOT NULL DEFAULT '' ,
  `uuid` CHAR(38) NOT NULL ,
  PRIMARY KEY (`privilege`) ,
  UNIQUE INDEX `privilege_uuid_index` (`uuid` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`person_attribute_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`person_attribute_type` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`person_attribute_type` (
  `person_attribute_type_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(50) NOT NULL DEFAULT '' ,
  `description` TEXT NOT NULL ,
  `format` VARCHAR(50) NULL DEFAULT NULL ,
  `foreign_key` INT(11) NULL DEFAULT NULL ,
  `searchable` SMALLINT(6) NOT NULL DEFAULT '0' ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `changed_by` INT(11) NULL DEFAULT NULL ,
  `date_changed` DATETIME NULL DEFAULT NULL ,
  `retired` SMALLINT(6) NOT NULL DEFAULT '0' ,
  `retired_by` INT(11) NULL DEFAULT NULL ,
  `date_retired` DATETIME NULL DEFAULT NULL ,
  `retire_reason` VARCHAR(255) NULL DEFAULT NULL ,
  `edit_privilege` VARCHAR(255) NULL DEFAULT NULL ,
  `uuid` CHAR(38) NOT NULL ,
  `sort_weight` DOUBLE NULL DEFAULT NULL ,
  PRIMARY KEY (`person_attribute_type_id`) ,
  UNIQUE INDEX `person_attribute_type_uuid_index` (`uuid` ASC) ,
  INDEX `name_of_attribute` (`name` ASC) ,
  INDEX `attribute_is_searchable` (`searchable` ASC) ,
  INDEX `person_attribute_type_retired_status` (`retired` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 31
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`person_attribute`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`person_attribute` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`person_attribute` (
  `person_attribute_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `person_id` INT(11) NOT NULL DEFAULT '0' ,
  `value` VARCHAR(50) NOT NULL DEFAULT '' ,
  `person_attribute_type_id` INT(11) NOT NULL DEFAULT '0' ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `changed_by` INT(11) NULL DEFAULT NULL ,
  `date_changed` DATETIME NULL DEFAULT NULL ,
  `voided` SMALLINT(6) NOT NULL DEFAULT '0' ,
  `voided_by` INT(11) NULL DEFAULT NULL ,
  `date_voided` DATETIME NULL DEFAULT NULL ,
  `void_reason` VARCHAR(255) NULL DEFAULT NULL ,
  `uuid` CHAR(38) NOT NULL ,
  PRIMARY KEY (`person_attribute_id`) ,
  UNIQUE INDEX `person_attribute_uuid_index` (`uuid` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 34
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`person_name`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`person_name` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`person_name` (
  `person_name_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `preferred` SMALLINT(6) NOT NULL DEFAULT '0' ,
  `person_id` INT(11) NULL DEFAULT NULL ,
  `prefix` VARCHAR(50) NULL DEFAULT NULL ,
  `given_name` VARCHAR(50) NULL DEFAULT NULL ,
  `middle_name` VARCHAR(50) NULL DEFAULT NULL ,
  `family_name_prefix` VARCHAR(50) NULL DEFAULT NULL ,
  `family_name` VARCHAR(50) NULL DEFAULT NULL ,
  `family_name2` VARCHAR(50) NULL DEFAULT NULL ,
  `family_name_suffix` VARCHAR(50) NULL DEFAULT NULL ,
  `degree` VARCHAR(50) NULL DEFAULT NULL ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `voided` SMALLINT(6) NOT NULL DEFAULT '0' ,
  `voided_by` INT(11) NULL DEFAULT NULL ,
  `date_voided` DATETIME NULL DEFAULT NULL ,
  `void_reason` VARCHAR(255) NULL DEFAULT NULL ,
  `changed_by` INT(11) NULL DEFAULT NULL ,
  `date_changed` DATETIME NULL DEFAULT NULL ,
  `uuid` CHAR(38) NOT NULL ,
  PRIMARY KEY (`person_name_id`) ,
  UNIQUE INDEX `person_name_uuid_index` (`uuid` ASC) ,
  INDEX `first_name` (`given_name` ASC) ,
  INDEX `middle_name` (`middle_name` ASC) ,
  INDEX `last_name` (`family_name` ASC) ,
  INDEX `family_name2` (`family_name2` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 21
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`person_name_code`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`person_name_code` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`person_name_code` (
  `person_name_code_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `person_name_id` INT(11) NULL DEFAULT NULL ,
  `given_name_code` VARCHAR(50) NULL DEFAULT NULL ,
  `middle_name_code` VARCHAR(50) NULL DEFAULT NULL ,
  `family_name_code` VARCHAR(50) NULL DEFAULT NULL ,
  `family_name2_code` VARCHAR(50) NULL DEFAULT NULL ,
  `family_name_suffix_code` VARCHAR(50) NULL DEFAULT NULL ,
  PRIMARY KEY (`person_name_code_id`) ,
  INDEX `given_name_code` (`given_name_code` ASC) ,
  INDEX `middle_name_code` (`middle_name_code` ASC) ,
  INDEX `family_name_code` (`family_name_code` ASC) ,
  INDEX `given_family_name_code` (`given_name_code` ASC, `family_name_code` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`program_encounter`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`program_encounter` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`program_encounter` (
  `program_encounter_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `patient_id` INT(11) NULL DEFAULT NULL ,
  `date_time` DATETIME NULL DEFAULT NULL ,
  `program_id` INT(11) NULL DEFAULT NULL ,
  PRIMARY KEY (`program_encounter_id`) )
ENGINE = InnoDB
AUTO_INCREMENT = 48
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `patient_billing`.`program_encounter_details`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`program_encounter_details` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`program_encounter_details` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `encounter_id` INT(11) NULL DEFAULT NULL ,
  `program_encounter_id` INT(11) NULL DEFAULT NULL ,
  `program_id` INT(11) NULL DEFAULT NULL ,
  `voided` INT(1) NULL DEFAULT '0' ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
AUTO_INCREMENT = 539
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `patient_billing`.`program_encounter_type_map`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`program_encounter_type_map` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`program_encounter_type_map` (
  `program_encounter_type_map_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `program_id` INT(11) NULL DEFAULT NULL ,
  `encounter_type_id` INT(11) NULL DEFAULT NULL ,
  PRIMARY KEY (`program_encounter_type_map_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`program_location_restriction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`program_location_restriction` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`program_location_restriction` (
  `program_location_restriction_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `program_id` INT(11) NULL DEFAULT NULL ,
  `location_id` INT(11) NULL DEFAULT NULL ,
  PRIMARY KEY (`program_location_restriction_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`program_orders_map`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`program_orders_map` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`program_orders_map` (
  `program_orders_map_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `program_id` INT(11) NULL DEFAULT NULL ,
  `concept_id` INT(11) NULL DEFAULT NULL ,
  PRIMARY KEY (`program_orders_map_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`program_patient_identifier_type_map`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`program_patient_identifier_type_map` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`program_patient_identifier_type_map` (
  `program_patient_identifier_type_map_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `program_id` INT(11) NULL DEFAULT NULL ,
  `patient_identifier_type_id` INT(11) NULL DEFAULT NULL ,
  PRIMARY KEY (`program_patient_identifier_type_map_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`relationship_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`relationship_type` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`relationship_type` (
  `relationship_type_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `a_is_to_b` VARCHAR(50) NOT NULL ,
  `b_is_to_a` VARCHAR(50) NOT NULL ,
  `preferred` INT(1) NOT NULL DEFAULT '0' ,
  `weight` INT(11) NOT NULL DEFAULT '0' ,
  `description` VARCHAR(255) NOT NULL DEFAULT '' ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `uuid` CHAR(38) NOT NULL ,
  `retired` TINYINT(1) NOT NULL DEFAULT '0' ,
  `retired_by` INT(11) NULL DEFAULT NULL ,
  `date_retired` DATETIME NULL DEFAULT NULL ,
  `retire_reason` VARCHAR(255) NULL DEFAULT NULL ,
  PRIMARY KEY (`relationship_type_id`) ,
  UNIQUE INDEX `relationship_type_uuid_index` (`uuid` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 14
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`program_relationship_type_map`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`program_relationship_type_map` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`program_relationship_type_map` (
  `program_relationship_type_map_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `program_id` INT(11) NULL DEFAULT NULL ,
  `relationship_type_id` INT(11) NULL DEFAULT NULL ,
  PRIMARY KEY (`program_relationship_type_map_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`regimen`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`regimen` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`regimen` (
  `regimen_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `concept_id` INT(11) NOT NULL DEFAULT '0' ,
  `min_weight` INT(3) NOT NULL DEFAULT '0' ,
  `max_weight` INT(3) NOT NULL DEFAULT '200' ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `retired` SMALLINT(6) NOT NULL DEFAULT '0' ,
  `retired_by` INT(11) NULL DEFAULT NULL ,
  `date_retired` DATETIME NULL DEFAULT NULL ,
  `program_id` INT(11) NOT NULL DEFAULT '0' ,
  PRIMARY KEY (`regimen_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`regimen_drug_order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`regimen_drug_order` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`regimen_drug_order` (
  `regimen_drug_order_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `regimen_id` INT(11) NOT NULL DEFAULT '0' ,
  `drug_inventory_id` INT(11) NULL DEFAULT '0' ,
  `dose` DOUBLE NULL DEFAULT NULL ,
  `equivalent_daily_dose` DOUBLE NULL DEFAULT NULL ,
  `units` VARCHAR(255) NULL DEFAULT NULL ,
  `frequency` VARCHAR(255) NULL DEFAULT NULL ,
  `prn` TINYINT(1) NOT NULL DEFAULT '0' ,
  `complex` TINYINT(1) NOT NULL DEFAULT '0' ,
  `quantity` INT(11) NULL DEFAULT NULL ,
  `instructions` TEXT NULL DEFAULT NULL ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `voided` SMALLINT(6) NOT NULL DEFAULT '0' ,
  `voided_by` INT(11) NULL DEFAULT NULL ,
  `date_voided` DATETIME NULL DEFAULT NULL ,
  `void_reason` VARCHAR(255) NULL DEFAULT NULL ,
  `uuid` CHAR(38) NOT NULL ,
  PRIMARY KEY (`regimen_drug_order_id`) ,
  UNIQUE INDEX `regimen_drug_order_uuid_index` (`uuid` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`relationship`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`relationship` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`relationship` (
  `relationship_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `person_a` INT(11) NOT NULL ,
  `relationship` INT(11) NOT NULL DEFAULT '0' ,
  `person_b` INT(11) NOT NULL ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `voided` SMALLINT(6) NOT NULL DEFAULT '0' ,
  `voided_by` INT(11) NULL DEFAULT NULL ,
  `date_voided` DATETIME NULL DEFAULT NULL ,
  `void_reason` VARCHAR(255) NULL DEFAULT NULL ,
  `uuid` CHAR(38) NULL DEFAULT NULL ,
  PRIMARY KEY (`relationship_id`) ,
  UNIQUE INDEX `relationship_uuid_index` (`uuid` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 77
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`report_def`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`report_def` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`report_def` (
  `report_def_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` MEDIUMTEXT NOT NULL ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  PRIMARY KEY (`report_def_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`report_object`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`report_object` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`report_object` (
  `report_object_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(255) NOT NULL ,
  `description` VARCHAR(1000) NULL DEFAULT NULL ,
  `report_object_type` VARCHAR(255) NOT NULL ,
  `report_object_sub_type` VARCHAR(255) NOT NULL ,
  `xml_data` TEXT NULL DEFAULT NULL ,
  `creator` INT(11) NOT NULL ,
  `date_created` DATETIME NOT NULL ,
  `changed_by` INT(11) NULL DEFAULT NULL ,
  `date_changed` DATETIME NULL DEFAULT NULL ,
  `voided` SMALLINT(6) NOT NULL DEFAULT '0' ,
  `voided_by` INT(11) NULL DEFAULT NULL ,
  `date_voided` DATETIME NULL DEFAULT NULL ,
  `void_reason` VARCHAR(255) NULL DEFAULT NULL ,
  `uuid` CHAR(38) NOT NULL ,
  PRIMARY KEY (`report_object_id`) ,
  UNIQUE INDEX `report_object_uuid_index` (`uuid` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`report_schema_xml`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`report_schema_xml` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`report_schema_xml` (
  `report_schema_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(255) NOT NULL ,
  `description` TEXT NOT NULL ,
  `xml_data` MEDIUMTEXT NOT NULL ,
  `uuid` CHAR(38) NOT NULL ,
  PRIMARY KEY (`report_schema_id`) ,
  UNIQUE INDEX `report_schema_xml_uuid_index` (`uuid` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`serialized_object`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`serialized_object` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`serialized_object` (
  `serialized_object_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(255) NOT NULL ,
  `description` VARCHAR(5000) NULL DEFAULT NULL ,
  `type` VARCHAR(255) NOT NULL ,
  `subtype` VARCHAR(255) NOT NULL ,
  `serialization_class` VARCHAR(255) NOT NULL ,
  `serialized_data` TEXT NOT NULL ,
  `date_created` DATETIME NOT NULL ,
  `creator` INT(11) NOT NULL ,
  `date_changed` DATETIME NULL DEFAULT NULL ,
  `changed_by` INT(11) NULL DEFAULT NULL ,
  `retired` SMALLINT(6) NOT NULL DEFAULT '0' ,
  `date_retired` DATETIME NULL DEFAULT NULL ,
  `retired_by` INT(11) NULL DEFAULT NULL ,
  `retire_reason` VARCHAR(1000) NULL DEFAULT NULL ,
  `uuid` CHAR(38) NOT NULL ,
  PRIMARY KEY (`serialized_object_id`) ,
  UNIQUE INDEX `serialized_object_uuid_index` (`uuid` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `patient_billing`.`reporting_report_design`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`reporting_report_design` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`reporting_report_design` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `uuid` CHAR(38) NOT NULL ,
  `name` VARCHAR(255) NOT NULL ,
  `description` VARCHAR(1000) NULL DEFAULT NULL ,
  `report_definition_id` INT(11) NOT NULL DEFAULT '0' ,
  `renderer_type` VARCHAR(255) NOT NULL ,
  `properties` TEXT NULL DEFAULT NULL ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `changed_by` INT(11) NULL DEFAULT NULL ,
  `date_changed` DATETIME NULL DEFAULT NULL ,
  `retired` TINYINT(1) NOT NULL DEFAULT '0' ,
  `retired_by` INT(11) NULL DEFAULT NULL ,
  `date_retired` DATETIME NULL DEFAULT NULL ,
  `retire_reason` VARCHAR(255) NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`reporting_report_design_resource`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`reporting_report_design_resource` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`reporting_report_design_resource` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `uuid` CHAR(38) NOT NULL ,
  `name` VARCHAR(255) NOT NULL ,
  `description` VARCHAR(1000) NULL DEFAULT NULL ,
  `report_design_id` INT(11) NOT NULL DEFAULT '0' ,
  `content_type` VARCHAR(50) NULL DEFAULT NULL ,
  `extension` VARCHAR(20) NULL DEFAULT NULL ,
  `contents` LONGBLOB NULL DEFAULT NULL ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `changed_by` INT(11) NULL DEFAULT NULL ,
  `date_changed` DATETIME NULL DEFAULT NULL ,
  `retired` TINYINT(1) NOT NULL DEFAULT '0' ,
  `retired_by` INT(11) NULL DEFAULT NULL ,
  `date_retired` DATETIME NULL DEFAULT NULL ,
  `retire_reason` VARCHAR(255) NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`role` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`role` (
  `role` VARCHAR(50) NOT NULL DEFAULT '' ,
  `description` VARCHAR(255) NOT NULL DEFAULT '' ,
  `uuid` CHAR(38) NOT NULL ,
  PRIMARY KEY (`role`) ,
  UNIQUE INDEX `role_uuid_index` (`uuid` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`role_privilege`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`role_privilege` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`role_privilege` (
  `role` VARCHAR(50) NOT NULL DEFAULT '' ,
  `privilege` VARCHAR(50) NOT NULL DEFAULT '' ,
  PRIMARY KEY (`privilege`, `role`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`role_role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`role_role` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`role_role` (
  `parent_role` VARCHAR(50) NOT NULL DEFAULT '' ,
  `child_role` VARCHAR(255) NOT NULL DEFAULT '' ,
  PRIMARY KEY (`parent_role`, `child_role`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`scheduler_task_config`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`scheduler_task_config` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`scheduler_task_config` (
  `task_config_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(255) NOT NULL ,
  `description` VARCHAR(1024) NULL DEFAULT NULL ,
  `schedulable_class` TEXT NULL DEFAULT NULL ,
  `start_time` DATETIME NULL DEFAULT NULL ,
  `start_time_pattern` VARCHAR(50) NULL DEFAULT NULL ,
  `repeat_interval` INT(11) NOT NULL DEFAULT '0' ,
  `start_on_startup` INT(1) NOT NULL DEFAULT '0' ,
  `started` INT(1) NOT NULL DEFAULT '0' ,
  `created_by` INT(11) NULL DEFAULT '0' ,
  `date_created` DATETIME NULL DEFAULT '2005-01-01 00:00:00' ,
  `changed_by` INT(11) NULL DEFAULT NULL ,
  `date_changed` DATETIME NULL DEFAULT NULL ,
  `uuid` CHAR(38) NOT NULL ,
  `last_execution_time` DATETIME NULL DEFAULT NULL ,
  PRIMARY KEY (`task_config_id`) ,
  UNIQUE INDEX `scheduler_task_config_uuid_index` (`uuid` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`scheduler_task_config_property`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`scheduler_task_config_property` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`scheduler_task_config_property` (
  `task_config_property_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(255) NOT NULL ,
  `value` TEXT NULL DEFAULT NULL ,
  `task_config_id` INT(11) NULL DEFAULT NULL ,
  PRIMARY KEY (`task_config_property_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`schema_info`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`schema_info` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`schema_info` (
  `version` INT(11) NULL DEFAULT NULL )
ENGINE = MyISAM
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `patient_billing`.`schema_migrations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`schema_migrations` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`schema_migrations` (
  `version` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL ,
  UNIQUE INDEX `unique_schema_migrations` (`version` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `patient_billing`.`serial_number`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`serial_number` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`serial_number` (
  `serial_number` INT(11) NOT NULL ,
  `national_id` VARCHAR(30) NULL DEFAULT NULL ,
  `date_assigned` DATETIME NULL DEFAULT NULL ,
  `date_created` DATETIME NULL DEFAULT NULL ,
  `creator` INT(11) NULL DEFAULT NULL ,
  `voided` TINYINT(1) NOT NULL DEFAULT '0' ,
  `voided_by` INT(11) NULL DEFAULT NULL ,
  PRIMARY KEY (`serial_number`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = latin1
COMMENT = 'Link between person and issued serial number';


-- -----------------------------------------------------
-- Table `patient_billing`.`sessions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`sessions` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`sessions` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `session_id` VARCHAR(255) NULL DEFAULT NULL ,
  `data` TEXT NULL DEFAULT NULL ,
  `updated_at` DATETIME NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `sessions_session_id_index` (`session_id` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 297
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `patient_billing`.`task`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`task` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`task` (
  `task_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `url` VARCHAR(255) NULL DEFAULT NULL ,
  `encounter_type` VARCHAR(255) NULL DEFAULT NULL ,
  `description` TEXT NULL DEFAULT NULL ,
  `location` VARCHAR(255) NULL DEFAULT NULL ,
  `gender` VARCHAR(50) NULL DEFAULT NULL ,
  `has_obs_concept_id` INT(11) NULL DEFAULT NULL ,
  `has_obs_value_coded` INT(11) NULL DEFAULT NULL ,
  `has_obs_value_drug` INT(11) NULL DEFAULT NULL ,
  `has_obs_value_datetime` DATETIME NULL DEFAULT NULL ,
  `has_obs_value_numeric` DOUBLE NULL DEFAULT NULL ,
  `has_obs_value_text` TEXT NULL DEFAULT NULL ,
  `has_program_id` INT(11) NULL DEFAULT NULL ,
  `has_program_workflow_state_id` INT(11) NULL DEFAULT NULL ,
  `has_identifier_type_id` INT(11) NULL DEFAULT NULL ,
  `has_relationship_type_id` INT(11) NULL DEFAULT NULL ,
  `has_order_type_id` INT(11) NULL DEFAULT NULL ,
  `skip_if_has` SMALLINT(6) NULL DEFAULT '0' ,
  `sort_weight` DOUBLE NULL DEFAULT NULL ,
  `creator` INT(11) NOT NULL ,
  `date_created` DATETIME NOT NULL ,
  `voided` SMALLINT(6) NULL DEFAULT '0' ,
  `voided_by` INT(11) NULL DEFAULT NULL ,
  `date_voided` DATETIME NULL DEFAULT NULL ,
  `void_reason` VARCHAR(255) NULL DEFAULT NULL ,
  `changed_by` INT(11) NULL DEFAULT NULL ,
  `date_changed` DATETIME NULL DEFAULT NULL ,
  `uuid` CHAR(38) NULL DEFAULT NULL ,
  PRIMARY KEY (`task_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`traditional_authority`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`traditional_authority` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`traditional_authority` (
  `traditional_authority_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(255) NOT NULL DEFAULT '' ,
  `district_id` INT(11) NOT NULL DEFAULT '0' ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `retired` TINYINT(1) NOT NULL DEFAULT '0' ,
  `retired_by` INT(11) NULL DEFAULT NULL ,
  `date_retired` DATETIME NULL DEFAULT NULL ,
  `retire_reason` VARCHAR(255) NULL DEFAULT NULL ,
  PRIMARY KEY (`traditional_authority_id`) ,
  INDEX `retired_status` (`retired` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 348
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`user_property`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`user_property` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`user_property` (
  `user_id` INT(11) NOT NULL DEFAULT '0' ,
  `property` VARCHAR(100) NOT NULL DEFAULT '' ,
  `property_value` VARCHAR(255) NOT NULL DEFAULT '' ,
  PRIMARY KEY (`user_id`, `property`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`user_role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`user_role` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`user_role` (
  `user_id` INT(11) NOT NULL DEFAULT '0' ,
  `role` VARCHAR(50) NOT NULL DEFAULT '' ,
  PRIMARY KEY (`role`, `user_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`village`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`village` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`village` (
  `village_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(255) NOT NULL DEFAULT '' ,
  `traditional_authority_id` INT(11) NOT NULL DEFAULT '0' ,
  `creator` INT(11) NOT NULL DEFAULT '0' ,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' ,
  `retired` TINYINT(1) NOT NULL DEFAULT '0' ,
  `retired_by` INT(11) NULL DEFAULT NULL ,
  `date_retired` DATETIME NULL DEFAULT NULL ,
  `retire_reason` VARCHAR(255) NULL DEFAULT NULL ,
  PRIMARY KEY (`village_id`) ,
  INDEX `retired_status` (`retired` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 32497
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `patient_billing`.`weight_for_height`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`weight_for_height` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`weight_for_height` (
  `supinecm` DOUBLE NULL DEFAULT NULL ,
  `medianwtht` DOUBLE NULL DEFAULT NULL ,
  `sdlowwtht` DOUBLE NULL DEFAULT NULL ,
  `sdhighwtht` DOUBLE NULL DEFAULT NULL ,
  `sex` SMALLINT(6) NULL DEFAULT NULL ,
  `heightsex` CHAR(5) NULL DEFAULT NULL )
ENGINE = MyISAM
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `patient_billing`.`weight_for_heights`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`weight_for_heights` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`weight_for_heights` (
  `supinecm` DOUBLE NOT NULL ,
  `median_weight_height` DOUBLE NOT NULL )
ENGINE = MyISAM
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `patient_billing`.`weight_height_for_age`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`weight_height_for_age` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`weight_height_for_age` (
  `agemths` SMALLINT(6) NULL DEFAULT NULL ,
  `sex` SMALLINT(6) NULL DEFAULT NULL ,
  `medianht` DOUBLE NULL DEFAULT NULL ,
  `sdlowht` DOUBLE NULL DEFAULT NULL ,
  `sdhighht` DOUBLE NULL DEFAULT NULL ,
  `medianwt` DOUBLE NULL DEFAULT NULL ,
  `sdlowwt` DOUBLE NULL DEFAULT NULL ,
  `sdhighwt` DOUBLE NULL DEFAULT NULL ,
  `agesex` CHAR(4) NULL DEFAULT NULL )
ENGINE = MyISAM
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `patient_billing`.`weight_height_for_ages`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_billing`.`weight_height_for_ages` ;

CREATE  TABLE IF NOT EXISTS `patient_billing`.`weight_height_for_ages` (
  `age_in_months` SMALLINT(6) NULL DEFAULT NULL ,
  `sex` CHAR(12) NULL DEFAULT NULL ,
  `median_height` DOUBLE NULL DEFAULT NULL ,
  `standard_low_height` DOUBLE NULL DEFAULT NULL ,
  `standard_high_height` DOUBLE NULL DEFAULT NULL ,
  `median_weight` DOUBLE NULL DEFAULT NULL ,
  `standard_low_weight` DOUBLE NULL DEFAULT NULL ,
  `standard_high_weight` DOUBLE NULL DEFAULT NULL ,
  `age_sex` CHAR(4) NULL DEFAULT NULL ,
  INDEX `index_weight_height_for_ages_on_age_in_months` (`age_in_months` ASC) ,
  INDEX `index_weight_height_for_ages_on_sex` (`sex` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = latin1;

USE `patient_billing`;

DELIMITER $$

USE `patient_billing`$$
DROP TRIGGER IF EXISTS `patient_billing`.`obs_after_update` $$
USE `patient_billing`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `patient_billing`.`obs_after_update`
AFTER UPDATE ON `patient_billing`.`obs`
FOR EACH ROW
BEGIN
  	IF new.concept_id = (SELECT concept_id FROM concept_name WHERE name = "BABY OUTCOME" LIMIT 1) AND new.voided = 1 THEN
		SET @outcome = (SELECT name FROM concept_name WHERE concept_name_id = new.value_coded_name_id);	

  		DELETE FROM patient_report WHERE patient_id = new.person_id AND baby_outcome = @outcome AND baby_outcome_date = new.obs_datetime AND obs_id = new.obs_id;
	END IF;

	IF new.concept_id = (SELECT concept_id FROM concept_name WHERE name = "DELIVERY MODE" LIMIT 1) AND new.voided = 1 THEN
		SET @mode = (SELECT name FROM concept_name WHERE concept_name_id = new.value_coded_name_id);	

  		DELETE FROM patient_report WHERE patient_id = new.person_id AND delivery_mode = @mode AND delivery_date = new.obs_datetime AND obs_id = new.obs_id;
	END IF;

	IF new.concept_id = (SELECT concept_id FROM concept_name WHERE name = "NUMBER OF BABIES" LIMIT 1) AND new.voided = 1 THEN
		SET @mode = (SELECT name FROM concept_name WHERE concept_name_id = new.value_coded_name_id);	

  		DELETE FROM patient_report WHERE patient_id = new.person_id AND babies = @mode AND birthdate = new.obs_datetime AND obs_id = new.obs_id;
	END IF;

	IF new.concept_id = (SELECT concept_id FROM concept_name WHERE name = "OUTCOME" LIMIT 1) AND new.voided = 1 THEN
		SET @mode = (SELECT name FROM concept_name WHERE concept_name_id = new.value_coded_name_id);	

  		DELETE FROM patient_report WHERE patient_id = new.person_id AND outcome = @mode AND outcome_date = new.obs_datetime AND obs_id = new.obs_id;
	END IF;
	
	IF new.concept_id = (SELECT concept_id FROM concept_name WHERE name = "ADMISSION TIME" LIMIT 1) AND new.voided = 1 THEN
		SET @ward = (SELECT name FROM location WHERE location_id = new.location_id);	

  		DELETE FROM patient_report WHERE patient_id = new.person_id AND admission_ward = @ward AND admission_date = new.value_datetime AND obs_id = new.obs_id;
	END IF;
	
	IF new.concept_id = (SELECT concept_id FROM concept_name WHERE name = "DIAGNOSIS" LIMIT 1) AND new.voided = 1 THEN
		SET @diagnosis = (SELECT name FROM concept_name WHERE concept_name_id = new.value_coded_name_id);	

		DELETE FROM patient_report WHERE patient_id = new.person_id AND diagnosis = @diagnosis AND diagnosis_date = new.obs_datetime AND obs_id = new.obs_id;
	END IF;
	
	IF new.concept_id = (SELECT concept_id FROM concept_name WHERE name = "ADMISSION SECTION" LIMIT 1) AND new.voided = 1 THEN
		SET @ward = (SELECT name FROM location WHERE location_id = new.location_id);	

		DELETE FROM patient_report WHERE patient_id = new.person_id AND source_ward = @ward AND destination_ward = new.value_text AND internal_transfer_date = new.obs_datetime AND obs_id = new.obs_id;
	ELSEIF new.concept_id = (SELECT concept_id FROM concept_name WHERE name = "ADMISSION SECTION" LIMIT 1) AND COALESCE(new.value_modifier, '') != '' THEN
		SET @ward = (SELECT name FROM location WHERE location_id = new.location_id);	

  		INSERT INTO patient_report (patient_id, source_ward, destination_ward, internal_transfer_date, obs_datetime, obs_id) VALUES(new.person_id, @ward, new.value_text, new.obs_datetime, new.obs_datetime, new.obs_id);

		UPDATE patient_report SET last_ward_where_seen = new.value_text, last_ward_where_seen_date = new.obs_datetime WHERE COALESCE(delivery_mode,'') != '' AND patient_id = new.person_id AND delivery_date >= DATE_ADD(new.obs_datetime, INTERVAL -7 DAY) AND delivery_date <= DATE_ADD(new.obs_datetime, INTERVAL 7 DAY);
	END IF;
	
	IF new.concept_id = (SELECT concept_id FROM concept_name WHERE name = "IS PATIENT REFERRED?" LIMIT 1) AND new.value_coded IN (SELECT concept_id FROM concept_name WHERE name = "Yes") AND new.voided = 1 THEN

		DELETE FROM patient_report WHERE patient_id = new.person_id AND referral_in = new.obs_datetime AND obs_id = new.obs_id;
	END IF;
	
	IF new.concept_id = (SELECT concept_id FROM concept_name WHERE name = "CLINIC SITE OTHER" LIMIT 1) AND new.value_coded IN (SELECT concept_id FROM concept_name WHERE name = "Yes") AND new.voided = 1 THEN

		DELETE FROM patient_report WHERE patient_id = new.person_id AND referral_out = new.obs_datetime AND obs_id = new.obs_id;
	END IF;
	
	IF new.concept_id = (SELECT concept_id FROM concept_name WHERE name = "PROCEDURE DONE" LIMIT 1) AND new.voided = 1 THEN
		SET @procedure = (SELECT name FROM concept_name WHERE concept_name_id = new.value_coded_name_id);	

		DELETE FROM patient_report WHERE patient_id = new.person_id AND procedure_done = @procedure AND procedure_date = new.obs_datetime AND obs_id = new.obs_id;
	END IF;
	
	IF new.concept_id = (SELECT concept_id FROM concept_name WHERE name = "CLINIC SITE OTHER" LIMIT 1) AND new.value_coded IN (SELECT concept_id FROM concept_name WHERE name = "No") AND new.voided = 1 THEN

		DELETE FROM patient_report WHERE patient_id = new.person_id AND discharged_home = new.obs_datetime AND obs_id = new.obs_id;
	END IF;

	IF new.concept_id = (SELECT concept_id FROM concept_name WHERE name = "OUTCOME" LIMIT 1) AND new.value_coded = (SELECT concept_id FROM concept_name WHERE name = "DISCHARGED" LIMIT 1) THEN
      SET @ward = (SELECT name FROM location WHERE location_id = new.location_id);
      
      DELETE FROM patient_report WHERE patient_id = new.person_id AND discharged = new.obs_datetime AND discharge_ward = @ward AND obs_id = new.obs_id;
      
	END IF;
	

END$$


DELIMITER ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

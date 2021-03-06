SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

-- -----------------------------------------------------
-- Table `billing_department`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `billing_department` ;

CREATE  TABLE IF NOT EXISTS `billing_department` (
  `department_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(50) NOT NULL ,
  `creator` INT(11) NOT NULL ,
  `voided` TINYINT(1) NOT NULL DEFAULT 0 ,
  `voided_by` INT(11) NULL DEFAULT NULL ,
  `date_voided` DATETIME NULL DEFAULT NULL ,
  `void_reason` VARCHAR(50) NULL DEFAULT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`department_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `billing_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `billing_category` ;

CREATE  TABLE IF NOT EXISTS `billing_category` (
  `category_id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(50) NOT NULL ,
  `department_id` INT(11) NOT NULL ,
  `creator` INT(11) NOT NULL ,
  `voided` TINYINT(1) NOT NULL DEFAULT 0 ,
  `voided_by` INT(11) NULL DEFAULT NULL ,
  `date_voided` DATETIME NULL DEFAULT NULL ,
  `void_reason` VARCHAR(50) NULL DEFAULT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`category_id`) ,
  INDEX `fk_billing_category_1` (`department_id` ASC) ,
  CONSTRAINT `fk_billing_category_1`
    FOREIGN KEY (`department_id` )
    REFERENCES `billing_department` (`department_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `billing_product_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `billing_product_type` ;

CREATE  TABLE IF NOT EXISTS `billing_product_type` (
  `product_type_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(50) NOT NULL ,
  `creator` INT(11) NOT NULL ,
  `voided` TINYINT(1) NOT NULL DEFAULT 0 ,
  `voided_by` INT(11) NULL DEFAULT NULL ,
  `void_reason` VARCHAR(50) NULL DEFAULT NULL ,
  `date_voided` DATETIME NULL DEFAULT NULL ,
  `created_at` DATETIME NULL DEFAULT NULL ,
  `updated_at` DATETIME NULL DEFAULT NULL ,
  PRIMARY KEY (`product_type_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `billing_product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `billing_product` ;

CREATE  TABLE IF NOT EXISTS `billing_product` (
  `product_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `product_type_id` INT(11) NOT NULL ,
  `category_id` INT(11) NOT NULL ,
  `name` VARCHAR(100) NOT NULL ,
  `creator` INT(11) NOT NULL ,
  `voided` TINYINT(1) NOT NULL DEFAULT 0 ,
  `voided_by` INT(11) NULL DEFAULT NULL ,
  `date_voided` DATETIME NULL DEFAULT NULL ,
  `void_reason` VARCHAR(50) NULL DEFAULT NULL ,
  `created_at` DATETIME NULL DEFAULT NULL ,
  `updated_at` DATETIME NULL DEFAULT NULL ,
  PRIMARY KEY (`product_id`) ,
  INDEX `fk_billing_product_2` (`product_type_id` ASC) ,
  INDEX `fk_billing_product_1` (`category_id` ASC) ,
  CONSTRAINT `fk_billing_product_2`
    FOREIGN KEY (`product_type_id` )
    REFERENCES `billing_product_type` (`product_type_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_billing_product_1`
    FOREIGN KEY (`category_id` )
    REFERENCES `billing_category` (`category_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `billing_price`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `billing_price` ;

CREATE  TABLE IF NOT EXISTS `billing_price` (
  `price_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `product_id` INT(11) NOT NULL ,
  `price_type` VARCHAR(50) NOT NULL ,
  `amount` DECIMAL NOT NULL ,
  `creator` INT(11) NOT NULL ,
  `voided` TINYINT(1) NOT NULL DEFAULT 0 ,
  `voided_by` INT(11) NULL DEFAULT NULL ,
  `date_voided` DATETIME NULL DEFAULT NULL ,
  `void_reason` VARCHAR(50) NULL DEFAULT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`price_id`) ,
  INDEX `fk_billing_price_1` (`product_id` ASC) ,
  CONSTRAINT `fk_billing_price_1`
    FOREIGN KEY (`product_id` )
    REFERENCES `billing_product` (`product_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `billing_medical_scheme_provider`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `billing_medical_scheme_provider` ;

CREATE  TABLE IF NOT EXISTS `billing_medical_scheme_provider` (
  `medical_scheme_provider_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `company_name` VARCHAR(50) NOT NULL ,
  `company_address` VARCHAR(50) NOT NULL ,
  `provider_type` VARCHAR(50) NOT NULL ,
  `phone_number_1` VARCHAR(30) NOT NULL ,
  `phone_number_2` VARCHAR(30) NULL DEFAULT NULL ,
  `email_address` VARCHAR(30) NULL DEFAULT NULL ,
  `creator` INT(11) NOT NULL ,
  `voided` TINYINT(1) NOT NULL DEFAULT 0 ,
  `voided_by` INT(11) NULL DEFAULT NULL ,
  `void_reason` VARCHAR(50) NULL DEFAULT NULL ,
  `date_voided` DATETIME NULL DEFAULT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`medical_scheme_provider_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `billing_medical_scheme`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `billing_medical_scheme` ;

CREATE  TABLE IF NOT EXISTS `billing_medical_scheme` (
  `medical_scheme_id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(50) NOT NULL ,
  `medical_scheme_provider_id` INT(11) NOT NULL ,
  `creator` INT(11) NOT NULL ,
  `voided` TINYINT(1) NOT NULL DEFAULT 0 ,
  `voided_by` INT(11) NULL DEFAULT NULL ,
  `date_voided` DATETIME NULL DEFAULT NULL ,
  `void_reason` VARCHAR(50) NULL DEFAULT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`medical_scheme_id`) ,
  INDEX `fk_billing_medical_scheme_1` (`medical_scheme_provider_id` ASC) ,
  CONSTRAINT `fk_billing_medical_scheme_1`
    FOREIGN KEY (`medical_scheme_provider_id` )
    REFERENCES `billing_medical_scheme_provider` (`medical_scheme_provider_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `billing_account`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `billing_account` ;

CREATE  TABLE IF NOT EXISTS `billing_account` (
  `account_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `patient_id` INT(11) NOT NULL ,
  `payment_method` VARCHAR(50) NULL ,
  `price_type` VARCHAR(50) NULL ,
  `creator` INT(11) NOT NULL ,
  `voided` TINYINT(1) NOT NULL DEFAULT 0 ,
  `voided_by` INT(11) NULL DEFAULT NULL ,
  `date_voided` DATETIME NULL DEFAULT NULL ,
  `void_reason` VARCHAR(50) NULL DEFAULT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`account_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `billing_accounts_medical_schemes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `billing_accounts_medical_schemes` ;

CREATE  TABLE IF NOT EXISTS `billing_accounts_medical_schemes` (
  `medical_scheme_id` INT(11) NOT NULL ,
  `account_id` INT(11) NOT NULL ,
  PRIMARY KEY (`medical_scheme_id`, `account_id`) ,
  INDEX `fk_billing_accounts_medical_schemes_1` (`medical_scheme_id` ASC) ,
  INDEX `fk_billing_accounts_medical_schemes_2` (`account_id` ASC) ,
  CONSTRAINT `fk_billing_accounts_medical_schemes_1`
    FOREIGN KEY (`medical_scheme_id` )
    REFERENCES `billing_medical_scheme` (`medical_scheme_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_billing_accounts_medical_schemes_2`
    FOREIGN KEY (`account_id` )
    REFERENCES `billing_account` (`account_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `billing_rules`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `billing_rules` ;

CREATE  TABLE IF NOT EXISTS `billing_rules` (
  `rule_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(50) NOT NULL ,
  `rate` FLOAT NOT NULL ,
  `medical_scheme_id` INT(11) NOT NULL ,
  `creator` INT(11) NOT NULL ,
  `voided` TINYINT(1) NOT NULL DEFAULT 0 ,
  `voided_by` DATETIME NULL DEFAULT NULL ,
  `void_reason` DATETIME NULL DEFAULT NULL ,
  `date_voided` DATETIME NULL DEFAULT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`rule_id`) ,
  INDEX `fk_billing_rules_1` (`medical_scheme_id` ASC) ,
  CONSTRAINT `fk_billing_rules_1`
    FOREIGN KEY (`medical_scheme_id` )
    REFERENCES `billing_medical_scheme` (`medical_scheme_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `billing_invoice`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `billing_invoice` ;

CREATE  TABLE IF NOT EXISTS `billing_invoice` (
  `invoice_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `account_id` INT(11) NOT NULL ,
  `invoice_type` CHAR(1) NOT NULL ,
  `payment_method` VARCHAR(50) NOT NULL ,
  `total_amount` DECIMAL NOT NULL ,
  `location_id` INT(11) NOT NULL ,
  `creator` INT(11) NOT NULL ,
  `voided` TINYINT(1) NOT NULL DEFAULT 0 ,
  `voided_by` INT(11) NULL DEFAULT NULL ,
  `date_voided` DATETIME NULL DEFAULT NULL ,
  `void_reason` VARCHAR(50) NULL DEFAULT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`invoice_id`) ,
  INDEX `fk_billing_invoice_2` (`account_id` ASC) ,
  CONSTRAINT `fk_billing_invoice_2`
    FOREIGN KEY (`account_id` )
    REFERENCES `billing_account` (`account_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `billing_invoice_line`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `billing_invoice_line` ;

CREATE  TABLE IF NOT EXISTS `billing_invoice_line` (
  `invoice_line_id` INT NOT NULL AUTO_INCREMENT ,
  `invoice_id` INT(11) NOT NULL ,
  `product_id` INT(11) NOT NULL ,
  `price_id` INT(11) NOT NULL ,
  `quantity` DECIMAL NOT NULL ,
  `price_per_unit` DECIMAL NOT NULL ,
  `rule_id` INT(11) NULL DEFAULT NULL ,
  `discount_amount` DECIMAL NOT NULL DEFAULT 0 ,
  `final_amount` DECIMAL NOT NULL ,
  `voided` TINYINT(1) NOT NULL DEFAULT 0 ,
  `voided_by` INT(11) NULL DEFAULT NULL ,
  `void_reason` VARCHAR(50) NULL DEFAULT NULL ,
  `date_voided` DATETIME NULL DEFAULT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NOT NULL ,
  PRIMARY KEY (`invoice_line_id`) ,
  INDEX `fk_billing_invoice_line_2` (`invoice_id` ASC) ,
  INDEX `fk_billing_invoice_line_3` (`rule_id` ASC) ,
  INDEX `fk_billing_invoice_line_1` (`product_id` ASC) ,
  CONSTRAINT `fk_billing_invoice_line_2`
    FOREIGN KEY (`invoice_id` )
    REFERENCES `billing_invoice` (`invoice_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_billing_invoice_line_3`
    FOREIGN KEY (`rule_id` )
    REFERENCES `billing_rules` (`rule_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_billing_invoice_line_1`
    FOREIGN KEY (`product_id` )
    REFERENCES `billing_product` (`product_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `billing_payment_method`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `billing_payment_method` ;

CREATE  TABLE IF NOT EXISTS `billing_payment_method` (
  `payment_method_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(50) NOT NULL ,
  `creator` INT(11) NOT NULL ,
  `voided` TINYINT(1) NOT NULL DEFAULT 0 ,
  `voided_by` INT(11) NULL DEFAULT NULL ,
  `void_reason` VARCHAR(50) NULL DEFAULT NULL ,
  `date_voided` DATETIME NULL DEFAULT NULL ,
  `created_at` DATETIME NULL DEFAULT NULL ,
  `updated_at` DATETIME NULL DEFAULT NULL ,
  PRIMARY KEY (`payment_method_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `billing_scheme_provider_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `billing_scheme_provider_type` ;

CREATE  TABLE IF NOT EXISTS `billing_scheme_provider_type` (
  `scheme_provider_type_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(50) NOT NULL ,
  `creator` INT(11) NOT NULL ,
  `voided` TINYINT(1) NOT NULL DEFAULT 0 ,
  `voided_by` INT(11) NULL DEFAULT NULL ,
  `void_reason` VARCHAR(50) NULL DEFAULT NULL ,
  `date_voided` DATETIME NULL DEFAULT NULL ,
  `created_at` DATETIME NULL DEFAULT NULL ,
  `updated_at` DATETIME NULL DEFAULT NULL ,
  PRIMARY KEY (`scheme_provider_type_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `billing_price_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `billing_price_type` ;

CREATE  TABLE IF NOT EXISTS `billing_price_type` (
  `price_type_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(50) NOT NULL ,
  `creator` INT(11) NOT NULL ,
  `voided` TINYINT(1) NOT NULL DEFAULT 0 ,
  `voided_by` INT(11) NULL DEFAULT NULL ,
  `void_reason` VARCHAR(50) NULL DEFAULT NULL ,
  `date_voided` DATETIME NULL DEFAULT NULL ,
  `created_at` DATETIME NULL DEFAULT NULL ,
  `updated_at` DATETIME NULL DEFAULT NULL ,
  PRIMARY KEY (`price_type_id`) )
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

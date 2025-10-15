-- Database schema for car service management system

DROP TABLE IF EXISTS service, serviceCategory, cars, CarModel, CarBrand, customers, admin, master;

-- ===========================================================
-- Table: master
-- ===========================================================
CREATE TABLE `master` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT,
  `username` VARCHAR(255),
  `password` VARCHAR(255)
);

-- ===========================================================
-- Table: admin
-- ===========================================================
CREATE TABLE `admin` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT,
  `fullname` VARCHAR(255),
  `username` VARCHAR(255),
  `email` VARCHAR(255),
  `phone` VARCHAR(50),
  `password` VARCHAR(255),
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ===========================================================
-- Table: customers
-- ===========================================================
CREATE TABLE `customers` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT,
  `fullname` VARCHAR(255),
  `email` VARCHAR(255),
  `phone` VARCHAR(50),
  `password` VARCHAR(255),
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ===========================================================
-- Table: CarBrand
-- ===========================================================
CREATE TABLE `CarBrand` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT,
  `brandName` VARCHAR(255)
);

-- ===========================================================
-- Table: CarModel
-- ===========================================================
CREATE TABLE `CarModel` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT,
  `modelName` VARCHAR(255),
  `carBrand_id` BIGINT,
  FOREIGN KEY (`carBrand_id`) REFERENCES `CarBrand`(`id`)
);

-- ===========================================================
-- Table: cars
-- ===========================================================
CREATE TABLE `cars` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT,
  `customer_id` BIGINT NOT NULL,
  `carModel_id` BIGINT,
  `year` DATE,
  `kilometer` VARCHAR(255),
  `licensePlate` VARCHAR(255),
  `stnkValidityPeriod` DATE,
  `status` ENUM('InProgress', 'Completed', 'NoServiceNeeded') DEFAULT 'InProgress',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`customer_id`) REFERENCES `customers`(`id`),
  FOREIGN KEY (`carModel_id`) REFERENCES `CarModel`(`id`)
);

-- ===========================================================
-- Table: serviceCategory
-- ===========================================================
CREATE TABLE `serviceCategory` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(255),
  `price` VARCHAR(100),
  `status` ENUM('available', 'not_available') DEFAULT 'available'
);

-- ===========================================================
-- Table: service
-- ===========================================================
CREATE TABLE `service` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT,
  `cars_id` BIGINT NOT NULL UNIQUE,
  `category_id` BIGINT NOT NULL,
  `phone` VARCHAR(50) NOT NULL,
  `noted` TEXT,
  `date` DATE,
  `time` TIME,
  `total_price` INT,
  FOREIGN KEY (`cars_id`) REFERENCES `cars`(`id`),
  FOREIGN KEY (`category_id`) REFERENCES `serviceCategory`(`id`)
);

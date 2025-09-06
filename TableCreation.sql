CREATE DATABASE mmwebapp_db;
USE mmwebapp_db;

CREATE TABLE memberuser(
	mem_userid INT AUTO_INCREMENT PRIMARY KEY,
    mem_name VARCHAR(200) NOT NULL,
    mem_email VARCHAR (100) NOT NULL,
    mem_phonenum BIGINT NOT NULL,
    mem_address VARCHAR (255) NOT NULL,
    mem_password VARCHAR (255) NOT NULL,
    mem_salt VARCHAR (32) NOT NULL,
    mem_role ENUM ('MEMBER', 'CAREGIVER') NOT NULL,
    mem_dietreq JSON,
    mem_disdesc TEXT,
    mem_deltime ENUM ('NONE', 'MORNING', 'AFTERNOON', 'NIGHT'),
    mem_emername VARCHAR (200) NOT NULL,
    mem_emerphonenum BIGINT NOT NULL
)auto_increment 100000;

CREATE TABLE volunteeruser(
	vol_userid INT AUTO_INCREMENT PRIMARY KEY,
    vol_name VARCHAR(200) NOT NULL,
    vol_bdate DATE NOT NULL,
    vol_email VARCHAR(100) NOT NULL,
    vol_phonenum BIGINT NOT NULL,
    vol_password VARCHAR(255) NOT NULL,
    vol_salt VARCHAR (32) NOT NULL,
    vol_dayrange VARCHAR(50),
    vol_timerange VARCHAR(50),
	vol_prefdelarea VARCHAR(200),
    vol_emername VARCHAR (200) NOT NULL,
    vol_emerphonenum BIGINT NOT NULL,
    vol_priorexp TEXT,
    vol_reason TEXT
)auto_increment 200000;

CREATE TABLE partneruser(
	org_userid INT AUTO_INCREMENT PRIMARY KEY,
    org_name VARCHAR(200) NOT NULL,
    org_rep VARCHAR (200) NOT NULL,
    org_email VARCHAR(100) NOT NULL,
    org_address VARCHAR (255) NOT NULL,
    org_phonenum BIGINT NOT NULL,
    org_password VARCHAR(255) NOT NULL,
    org_salt VARCHAR (32) NOT NULL,
    org_service JSON,
    org_dayrange VARCHAR(50),
    org_timerange VARCHAR(50),
	org_desc TEXT
)auto_increment 300000;

CREATE TABLE meal(
	meal_id INT AUTO_INCREMENT PRIMARY KEY,
    meal_name VARCHAR(100) NOT NULL,
    meal_type ENUM('BREAKFAST', 'LUNCH', 'DINNER') NOT NULL,
    meal_description TEXT,
    meal_diettag JSON,
    meal_allergens JSON,
    meal_createdby INT,
    FOREIGN KEY (meal_createdby) REFERENCES partneruser(org_userid)
) AUTO_INCREMENT = 400000;

-- Delivery Table
CREATE TABLE delivery(
	delivery_id INT AUTO_INCREMENT PRIMARY KEY,
    delivery_date DATE NOT NULL,
    delivery_time ENUM('MORNING', 'AFTERNOON', 'NIGHT') NOT NULL,
    meal_id INT NOT NULL,
    member_id INT NOT NULL,
    volunteer_id INT,
    status ENUM('PENDING', 'DISPATCHED', 'DELIVERED', 'CANCELLED') DEFAULT 'PENDING',
    FOREIGN KEY (meal_id) REFERENCES meal(meal_id),
    FOREIGN KEY (member_id) REFERENCES memberuser(mem_userid),
    FOREIGN KEY (volunteer_id) REFERENCES volunteeruser(vol_userid)
) AUTO_INCREMENT = 500000;

-- Donation Table
CREATE TABLE donation(
	donation_id INT AUTO_INCREMENT PRIMARY KEY,
    donor_name VARCHAR(200) NOT NULL,
    donor_email VARCHAR(100) NOT NULL,
    donor_phonenum BIGINT NOT NULL,
    donor_address VARCHAR(255) NOT NULL,
    donation_amount DECIMAL(10,2) NOT NULL,
    donation_frequency ENUM('ONE-TIME', 'MONTHLY', 'QUARTERLY', 'ANNUALLY') NOT NULL,
    donation_purpose TEXT,
    card_number VARCHAR(20) NOT NULL,
    expiry_date DATE NOT NULL,
    billing_address VARCHAR(255) NOT NULL,
    same_as_donor BOOLEAN DEFAULT FALSE,
    subscribe_newsletter BOOLEAN DEFAULT FALSE,
    anonymous BOOLEAN DEFAULT FALSE,
    donor_notes TEXT,
    dedicate_message TEXT,
    donation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) AUTO_INCREMENT = 600000;
DROP DATABASE IF EXISTS LoginInfo;
CREATE DATABASE LoginInfo;

USE LoginInfo;

CREATE TABLE Users (
	userID INT(11) PRIMARY KEY AUTO_INCREMENT,
    un VARCHAR(50) NOT NULL,
    pw VARCHAR(50) NOT NULL
);

CREATE TABLE Searches (
	userID INT(11) NOT NULL,
	searchID INT(11) PRIMARY KEY AUTO_INCREMENT,
    searchQuery VARCHAR(50) NOT NULL,
    FOREIGN KEY (userID) REFERENCES Users(userID)
);

INSERT INTO Users (un, pw)
	VALUES ("user1", "user1"),
		   ("user2", "user2");
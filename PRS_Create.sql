USE MASTER;	

DROP DATABASE IF EXISTS prs;
CREATE DATABASE prs;

USE prs;

CREATE TABLE Users
(	UserID				int				NOT NULL	PRIMARY KEY IDENTITY,
	FirstName			varchar (50)	NOT NULL,
	LastName			varchar (50)	NOT NULL,
	Phone				varchar (13)	NOT NULL,
	Email				varchar (75)	NOT NULL,
	Username			varchar (20)	NOT NULL UNIQUE,
	Password			varchar (20)	NOT NULL,
	Reviewer			bit				NOT NULL,
	Admin				bit				NOT NULL);

CREATE TABLE Vendors
(	VendorID			int				NOT NULL	PRIMARY KEY IDENTITY,
	Code				varchar (10)	NOT NULL,
	Name				varchar (255)	NOT NULL,
	Street				varchar (255)	NOT NULL,
	City				varchar (255)	NOT NULL,
	State				char (2)		NOT NULL,
	Zip					varchar (10)	NOT NULL,
	Email				varchar (100)	NOT NULL,
	Phone				varchar (13)	NOT NULL);

CREATE TABLE PurchaseRequests
(	RequestID			int							PRIMARY KEY IDENTITY,
	UserID				int				NOT NULL,
	Description			varchar (100)	NOT NULL,
	Justification		varchar (255)	NOT NULL,
	DateNeeded			date			NOT NULL,	
	DeliveryMode		varchar (25)	NOT NULL,
	Status				varchar (20)	NOT NULL,
	Total				smallmoney		NOT NULL CHECK (Total >= 0),
	SubmittedDate		datetime2		NOT NULL,
	ReasonForRejection	varchar (255)	NULL,
	CONSTRAINT FK_PRUser FOREIGN KEY (UserID)
		REFERENCES Users (UserID)
);

CREATE TABLE Products
(	ProductID				int								PRIMARY KEY IDENTITY,
	VendorID				int					NOT NULL,
	PartNumber				varchar (50)		NOT NULL,
	Price					smallmoney			NOT NULL,
	Name					varchar (50)		NOT NULL,
	Unit					varchar (255)		NULL,
	PhotoPath				varchar (255)		NULL,
	CONSTRAINT FK_PRVendor FOREIGN KEY (VendorID)
		REFERENCES Vendors (VendorID)
);

CREATE TABLE LineItems
(	LineItemID				int								PRIMARY KEY IDENTITY,
	RequestID				int					NOT NULL,
	ProductID				int					NOT NULL,
	Quantity				int					NOT NULL,
	CONSTRAINT FK_PRRequest FOREIGN KEY (RequestID)
		REFERENCES PurchaseRequests (RequestID),
	CONSTRAINT FK_PRProduct FOREIGN KEY (ProductID)
		REFERENCES Products (ProductID),
	CONSTRAINT ReqID_ProdID UNIQUE (RequestID, ProductID)
);

ALTER TABLE Users
ADD LoyaltyID int;
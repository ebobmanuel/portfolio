
--Financial Consumer Complaints

-- DATA CLEANING & EXPLORATORY DATA ANALYSIS (EDA)


SELECT *
FROM finacial_complaints

-- Remove Duplicate
-- Standardize the Data
-- Address Null or Blank Values
-- Remove unnecessary Columns


--Create staging table to peform changes to file
	
CREATE TABLE StageArea_financial_complaints( 
	Complaint_ID float NULL,
	DateSumbited datetime NULL,
	Product nvarchar(255) NULL,
	Sub_product nvarchar(255) NULL,
	Issue nvarchar(255) NULL,
	Sub_issue nvarchar(255) NULL,
	Company_public_response nvarchar(255) NULL,
	Company nvarchar(255) NULL,
	State nvarchar(255) NULL,
	Tags nvarchar(255) NULL,
	Consumer_consent_provided nvarchar(255) NULL,
	Submitted_via nvarchar(255) NULL,
	DateReceived datetime NULL,
	Company_response_to_consumer nvarchar(255) NULL,
	Timely_response nvarchar(255) NULL,
	Consumer_disputed nvarchar(255) NULL
) 

INSERT INTO StageArea_financial_complaints
SELECT *
FROM finacial_complaints

SELECT *
FROM StageArea_financial_complaints
	

-- REMOVE DUPLACTES
-- checking Complaint_ID results indicate no duplicates

SELECT Complaint_ID, COUNT(*) 
FROM PortfolioProject..StageArea_financial_complaints
GROUP BY  Complaint_ID
HAVING COUNT(*)>1;  


-- STANDARDIZE DATA
-- Data had 2 colums for 'Credit card' & 'Credit card or prepaid card'. combined all into 1 Column namely 'Credit card or prepaid card'

SELECT *
FROM StageArea_financial_complaints
WHERE Product LIKE 'Credit card'


SELECT *
FROM StageArea_financial_complaints
WHERE Product LIKE 'Credit card or prepaid card'

UPDATE StageArea_financial_complaints 
SET Product = 'Credit card or prepaid card'
WHERE Product LIKE 'Credit card'

SELECT Product
FROM PortfolioProject..StageArea_financial_complaints
WHERE Product LIKE 'Credit card or prepaid card'
	

-- Viewing states-- 	
-- Data Shows 62 states listed. Updated data to only include 50 states plus DC
	

SELECT DISTINCT State 
FROM StageArea_financial_complaints
GROUP BY State


SELECT *
FROM StageArea_financial_complaints
WHERE State IN ('AS', 'AP', 'FM', 'GU', 'VI', 'MP', 'PR', 'AE', 'PW')
OR State IN ('UNITED STATES MINOR OUTLYING ISLANDS')
OR State IS NULL;

DELETE --Deleted states not among 50 states plus DC
FROM StageArea_financial_complaints
WHERE State IN ('AS', 'AP', 'FM', 'GU', 'VI', 'MP', 'PR', 'AE', 'PW')
OR State IN ('UNITED STATES MINOR OUTLYING ISLANDS')
OR State IS NULL;

 -- Confirmed states were deleted. Data shows updated to only 50 states plus DC

SELECT DISTINCT State
FROM StageArea_financial_complaints
GROUP BY State



-- ADDRESS NULL & BLANK VALUES

	
SELECT *
FROM StageArea_financial_complaints
WHERE Sub_product = '""'

DELETE 
FROM StageArea_financial_complaints
WHERE Sub_product = '""'


SELECT *
FROM StageArea_financial_complaints
WHERE Consumer_consent_provided IS NULL

DELETE 
FROM StageArea_financial_complaints
WHERE Consumer_consent_provided IS NULL
	
	

-- REMOVE UNNECESSARY COLUMNS
	
SELECT *
FROM StageArea_financial_complaints

ALTER TABLE StageArea_financial_complaints
DROP COLUMN Tags

ALTER TABLE StageArea_financial_complaints
DROP COLUMN Consumer_disputed

ALTER TABLE StageArea_financial_complaints
DROP COLUMN Company_public_response

ALTER TABLE StageArea_financial_complaints
DROP COLUMN Sub_issue

SELECT *
FROM StageArea_financial_complaints


	
-- EXPLORATORY DATA ANALYSIS--

SELECT *
FROM PortfolioProject..StageArea_financial_complaints

SELECT COUNT(*) AS Number_of_complaints -- Checking the total Number of Complaints
FROM PortfolioProject..StageArea_financial_complaints


--checking the number of complaints per state to see which states have the highest Number of complaints	
	
SELECT State, COUNT(*)Complaint_ID 
FROM PortfolioProject..StageArea_financial_complaints
GROUP BY State
ORDER BY Complaint_ID DESC
	

--checking what issues generate the most complaints
	
SELECT Issue, COUNT(*)Complaint_ID  
FROM PortfolioProject..StageArea_financial_complaints
GROUP BY Issue
ORDER BY Complaint_ID DESC
	

--checking the number of complaints by product
	
SELECT Product, COUNT(*)Complaint_ID 
FROM PortfolioProject..StageArea_financial_complaints
GROUP BY Product
ORDER BY Complaint_ID DESC
	

--checking how most complaints are submitted and percentage breakdown via each channel
	
SELECT Submitted_via, 
    COUNT(*) AS Complaint_ID,
    FORMAT(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM PortfolioProject..StageArea_financial_complaints), 'N2') + '%' AS Percentage
FROM PortfolioProject..StageArea_financial_complaints
GROUP BY Submitted_via
ORDER BY Complaint_ID DESC;


-- checking percentage of timely responses shows 97.81% 

SELECT CONCAT(ROUND(SUM(CASE WHEN Timely_response = 'Yes' THEN 1 ELSE 0 END) / CAST (COUNT(*) AS 
float),4)*100, '%') AS 'Timely_responses (%)'
FROM PortfolioProject..StageArea_financial_complaints;












/*

--PERFORM CLEANING--

*/

SELECT *
FROM heart_disease_indicators


--Create staging area to perform cleaing in SQL

CREATE TABLE heart_disease_indicators_Staging(
	State nvarchar(255) NULL,
	Sex nvarchar(255) NULL,
	GeneralHealth nvarchar(255) NULL,
	PhysicalHealthDays float NULL,
	MentalHealthDays float NULL,
	LastCheckupTime nvarchar(255) NULL,
	PhysicalActivities nvarchar(255) NULL,
	SleepHours float NULL,
	RemovedTeeth nvarchar(255) NULL,
	HadHeartAttack nvarchar(255) NULL,
	HadAngina nvarchar(255) NULL,
	HadStroke nvarchar(255) NULL,
	HadAsthma nvarchar(255) NULL,
	HadSkinCancer nvarchar(255) NULL,
	HadCOPD nvarchar(255) NULL,
	HadDepressiveDisorder nvarchar(255) NULL,
	HadKidneyDisease nvarchar(255) NULL,
	HadArthritis nvarchar(255) NULL,
	HadDiabetes nvarchar(255) NULL,
	DeafOrHardOfHearing nvarchar(255) NULL,
	BlindOrVisionDifficulty nvarchar(255) NULL,
	DifficultyConcentrating nvarchar(255) NULL,
	DifficultyWalking nvarchar(255) NULL,
	DifficultyDressingBathing nvarchar(255) NULL,
	DifficultyErrands nvarchar(255) NULL,
	SmokerStatus nvarchar(255) NULL,
	ECigaretteUsage nvarchar(255) NULL,
	ChestScan nvarchar(255) NULL,
	RaceEthnicityCategory nvarchar(255) NULL,
	AgeCategory nvarchar(255) NULL,
	HeightInMeters float NULL,
	WeightInKilograms float NULL,
	BMI float NULL,
	AlcoholDrinkers nvarchar(255) NULL,
	HIVTesting nvarchar(255) NULL,
	FluVaxLast12 nvarchar(255) NULL,
	PneumoVaxEver nvarchar(255) NULL,
	TetanusLast10Tdap nvarchar(255) NULL,
	HighRiskLastYear nvarchar(255) NULL,
	CovidPos nvarchar(255) NULL
)


INSERT INTO heart_disease_indicators_Staging
SELECT *
FROM heart_disease_indicators


SELECT *
FROM heart_disease_indicators_Staging


--STANDARDIZING DATA


----------------------------------------------------------------------------------------------------

--Update race column details

SELECT RaceEthnicityCategory
FROM heart_disease_indicators_Staging

EXEC sp_rename 'heart_disease_indicators_Staging.RaceEthnicityCategory', 'Race', 'COLUMN'; --update column name


--change race data to "white', 'black' or 'other"--

UPDATE heart_disease_indicators_Staging
SET Race = 'White'
WHERE Race LIKE 'White only, Non-Hispanic'

UPDATE heart_disease_indicators_Staging
SET Race = 'Black'
WHERE Race LIKE 'Multiracial, Non-Hispanic'

UPDATE heart_disease_indicators_Staging
SET Race = 'Black'
WHERE Race LIKE 'Black only, Non-Hispanic'

UPDATE heart_disease_indicators_Staging
SET Race = 'Other'
WHERE Race LIKE 'Other race only, Non-Hispanic'


-------------------------------------------------------------------------------------------------------------------------

--Standardize diabetes data

SELECT HadDiabetes
FROM heart_disease_indicators_Staging

UPDATE heart_disease_indicators_Staging
SET HadDiabetes = 'Yes, during pregnancy'
WHERE HadDiabetes LIKE 'Yes, but only during pregnancy (female)'

UPDATE heart_disease_indicators_Staging
SET HadDiabetes = 'No, pre-diabetes'
WHERE HadDiabetes LIKE 'No, pre-diabetes or borderline diabetes'


--------------------------------------------------------------------------------------------------------------------------

--Update SmokerStatus to either Smoker or Non-Smoker

SELECT SmokerStatus
FROM heart_disease_indicators_Staging

UPDATE heart_disease_indicators_Staging
SET SmokerStatus = 'Non-Smoker'
WHERE SmokerStatus LIKE 'Former smoker' OR SmokerStatus LIKE 'Never smoked';


UPDATE heart_disease_indicators_Staging
SET SmokerStatus = 'Smoker'
WHERE SmokerStatus LIKE 'Current smoker - now smokes some days' OR SmokerStatus LIKE 'Current smoker - now smokes every day';

--------------------------------------------------------------------------------------------------------------------------

--Standardize AgeCategory

SELECT AgeCategory
FROM heart_disease_indicators_Staging

UPDATE PortfolioProject..heart_disease_indicators_Staging
SET AgeCategory = REPLACE(REPLACE(AgeCategory, 'Age ', ''), ' to ', ' - ');



-------------------------------------------------------------------------------------------------------------------------

--Round up weight Value to whole number

SELECT WeightInKilograms
FROM heart_disease_indicators_Staging

UPDATE heart_disease_indicators_Staging
SET WeightInKilograms = ROUND(WeightInKilograms, 0);


------------------------------------------------------------------------------------------------------------------------

--Delete unnecessary columns--

SELECT *
FROM heart_disease_indicators_Staging

ALTER TABLE heart_disease_indicators_Staging
DROP COLUMN PneumoVaxEver, FluVaxLast12, CovidPos,HighRiskLastYear, HadAngina,HadArthritis,HadCOPD,HadDepressiveDisorder,HadKidneyDisease,DeafOrHardOfHearing, RemovedTeeth, LastCheckupTime

ALTER TABLE heart_disease_indicators_Staging
DROP COLUMN BlindOrVisionDifficulty, DifficultyConcentrating, DifficultyDressingBathing, DifficultyWalking, DifficultyErrands, ECigaretteUsage, ChestScan, State, HIVTesting, TetanusLast10Tdap 


------------------------------------------------------------------------------------------------------------------------

--Remove NULLS--


SELECT * 
FROM heart_disease_indicators_Staging
WHERE HadStroke IS NULL 
   OR HadAsthma IS NULL 
   OR HadSkinCancer IS NULL
   OR HadDiabetes IS NULL 
   OR SmokerStatus IS NULL
   OR RaceEthnicityCategory IS NULL 
   OR AgeCategory IS NULL
   OR HeightInMeters IS NULL 
   OR WeightInKilograms IS NULL
   OR BMI IS NULL 
   OR AlcoholDrinkers IS NULL
   OR HadHeartAttack IS NULL 
   OR SleepHours IS NULL
   OR PhysicalActivities IS NULL 
   OR MentalHealthDays IS NULL
   OR PhysicalHealthDays IS NULL 
   OR GeneralHealth IS NULL;


DELETE
FROM heart_disease_indicators_Staging
WHERE HadStroke IS NULL 
   OR HadAsthma IS NULL 
   OR HadSkinCancer IS NULL
   OR HadDiabetes IS NULL 
   OR SmokerStatus IS NULL
   OR RaceEthnicityCategory IS NULL 
   OR AgeCategory IS NULL
   OR HeightInMeters IS NULL 
   OR WeightInKilograms IS NULL
   OR BMI IS NULL 
   OR AlcoholDrinkers IS NULL
   OR HadHeartAttack IS NULL 
   OR SleepHours IS NULL
   OR PhysicalActivities IS NULL 
   OR MentalHealthDays IS NULL
   OR PhysicalHealthDays IS NULL 
   OR GeneralHealth IS NULL;

SELECT * 
FROM PortfolioProject..heart_disease_indicators_Staging









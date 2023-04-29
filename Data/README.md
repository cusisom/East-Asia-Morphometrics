# Data

Material in this folder includes the original morphometrics dataset provided by Dr. Kat Platchard. This material was used in her dissertation on Distinguishing Closely Related Modern Human Populations Using Cranial Morphometrics: A View from Korea and Japan.

## Folder Contents

The two subfolders found here store the original content, the output files fromthe data processing code, and the data dictionary. 

### Raw Data 

The Data provided for this project (found in the `Raw_data` folder) is divided into three separate Excel files. Additionally, there was no data dictionary provided. Two immediate goals of this project are to use the material in this folder to generate a consolidated data file and to develop the data dictionary.

The files below detail 3D Cranial Landmark Data for modern populations in Korea and Japan. 


		`Raw_Japan.csv` - Raw data on modern crania from Japan
		`Raw_korea.csv` - Raw data on modern crania from Korea
		`Raw_classifiers.csv` - Raw data on Demographic factors and Specimen IDs
		`Cranial_landmarks.csv` - Dictionary of cranial landmark abbreviations


### Processed Data

The material found in this folder is what will be used for my data analysis. Accordingly, the files from the `Raw_data` folder will not be altered. All data cleaned, processed, and consolidated, including the developed data dictionary can be found in the `Processed_data` folder.  



The files in this folder include the reorganized data into datasets with associated demographic information and datasets formated as arrays for morphometric analysis. Each file was written in .csv and .rds formats. 

	`Japan_array.csv` = Japan data ready for morphometric analysis
	`Japan_array.rds` = Japan data ready for morphometric analysis
	`Korea_array.csv` = Korea data ready for morphometric analysis
	`Korea_array.rds` = Korea data ready for morphometric analysis
	
	`Japan_dem.csv` = Japan data merged with pertinent demographic data from the `Raw_classifiers.csv` file provided by the original investigator. 
	`Japan_dem.rds` = Japan data merged with pertinent demographic data from the `Raw_classifiers.csv` file provided by the original investigator. 
	`Korea_dem.csv` = Korea data merged with pertinent demographic data from the `Raw_classifiers.csv` file provided by the original investigator. 
	`Korea_dem.rds` = Korea data merged with pertinent demographic data from the `Raw_classifiers.csv` file provided by the original investigator. 

## History

The data dictionary for this project's cranial landmarks was created and pushed through on 4/20/2023. It was added to the `Raw_data` folder.


The array and demographic files in the `Processed_data` folder were completed on 4/27/2023. The files were pushed through to this repo on 4/29/2023
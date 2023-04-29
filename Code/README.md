# Project Code

The two subfolders listed above divide the r code into two operations. The original data for this project (found in the `Data/Raw_data` folder) was provided by an outside source and compiled into three excel spreadsheets. Because of the current format and unknown condition of the provided material, this project dedicates a separate folder (`Processing_code`) to piecing the data together and getting it into workable condition for analysis. 

The `Analysis_code` folder will be used for statistical analyses and for the production of Tables and Figures for the final manuscript.

# Code Documentaion

There are two primary .r scripts for this project. The first script (`processingcode.r`) can be found in the `Processing_code` folder. This file was created to organize and visualize the 3D morphometric data for this project into a format that is ready for analysis and easy to read. The second file, `EAanalysis.r` is found ing the `Analysis_code` folder. This file is still being developed. It uses the finished product from the Processing Code to examine the differences between two large populations in East Asia (one from Korea and one from Japan). 

### Inputs
		reads in the following files from `../../Data/Raw_data/`
		`Raw_Japan.csv` - Raw data on modern crania from Japan
		`Raw_korea.csv` - Raw data on modern crania from Korea
		`Raw_classifiers` - Raw data on Demographic factors and Specimen IDs

### Outputs
		outputs to `../../Data/Processed_data/` 
		
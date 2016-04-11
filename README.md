# Getting and Cleaning Data
## Course Project

This repository it's destinated to host my project of the "Getting and Cleaning Data" course project 
in the "Data Science" specialization offered through coursera.

It contains only one script : run_analysis.R.

## Overview

The script reads the datasets splitted in train and test sets , and merges them to form a unique dataset .
It joins the dataset with the activity description file to have the the activity name insted of it identifier.
It gives more meaningful and easy to read names to the variables in the resulting data set.
Finaly it calculates the mean for every variable by each subject and activity. 

### Script instructions and prerrequisites.

1. It is neccesary an internet connection as the script downloads the required datasets from the web.
2. Besides the internet connection ,the script can be run without any special instructions  or libraries.
3. The script can be run from RStudio or with Rscript <run_analysis.R> assuming Rscript is in the path envirionmental variable. 
4. When the script finishes , it will give it's output as a tidy dataset named "means_dataset.txt" in the working directory.

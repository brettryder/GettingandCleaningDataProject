GettingandCleaningDataProject
=============================

## run_analysis.R file description

### Background

The run_analysis.R script takes **raw** data from a study of 30 subjects and then measures their movement using a Samsung Galaxy S smartphone acclerometer. Measurements were taken during 6 different activities (standing, laying, sitting, walking, walking downstairs and walking upstairs). Measurements were taken during both a training and test phase.

Links to the raw data and a description of the raw data respectively are at: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  and http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

### The run_analysis.R Script
The script file reads in the measurement variable names contained in the file features.txt. In order to tidy the data, the gsub command is used to remove blank spaces, brackets etc. The tolower command is used to remove upper case letters. The result is a set of column labels called "cnames" to apply to the measurement data.

The next step is to read in the activity names during the training and testing phases (files y_train.txt and y_test.txt respectively). These are in number format and therefore subsetting is used to replace the numerals with their corresponding descriptive activity labels.

For the training phase data the following steps are followed:
*the raw data is read in from x_train.txt using the "cnames" vector as column labels
*this data is then merged with the activity labels to so that the first column of the resulting data is the activity label.
*the subject identifiers are then read in from the subject_train.txt file
*this is also merged with the training data so that the first column corresponds to the subject

The same steps are then followed for the test data and the two sets of data are combined using the rbind command. The resulting data is called xtotal.

The xtotal data is then subset so as to only retain the subject id, activity, and the means and standard deviations of the data.

The melt command is then used to reshape the data and then the dcast command is used to calculate the final table with the means of the variables by subject id and activity type.

The final lines of the code then write the resulting data to a text file with the name of tidydata.txt.


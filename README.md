##run_analysis.R

The run_analysis.R script does the following:

1) If the file does not exist, download it.
2) If the file has now been already been extracted to the directory, extract it.
3) Load the test and train data.
4) Load the features/activity labels.
5) Extract the mean and standard deviation column names and data.
6) Process the data and creates the data sets:
   a) ./tidy-UCI-HAR-dataset-AVG.txt
   b) ./tidy-UCI-HAR-dataset.txt

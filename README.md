##run_analysis.R

The run_analysis.R script does the following:

- If the file does not exist, download it.
- If the file has now been already been extracted to the directory, extract it.
- Load the test and train data.
- Load the features/activity labels.
- Extract the mean and standard deviation column names and data.
- Process the data and creates the data sets a) ./tidy-UCI-HAR-dataset-AVG.txt, and b) ./tidy-UCI-HAR-dataset.txt, from which a) corresponds to the second, independent tidy data set with the average of each variable for each activity and each subject.

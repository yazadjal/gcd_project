<b>CODEBOOK</b>

This codebook will first describe the variables that were in the UCI HAR dataset given (can be downloaded from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones), the transformations performed on the data, and the data in the final_data.txt file which is the complete output file created for the project. 

<b>Original Data</b>

The files in the UCI HAR dataset include:
- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

- 'train/subject_train.txt' & 'train/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

The train and test folders each also contained an 'Inertial Signals' folder which was ignored. 

<b>Transformations</b>

After downloading the zip and reading the relevant files into R using read.table(), the training and test datasets were merged using rbind() creating three tables, one each for the x-data, y-data, and subject data. These three tables were then merged using cbind() to create <b><i>initial_data</b></i>, which satisfies the requirement of Step 1 to merge all the data sets and create one data set.

grep() was used to extract the mean and standard deviation columns and x_data, y_data, and subject_data tables were modified to only contain the mean / std dev data. Using names(), the activity labels were added from activity_lables.txt and descriptive names like "subject" and "activity" were added. The dataset was reassembled using cbind() and was named <b><i>all_data</b></i>. This satisfied the requirements of Steps 2, 3 and 4 of the project. 

<b>Tidy data set</b>

For the final step of creating a tidy data set with averages for each variable and each subject, first the following packages were installed using library(): data.table, dplyr, tidyr, and stringr. 

The subject average column with the mean of subject was created by using mutate() on all_data. Then a new row called activity_avg was created with the mean of every variable using colMeans and then rbind(). To create a tidy data set from  the transformed all_data table  the gather() function was used. Before gather() could be used, the column names which contained special characters "-" and "()" had to be changed using str_replace(). The name changes have been recorded and stored in namechanges.csv for later reference, if necessary. 

Finally, gather() was used to create a tidy data set called <b><i>final_data</b></i> and the file was saved as final_data.text. final_data has four variables, each in its own column: subject, activity, feature, and observation. 

- <b>subject</b>: Each row identifies the subject who performed the relevant activity. Its range is from 1 to 30. An additional variable "ALL" which is the average of the relevant feature for all subjects is added. 

- <b>activity</b>: Describes each activity performed using the descriptive labels from "activity_labels.txt" in the UCI HAR dataset. The activities are: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING and LAYING.

- <b>feature</b>: collapses the column variables from the updated all_data table into one feature variable. The original feature list and details are in the UCI HAR database. The modified feature names and their original equivalents are in this repo as "namechanges.csv". These only include the features with "mean" or "std" in their names. An additional variable called "subject_avg" which is the average of that subject over all variables is added. 

- <b>observation</b>: the relevant sensor signals obtained from merging the X_train and X_test datasets in the UCI HAR dataset, these also include the calculated sensor signal averages as described in the subject and feature column descriptions above. 
 
According to Hadley Wickham's seminal article "Tidy Data", in tidy data:

1. Each variable forms a column.
2. Each observation forms a row.
3. Each type of observational unit forms a table. 

<b><i>final_data</b></i> conforms to this as each variable (subject, activity, feature, observation) has its own column, the relevant sensor signal mean and standard deviation observations each form a row, and the entire observational unit of mean and standard deviation observations of the relevant sensor signals forms the table. 


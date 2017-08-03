
##Code book 

This codebook will first describe the variables that were in the UCI HAR dataset given (can be downloaded from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones), the transformations performed on the data and the data in the final_data.txt file which is the complete output file created for the project. 

##Original Data
The files in the UCI HAR dataset include:

- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels

- 'train/subject_train.txt' & 'train/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

The train and test folders each also contained an ÒInertial SignalsÓ folder which was ignored. 

Transformations:

After downloading the zip and reading the relevant files into R using read.table(), the training and test datasets were merged using rbind() creating three tables, one each for the x-data, y-data, and subject data. These three tables were then merged using cbind() to create initial_data, which satisfies the requirement of Step 1 to merge all the data sets and create one data set.

grep() was used to extract the mean and standard deviation columns and x_data, y_data, and subject_data tables were modified to only contain the mean / std dev data. Using names(), the activity labels were added from activity_lables.txt and descriptive names like ÒsubjectÓ and ÒactivityÓ were added. The dataset was reassembled using cbind() and was named all_data. This satisfied the requirements of Steps 2, 3 and 4 of the project. 

For the final step of creating a tidy data set with averages for each variable and each subject, first the following packages were installed using library(): data.table, dplyr, tidyr, and stringr. 

The subject average column with the mean of subject was created by using mutate() on all_data. Then a new row called activity_avg was created with the mean of every variable using colMeans and then rbind(). To create a tidy data set from  the transformed all_data table  the gather() function was used. Before gather() could be used, the column names which contained special characters Ò-Ò and Ò()Ó had to be changed using str_replace(). The name changes have been recorded and stored in namechanges.txt for later reference, if necessary. 

Finally, gather() was used to create a tidy data set called final_data and the file was saved as final_data.text. final_data has four variables, each in its own column: subject, activity, feature, and observation. 

subject: Each row identifies the subject who performed the relevant activity. Its range is from 1 to 30 and ÒALLÓ which is the average of the relevant feature for all subjects. 

activity: Describes each activity performed using the descriptive labels from Òactivity_lables.txtÓ in the UCI HAR dataset. The activities are: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING and LAYING.

feature: collapses the column variables from the updated all_data table into one feature variable. The original feature list and details are in the UCI HAR database. The modified feature names and their original equivalents are in this repo as Ònamechanges.csvÓ. These only include the features with ÒmeanÓ or ÒstdÓ in their names. An additional variable called Òsubject_avgÓ which is the average of that subject over all variables is added. 

observation: the relevant sensor signals obtained from merging the X_train and X_test datasets in the UCI HAR dataset, these also include the calculated sensor signal averages as described in the subject and feature column descriptions above. 
 
According to Hadley Wickham's seminal article "Tidy Data", in tidy data:

1. Each variable forms a column.
2. Each observation forms a row.
3. Each type of observational unit forms a table. 

final_data conforms to this as each variable (subject, activity, feature, observation) has its own column, the relevant sensor signal mean and standard deviation observations each form a row, and the entire observational unit of mean and standard deviation observations of the relevant sensor signals forms the table. 


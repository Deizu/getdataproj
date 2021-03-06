# "Getting & Cleaning Data" Course Project Code Book
This document describes the data used in this analysis and the variables selected for use. All actions taken by the <code>run_analysis.R</code> script in order to clean up the data are covered in the *README.md* file.

----

##Data
The analysis performed in this project uses a subset of the publicly available "Human Activity Recognition Using Smartphones Data Set" <sup>1</sup>. The data set was downloaded for this analysis from the <a href="http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones">UCI Machine Learning Repository</a> <sup>2 & 3</sup> on July 8, 2015. The original dataset is described by the repository as follows.

> Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.

The authors of the dataset included the following introductory description in their README file.

> The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity...

It is important to note that the authors of the dataset indicate within their *README.txt* file that "Features are normalized and bounded within [-1,1]." **This means that units are not provided with these measurements; they were normalized prior to this analysis and are therefore to be taken as-is.**

####Citations
1. Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012.
2. Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013. 
3. Lichman, M. (2013). UCI Machine Learning Repository [http://archive.ics.uci.edu/ml]. Irvine, CA: University of California, School of Information and Computer Science. 

----

##Variables

The variable names used in the original dataset used abbreviations, camel case lettering, and punctuation to provide distinct names for each of the 561 items in each observation vector. This analysis is concerned only with the measurements of mean and standard deviation, so it is possible to reduce the list of measurement variables from 561 to a total of 66. (Note that the resulting tidy dataset contains 68 variables because it includes identification factors for both the activity and subject for each observation.)

Using the <code>gsub()</code> function in R, the variable names have been revised. The abbreviations, camel case lettering, and punctuation previously mentioned have been removed to create simple, human-readible descriptions consisting of full words separated by single periods.

The original and revised variable names used in this analysis are shown below in a table for ease of reference. To illustrate the process, please see the first item in the Transformations section.

|#|   Original| Revised|
| :------------: |:---------------| :-----|
|1| 	tBodyAcc-mean()-X| 	time.body.accelerometer.mean.x|
|2| 	tBodyAcc-mean()-Y| 	time.body.accelerometer.mean.y|
|3| 	tBodyAcc-mean()-Z| 	time.body.accelerometer.mean.z|
|4| 	tBodyAcc-std()-X| 	time.body.accelerometer.standard.deviation.x|
|5| 	tBodyAcc-std()-Y| 	time.body.accelerometer.standard.deviation.y|
|6| 	tBodyAcc-std()-Z| 	time.body.accelerometer.standard.deviation.z|
|7| 	tGravityAcc-mean()-X| 	time.gravity.accelerometer.mean.x|
|8| 	tGravityAcc-mean()-Y| 	time.gravity.accelerometer.mean.y|
|9| 	tGravityAcc-mean()-Z| 	time.gravity.accelerometer.mean.z|
|10| 	tGravityAcc-std()-X| 	time.gravity.accelerometer.standard.deviation.x|
|11| 	tGravityAcc-std()-Y| 	time.gravity.accelerometer.standard.deviation.y|
|12| 	tGravityAcc-std()-Z| 	time.gravity.accelerometer.standard.deviation.z|
|13| 	tBodyAccJerk-mean()-X| 	time.body.accelerometer.jerk.mean.x|
|14| 	tBodyAccJerk-mean()-Y| 	time.body.accelerometer.jerk.mean.y|
|15| 	tBodyAccJerk-mean()-Z| 	time.body.accelerometer.jerk.mean.z|
|16| 	tBodyAccJerk-std()-X| 	time.body.accelerometer.jerk.standard.deviation.x|
|17| 	tBodyAccJerk-std()-Y| 	time.body.accelerometer.jerk.standard.deviation.y|
|18| 	tBodyAccJerk-std()-Z| 	time.body.accelerometer.jerk.standard.deviation.z|
|19| 	tBodyGyro-mean()-X| 	time.body.gyroscope.mean.x|
|20| 	tBodyGyro-mean()-Y| 	time.body.gyroscope.mean.y|
|21| 	tBodyGyro-mean()-Z| 	time.body.gyroscope.mean.z|
|22| 	tBodyGyro-std()-X| 	time.body.gyroscope.standard.deviation.x|
|23| 	tBodyGyro-std()-Y| 	time.body.gyroscope.standard.deviation.y|
|24| 	tBodyGyro-std()-Z| 	time.body.gyroscope.standard.deviation.z|
|25| 	tBodyGyroJerk-mean()-X| 	time.body.gyroscope.jerk.mean.x|
|26| 	tBodyGyroJerk-mean()-Y| 	time.body.gyroscope.jerk.mean.y|
|27| 	tBodyGyroJerk-mean()-Z| 	time.body.gyroscope.jerk.mean.z|
|28| 	tBodyGyroJerk-std()-X| 	time.body.gyroscope.jerk.standard.deviation.x|
|29| 	tBodyGyroJerk-std()-Y| 	time.body.gyroscope.jerk.standard.deviation.y|
|30| 	tBodyGyroJerk-std()-Z| 	time.body.gyroscope.jerk.standard.deviation.z|
|31| 	tBodyAccMag-mean()| 	time.body.accelerometer.magnitude.mean|
|32| 	tBodyAccMag-std()| 	time.body.accelerometer.magnitude.standard.deviation|
|33| 	tGravityAccMag-mean()| 	time.gravity.accelerometer.magnitude.mean|
|34| 	tGravityAccMag-std()| 	time.gravity.accelerometer.magnitude.standard.deviation|
|35| 	tBodyAccJerkMag-mean()| 	time.body.accelerometer.jerk.magnitude.mean|
|36| 	tBodyAccJerkMag-std()| 	time.body.accelerometer.jerk.magnitude.standard.deviation|
|37| 	tBodyGyroMag-mean()| 	time.body.gyroscope.magnitude.mean|
|38| 	tBodyGyroMag-std()| 	time.body.gyroscope.magnitude.standard.deviation|
|39| 	tBodyGyroJerkMag-mean()| 	time.body.gyroscope.jerk.magnitude.mean|
|40| 	tBodyGyroJerkMag-std()| 	time.body.gyroscope.jerk.magnitude.standard.deviation|
|41| 	fBodyAcc-mean()-X| 	frequency.body.accelerometer.mean.x|
|42| 	fBodyAcc-mean()-Y| 	frequency.body.accelerometer.mean.y|
|43| 	fBodyAcc-mean()-Z| 	frequency.body.accelerometer.mean.z|
|44| 	fBodyAcc-std()-X| 	frequency.body.accelerometer.standard.deviation.x|
|45| 	fBodyAcc-std()-Y| 	frequency.body.accelerometer.standard.deviation.y|
|46| 	fBodyAcc-std()-Z| 	frequency.body.accelerometer.standard.deviation.z|
|47| 	fBodyAccJerk-mean()-X| 	frequency.body.accelerometer.jerk.mean.x|
|48| 	fBodyAccJerk-mean()-Y| 	frequency.body.accelerometer.jerk.mean.y|
|49| 	fBodyAccJerk-mean()-Z| 	frequency.body.accelerometer.jerk.mean.z|
|50| 	fBodyAccJerk-std()-X| 	frequency.body.accelerometer.jerk.standard.deviation.x|
|51| 	fBodyAccJerk-std()-Y| 	frequency.body.accelerometer.jerk.standard.deviation.y|
|52| 	fBodyAccJerk-std()-Z| 	frequency.body.accelerometer.jerk.standard.deviation.z|
|53| 	fBodyGyro-mean()-X| 	frequency.body.gyroscope.mean.x|
|54| 	fBodyGyro-mean()-Y| 	frequency.body.gyroscope.mean.y|
|55| 	fBodyGyro-mean()-Z| 	frequency.body.gyroscope.mean.z|
|56| 	fBodyGyro-std()-X| 	frequency.body.gyroscope.standard.deviation.x|
|57| 	fBodyGyro-std()-Y| 	frequency.body.gyroscope.standard.deviation.y|
|58| 	fBodyGyro-std()-Z| 	frequency.body.gyroscope.standard.deviation.z|
|59| 	fBodyAccMag-mean()| 	frequency.body.accelerometer.magnitude.mean|
|60| 	fBodyAccMag-std()| 	frequency.body.accelerometer.magnitude.standard.deviation|
|61| 	fBodyBodyAccJerkMag-mean()| 	frequency.body.accelerometer.jerk.magnitude.mean|
|62| 	fBodyBodyAccJerkMag-std()| 	frequency.body.accelerometer.jerk.magnitude.standard.deviation|
|63| 	fBodyBodyGyroMag-mean()| 	frequency.body.gyroscope.magnitude.mean|
|64| 	fBodyBodyGyroMag-std()| 	frequency.body.gyroscope.magnitude.standard.deviation|
|65| 	fBodyBodyGyroJerkMag-mean()| 	frequency.body.gyroscope.jerk.magnitude.mean|
|66| 	fBodyBodyGyroJerkMag-std()| 	frequency.body.gyroscope.jerk.magnitude.standard.deviation|


Basic format of revised variable names: domain.target.sensor(.type)(.axis)

 * Domain refers to the time or frequency of the sensor readings.
 * Target refers to the measurement of the body's movement in space or to the relative effect of gravity.
 * Sensor refers to either the accelerometer or gyroscope sensors of the smart phone.
 * Type describes the kind of measurement.
 * Axis refers to either the X, Y, or Z axis of the phone.

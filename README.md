# README First!

This data analysis project is an exercise in obtaining "messy" data from a real-world source and manipulating it in such a fashion that it becomes "tidy", defined by Hadley Wickham in his paper _Tidy data_<sup>1</sup> as meeting the following criteria:

> 1. Each variable forms a column.
2. Each observation forms a row.
3. Each type of observational unit forms a table.

The <code>run_analysis.R</code> script provided for this analysis enables a user to reassemble a dataset of 564 variables and 10299 observations and subsequently hone in on specific measurements before summarizing them down into one tidy dataset containing 68 variables and 180 observations.

Read further to understand this project's included scripts, dependencies, assumptions, actions, and results. Please also see the Citations section at the bottom for proper accreditation.

## Scripts & Files

1. *run_analysis.R*
  This analysis uses a single script file containing all operations needed to import and transform the raw data and output the required tidy dataset.
2. *CodeBook.md*
  This is the Code Book for this analysis, describing the data, variables, and actions performed by scripts. 
3. *README.md*
  This is the README file for this analysis and this GitHub repository.
4. *tidy_data.txt*
  This is an example of the tidy dataset output by this analysis.

## Dependencies

#### 1. Data Exists in Home Directory

Please make sure you have the raw dataset<sup>6 & 7</sup> downloaded and unzipped in your R working directory before using this script. This script assumes that any users have maintained the same folder structure as the data was originally provided in. This script cannot analyze the raw data if it is not present!

#### 2. Required Package: <code>dplyr</code>

Please make sure you have installed the <code>dplyr</code> package in R. It is used in the summarization process.

## Assumptions

#### Variable Inclusion / Exclusion

This analysis is concerned solely with the measurements of mean and standard deviation. Thus, all variables which measure or estimate the mean (as shown through the characters "mean" in the original variable name) or the standard deviation (as shown through the characters "std" in the original variable name) have been kept with some exclusions. Variables which included "mean" or "std" as part of a calculation of estimated angle are dropped.

#### Units of Measurement

It is important to note that the authors of the dataset indicate within their *README.txt* file that "Features are normalized and bounded within [-1,1]." **This means that units are not provided with these measurements; they were normalized prior to this analysis and are therefore to be taken as-is.**

## Actions (Transformations)

#### Variable name transformation

The variable names for these datasets are provided in a standalone file (*/UCI HAR Dataset/features.txt*) and are read into R using <code>read.table()</code>. In order to provide more user-friendly variable names, the originals are processed using <code>gsub()</code> to remove punctuation and expand abbreviations into full words separated by periods and simultaneously drop capital letters by ignoring case during replacment. While the <code>run_analysis.R</code> script performs these operations in a vectorized fashion, the following example illustrates the process for a single variable (#1 from the list in the *CodeBook.md* file).

**Original**: tBodyAcc-mean()-X

**Revised**: time.body.accelerometer.mean.x
````
variable <- "tBodyAcc-mean()-X"
variable <- tolower(variable)
variable <- gsub("-|\\(|\\)","",variable,ignore.case=FALSE)
variable <- gsub("acc","accelerometer.",variable)
variable <- gsub("t.body","time.body.",variable)
variable <- gsub("acc","accelerometer.",variable)
variable <- gsub("x",".x",variable)
````

#### Activity name clarification

The activity names for these datasets are provided in a standalone file (*/UCI HAR Dataset/activity_labels.txt*) and are read into R using <code>read.table()</code>. The activities come with numerical identifiers much like those used in a relational database. This analysis flattens the activity names to lowercase using <code>tolower()</code>. The numerical identifier present in the imported datasets (see below) is converted to a factor, and then the labels for that factor are overwritten using the lowercase activity names via the <code>levels()</code> function.

#### Combination of Test and Train datasets

There were a total of 6 files needed to piece together the original dataset, because the others had used 70% of their results to train an algorithm and 30% of their results to test the accuracy of the algorithm they developed. These files were located in the following places.
 * /UCI HAR Dataset/test/X_test.txt
 * /UCI HAR Dataset/test/y_test.txt
 * /UCI HAR Dataset/test/subject_test.txt
 * /UCI HAR Dataset/train/X_train.txt
 * /UCI HAR Dataset/train/y_train.txt
 * /UCI HAR Dataset/train/subject_train.txt

##### Combining each set individually

Each of the 3 files (X, y, and subject) were read into R using <code>read.table()</code> with default settings and then combined using the <code>cbind()</code> function, placing the columns in the following order: activity, subject, measurement. In case a future user needs to parse through which observations came from which original set as they step through the <code>run_analysis.R</code> script in the future, one further <code>cbind()</code> has been used to place a column called "set" which defines the source value as either "test" or "train" appropriately. Note that this column is immediately dropped when the analysis continues, as it is not required for the final tidy data output.

##### Combining the Test and Train datasets

The completed Test and Train datasets are easily combined by stacking them via the <code>rbind()</code> function.

#### Subsetting the Raw Data

The combined dataset is subsetted by using an index vector pulled through the <code>grep()</code> function matching the character strings of "-mean(" or "-std(". The subject and activity columns are maintained, and only the columns matching the index are added back through a <code>cbind()</code> command.

#### Summarization of Mean Measurements by Subject and Activity

This analysis made use of the <code>dplyr</code> package and its <code>summarize_each()</code> function to distill the contents of the grouped data into one mean measurement for each of the 66 variables of interest for every combination of subject and activity, yielding a final tidy dataset of 180 observations of 68 variables.

### Results

The output of the analysis is a tidy dataset written by <code>write.table()</code> to a text file, though the script also leaves the tidy dataset available in the user's environment should further analysis in R be desired. The final dataset containins 68 variables (2 factors: subject and activity / 66 numerical variables) and 180 observations of the mean; one for each combination of subject and activity.

#### How to read the resultant tidy dataset back into R

The tidy dataset output by the <code>run_analysis.R</code> script is provided as *tidy_dataset.txt* in this repository. To read it into R, please use the following code.
````
imported_tidy_data <- read.table("./tidy_data.txt",stringsAsFactors=TRUE,header=TRUE)
````
The tidy dataset submitted for this Coursera course project is also available online. To use it instead, please use the following code.
````
address <- "https://s3.amazonaws.com/coursera-uploads/user-8359e34dc2d78171cdbf41fb/975114/asst-3/fd1f75e033db11e5b42eef7d236f8319.txt"
address <- sub("^https", "http", address)
data <- read.table(url(address), stringsAsFactors=TRUE, header = TRUE)
View(data)
````

## Citations

1. Wickham, H. (2014). Tidy data. The Journal of Statistical Software, 59 (10). Retrieved preprint copy from http://vita.had.co.nz/papers/tidy-data.html (2015).
2. Wickham, H. (2015). dplyr: A Grammar of Data Manipulation. The Comprehensive R Archive Network. https://cran.r-project.org/web/packages/dplyr/ (2015).
3. Hood, D. "Tidy Data and the Assignment". Accessed at https://class.coursera.org/getdata-030/forum/thread?thread_id=107 (2015).
4. Hood, D. "David's personal course project FAQ". Accessed at https://class.coursera.org/getdata-030/forum/thread?thread_id=37 (2015).
5. Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012.
6. Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.
7. Lichman, M. (2013). UCI Machine Learning Repository [http://archive.ics.uci.edu/ml]. Irvine, CA: University of California, School of Information and Computer Science.

Note that several citations are repeated on the *CodeBook.md* markdown document, for ease of reference.
# README First!

This data analysis project is an exercise in obtaining "messy" data from a real-world source and manipulating it in such a fashion that it becomes "tidy", defined by Hadley Wickham in his paper _Tidy data_<sup>1</sup> as meeting the following criteria:

> 1. Each variable forms a column.
2. Each observation forms a row.
3. Each type of observational unit forms a table.

Read further to understand this project's included scripts, dependencies, assumptions, and results. Please also see the Citations section at the bottom for proper accreditation.

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
Please make sure you have the raw dataset downloaded and unzipped in your R working directory before using this script. This script cannot analyze the raw data if it is not present!

#### 2. Required Package: <code>dplyr</code>
Please make sure you have installed the <code>dplyr</code> package in R. It is used in the summarization process.

## Assumptions

#### Variable Inclusion / Exclusion
This analysis is concerned solely with the measurements of mean and standard deviation.

#### Units of Measurement
It is important to note that the authors of the dataset indicate within their *README.txt* file that "Features are normalized and bounded within [-1,1]." **This means that units are not provided with these measurements; they were normalized prior to this analysis and are therefore to be taken as-is.**

### How to read the resultant tidy dataset back into R

The tidy dataset output by the <code>run_analysis.R</code> script is provided as *tidy_dataset.txt* in this repository. To read it into R, please use the following code.
````
imported_tidy_data <- read.table("./tidy_data.txt",stringsAsFactors=TRUE,header=TRUE)
````
The tidy dataset submitted for this Coursera course project is also available online. To use it instead, please use the following code.
````
address <- "https://s3.amazonaws.com/coursera-uploads/user-8359e34dc2d78171cdbf41fb/975114/asst-3/c5000b90325d11e5b5c39524000db49c.txt"
address <- sub("^https", "http", address)
data <- read.table(url(address), stringsAsFactors=TRUE, header = TRUE)
View(data)
````

## Citations
1. Wickham, H. (2014). Tidy data. The Journal of Statistical Software, 59 (10). Retrieved preprint copy from http://vita.had.co.nz/papers/tidy-data.html (2015).
dplyr package
rstudio
CTA David Hood https://class.coursera.org/getdata-030/forum/thread?thread_id=107
CTA David Hood https://class.coursera.org/getdata-030/forum/thread?thread_id=37
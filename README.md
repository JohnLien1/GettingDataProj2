The Working Directory for the code to operate as it stands should be where th data has be downlaoded to, in this case (UCI HAR dataset).

Section 1 in the code---
the files names with .txt extensions are obtained for train and test folders
and stored in train.files and test.files, respectively. 

Subject, action and chunk are read from .txt files subject_x1.txt, Y_x1.txt 
and 'X_x1.txt', respetcively, here x1 can be test or train. these data is converted to numerical and combined using cbind to form Data_train and Data_test.

Names of the quantities are read into names using read.table from features.txt file.
The combined dataset is also given the same name thus obtained.

rbind is used to combine both train and test datasets called Data...

Section 2 in the code----

Next only colnames with mean(), std(), subject and action are selected from Data. However mean() asloe selects meanfreq() coloumns. To avoid this coulmns.
all coloumns that does not contain MeanFreq() is selected. an intesection of first selection and second selection will give the required coloumn. Using these, Data2 is created which is a subset of Data and contains required coloumns only. 

Section 3 in the code --- 
 In Action coulmn coloumn respective numbers are changed to activities given in activity_label.txt file. this is not directly from file, instead hard coded. 


Section 4 in the code---

titles of the coulmns are changed by removing () and - to '.'
Acc is changed to acclerator, Gyro to Ang velcoity- which is the angular velocity.
small letter t is changed to Time and f to Freq (Frequency).

section 5 in the code ---
two packages are loaded names plyr and dplyr
A new dataset namely NewData is created..
NewData contains subject and action along with 66 columns for which mean value of the coloumn was obtained.
similarly a NewData2 contains standard deviation for the same 66 coloumns for mean value was obtained. 
NewData is stored again into Req_Data.

section 6 ---

the required data is written into a new file called TidyData.txt...

Section 7---
Part of the cookbook is created automatically where by each part of the heading is elborated using a gsub function, and later combined to give a full discription. 
 

    


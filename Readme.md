
### Readme for tidy data

This data is derived from separated dataset that collecting human activity using smartphone, where 70% is for training data and 30% is for the test data.The orinal data, which contains sereral file in two folders, was processed using programming language R to generate one file. 

First, cbind() was used to combine data with activity and identifier for both test and training data. 

Then, they were merged to generate one big file named "allData" by both "subject" and "activivy" using merge() command. Partial data including only mean and stadard derivation of each measurement was further extract using select() in dplyr package.

Next, numeric activity values were replaced by descriptive names by producing factor variable. Column variable names were also editted by more descriptive names, including replacing "t" and "f" with "time" and "freq" separetely, removing "-" and "()" and fix "BodyBody" error.

Final data is only including the average of each variable for each activity and subject.

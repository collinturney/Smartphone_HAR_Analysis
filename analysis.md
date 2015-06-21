# HAR Analysis Steps

## Step 1: Merging the datasets

The raw data consists of training and test data. This step merges those datasets
and does some basic renaming of columns for consistency.

## Step 2: Select mean/standard deviation

This step selects only the columns that contain mean and standard deviations to
be summarized later. Additionally, the column names are cleaned up and lower
cased.

## Step 3-4: Label activity column

This step factors in the data from activity\_labels.txt in place of the activity
IDs that are in the raw data set.

## Step 5: Group and summarize each column

Finally, each column is summarized according to subject activity and written to
"tidy\_data.txt".


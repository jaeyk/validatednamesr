# validatednamesr

Author: Jae Yeon Kim and Charles Crabtree

## Summary 

## Installation 

```r
devtools::install_github("jaeyk/validatednamesr",
                          dependencies = TRUE)
```

## Usage 

1. `view_data()`: This function views the dataset's filename, type, and notes. 

```r
                  filename      type                   notes
1                names.rds  Original               Raw names
2             study123.rds  Original    Pooled study results
3        study-1-names.rds  Original          Study 1 result
4        study-2-names.rds  Original          Study 2 result
5        study-3-names.rds  Original          Study 3 result
6 hq_group_group_names.rds Validated Within group assessment
````

2. `load_data()`: This function loads a particualr dataset. Use either `file_name` or `file_note` argument.

```{r}
# The following two commands will provide the same output.

#file name
df <- load_data(file_name = "names.rds")

# file note 
df <- load_data(file_note == "Raw names")
```

## How to cite

```{r}

Kim, J and Crabtree, C. (2022). validatednamesr: R package for viewing, loading, and visualizing the Validated Names for Experimental Studies on Race and Ethnicity datasets. 

```

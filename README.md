# validatednamesr

Authors: [Jae Yeon Kim](https://jaeyk.github.io/) and [Charles Crabtree](https://charlescrabtree.com/)

## Summary 
    
Researchers have used names to signal race in various types of experimental tasks (e.g., survey experiments, conjoint experiments, and correspondence experiments). 

In so doing, researchers need to take at least the following three factors into consideration: 

1. Select names that vary across race but are constant across other perceived attributes or names that vary across race and other perceived attributes. 

2. Use not just one but several names to increase reliability. 

3. Use names that signal differences in citizenship, education, and income both within and across races to explore.

This R package provides functions to perform each task based on the validated names datasets forthcoming in *Nature Scientific Data* (Crabtree, Kim, Gaddis, Holbein, Guage, and Marx 2023). It helps researchers to choose names in an experimental study consistent with their research objectives and underlying assumptions.

## Installation 

```r
devtools::install_github("jaeyk/validatednamesr",
                          dependencies = TRUE)
```

## Usage 

### Viewing and loading datasets 

1. `view_data()`: This function views the dataset's filename, type, and notes (meta data). 

```r
view_data()

           filename    type          notes
1         names.rds   Names      Raw names
2 study-1-names.rds Studies Study 1 result
3 study-2-names.rds Studies Study 2 result
4 study-3-names.rds Studies Study 3 result
5      study123.rds  Pooled  Pooled result
````

2. `load_data()`: This function loads a particular dataset. Use either `file_name` or `file_note` argument.

```{r}
# The following two commands will provide the same output.

#file name
df <- load_data(file_name = "names.rds")

# file note 
df <- load_data(file_note == "Raw names")
```

### Select names in conjunction with other perceived attributes 

### Select many names 

### Select 

## How to cite

```{r}

Kim, J and Crabtree, C. (2022). validatednamesr: R package for viewing, loading, and visualizing the Validated Names for Experimental Studies on Race and Ethnicity datasets. 

```

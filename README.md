# validatednamesr

Authors: [Jae Yeon Kim](https://jaeyk.github.io/) and [Charles Crabtree](https://charlescrabtree.com/)

## Summary 
    
Researchers have used names to signal race in various experimental tasks (e.g., survey, conjoint, and correspondence experiments). 

In so doing, researchers need to take at least the following three factors into consideration: 

1. Select names that vary across race but are constant across other perceived attributes or names that vary across race and other perceived attributes. 

2. Use not just one but several names to increase reliability. 

3. Use names that signal differences in citizenship, education, and income within and across races to explore.

This R package provides functions to perform each task based on the validated **600** names (white: 100, Asian: 300, black: 100, Hispanic: 100) datasets forthcoming in *Nature Scientific Data* (Crabtree, Kim, Gaddis, Holbein, Guage, and Marx 2023). It helps researchers to choose names in an experimental study consistent with their research objectives and underlying assumptions.

## Installation 

```r
devtools::install_github("jaeyk/validatednamesr", dependencies = TRUE)
```

## Usage 

### View and load datasets 

1. `view_data()`: This function views the dataset's filename, type, and notes (metadata). 

```r
view_data()

           filename    type          notes
1         names.rds   Names      Raw names
2 study-1-names.rds Studies Study 1 result
3 study-2-names.rds Studies Study 2 result
4 study-3-names.rds Studies Study 3 result
5      study123.rds  Pooled  Pooled result
````

2. `load_data()`: This function loads a particular dataset. Use either the `file_name` or `file_note` argument.

```{r}
# The following two commands will provide the same output.

#file name
raw_names <- load_data(file_name = "names.rds")

# file note 
raw_names <- load_data(file_note == "Raw names")
```

### Select names 

The `select_names()` function helps to choose the validated names intended to signal a particular race using the `race` argument. The options available for this argument are: `Asian,` `Black,` `Hispanic,` `White.`

The output's datatype is a dataframe, and it has nine columns: `first` (first name), `last` = last name, `w.asian` = westernized Asian name (1 = yes, 0 = no), `name` (full name), `identity` (the name's intended race), `mean_correct` = the percentage of the name's intended race correctly perceived (0-1), `avg_income` = average perceived income level (1-5), `avg_education` = average perceived education level (1-5), `avg_citizenship_guess` = the percentage of perceived citizenship status (0-1).

```r
asian_names <- select_names(race = "Asian") # Asian signalling names 

asian_names 

  first last  w.asian name      identity       mean_correct avg_income avg_education avg_citizenship_guess
  <chr> <chr>   <dbl> <chr>     <fct>            <dbl>   <dbl>   <dbl>   <dbl>
1 Dan   Yang        1 Dan Yang  Asian or Paci…   0.848    2.09    2.55   0.773
2 Hong  Pham        0 Hong Pham Asian or Paci…   0.826    1.94    2.28   0.465
3 May   Chen        1 May Chen  Asian or Paci…   0.878    2.07    2.37   0.789
4 Hong  Le          0 Hong Le   Asian or Paci…   0.816    1.97    2.42   0.539
5 Wei   Le          0 Wei Le    Asian or Paci…   0.806    1.93    2.18   0.418
```

You can change the threshold level of the names to be correctly perceived using the `pct_correct` argument. The default value for this argument is `0.8.`

```r
high_thres_names <- select_names(race = "Asian", pct_correct = 0.7)
```

You can also change the number of the names to be selected using the `n_names` argument. The default value for this argument is `5.` These names will be selected randomly.  

```r
greater_n_names <- select_names(race = "Asian", n_names = 10)
```

It's possible to select the names using ordering rather than random sampling. To do so, you need to select what variable you need to use to order the observations (i.e., names). The argument for this feature is called `order_by_var.` The values available for it are: `pct_correct` = the percentage of the name's intended race correctly perceived, `avg_income` = average perceived income level, `avg_education` = average perceived education level, and `avg_citizenship_guess` = the percentage of perceived citizenship status. 

```r
top_correct_names <- select_names(race = "Asian", order_by = "pct_correct")
```

Finally, if you would like to select the names from all racial groups, use `select_nams_all()` instead of `select_names().` Note that `select_names_all()` does not have the `race` argument. The other arguments are identical. 

```r
all_race_names <- select_names_all()
```

## How to cite

```{r}

Kim, J and Crabtree, C. (2022). validatednamesr: R package for viewing, loading, and visualizing the Validated Names for Experimental Studies on Race and Ethnicity datasets. 

```
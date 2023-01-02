#' Select names from all races
#' 
#' @param pct_correct_thres The names' threshold rate of being correctly perceived as a particular race. The default value is 0.8
#' @param order_by_var The variable to be used to order the list of the names to be extracted. The default variable is NULL (non-selected). The other options are pct_correct = the percentage of the name's intended race correctly perceived, avg_income = average perceived income level, avg_education = average perceived education level, and avg_citizenship_guess = the percentage of perceived citizenship status 
#' @param n_names The number of the names to be selected. The default number is 5.
#' @return The dataset that contains the list of the selected names. first = first name, last = last name, w.asian = westernized Asian name (1 = yes, 0 = no), name (full name), identity (the name's intended race), 
#' pct_correct = the percentage of the name's intended race correctly perceived, avg_income = average perceived income level, avg_education = average perceived education level, avg_citizenship_guess = the percentage of perceived citizenship status 
#' 
#' @importFrom dplyr mutate
#' @importFrom dplyr bind_rows
#' @importFrom purrr reduce
#' @export
#' 

select_names_all <- function(pct_correct_thres = 0.8, order_by_var = NULL, n_names = 5) {
  
  # Each racial group names
  asian_names <- select_names(race = "Asian")
  white_names <- select_names(race = "White")
  black_names <- select_names(race = "Black")
  hispanic_names <- select_names(race = "Hispanic")
  
  # Combine them
  df <- reduce(list(asian_names, white_names, black_names, hispanic_names), bind_rows)
    
  return(df)
  
}

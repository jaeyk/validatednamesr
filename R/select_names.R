#' Select names 
#' 
#' @param race Character. The race intended to be signaled by the names. The value should be either "Asian," "Hispanic," "Black," or "White." 
#' @param pct_correct Numeric. The names' threshold rate of being correctly perceived as a particular race. The default value is 0.8
#' @param order_by_var Character. The variable to be used to order the list of the names to be extracted. The default variable is NULL (non-selected). In this case, the names will be chosen randomly. The other options are pct_correct = the percentage of the name's intended race correctly perceived, avg_income = average perceived income level, avg_education = average perceived education level, and avg_citizenship = the percentage of perceived citizenship status.
#' @param n_names Numeric. The number of the names to be selected. The default number is 5.
#' @return The dataset that contains the list of the selected names. first = first name, last = last name, w.asian = westernized Asian name (1 = yes, 0 = no), name (full name), identity (the name's intended race), 
#' pct_correct = the percentage of the name's intended race correctly perceived, avg_income = average perceived income level, avg_education = average perceived education level, avg_citizenship = the percentage of perceived citizenship status 
#' 
#' @importFrom dplyr group_by
#' @importFrom dplyr ungroup
#' @importFrom dplyr filter
#' @importFrom dplyr select
#' @importFrom dplyr distinct
#' @importFrom dplyr summarize
#' @importFrom dplyr filter
#' @importFrom dplyr left_join
#' @importFrom stringr str_detect
#' @importFrom dplyr slice_max
#' @importFrom dplyr slice_sample
#' @importFrom dplyr rename
#' @export
#' 

select_names <- function(race, pct_correct = 0.8, order_by_var = NULL, n_names = 5) {
  
  if (is.null(race)) {
    
    stop("Provide the intended race of the names that you would like to select")
    
  }
    
  # Pooled dataset
  pooled <- load_data(file_note = "Pooled")
  names <- load_data(file_name = "names.rds")
  
  # Pct correctness 
  name_pct_correct <- pooled %>%
    group_by(name) %>%
    summarize(mean_correct = mean(correct))
  
  # Covariates 
  name_covariates <- pooled %>%
    group_by(name) %>%
    summarize(avg_income = mean(income.ord, na.rm = T),
              avg_education = mean(education.ord, na.rm = T),
              avg_citizenship = mean(citizen, na.rm = T))
  
  # Join names, pct correctness, and covariates
  df <- names %>%
    select(name, identity) %>%
    left_join(name_pct_correct) %>%
    left_join(name_covariates) 
  
  if (is.null(order_by_var)) {
  
    out <- df %>%
      filter(str_detect(identity, race)) %>% # race
      filter(mean_correct >= pct_correct) %>% # pct_correct
      ungroup() %>%
      slice_sample(n = n_names) %>%
      rename(pct_correct = mean_correct)
    
  } else {
  
    out <- df %>%
      filter(str_detect(identity, race)) %>% # race
      filter(mean_correct >= pct_correct) %>%
      ungroup() %>%
      rename(pct_correct = mean_correct) %>%
      slice_max(get(order_by_var), 
                n = n_names) # n_names
    
  }
  
  return(out)
  
  }

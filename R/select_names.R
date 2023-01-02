#' Select names 
#' 
#' @param race The race intended to be signaled by the names. The value should be either "Asian," "Hispanic," "Black," or "White." 
#' @param pct_correct_thres The names' threshold rate of being correctly perceived as a particular race. The default value is 0.8
#' @param n_names The number of the names to be selected. The list is ordered by pct_correct. The default number is 5.
#' @return The dataset that contains the list of the selected names. first = first name, last = last name, w.asian = westernized Asian name (1 = yes, 0 = no), name (full name), identity (the name's intended race), 
#' pct_correct = the percentage of the name's intended race correctly perceived, avg_income = average perceived income level, avg_edu = average perceived education level, avg_citizenship_guess = the percentage of perceived citizenship status 
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
#' @export
#' 

select_names <- function(race, pct_correct_thres = 0.8, n_names = 5) {
  
  if (is.null(race)) {
    
    stop("Provide the intended race of the names that you would like to select")
    
  }
    
  # Pooled dataset
  pooled <- load_data(file_note = "Pooled")
  names <- load_data(file_name = "names.rds")
  
  # Pct correctness 
  name_pct_correct <- pooled %>%
    group_by(name) %>%
    summarize(pct_correct = mean(correct))

  # Covariates 
  name_covariates <- pooled %>%
    group_by(name) %>%
    summarize(avg_income = mean(income.ord, na.rm = T),
              avg_education = mean(education.ord, na.rm = T),
              avg_citizenship_guess = mean(citizen, na.rm = T))
  
  # Join names, pct correctness, and covariates
  df <- names %>%
    select(name, identity) %>%
    left_join(name_pct_correct) %>%
    left_join(name_covariates)
  
  out <- df %>%
    filter(str_detect(identity, race)) %>% # race
    filter(pct_correct >= pct_correct_thres) %>% # pct_correct_thres
    ungroup() %>%
    slice_max(pct_correct, 
              n = n_names) # n_names

  return(out)
  
  }

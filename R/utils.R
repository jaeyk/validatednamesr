#' View the data from the Harvard Dataverse 
#' 
#' @param name_type The type of the dataset. Either original or validated. The default value is NULL.
#' @param name_target The name of the target dataset. The default value is NULL.
#' 
#' @return A dataframe that contains three columns: file name, type (either origianl or validated), and note
#' 
#' @importFrom dataverse get_dataset
#' @importFrom readr read_rds
#' @importFrom stringr str_detect
#' @export
#' 

view_data <- function(name_type = NULL, name_target = NULL) {
  
  # Set the Harvard server as the dataverse server 
  Sys.setenv("DATAVERSE_SERVER" = "dataverse.harvard.edu")
  
  # Load the pooled dataset 
  dataset <- dataverse::get_dataset("https://doi.org/10.7910/DVN/JVCUQM")
  
  # Pull the filenames 
  filenames <- dataset$files$filename
  
  # Original dataset 
  original <- c(filenames[5], filenames[stringr::str_detect(filenames, "study")]) 
  
  # Validated dataset 
  validated <- setdiff(filenames, original)
  
  # Add meta data 
  meta <- data.frame(filename = c(original, validated),
                     type = c(rep("Original", length(original)),
                              rep("Validated", length(validated))),
                     notes = c("Raw names", "Pooled study results", "Study 1 result",
                               "Study 2 result", "Study 3 result",
                               "Within group assessment", "Non-white and white assessment",
                               "White and non-white assessment", "General perception",
                               "Equivalance assessment"))
  
  if (is.null(name_type) & is.null(name_target))
    return(meta)
  
}

#' Load the data from the Harvard Dataverse 
#' 
#' @param file_name The exact file name for a particular dataset.One can find this information usign `view_data().`
#' @param file_note The exact note for a particular dataset. One can find this information using `view_data().` 
#' 
#' @return df A particular dataset 
#' 
#' @importFrom dataverse get_dataset
#' @importFrom dataverse get_dataframe_by_name
#' @importFrom readr read_rds
#' @importFrom stringr str_detect
#' @export
#' 

load_data <- function(file_name = NULL, file_note = NULL) {
  
  if (is.null(file_name) & is.null(file_note)) {
    
    stop("provide a non-NULL value for either file_name, file_type or file_note.")
    
  }
  
  # Meta data
  meta <- view_data()
  
  # Filtering 
  if (!is.null(file_name)) meta <- subset(meta, filename == file_name)
  if (!is.null(file_note)) meta <- subset(meta, notes == file_note)
  
  # Get the specific dataset
  df <- dataverse::get_dataframe_by_name(
    filename = meta$filename,
    dataset = "https://doi.org/10.7910/DVN/JVCUQM",
    original = T,
    .f = readr::read_rds)
  
  return(df)
}

test_that("Dataset view works", {
  
  dfs <- view_data()
  
  expect_equal(nrow(dfs), 5)
  
})

test_that("Dataset load works", {
  
  names <- load_data(file_name = "names.rds")
  
  expect_equal(nrow(names), 600)
  
})

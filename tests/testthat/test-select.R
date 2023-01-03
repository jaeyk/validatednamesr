
test_that("Asian names selected well", {
  
  expect_equal(nrow(select_names("Asian", pct_correct = 0.8, n_names = 5)), 5)
  
})

test_that("Black names selected well", {
  
  expect_equal(nrow(select_names("Black", pct_correct = 0.8, n_names = 5)), 5)
  
})

test_that("White names selected well", {
  
  expect_equal(nrow(select_names("White", pct_correct = 0.8, n_names = 5)), 5)
  
})

test_that("Hispanic names selected well", {
  
  expect_equal(nrow(select_names("Hispanic", pct_correct = 0.8, n_names = 5)), 5)
  
})

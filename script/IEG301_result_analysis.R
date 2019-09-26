rm(list=ls())

# Load the library
library(swirlify)
library(dplyr)

#### Change this to go to the next name, course, lesson, etc ####
# n_course = 1 IEG301 R Programming E; n_lesson = 15
# n_course = 2 IEG301 Getting and Cleaning Data; n_lesson = 4
# n_course = 3 IEG301 Exploratory Data Analysis; n_lesson = 9

n_course <- 1
n_lesson <- 2
# Import the data

#### Total scores for each lesson ####
if (n_course == 1) {
  total_score <- data.frame(lesson = c("basic_building_blocks", # lesson 1 = 18
                                       "workspace_and_files", # lesson 2 = 21
                                       "sequences_of_numbers", # lesson 3 = 14
                                       "vectors", # lesson 4 = 13
                                       "missing_values", # lesson 5 = 21
                                       "subsetting_vectors", # lesson 6 = 21
                                       "matrices_and_dataframes", # lesson 7 = 21
                                       "logic", # lesson 8 = 22
                                       "functions", # lesson 9 = 19
                                       "lapply_and_sapply", # lesson 10 = 26
                                       "vapply_and_tapply", # lesson 11 = 10
                                       "looking_at_data", # lesson 12 = 13
                                       "simulation", # lesson 13 = 22
                                       "dates_and_times", # lesson 14 = 26
                                       "base_graphics"), # lesson 15 = 19
                            total_score = c(18,21,14,13,12,21,21,22,19,10,13,22,19,
                                            19,19))
}

if (n_course == 2) {
  total_score <- data.frame(lesson = c("Manipulating Data with dplyr", # lesson 1
                                       "Grouping and Chaining with dplyr", # lesson 2
                                       "Tidying data with tidyr", # lesson 3
                                       "Dates and Times with lubridate"), # lesson 4,
                            total_score = c(38,21,20,44))
}

if (n_course == 3) {
  total_score <- data.frame(lesson = c("Principles of Analytics Graphs", # lesson 1
                                       "Exploratory Graphs", # lesson 2
                                       "Graphic Devices in R", # lesson 3
                                       "Plotting Systems", # lesson 4
                                       "Base Plotting Systems", # lesson 5
                                       "Hierarchical Clustering", # lesson 6
                                       "K means Clustering", # lesson 7
                                       "Dimension Reduction", # lesson 8
                                       "Case Study"), # lesson 9
                            total_score = c(10,33,18,11,31,16,21,23,62))
}

# Choose the data file to import
df <- google_form_decode()

# Convert from seconds to date
df$datetime <- as.POSIXct(df$datetime,origin="1970-01-01")

# Change some columns to factors or logicals
df$course_name <- as.factor(df$course_name)
df$lesson_name <- as.factor(df$lesson_name)
df$correct <- as.logical(df$correct)
df$skipped <- as.logical(df$skipped)

# Change the lesson to tbl format
df <- na.omit(df) # Omit all rows with NA's, usually bad data row.
df <- tbl_df(df)

# Check the list of names
names_user <- tbl_df(unique(df$user))
names_user <- arrange(names_user,value)
print(names_user)

# Check the list of courses
names_courses <- tbl_df(unique(df$course_name))
print(names_courses)

# Check the list of lessons
names_lessons <- tbl_df(unique(df$lesson_name))
print(names_lessons)

#### Score calculation ####
# create dataframe to hold results
df_results <- data.frame()
df_name <- as.vector(nrow(names_user))
df_course <- as.vector(nrow(names_user))
df_lesson <- as.vector(nrow(names_user))
df_score <- as.vector(nrow(names_user))

for (i in 1:nrow(names_user)){
  df_user <- df %>% filter(user == names_user$value[i]) %>%
    filter(lesson_name == names_lessons$value[n_lesson]) %>%
    filter(course_name == names_courses$value[n_course]) %>% 
    filter(correct == TRUE & skipped == FALSE)
  
  score <- with(df_user, length(unique(question_number))) / 
    total_score$total_score[n_lesson] * 100
  
  df_name[i] <- names_user$value[i]
  df_course[i] <- as.character(names_courses$value[n_course])
  df_lesson[i] <- as.character(names_lessons$value[n_lesson])
  df_score[i] <- score
  
}

df_results <- data.frame(name = df_name, course = as.character(df_course), 
                         lesson = as.character(df_lesson), score = df_score)



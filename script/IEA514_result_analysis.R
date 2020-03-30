rm(list=ls())

# Load the library
library(swirlify)
library(dplyr)

#### Change this to go to the next name, course, lesson, etc ####
# n_course = 1 IEA514 R Programming E; n_lesson = 11
# n_course = 2 IEA514 Exploratory Data Analysis; n_lesson = 9

n_course <- 2
n_lesson <- 1
# Import the data

#### Total scores for each lesson ####
# n_course = 1 IEA514 R Programming E; n_lesson = 11
if (n_course == 1) {
  total_score <- data.frame(lesson = c("Basic Building Blocks", # lesson 1 = 20
                                       "workspace_and_files", # lesson 2 = 21
                                       "sequences_of_numbers", # lesson 3 = 14
                                       "vectors", # lesson 4 = 13
                                       "missing_values", # lesson 5 = 21
                                       "subsetting_vectors", # lesson 6 = 21
                                       "matrices_and_dataframes", # lesson 7 = 21
                                       "logic", # lesson 8 = 22
                                       "looking_at_data", # lesson 12 = 13
                                       "dates_and_times", # lesson 14 = 26
                                       "base_graphics"), # lesson 15 = 19
                            total_score = c(20,21,14,13,21,21,21,22,13,26,19))
  
}

# n_course = 2 IEA514 Exploratory Data Analysis; n_lesson = 9
if (n_course == 2) {
  total_score <- data.frame(lesson = c("Principles_of_Analytic_Graphs", # lesson 1
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
    filter(course_name == names_courses$value[n_course]) %>% 
    filter(lesson_name == as.character(total_score$lesson[n_lesson])) %>%
    filter(correct == TRUE & skipped == FALSE)
  #names_lessons$value[n_lesson]
  score <- with(df_user, length(unique(question_number))) / 
    total_score$total_score[n_lesson] * 100
  
  df_name[i] <- names_user$value[i]
  df_course[i] <- as.character(names_courses$value[n_course])
  df_lesson[i] <- as.character(total_score$lesson[n_lesson])
  df_score[i] <- score
  
}

df_results <- data.frame(name = df_name, course = as.character(df_course), 
                         lesson = as.character(df_lesson), score = df_score)



rm(list=ls())

# Load the library
library(swirlify)
library(dplyr)

#### Change this to go to the next name, course, lesson, etc ####
# n_course = 1 IEG301 R Programming E; n_lesson = 11
# n_course = 2 IEG301 Exploratory Data Analysis; n_lesson = 9
n_course <- 2
n_lesson <- 9
n_rows <- 40 # Need to change based on the number of students or rows
df_IEG301_results_all <- data.frame(no = c(1:n_rows))

for (nLesson in 1:n_lesson){
  # Import the data
  
  #### Total scores for each lesson ####
  # n_course = 1 IEG301 R Programming E; n_lesson = 11
  if (n_course == 1) {
    total_score <- data.frame(lesson = c("Basic Building Blocks", # lesson 1 = 20, 30 min
                                         "Workspace and Files", # lesson 2 = 21, 30 min
                                         "Sequences of Numbers", # lesson 3 = 14, 60 min
                                         "Vectors", # lesson 4 = 17, 60 min
                                         "Missing Values", # lesson 5 = 12, 20 min,
                                         "Subsetting Vectors", # lesson 6 = 21, 30 min
                                         "Matrices and Dataframes", # lesson 7 = 21, 20 min
                                         "Logic", # lesson 8 = 33, 40 min
                                         "Looking at Data", # lesson 12 = 13, 30 min
                                         "Dates and Times", # lesson 14 = 26, 30 min
                                         "Base Graphics"), # lesson 15 = 19, 20 min
                              total_score = c(20,21,14,17,12,24,21,33,13,26,19))
    ques_basic_building_blocks <- c(3,8,10,11,12,14,15,16,17,18,21,22,23,25,26,27,31,33,36,38)
    ques_workspace <- c(5,6,8,9,10,11,14,15,17,19,21,22,23,25,27,29,31,32,33,34,35)
    ques_sequences <- c(2,3,5,8,10,11,12,13,15,16,17,21,22,23)
    ques_vectors <- c(5,6,7,8,11,17,18,19,22,23,25,28,29,30,32,33,35)
    ques_missing <- c(3,4,6,7,8,9,10,12,17,18,19,20)
    ques_subsetting <- c(3,5,8,9,10,11,13,14,15,17,21,22,23,26,27,29,30,31,32,33,34,36,37,38)
    ques_matrices <- c(3,4,5,6,7,9,10,12,13,14,16,17,18,21,22,26,27,30,33,34,35)
    ques_logic <- c(4,6,7,9,10,12,13,14,15,17,18,20,21,23,27,28,30,32,33,35,36,37,38,39,41,42,43,44,46,47,49,50,51)
    ques_looking <- c(3,4,6,8,9,10,11,13,15,16,17,20,22)
    ques_dates <- c(NA)
    ques_base_graphics <- c(4,6,8,10,14,16,19,22,23,24,27,28,30,31,33,37,39,42,45)
  }
  
  # n_course = 2 IEG301 Exploratory Data Analysis; n_lesson = 9
  if (n_course == 2) {
    total_score <- data.frame(lesson = c("Principles_of_Analytic_Graphs", # lesson 1, 15 min
                                         "Exploratory_Graphs", # lesson 2, 60 min
                                         "Graphics_Devices_in_R", # lesson 3, 10 min 
                                         "Plotting_Systems", # lesson 4, 10 min
                                         "Base_Plotting_System", # lesson 5, 60 min
                                         "Hierarchical_Clustering", # lesson 6, 15 min
                                         "K_Means_Clustering", # lesson 7, 20 min
                                         "Dimension_Reduction", # lesson 8, 30 min
                                         "CaseStudy"), # lesson 9, 60 min
                              total_score = c(10,46,14,19,39,27,32,35,67))
    ques_principles <- c(3,7,11,14,21,25,32,33,34,35)
    ques_exploratory <- c(3,5,8,10,12,14,15,16,17,19,22,23,25,27,28,30,
                          31,33,34,35,37,38,39,41,42,43,44,45,49,50,
                          51,52,53,55,58,59,60,61,62,65,66,67,69,72,73,74)
    ques_graphics <- c(7,10,11,12,13,14,15,25,26,27,30,31,32,33)
    ques_plotting <- c(5,7,9,11,16,17,19,20,21,25,26,27,28,31,32,33,34,35,36)
    ques_base <- c(6,11,12,13,14,15,16,18,19,20,22,23,24,25,26,27,28,30,31,32,33,36,40,
                   43,44,45,46,47,48,49,50,51,52,54,56,58,60,62,64)
    ques_k_means <- c(8,9,12,13,15,16,17,18,19,21,23,24,25,26,27,28,29,
                      31,32,33,36,37,38,39,41,42,43,45,46,47,48,49)
    ques_dimension <- c(4,5,7,8,9,11,13,19,24,25,26,30,31,35,
                        40,42,43,44,46,52,54,56,62,64,69,
                        70,72,73,74,75,78,79,80,81,82)
    ques_casestudy <- c(4,5,7,8,9,10,11,12,13,14,16,17,19,20,22,23,25,26,28,30,31,32,34,
                        35,36,37,38,41,43,44,46,50,51,52,53,54,55,56,57,58,59,60,61,62,
                        63,65,66,68,69,70,71,72,76,77,79,80,81,82,83,84,85,86,87,90,
                        91,92,94)
    
    
    
  }
  
  
  # Choose the data file to import
  df_IEG301 <- google_form_decode(path = '~/Documents/Work/Data_analysis/R_swirl/results_IEG301_sem2_2019_2020/IEG301 R Swirl Semester 2 2019-2020.csv')
  
  # Convert from seconds to date
  df_IEG301$datetime <- as.POSIXct(df_IEG301$datetime,origin="1970-01-01")
  
  # Change some columns to factors or logicals
  df_IEG301$course_name <- as.factor(df_IEG301$course_name)
  df_IEG301$lesson_name <- as.factor(df_IEG301$lesson_name)
  df_IEG301$correct <- as.logical(df_IEG301$correct)
  df_IEG301$skipped <- as.logical(df_IEG301$skipped)
  
  # Change the lesson to tbl format
  df_IEG301 <- na.omit(df_IEG301) # Omit all rows with NA's, usually bad data row.
  df_IEG301 <- tbl_df(df_IEG301)
  
  # Check the list of names
  names_user <- tbl_df(unique(df_IEG301$user))
  names_user <- arrange(names_user,value)
  print(names_user)
  
  # Check the list of courses
  names_courses <- tbl_df(unique(df_IEG301$course_name))
  print(names_courses)
  
  # Check the list of lessons
  names_lessons <- tbl_df(unique(df_IEG301$lesson_name))
  print(names_lessons)
  
  #### Score calculation ####
  # create dataframe to hold results
  df_IEG301_results <- data.frame()
  
  df_IEG301_name <- as.vector(nrow(names_user))
  df_IEG301_course <- as.vector(nrow(names_user))
  df_IEG301_lesson <- as.vector(nrow(names_user))
  df_IEG301_score <- as.vector(nrow(names_user))
  
  #### Overall results ####
  for (i in 1:nrow(names_user)){
    df_IEG301_user <- df_IEG301 %>% filter(user == names_user$value[i]) %>%
      filter(course_name == names_courses$value[n_course]) %>% 
      filter(lesson_name == as.character(total_score$lesson[nLesson])) %>%
      filter(correct == TRUE & skipped == FALSE)
    score <- with(df_IEG301_user, length(unique(question_number))) / 
      total_score$total_score[nLesson] * 100
    
    df_IEG301_name[i] <- names_user$value[i]
    df_IEG301_course[i] <- as.character(names_courses$value[n_course])
    df_IEG301_lesson[i] <- as.character(total_score$lesson[nLesson])
    df_IEG301_score[i] <- score
    
  }
  
  df_IEG301_results <- data.frame(name = df_IEG301_name, course = as.character(df_IEG301_course), 
                                  lesson = as.character(df_IEG301_lesson), score = df_IEG301_score)
  
  df_IEG301_results_all <- cbind(df_IEG301_results_all,df_IEG301_results)
}



write.table(df_IEG301_results_all,'IEG301_temp.csv',sep=',')


  
#### Per user analysis ####
i <- 9
df_IEG301_user <- df_IEG301 %>% filter(user == names_user$value[i]) %>%
  filter(course_name == names_courses$value[n_course]) %>% 
  filter(lesson_name == as.character(total_score$lesson[n_lesson]))
  

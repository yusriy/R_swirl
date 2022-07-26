# Change according to situation
n_course <- 1
nLesson <- 2
pathFile = "/Users/Yusri/Downloads/IEG301 R Swirl Semester 2.csv"


# Choose the data file to import
df_IEG301 <- google_form_decode(path = pathFile)
# Convert from seconds to date
df_IEG301$datetime <- as.POSIXct(df_IEG301$datetime,origin="1970-01-01")

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


df_IEG301_results <- data.frame()

df_IEG301_name <- as.vector(nrow(names_user))
df_IEG301_course <- as.vector(nrow(names_user))
df_IEG301_lesson <- as.vector(nrow(names_user))
df_IEG301_score <- as.vector(nrow(names_user))

i <- 1
df_IEG301_user <- df_IEG301 %>% filter(user == names_user$value[i]) %>%
  filter(course_name == names_courses$value[n_course]) %>% 
  filter(lesson_name == as.character(total_score$lesson[nLesson])) %>%
  filter(correct == TRUE & skipped == FALSE)
score <- with(df_IEG301_user, length(unique(question_number))) / 
  total_score$total_score[nLesson] * 100

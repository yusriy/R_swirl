library(datasets)
# Put initialization code in this file.

# For compatibility with 2.2.21
.get_course_path <- function(){
  tryCatch(swirl:::swirl_courses_dir(),
           error = function(c) {file.path(find.package("swirl"),"Courses")}
  )
}

path_to_course <- file.path(.get_course_path(),
	"IEA514_Exploratory_Data_Analysis","Graphics_Devices_in_R")

try(dev.off(),silent=TRUE)
plot.new()

# Code placed in this file fill be executed every time the
# lesson is started. Any variables created here will show up in
# the user's working directory and thus be accessible to them
# throughout the lesson.

swirl_options(swirl_logging = TRUE)


library(jpeg)
library(datasets)

# For compatibility with 2.2.21
.get_course_path <- function(){
  tryCatch(swirl:::swirl_courses_dir(),
           error = function(c) {file.path(find.package("swirl"),"Courses")}
  )
}

data(cars)
data(mpg)
state <- data.frame(state.x77, region = state.region)
# Put initialization code in this file.
path_to_course <- file.path(.get_course_path(),
	"Exploratory_Data_Analysis","Base_Plotting_System")
try(dev.off(), silent=TRUE)
plot.new()

# Code placed in this file fill be executed every time the
# lesson is started. Any variables created here will show up in
# the user's working directory and thus be accessible to them
# throughout the lesson.

swirl_options(swirl_logging = TRUE)
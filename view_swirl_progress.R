# Resubmit a swirl log

library(swirl)
library(base64enc)

swirl_user <- getOption("swirl_user")
sdd <- swirl:::swirl_data_dir()

if(is.null(swirl_user)){
  swirl_user <- select.list(choices = list.dirs(sdd, full.names = FALSE, recursive = FALSE),
              title = "Which of the following is your user name?")
}

user_data_path <- file.path(sdd, swirl_user)
swlogs <- list.files(user_data_path, pattern = "swlog$", full.names = TRUE)
log_choices <- rep(NA, length(swlogs))

for(i in seq_along(swlogs)){
  log_ <- readRDS(swlogs[i])
  course <- log_$course_name
  lesson <- log_$lesson_name
  dt <- file.mtime(swlogs[i])
  log_choices[i] <- paste(course, lesson, dt)
}

message("You've completed the following lessons:")
message(paste(log_choices, collapse = "\n"))

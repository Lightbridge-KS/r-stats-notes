library(here)

# Knitr Chunk -------------------------------------------------------------


knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  error = TRUE
)



## From: https://github.com/hadley/adv-r/blob/master/common.R


options(
  rlang_trace_top_env = rlang::current_env(),
  rlang__backtrace_on_error = "none"
)



# Make error messages closer to base R
registerS3method("wrap", "error", envir = asNamespace("knitr"),
                 function(x, options) {
                   msg <- conditionMessage(x)
                   
                   call <- conditionCall(x)
                   if (is.null(call)) {
                     msg <- paste0("Error: ", msg)
                   } else {
                     msg <- paste0("Error in ", deparse(call)[[1]], ": ", msg)
                   }
                   
                   msg <- error_wrap(msg)
                   knitr:::msg_wrap(msg, "error", options)
                 }
)

error_wrap <- function(x, width = getOption("width")) {
  lines <- strsplit(x, "\n", fixed = TRUE)[[1]]
  paste(strwrap(lines, width = width), collapse = "\n")
}
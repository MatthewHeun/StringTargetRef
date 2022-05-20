#' A simple targets pipeline
#' @param suff The suffix to the target name
#' @return A list of targets
#' @export
get_pipeline <- function(suff) {

  target1_str <- paste0("target1_", suff)
  target1_sym <- as.symbol(target1_str)
  target2_str <- paste0("target2_", suff)
  list(
    targets::tar_target_raw(target1_str, 1),
    targets::tar_target_raw(target2_str, substitute(StringTargetRef::plus1(x = target1_sym)))
  )
}


#' A function for testing
#' Adds 1 to `x`.
#' @param x The incoming parameter
#' @return `x + 1`
#' @export
plus1 <- function(x) {
  x + 1
}

#' A simple targets pipeline
#' @param suff The suffix to the target name
#' @return A list of targets
#' @export
get_pipeline <- function(suff) {

  target1_name <- paste0("target1_", suff)
  target1_sym <- as.symbol(target1_name)
  target2_name <- paste0("target2_", suff)
  list(
    targets::tar_target_raw(target1_name, 1),
    # targets::tar_target_raw(target2_name, quote(StringTargetRef::plus1(target1_suff)))
    # targets::tar_target_raw(target2_name, quote(StringTargetRef::plus1(target1_name))) # object `target1_name` not found
    # targets::tar_target_raw(target2_name, quote(StringTargetRef::plus1(eval(target1_name)))) # object `target1_name` not found
    # targets::tar_target_raw(target2_name, quote(StringTargetRef::plus1(rlang::enquo(target1_name)))) # object `target1_name` not found
    # targets::tar_target_raw(target2_name, quote(StringTargetRef::plus1({{target1_name}}))) # object `target1_name` not found
    targets::tar_target_raw(target2_name, substitute(StringTargetRef::plus1(x = target1_sym))) #
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

# > tar_manifest()
# # A tibble: 2 × 3
# name         command                              pattern
# <chr>        <chr>                                <chr>
# 1 target1_suff 1                                    NA
# 2 target2_suff StringTargetRef::plus1(target1_suff) NA

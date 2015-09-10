#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
tableize <- function(message, width = NULL, height = NULL) {

  # forward options using x
  x = list(
    message = message
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'tableize',
    x,
    width = width,
    height = height,
    package = 'tableize'
  )
}

#' Widget output function for use in Shiny
#'
#' @export
tableizeOutput <- function(outputId, width = '100%', height = '400px'){
  shinyWidgetOutput(outputId, 'tableize', width, height, package = 'tableize')
}

#' Widget render function for use in Shiny
#'
#' @export
renderTableize <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, tableizeOutput, env, quoted = TRUE)
}

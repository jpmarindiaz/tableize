#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
tableize <- function(d, fixedCols = NULL, rowLabelCol =  NULL,fixedRows = NULL,
                     header = NULL, theme = "basic", customCSS = NULL,
                     placeholderRow = NULL, placeholderCol = NULL,
                     selectedRows = NULL, selectedCols = NULL,
                     width = NULL, height = NULL) {

  fixedCols <- fixedCols %||% names(d)[1]
  rowLabelCol <- rowLabelCol %||% names(d)[1]
  if(!rowLabelCol %in% names(d))
    stop('rowLabelCol must be in names(d)')
  if(!all(fixedRows %in% d[,rowLabelCol]))
    stop("fixedRow not in selected column to filter")
  fixedRows <- fixedRows
  header <- header %||% names(d)
  if(length(header) != length(names(d)))
    stop('header must have the same length as names(d)')

  controls <- getControls(d,fixedCols,rowLabelCol, fixedRows,
                          selectedRows = selectedRows, selectedCols = selectedCols)
  style <- getStyle(theme = theme, customCSS = customCSS)

  table <-prepareTable(d,fixedCols = fixedCols,
                       rowLabelCol = rowLabelCol, fixedRows = fixedRows,
                       header = header)

  placeholderRow <- placeholderRow %||% "..."
  placeholderCol <- placeholderCol %||% "..."

  # forward options using x
  x = list(
    table = table,
    style = style,
    controls = controls,
    placeholderRow = placeholderRow,
    placeholderCol = placeholderCol
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'tableize',
    x,
    width = width,
    height = height,
    sizingPolicy = htmlwidgets::sizingPolicy(
      browser.fill = TRUE
    ),
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



prepareTable <- function(d, fixedCols,
                         rowLabelCol, fixedRows,
                         header){

  d <- rbind.data.frame(header,d)
  d$rowId <- d[,rowLabelCol]
  d$rowId[1] <- "table_header"

  table <- list(
    fixedCols = fixedCols,
    fixedRows = fixedRows,
    data = d
  )
}


getStyle <- function(theme = NULL, customCSS = ""){
  theme <- theme %||% "basic"
  if(theme == "blank")
    theme <- ""
  else{
    theme <- paste0(theme,".css")
    filePath <- file.path(system.file("styles",package="tableize"),theme)
    theme <- paste0(readLines(filePath),collapse="")
  }
  style <- paste(theme,customCSS,"\n")
  #message(style)
  style
}


getControls <- function(d,fixedCols,rowLabelCol,fixedRows,
                        selectRowsText = NULL, selectColsText = NULL,
                        selectedRows = NULL, selectedCols = NULL){

  controlTpl <- "controls"
  name <- paste0(controlTpl,".html")
  filePath <- file.path(system.file("controls",package="tableize"),name)
  tpl <- paste0(readLines(filePath),collapse="\n")

  selectRowsText = selectRowsText %||% 'Seleccione filas'
  selectColsText = selectColsText %||% 'Seleccione columnas'


  optionColTpl <- '<option value="{{colName}}" {{selected}}>{{colName}}</option>'
  filterCols <- names(d)[which(!names(d) %in% fixedCols)]
  selectedCols <- selectedCols %||% filterCols
  lcol <- lapply(filterCols,function(col){
    selected <- ""
    if(col %in% selectedCols) selected <- "selected"
    list(colName = col,selected = selected)
  })
  colOptions <- lapply(lcol,function(col){
    list(optionHtml = whisker.render(optionColTpl,col))
  })

  optionRowTpl <- '<option value="{{rowName}}" {{selected}}>{{rowName}}</option>'
  filterRows <-  d[,rowLabelCol]
  filterRows <- filterRows[!filterRows %in% fixedRows]
  selectedRows <- selectedRows %||% filterRows
  lrow <- lapply(filterRows,function(row){
    selected <- ""
    if(row %in% selectedRows) selected <- "selected"
    list(rowName = row,selected = selected)
  })
  rowOptions <- lapply(lrow,function(row){
    list(optionHtml = whisker.render(optionRowTpl,row))
  })

  #   options = list(
  #     list(optionHtml = '<option value="lastName" selected>Replaceeeed</option>')
  #   )

  tplData <- list(selectRowsText = selectRowsText,
                  selectColsText = selectColsText,
                  colOptions = colOptions,
                  rowOptions = rowOptions)

  controlsHtml <- whisker.render(tpl,tplData)
  #cat(controlsHtml)
  controlsHtml
}

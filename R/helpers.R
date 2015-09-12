

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


getStyle <- function(name = "table1"){
  name <- paste0(name,".css")
  filePath <- file.path(system.file("styles",package="tableize"),name)
  paste0(readLines(filePath),collapse="")
}


getControls <- function(d,fixedCols,rowLabelCol,fixedRows,
                        selectRowsText = NULL, selectColsText = NULL){

  controlTpl <- "controls"
  name <- paste0(controlTpl,".html")
  filePath <- file.path(system.file("controls",package="tableize"),name)
  tpl <- paste0(readLines(filePath),collapse="\n")

  selectRowsText = selectRowsText %||% 'Seleccione filas'
  selectColsText = selectColsText %||% 'Seleccione columnas'


  optionColTpl <- '<option value="{{colName}}" selected>{{colName}}</option>'
  filterCols <- names(d)[which(!names(d) %in% fixedCols)]
  colOptions <- lapply(filterCols,function(col){
    list(optionHtml = whisker.render(optionColTpl,list(colName = col)))
  })

  optionRowTpl <- '<option value="{{rowName}}" selected>{{rowName}}</option>'
  filterRows <-  d[,rowLabelCol]
  filterRows <- filterRows[!filterRows %in% fixedRows]
  rowOptions <- lapply(filterRows,function(row){
    list(optionHtml = whisker.render(optionRowTpl,list(rowName = row)))
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

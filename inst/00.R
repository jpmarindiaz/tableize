library(devtools)
load_all()
document()
devtools::install()


library(tableize)



d <- mtcars
d[,1] <- row.names(mtcars)
row.names(d) <- NULL

fixedCols <- c("mpg","cyl","disp","hp")
rowLabelCol <- "mpg"
fixedRows <- c("Valiant","Merc 240D")
tableize(d,fixedCols = fixedCols,rowLabelCol = rowLabelCol,fixedRows =  fixedRows)





d <- read.csv(system.file("data/sample.csv",package = "tableize"),
              stringsAsFactors = FALSE)

tableize(d)
tableize(d, selectedRows = c("David","Juan"))
tableize(d, selectedCols = c("age"), placeholderCol = "Col")


fixedCols <- c("lastName","firstName")
tableize(d, fixedCols, placeholderRow = "Seleccione cualidades para filtrar", selectedRows = "Juan")

fixedRows <- c("Juan")
tableize(d, fixedRows = fixedRows)

fixedRows <- c("Pepa")
tableize(d, fixedRows = fixedRows)

header <- c("NOMBRE","<h3>Apellido</h3>","Color","<small style={color:blue !important}>edad</small>")
tableize(d, header = header)


names(d)
rowLabelCol <- "color"
fixedRows <- c("yellow")
tableize(d,fixedCols = fixedCols,rowLabelCol = rowLabelCol,fixedRows =  fixedRows)

names(d)
header <- c("NOMBRE","<h3>Apellido<h/3>","Color","<p style={color:blue}>Edad</p>")
tableize(d,fixedCols = fixedCols,rowLabelCol = rowLabelCol,fixedRows =  fixedRows,header = header)







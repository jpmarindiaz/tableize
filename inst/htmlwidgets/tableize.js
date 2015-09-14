HTMLWidgets.widget({

    name: "tableize",
    type: "output",

    initialize: function(el, width, height) {


        // $(el).append('<div id="isotopeControls"></div>');
        // $(el).append('<div id="isotope-items"></div>');


        // var iso = new Isotope('#isotope-items', {
        //     itemSelector: '.element-item'
        // });
        // console.log(iso.options.getSortData)
        // return ({
        //     iso: iso
        // })
        return ({})

    },

    resize: function(el, width, height, instance) {
        // instance.iso.bindResize();
        //instance.iso.reloadItems();
    },

    renderValue: function(el, x, instance) {

        $("#controls").remove();
        $(el).append('<div id="controls"></div>');

        $("#controls").append(x.controls);

        $("#renderTable").remove();
        $(el).append('<table id="renderTable"></table>');

        var style = x.style;
        var style = "<style> body{overflow:auto !important;}" + style + "</style>";
        $(style).appendTo("body");


    var table = {
        fixedCols: ["number"],
        fixedRows: ["row0"],
        data: [{
            rowId: "table_header",
            number: "Edad",
            firstName: "Nombre",
            lastName: "Apellido"
        },{
            rowId: "row0",
            number: 32,
            firstName: "Juan",
            lastName: "Pérez"
        }, {
            rowId: "row1",
            number: 1,
            firstName: "Peter",
            lastName: "Jhons"
        }, {
            rowId: "row2",
            number: 2,
            firstName: "David",
            lastName: "Bowie"
        }, {
            rowId: "row3",
            number: 3,
            firstName: "Jose",
            lastName: "Marín"
        }]
    };

        var table = x.table;
        x.table.data = HTMLWidgets.dataframeToD3(x.table.data);
        console.log(x.table)

        var selRowOpts = {
            maxItems: 10,
            placeholder: '...',
            plugins: ['remove_button']
        };
        var selColOpts = {
            maxItems: 10,
            placeholder: '...',
            plugins: ['remove_button']
        };
        selRowOpts.placeholder = x.placeholderRow;
        selColOpts.placeholder = x.placeholderCol;

        var $selectColumn = $('#select-columns').selectize(selColOpts)
        var $selectRow = $('#select-rows').selectize(selRowOpts)


        var fixedRows = ["table_header"].concat(table.fixedRows);
        var fixedCols = table.fixedCols;

        // FILTER ROWS COLS
        function filterCols(data, selectedCols) {
            function filterByKeys(obj, accepted) {
                var result = {};
                for (var o in obj) {
                    if (accepted.indexOf(o) > -1)
                        result[o] = obj[o];
                }
                return result;
            };
            var result = [];
            for (i in data) {
                result.push(filterByKeys(data[i], selectedCols))
            }
            return result
        };


        function filterRows(data, selectedRowIds) {
            return data.filter(function(el) {
                return selectedRowIds.indexOf(el.rowId) > -1
            });
        };

        function filterRowsCols(data, rowIds, colIds) {
            // console.log(typeof(rowIds[1]))
            var data2 = filterRows(data, rowIds);
            var data3 = filterCols(data2, colIds);
            return data3
        }


        // DRAWTABLE FUNS

        // http://jsfiddle.net/mjaric/sewm6/
        function drawTable(data) {
            // Draw header
            var row = $("<tr />")
            $("#renderTable").append(row);
            var header = data[0];
            var nProps = countProperties(header);
            var keys = Object.keys(header);
            for (var i = 0; i < nProps; i++) {
                if (keys[i] != "rowId") {
                    row.append($("<th>" + header[keys[i]] + "</th>"));
                }
            }
            // Draw rows
            for (var i = 1; i < data.length; i++) {
                drawRow(data[i]);
            }
        }

        function drawRow(rowData) {
            var row = $("<tr />")
            $("#renderTable").append(row); //this will append tr element to table... keep its reference for a while since we will add cels into it
            var nProps = countProperties(rowData);
            var keys = Object.keys(rowData);
            for (var i = 0; i < nProps; i++) {
                if (keys[i] != "rowId") {
                    row.append($("<td>" + rowData[keys[i]] + "</td>"));
                }
            }
        }

        function countProperties(obj) {
            var count = 0;
            for (var prop in obj) {
                if (obj.hasOwnProperty(prop))
                    ++count;
            }
            return count;
        }



        // UPDATE TBL


        function updateTable(data, rows, cols) {
            var data = filterRowsCols(data, rows, cols);
            // console.log(rows)
            drawTable(data)

        }

        var controls = $(".controls");
        controls.on('change', function() {
            var data = table.data;
            // console.log(this)
            var cols = $('#select-columns').selectize()[0].selectize.getValue();
            var rows = $('#select-rows').selectize()[0].selectize.getValue();
            rows = rows.concat(fixedRows);
            cols = cols.concat(fixedCols);
            // console.log(rows)
            $("#renderTable").find("tr").remove();
            updateTable(data, rows, cols);

        });


        $(document).ready(function() {
            var data = table.data;
            var cols = $('#select-columns').selectize()[0].selectize.getValue();
            var rows = $('#select-rows').selectize()[0].selectize.getValue();
            rows = rows.concat(fixedRows);
            cols = cols.concat(fixedCols);
            updateTable(data, rows, cols);
        });


    },
});

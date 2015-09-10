var data = [{
    rowId: "row0",
    firstName: "First Name",
    lastName: "Last Name"
}, {
    rowId: "row1",
    firstName: "Peter",
    lastName: "Jhons"
}, {
    rowId: "row2",
    firstName: "David",
    lastName: "Bowie"
}, {
    rowId: "row3",
    firstName: "Jose",
    lastName: "Marin"
}];


// FILTER COLS
function filterCols(data, selectedRows) {
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
        // console.log(data[i])
        result.push(filterByKeys(data[i], selectedRows))
    }
    return result
};
// FILTER ROWS
var rowIds = data.map(function(obj) {
    return obj["rowId"]
});

function filterRows(data, selectedRowIds) {
    return data.filter(function(el) {
        return selectedRowIds.indexOf(el.rowId) > -1
    });
};
// FILTER ROWS COLS
function filterRowsCols(data, rowIds, colIds) {
    var data2 = filterRows(data, rowIds);
    var data3 = filterCols(data2, colIds);
    return data3
}

var rowIds = ["row2", "row1"]
var colIds = ["firstName", "lastName"]

var dataOut = filterRowsCols(data, rowIds, colIds)
console.log(dataOut)


var fixedRows = ["row0"];















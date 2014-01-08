$(document).ready(function() {
  var docTable = $('#documents').dataTable( {
    "sPaginationType": "full_numbers",
    "bProcessing": true,
    "bServerSide": true,
    "sAjaxSource": $('#documents').data('source'),
    "oLanguage": { "sSearch": "Search all columns:" },
  })

  $.datepicker.regional[""].dateFormat = 'dd/mm/yyyy';
  $.datepicker.setDefaults($.datepicker.regional['']);

  $.get('/collections.json', function(data) {
    var collectionNames = [];
    for (var i = 0; i < data.length; i++) {
      collectionNames.push(data[i]["name"]);
    }
    docTable.dataTable().columnFilter({
      sPlaceHolder: "head:before",
      aoColumns: [
        null,
        { type: "text" },
        { type: "text" },
        { type: "text" },
        { type: "date-range", sRangeFormat: "Between {from} and {to}" }
      ]
    });
  });
  $("#collection_id").select2();
});

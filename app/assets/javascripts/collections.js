$('#collections').dataTable( {
  "sPaginationType": "full_numbers",
  "bProcessing": true,
  "bServerSide": true,
  "sAjaxSource": $('#collections').data('source'),
});

$('#sortable').sortable({
  update: function(event, ui) {
    ui.item.effect("highlight", {}, 1000);
    $('#sortable').children('tr').each(function() {
      var index = $(this).index();
      $(this).children('input').attr('value', index);
      $(this).children('.order').text(index);
    });
  }
});
$("#sortable").disableSelection();

jQuery ->
  $('#primary_documents').dataTable
    sPaginationType: "full_numbers"
    bJQueryUI: true
    bProcessing: true
    bServerSide: true
    sAjaxSource: $('#primary_documents').data('source')
$ ->
  $('#problems-table').dataTable
     console.log('haha')
    processing: true
    serverSide: true
    ajax: $('#problems-table').data('source')
    pagingType: 'full_numbers'
    # optional, if you want full pagination controls.
    # Check dataTables documentation to learn more about
    # available options.
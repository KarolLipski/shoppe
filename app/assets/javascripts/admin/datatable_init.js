jQuery(document).ready(function() {
    $('#items-table').dataTable({
        "processing": true,
        "serverSide": true,
        "ajax": $('#items-table').data('source'),
// optional, if you want full pagination controls.
// Check dataTables documentation to learn more about
// available options.
    });
});


jQuery(document).ready(function($)
{
    tableContainer = $("#table-standard_datatable");
    tableContainer.dataTable({

    });
});
$(function(){$(".datatable").DataTable({serverSide:!0,ordering:!0,processing:!0,ajax:$(".datatable").data("source"),columnDefs:[{targets:-1,orderable:!1}],searchDelay:1e3,language:{lengthMenu:'<select><option value="10">10</option><option value="25">25</option><option value="50">50</option><option value="100">100</option></select>\u6761\u8bb0\u5f55',search:'<span class="label label-success">\u641c\u7d22\uff1a</span>',paginate:{previous:"\u4e0a\u4e00\u9875",next:"\u4e0b\u4e00\u9875"},zeroRecords:"\u6ca1\u6709\u5185\u5bb9",info:"\u663e\u793a_START_ \u81f3 _END_ \u6761\uff0c\u5171 _TOTAL_ \u6761",infoEmpty:"0\u6761\u8bb0\u5f55",emptyTable:"\u8868\u4e3a\u7a7a",processing:"\u73a9\u547d\u52a0\u8f7d\u4e2d...",infoFiltered:""},retrieve:!0,destroy:!0,paging:!0,pagingType:"simple_numbers",stateSave:!0})});
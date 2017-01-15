$(function() {
	var table = $(".datatable").DataTable({
		serverSide: true,
		ordering: false,
		processing: true,
		ajax: $('.datatable').data('source'),
		searchDelay: 1000,
		retrieve: true,
		destroy: true,
		paging: false,
		info: false,
		pagingType: "simple_numbers",
		stateSave: true
	});
	var searchable = $("#searchable").attr("value");
	$(".input-sm").attr("placeholder", searchable);
});
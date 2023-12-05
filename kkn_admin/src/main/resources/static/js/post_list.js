$(document).ready(function() {
	$("#home").click(function() {
		window.open("/", "_self");
	});

	$("#memberlist").click(function() {
		window.open("/post", "_self");
	});
	
	$("#search-select").change(function() {
		$('#search-input').attr('placeholder', $('option:selected').text() + ' 입력');
	})
});
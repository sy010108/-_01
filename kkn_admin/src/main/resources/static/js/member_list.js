$(document).ready(function() {
	let token = $("meta[name='_csrf']").attr("content"); 
    let header = $("meta[name='_csrf_header']").attr("content");
	
	$(document).ajaxSend(function(e, xhr, options){
        xhr.setRequestHeader(header, token);
    });
    
	$(".pwclear").click(function(e) {
		if(confirm("정말로 비밀번호를 초기화해도 될까요?")) {    		 
			let userid = $($(e.target).parent().siblings()[0]).text();
			
			$.ajax({
				url: "/member/pw_initialize",
				type: 'post',
				dataType: 'json',
				data: {
					userid: userid
				},
				async: true,
			}).done(function(data) {
				alert(data["message"]);
			});
		}
	});
	
	$(".deluser").click(function(e) {
		let userid = $($(e.target).parent().siblings()[0]).text();
		
		if(confirm("정말로 " + userid + "를 삭제해도 될까요?")) {
			$.ajax({
				url: "/member/delete",
				type: 'post',
				dataType: 'json',
				data: {
					userid: userid
				},
				async: true,
			}).done(function(data) {
				alert(data["message"]);
				window.location.reload();
			});
		}
	});
	
	$("#home").click(function() {
		window.open("/", "_self");
	});

	$("#memberlist").click(function() {
		window.open("/member", "_self");
	});
	
	$("#search-select").change(function() {
		$('#search-input').attr('placeholder', $('option:selected').text() + ' 입력');
	})
});
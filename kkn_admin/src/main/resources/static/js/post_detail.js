$(document).ready(function() {
	let token = $("meta[name='_csrf']").attr("content"); 
    let header = $("meta[name='_csrf_header']").attr("content");
	
	$(document).ajaxSend(function(e, xhr, options){
        xhr.setRequestHeader(header, token);
    });
	
	$("#postlist").click(function() {
		let postListPage = $("#postListPage").val();
		let postListCategory = $("#postListCategory").val();
		let postListSearchInput = $("#postListSearchInput").val();
		
		if(postListCategory == "") {
			window.open("/post?page=" + postListPage + "&category=" + postListCategory + "&searchinput=" + postListSearchInput, "_self");
		} else {
			window.open("/post/search?page=" + postListPage + "&category=" + postListCategory + "&searchinput=" + postListSearchInput, "_self");
		}
		
	});
	
	$("#postDelete").click(function() {
		let postNum = $("#postNum").val();
		let postListPage = $("#postListPage").val();
		let postListCategory = $("#postListCategory").val();
		let postListSearchInput = $("#postListSearchInput").val();
		
		if(confirm("정말로 이 글을 삭제해도 될까요?")) {
			$.ajax({
				url: "/post/delete",
				type: 'post',
				dataType: 'json',
				data: {
					postNum: postNum
				},
				async: true,
			}).done(function(data) {
				alert(data["message"]);
				
				if(postListCategory == "") {
					window.open("/post?page=" + postListPage + "&category=" + postListCategory + "&searchinput=" + postListSearchInput, "_self");
				} else {
					window.open("/post/search?page=" + postListPage + "&category=" + postListCategory + "&searchinput=" + postListSearchInput, "_self");
				}
			});
		}
	});
	
	$(".delete-comment-button").click(function(e) {
		let commentNum = $(e.target).parent().parent().parent().siblings().val();
		
		if(confirm("정말로 댓글을 삭제해도 될까요?")) {
			$.ajax({
				url: "/post/commentdelete",
				type: 'post',
				dataType: 'json',
				data: {
					commentNum: commentNum
				},
				async: true,
			}).done(function(data) {
				alert(data["message"]);
				window.location.reload();
			});
		}
	});
});
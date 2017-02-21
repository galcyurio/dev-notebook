<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript" src="/webjars/jquery/3.1.1/dist/jquery.min.js"></script>
<style>
#box {
	border: 1px solid #CCCCCC
}

#writer, #title, #content {
	font-size: 9pt;
	font-weight: bold;
	color: #7F7F7F;
}

input {
	font-size: 9pt;
	border-left: 1px solid #C3C3C3;
	border-top: 1px solid #C3C3C3;
	border-right: 1px solid #C3C3C3;
	border-bottom: 1px solid #C3C3C3;
	color: #7F7F7F;
}

#title input {
	width: 250px;
}

#content textarea {
	width: 503px;
	border: 0;
	height: 153;
	background: url("/board/images/write_bg.gif");
	border: #C3C3C3 1px solid;
}

#copyright {
	font-size: 9pt;
}

a {
	text-decoration: none;
}

img {
	border: 0px;
}
</style>
<script>
function update(){
	if(confirm("수정하시겠습니까") != true){
		return;
	}
	
	var data = {
			board_pk:detailForm.board_pk.value,
			writer:detailForm.writer.value,
			title:detailForm.title.value,
			content:detailForm.content.value
		};
	
	$.ajax({
		"headers":{
			"Accept":"application/json",
			"Content-Type":"application/json"
		},
		"url":"/board",
		"type":"PATCH",
		"dataType":"json",
		"data":JSON.stringify(data),
		success:function(result){
			console.log(result);
			alert("수정이 완료되었습니다.");
			location.href="/board/"+detailForm.board_pk.value;
		}
	});
}

function del(){
	if(confirm('삭제하시겠습니까?') != true){
		return;
	}
	
	$.ajax({
		"headers":{
			"Accept":"application/json",
			'Content-Type':"application/json"
		},
		'url':"/board/"+detailForm.board_pk.value,
		'type':"DELETE",
		'dataType':"json",
		'success':function(result){
			console.log(result);
			alert("삭제가 완료되었습니다.");
			location.href="/board"
		}
	});
}
</script>
</head>
<body>
	<table id="box" align="center" width="603" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td>
				<img src="/board/images/ceil.gif" width="603" height="25">
			</td>
		</tr>
		<tr>
			<td height="1" bgcolor="#CCCCCC"></td>
		</tr>
		<tr>
			<td id="list">
				<form name="detailForm">
					<input type="hidden" name="board_pk" value="${board.board_pk}" />
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="100">&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
						<tr id="writer">
							<td height="25" align="center">작성자</td>
							<td><input type="text" name="writer" value="${board.writer}"></td>
						</tr>
						<tr id="title">
							<td height="25" align="center">제목</td>
							<td><input type="text" name="title" value="${board.title}"></td>
						</tr>
						<tr id="content">
							<td align="center">내용</td>
							<td><textarea name="content" rows="20" >${board.content}</textarea></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
					</table>
				</form>
			</td>
		</tr>
		<tr>
			<td height="30" align="right" style="padding-right: 2px;">
			<a href="javascript:update()">
				<img src="/board/images/write_btin.gif" width="61" height="20">
			</a>
			<a href="javascript:del()">
				<img src="/board/images/delete_btn.gif" width="61" height="20">
			</a>
			<a href="/board">
				<img src="/board/images/list_btn.gif" width="61" height="20" border="0">
			</a>
			</td>
		</tr>
		
		<!-- 댓글 영역 begin -->
		<tr>
			<td>
				<!-- 목록을 보여줄 테이블 begin -->
				<table width="100%" border="1px">
					
				</table>
				<!-- 목록을 보여줄 테이블 end -->
			</td>
		</tr>
		<!-- 댓글 영역 end -->
		
		<tr>
			<td height="1" bgcolor="#CCCCCC"></td>
		</tr>
		<tr>
			<td height="20" align="center" id="copyright">Copyright zino All Rights Reserved</td>
		</tr>
	</table>
</body>
</html>

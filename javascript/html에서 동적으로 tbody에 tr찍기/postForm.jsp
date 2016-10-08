<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
form{
	margin:0px;
}
</style>
<script>
var table_post;
var tbody_post;

window.addEventListener("load", function(){
	init();
});

function init(){
	table_post = document.getElementById("table_post");
	tbody_post = table_post.getElementsByTagName('tbody')[0];
}

function getXhttp(){
	var xhttp = new XMLHttpRequest();
	return xhttp;
}

function search(){
	var xhttp = getXhttp();
	
	xhttp.onreadystatechange = function(){
		if(xhttp.readyState == 4 && xhttp.status == 200){
			var received = xhttp.responseText;
			// received 에는 서버로부터 받은 JSON 객체가 들어있음
			var jsonObject = JSON.parse(received);
			var postList = jsonObject.postList;
			
			//tr 생성전에 tbody 영역을 지워준다.
			tbody_post.innerHTML="";
			
			for(var i=0; i<postList.length; i++){
				createTr(postList[i]);
			}
		}
	}
	
	xhttp.open("GET", "postForm_select.jsp?keyword="+searchForm.keyword.value, true);
	xhttp.send();
}


function createTr(post) {
	// tbody 에 tr을 생성한다.
	var tr = tbody_post.insertRow(tbody_post.rows.length);

	var addr = post.sido + " " + post.gugun + " " + post.dong + " "
			+ post.bunji;
	for (var i = 0; i < 2; i++) {
		var td = tr.insertCell(i);

		switch (i) {
		case 0:
			td.innerText = post.zipcode;
			break;
		case 1:
			td.innerText = addr;
			break;
		}
	}
}
</script>
</head>
<body>
	<div>
		<form name="searchForm">
			<input type="text" placeholder="주소 입력" name="keyword" style="height:30px;"/>
			<input type="button" value="검색" onclick="search()"/>
		</form>
		
		<br /><br />
		<table id="table_post" style="width:100%;" border=1px>
			<thead>
				<th>우편번호</th>
				<th>주소</th>
			</thead>
			<tbody>
			
			</tbody>
		</table>
	</div>
</body>
</html>
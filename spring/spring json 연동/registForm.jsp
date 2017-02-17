<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Bootstrap Example</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"
></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
></script>

<script>
function regist(){
	var data = {
			id:$("#id").val(),
			password:$("#password").val(),
			name:$("#name").val()
	};
	
	var info = {
			url:"/member/regist.do",
			dataType:"json",
			type:"post",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(data),
			success:function(result){
				console.log(result);
			}
	};
	
	$.ajax(info);
}

</script>

<body>
	<div class="container">
		<h2>Vertical (basic) form</h2>
		<form name="registForm">
			<div class="form-group">
				<label for="id">id:</label> 
				<input type="text" name="id"
					class="form-control" id="id" placeholder="Enter id">
			</div>
			<div class="form-group">
				<label for="password">Password:</label> 
				<input type="password" name="password" class="form-control"
						 id="password" placeholder="Enter password" >
			</div>
			<div class="form-group">
				<label for="name">Name:</label> 
				<input type="text" name="name" class="form-control"
						 id="name" placeholder="Enter name" >
			</div>
			<div class="checkbox">
				<label><input type="checkbox"> Remember me</label>
			</div>
			<button type="button" class="btn btn-default" onclick="regist()">Submit</button>
		</form>
	</div>
</body>
</html>

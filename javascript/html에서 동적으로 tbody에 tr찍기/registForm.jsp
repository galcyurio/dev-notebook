<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
var table_customer;
var tbody_customer;

//문서가 로드되면...
window.addEventListener("load", function(){
	init();
});

//초기화 메서드
function init(){
	table_customer = document.getElementById("table_customer");
	tbody_customer = table_customer.getElementsByTagName("tbody")[0];
	getCustomerList();
}

function getXhttp(){
	var xhttp;	//비동기 요청을 처리하는 핵심 객체
	
	if(xhttp === undefined){
		if(window.XMLHttpRequest){
			xhttp = new XMLHttpRequest();		// 모든 브라우저 공통
		} else {
			// for IE5, IE6
			xhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
	}
	
	return xhttp;
}

function idCheck(){
	var xhttp = getXhttp();

	// 서버로부터 응답 받은 데이터를 처리해보자!
	/* 
	0: request not initialized 
	1: server connection established
	2: request received 
	3: processing request 
	4: request finished and response is ready 
	*/
	
	//서버의 상태에 따라 아래의 callBack 함수가 호출된다.
	// 서버의 상태는 총 0~4 까지 5단계가 있으며
	// 비동기방식을 처리함에 있어 서버의 응답타이밍을 알 수 있는 유일한 단서
	xhttp.onreadystatechange = function(){
		if(xhttp.readyState == 0){
			console.log("요청할 준비가 되어 있지 않습니다."+xhttp.status);
		}else if(xhttp.readyState == 1){
			console.log("서버와 연결되었습니다."+xhttp.status);
		}else if(xhttp.readyState == 2){
			console.log("서버에 요청이 전달되었습니다."+xhttp.status);
		}else if(xhttp.readyState == 3){
			console.log("서버에서 요청을 처리하고 있습니다."+xhttp.status);
		}else if(xhttp.readyState == 4){
			console.log("서버에서 응답할 준비가 끝났습니다."+xhttp.status);
		}
		
		//개발자는 제 4단게와 서버에서 아무런 문제가 없다는 status 를 검증
		if(xhttp.readyState == 4 && xhttp.status == 200){
			// 서버와 통신에 성공했을 경우... span에 알맞는 메세지 출력
			var message = document.getElementById("message");
			var data = xhttp.responseText;
			
			message.innerHTML = data;
		}
	}
	
	// 비동기 방식으로 요청
	// action="/customer/registForm_idCheck.jsp"" method="get"
	xhttp.open("GET", "/customer/registForm_idCheck.jsp?id="+registForm.id.value, true);
	xhttp.send();		//현재 시점에서 요청이 일어난다.
}

function regist(){
	console.log("regist() called");
	var xhttp = getXhttp();
	
	xhttp.onreadystatechange = function(){
		if(xhttp.readyState == 4 && xhttp.status == 200){
			// 응답을 받으면...
			var received = xhttp.responseText;
			if(received == 1){
				// 비동기로 새로운 요청을 시도한다.
				getCustomerList();
			}
		}
	}
	
	var sendData = "id="+registForm.id.value+"&password="+registForm.password.value;
	sendData+="&zipcode1="+registForm.zipcode1.value+"&zipcode2="+registForm.zipcode2.value;
	sendData+="&addr1="+registForm.addr1.value+"&addr2="+registForm.addr2.value;
	
	xhttp.open("POST", "/customer/registForm_insert.jsp", true);
	xhttp.setRequestHeader("content-type", "application/x-www-form-urlencoded");
	xhttp.send(sendData);
}

function getCustomerList(){
	console.log("getCustomerList() called");
	var xhttp = getXhttp();
	
	xhttp.onreadystatechange = function(){
		if(xhttp.readyState ==4 && xhttp.status == 200){
			var received = xhttp.responseText;
			// table 에 동적으로 tr을 생성한다.
			
			var jsonObject = JSON.parse(received);
			var customerList = jsonObject.customerList;
			
			// tr 생성 전 tbody 지워주기
			tbody_customer.innerHTML = "";
			
			for(var i=0; i<customerList.length; i++){
				var customer = customerList[i];
				
				createTr(customer);
			}
		}
	}
	
	xhttp.open("GET", "/customer/registForm_selectAll.jsp", true);
	xhttp.send();
}

function createTr(customer) {
	console.log("createTr() called");
	
	var tr = tbody_customer.insertRow(tbody_customer.rows.length);
	for (var i = 0; i < Object.keys(customer).length; i++) {
		var td = tr.insertCell(i);
		
		switch (i) {
		case 0:
			td.innerText = customer.customer_id;
			break;
		case 1:
			td.innerText = customer.id;
			break;
		case 2:
			td.innerText = customer.password;
			break;
		case 3:
			td.innerText = customer.zipcode1;
			break;
		case 4:
			td.innerText = customer.zipcode2;
			break;
		case 5:
			td.innerText = customer.addr1;
			break;
		case 6:
			td.innerText = customer.addr2;
			break;
		case 7:
			td.innerText = customer.regdate;
			break;
		}
		td.style.textAlign = "center";
	}
}

function openPostForm(){
	window.open("/customer/postForm.jsp", "postForm", "width=500, height=700, left=500, top=100");
}
</script>
</head>
<body>
<!-- 
	동기방식 : 클라이언트가 요청시 서버가 응답할 때까지 클라이언트가 대기상태에 빠지는 방식
			장점 - 데이터가 엉킬 경우가 없음
			단점 - 동시에 두가지 일을 할 수 없음
			
	비동기방식 : 클라이언트가 요청시 새로운 실행부가 서버로 요청하여 클라이언트가 대기상태에 빠지지 않는 방식
			장점 - 동시에 여러가지 일을 처리 가능
			단점 - 확실히 데이터를 가져온다는 보장이 없음 
 -->
<form name="registForm" action="" method="post">
	<div>
		<input type="text" placeholder="ID" name="id" required />
		<input type="button" value="중복확인" onclick="idCheck()"/>
		<span id="message"></span><br /><br />
		
		<input type="password" placeholder="비밀번호" name="password" required /><br /><br />
		
		<input type="text" name="zipcode1" required/
		> - <input type="text" name="zipcode2" required/>
		<input type="button" value="우편번호 검색" onClick="openPostForm()" /><br /><br />
		
		<input type="text" placeholder="주소" name="addr1" required /><br /><br />
		
		<input type="text" placeholder="상세주소" name="addr2" required /><br /><br />
		
		<input type="button" value="회원가입" onclick="regist()"/><br /><br />
	</div>	
</form>

<div>
	<table id="table_customer" border="1px" width="1000px">
		<thead>
			<th>CUSTOMER_ID</th>
			<th>ID</th>
			<th>PASSWORD</th>
			<th>ZIPCODE1</th>
			<th>ZIPCODE2</th>
			<th>ADDR1</th>
			<th>ADDR2</th>
			<th>REGDATE</th>
		</thead>
		<tbody>
		
		</tbody>
	</table>
</div>
</body>
</html>
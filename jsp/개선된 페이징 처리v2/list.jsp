<%@page import="com.example.commons.PagingManager"%>
<%@page import="com.example.vo.Board"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%
	PagingManager pagingManager = (PagingManager) request.getAttribute("pagingManager");
	List<Board> boardList = (List<Board>) request.getAttribute("boardList");
%>
<!DOCTYPE HTML>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style>
#box {
	border: 1px solid #CCCCCC
}

#title {
	font-size: 9pt;
	font-weight: bold;
	color: #7F7F7F;
	돋움
}

#category {
	font-size: 9pt;
	color: #7F7F7F;
	돋움
}

#keyword {
	width: 80px;
	height: 17px;
	font-size: 9pt;
	border-left: 1px solid #333333;
	border-top: 1px solid #333333;
	border-right: 1px solid #333333;
	border-bottom: 1px solid #333333;
	color: #7F7F7F;
	돋움
}

#paging {
	font-size: 9pt;
	color: #7F7F7F;
	돋움
}

#list td {
	font-size: 9pt;
}

#copyright {
	font-size: 9pt;
}

a {
	text-decoration: none
}

img {
	border: 0px
}

.pageColoring{
	color:green;
	font-size;14pt;
	font-weight:bold;
}
</style>
</head>
<body>
	<table id="box" align="center" width="603" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td colspan="6"><img src="/images/ceil.gif" width="603" height="25"></td>
		</tr>
		<tr id="title" align="center">
			<td width="50" height="20">번호</td>
			<td width="40" height="20">이미지</td>
			<td width="303" height="20">제목</td>
			<td width="100" height="20">글쓴이</td>
			<td width="100" height="20">날짜</td>
			<td width="50" height="20">조회수</td>
		</tr>
		<tr>
			<td height="1" colspan="6" bgcolor="#CCCCCC"></td>
		</tr>
		<tr>
			<td colspan="6" id="list">
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<% for(int i=0; i<boardList.size(); i++){%>
						<%Board board = boardList.get(i); %>
						<tr align="center" height="20px"
							onMouseOver="this.style.background='#FFFF99'"
							onMouseOut="this.style.background=''">
							<td width="50"><%=pagingManager.getFirstRecord()-i %></td>
							<td width="50">
								<img width="40" />
							</td>
							<td width="303"><a href="/board/detail.do?board_pk=<%=board.getBoard_pk()%>"><%=board.getTitle() %></a></td>
							<td width="100"><%=board.getWriter() %></td>
							<td width="100"><%=board.getRegdate() %></td>
							<td width="50"><%=board.getHit()%></td>
						</tr>
						<tr>
							<td height="1" colspan="6" background="/images/line_dot.gif"></td>
						</tr>
					<%} %>
				</table>
			</td>
		</tr>
		<tr>
			<td id="paging" height="20" colspan="6" align="center">
				<%for(int i=pagingManager.getFirstPage(); i<=pagingManager.getLastPage(); i++){ %>
					<a href="/board/list.do?start=<%=(i-1)*pagingManager.getPageSize()%>"
						<%if(i==pagingManager.getCurrentPage()) { %> class="pageColoring" <%} %>>
						[<%=i %>]
					</a>
				<%} %>
			</td>
		</tr>
		<tr>
			<td height="20" colspan="6" align="right" style="padding-right: 2px;">
				<table width="160" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td width="70">
							<select name="select" id="category">
								<option>제목</option>
								<option>내용</option>
								<option>글쓴이</option>
							</select>
						</td>
						<td width="80"><input name="textfield" id="keyword" type="text" size="15"></td>
						<td><img src="/images/search_btn.gif" width="32" height="17"></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td height="30" colspan="6" align="right" style="padding-right: 2px;">
				<a href="/board/write.do">
					<img src="/images/write_btin.gif" width="61" height="20" border="0">
				</a>
			</td>
		</tr>
		<tr>
			<td height="1" colspan="6" bgcolor="#CCCCCC"></td>
		</tr>
		<tr>
			<td height="20" colspan="6" align="center" id="copyright">Copyright zino All Rights Reserved</td>
		</tr>
	</table>
</body>
</html>

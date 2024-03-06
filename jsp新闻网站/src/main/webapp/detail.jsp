<%@page import="util.SomeInfoMgr"%>
<%@page import="com.example.demo.JavaBean.News"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="images/icon/icon.png">
<link rel="stylesheet" href="css/detail.css">
<meta charset="UTF-8">
<%
	News news=(News)session.getAttribute("currentNews");
	news.setContent(news.getContent().replaceAll("\n","<br/>"));
%>
<title><%=news.getTitle()%></title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">

</head>
<body>
<jsp:include page="nav.jsp"></jsp:include>
<div class="newsTitle"><%=news.getTitle()%></div>
<div class="newsInfo"><%="作者： "+news.getAuthor()+" 发布时间："+news.getTime()%></div>
<div class="line"></div>
<div class="newsContent"><%=news.getContent()%></div>
<footer>
	<hr>
	<center>
	<p>© 该网站所有内容来自Ray</p>
	</center>
</footer>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" ></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" ></script>
</body>
</html>
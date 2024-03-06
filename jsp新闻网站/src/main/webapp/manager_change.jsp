<%@page import="util.SqlManager"%>
<%@page import="com.example.demo.JavaBean.News"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<% 	String type=request.getParameter("type");
	pageContext.setAttribute("type", type);
	String title=null;
	if(type.equals("add"))
		title="添加新闻";
	else
		title="修改新闻";
		
%>
<title><%=title%></title>
<link rel="stylesheet" href="css/searchInput.css">
<link rel="shortcut icon" href="//img.alicdn.com/imgextra/i2/O1CN01ZyAlrn1MwaMhqz36G_!!6000000001499-73-tps-64-64.ico" type="image/x-icon">
<link rel="icon" type="image/svg+xml" href="//img.alicdn.com/imgextra/i4/O1CN01EYTRnJ297D6vehehJ_!!6000000008020-55-tps-64-64.svg">
<link rel="stylesheet" href="css/manager.css">
<link rel="stylesheet" href="css/manager_change.css">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
</head>
<body>
<%
	News news=new News();
	int id=0;
	if(type.equals("change")){
		id=Integer.parseInt(request.getParameter("id"));
		news=SqlManager.Instance().GetNews(id);
	}
	System.out.print(news.getType());
	String isChange=type.equals("change")? "&id="+id:" ";
	pageContext.setAttribute("isChange", isChange);
	String newsType=null;
	switch(news.getType())
	{
		case 1:
			newsType="社会新闻";
			break;
		case 2:
			newsType="国家新闻";
			break;
		case 3:
			newsType="国际新闻";
			break;
		case 4:
			newsType="教育新闻";
			break;
		case 5:
			newsType="娱乐新闻";
			break;
		default:newsType="";
	}
	pageContext.setAttribute("currentNews",news);
%>
<jsp:include page="baseMgr.jsp"></jsp:include>
<div class="right">
	<div class="right-top">
		<span class="title">新闻管理系统</span>
		<a class="exit" href="login.jsp">注销</a>
	</div>
	<div class="right-bottom">
		<div class="top">
			<p><%=title%></p>
			<div class="btnDiv"><input class="btn" type="button" value="返回" id="backBtn"/></div>
		</div>
		<div>
		
		<form method="post" action="SubmitServlet?type=${type}${isChange}">
		<div><span>新闻标题:</span><input type="text" name="title" value="${currentNews.title}"/></div>
		<span>新闻类型:</span>
		<select name="newsType">
			<option value="1" <%=news.getType()==1? "selected":""%>>社会新闻</option>
			<option value="2" <%=news.getType()==2? "selected":""%>>国家新闻</option>
			<option value="3" <%=news.getType()==3? "selected":""%>>国际新闻</option>
			<option value="4" <%=news.getType()==4? "selected":""%>>教育新闻</option>
			<option value="5" <%=news.getType()==5? "selected":""%>>娱乐新闻</option>
		</select>
		<div><span>新闻作者:</span><input type="text" name="author" value="${currentNews.author}" maxlength="20"/></div>
		<div><div>新闻内容:</div><textarea class="newscontent" name="content">${currentNews.content}</textarea></div>
		<div class="maxbottom"><input class="btn" type="submit" value="提交新闻" id="sumbitBtn"/></div>
		</form>
		</div>
	</div>
</div>
<script>
	var backBtn=document.getElementById("backBtn");
	backBtn.onclick=function()
	{
		window.location.href="manager.jsp?keyword=";
	}
	<%
	String msg=(String)session.getAttribute("msg");
		if(msg!=null){
	%>
		alert('<%=msg%>');
	<%
		session.setAttribute("msg",null);
		}
	%>
</script>
</body>
</html>
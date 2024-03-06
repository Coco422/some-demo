<%@page import="util.SomeInfoMgr"%>
<%@page import="util.SqlManager"%>
<%@page import="com.example.demo.JavaBean.News"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/searchInput.css">
<link rel="shortcut icon" href="//img.alicdn.com/imgextra/i2/O1CN01ZyAlrn1MwaMhqz36G_!!6000000001499-73-tps-64-64.ico" type="image/x-icon">
<link rel="icon" type="image/svg+xml" href="//img.alicdn.com/imgextra/i4/O1CN01EYTRnJ297D6vehehJ_!!6000000008020-55-tps-64-64.svg">
<link rel="stylesheet" href="css/manager.css">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<title>新闻管理页面</title>
</head>
<body>
<%
	int pageCount=0;
	int allCount=0;
	int currentPage=0;
	String keyword=null;
	List<News> newsList=null;
	List<News> currentList=new ArrayList<News>();
	if(request.getParameter("keyword")!=null)
	{
		List<News> searchList=SqlManager.Instance().SearchByKeyword(request.getParameter("keyword"));
		keyword=request.getParameter("keyword");
		pageCount=(int)(searchList.size()/13)+(searchList.size()%13==0? 0:1);
		allCount=searchList.size();
		currentPage=1;
		if(request.getParameter("page")!=null)
			currentPage=Integer.parseInt(request.getParameter("page"));
		if(currentPage>pageCount)
		{
			currentPage=pageCount;
		}
		if(currentPage<=0)
			currentPage=1;
		
		for(int i=(currentPage-1)*13;i<(currentPage-1)*13+13;i++)
		{
			if(i>=allCount)
				break;
			currentList.add(searchList.get(i));
		}
	}
	else
	{
		newsList=SqlManager.Instance().GetNewsByType(0,-1);
		
		pageCount=(int)(newsList.size()/13)+(newsList.size()%13==0? 0:1);
		allCount=newsList.size();
		currentPage=1;
		if(request.getParameter("page")!=null)
			currentPage=Integer.parseInt(request.getParameter("page"));
		if(currentPage>pageCount)
		{
			currentPage=pageCount;
		}
		if(currentPage<=0)
			currentPage=1;
		
		for(int i=(currentPage-1)*13;i<(currentPage-1)*13+13;i++)
		{
			if(i>=allCount)
				break;
			currentList.add(newsList.get(i));
		}
	}
	
	pageContext.setAttribute("newsList", newsList);
	pageContext.setAttribute("allCount", allCount);
	pageContext.setAttribute("currentList",currentList);
%> 
<jsp:include page="baseMgr.jsp"></jsp:include>
<div class="right">
	<div class="right-top">
		<span class="title">新闻管理系统</span>
		<a class="exit" href="login.jsp">注销</a>
	</div>
	<div class="right-bottom">
		<div class="top">
			<div><input class="btn" type="button" value="添加新闻" id="addBtn"/></div>
			<div class="container">
			<input type="text" class="search" placeholder="搜索管理新闻" id="searchInput">
				<button id="search">搜索</button>
			</div>
		</div>
		<table>
		<tr class="tabletop">
			<th>id</th>
			<th>标题</th>
			<th>类型</th>
			<th>内容</th>
			<th>作者</th>
			<th>发布时间</th>
			<td colspan="3">新闻操作</td>
		</tr>
		<c:forEach items="${currentList}" var="item">
			<tr>
				<td class="idtd">${item.id}</td>
				<td class="tabletitle">${item.title}</td>
				<td class="type">${SomeInfoMgr.Instance().GetNewsType(item.type)}</td>
				<td class="content">${item.content}</td>
				<td class="tableAuthor">${item.author}</td>
				<td>${item.time}</td>
				<td><input class="btn changebtn" data-id="${item.id}" type="button" value="修改新闻" id="changeBtn"/></td>
				<td><input class="btn deletebtn" data-id="${item.id}"  type="button" value="删除新闻" id="deleteBtn"/></td>
			</tr>
		</c:forEach>
		</table>
		<div class="pageNum">
			<div id="lt" class="jump">&lt;</div>
			<div id="gt" class="jump">&gt;</div>
			第
			<input id="page" type="number" value='<%=currentPage%>'/>
			页
			<div id="jumpBtn" class="jump">跳转</div>
			<span>共${allCount}条数据</span>
		</div>
	</div>
</div>
<script type="text/javascript">
	var addBtn=document.getElementById("addBtn");
	addBtn.onclick=function(){
		window.location.href="manager_change.jsp?type=add";
	}
	
	var page=document.getElementById("page");
	var jumpBtn=document.getElementById("jumpBtn");
	var last=document.getElementById("lt");
	var next=document.getElementById("gt");
	jumpBtn.onclick=function()
	{
		var href = window.location.href;
		var t = href.lastIndexOf('&page');
		var newHref = t == -1 ? href : href.substring(0, t);
		window.location.href=newHref+"&page="+page.value;
	}
	last.onclick=function()
	{
		var href = window.location.href;
		var t = href.lastIndexOf('&page');
		var newHref = t == -1 ? href : href.substring(0, t);
		console.log(newHref);
		window.location.href=newHref+"&page=<%=currentPage-1<=0? 1:currentPage-1%>";
	}
	next.onclick=function()
	{
		var href = window.location.href;
		var t = href.lastIndexOf('&page');
		var newHref = t == -1 ? href : href.substring(0, t);
		window.location.href=newHref+"&page=<%=currentPage+1>pageCount? pageCount:currentPage+1%>"
	}
	
	var searchBtn=document.getElementById("search");
	var content=document.getElementById("searchInput");
	function search()
	{
		var ct=content.value;
		if(!ct)
		{
				window.location.href="manager.jsp?keyword=*";
		}
		else
		window.location.href="manager.jsp?keyword="+ct;
	}
	searchBtn.onclick=function(){
		search()
	}
	searchInput.onkeyup = function(e) {
	      if (e.keyCode == 13) {
	        search()
	      }
	    }
	
	var changeBtns=document.getElementsByClassName("changebtn");
	var deleteBtns=document.getElementsByClassName("deletebtn");
	for(let i=0;i<changeBtns.length;i++)
		{
			changeBtns[i].onclick=function()
			{
				var newsId=this.getAttribute("data-id");
				window.location.href="manager_change.jsp?type=change&id="+newsId;
			}
		}
	for(let i=0;i<deleteBtns.length;i++)
	{
		deleteBtns[i].onclick=function()
		{
			var isDelete=window.confirm("是否确认删除该新闻");
			if(isDelete)
			{
				var newsId=this.getAttribute("data-id");
				window.location.href="DeleteServlet?id="+newsId;
			}
		}
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
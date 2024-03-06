<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.example.demo.JavaBean.News"%>
<%@ page import="util.SomeInfoMgr"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="util.SqlManager" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>小瑞新闻网</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
</head>
<body>
<%!
    int type=0;
    String newsType="";
%>
<%
    List<News> news=new ArrayList<News>();
    List<News> currentList=new ArrayList<News>();
    if(request.getParameter("newsType")!=null) {
        type = Integer.parseInt(request.getParameter("newsType"));
    }else {
        response.sendRedirect(request.getContextPath()+"/index.jsp?newsType=0");
    }
    newsType=SomeInfoMgr.Instance().GetNewsType(type);
    news= SqlManager.Instance().GetNewsByType(type,-1);
    if(request.getParameter("keyword")!=null)
    {
        currentList=SqlManager.Instance().SearchByKeyword(request.getParameter("keyword"));
    }
    int pageCount=(int)(news.size()/6)+(news.size()%6==0? 0:1);
    System.out.println("pageCount"+pageCount);
    int allCount=news.size();
    int currentPage=1;
    if(request.getParameter("page")!=null)
        currentPage=Integer.parseInt(request.getParameter("page"));
    if(currentPage>pageCount)
    {
        currentPage=pageCount;
    }
    if(currentPage<=0)
        currentPage=1;

    System.out.println(currentPage);
    for(int i=(currentPage-1)*6;i<(currentPage-1)*6+6;i++)
    {
        if(i>=allCount)
            break;
        currentList.add(news.get(i));
    }
    pageContext.setAttribute("allCount", allCount);
    pageContext.setAttribute("currentList", currentList);
    pageContext.setAttribute("news", news);
    pageContext.setAttribute("type", type);
%>
<jsp:include page="nav.jsp"></jsp:include>
    <br>
<%--banner--%>
    <div class="container">
        <div class="jumbotron" style="background-color: #3c763d;">
            <h1><center style="color: white;">新闻报道</center></h1>
            <p><center style="color: white;">为您实时报道</center></p>
            <h2><center style="color: white;">公历时间：<%=SomeInfoMgr.Instance().GetTime(null)%></center></h2>
        </div>
    </div>

<div class="container">
    <div class="row row-offcanvas row-offcanvas-right">
        <div class="col-xs-12 col-sm-9">
            <div class="row">
                <c:forEach items="${currentList}" var="item">
                    <div class="col-xs-6 col-lg-4 card">
                        <div class="card-body">
                            <h4 class="card-title">${item.title}</h4>
                            <h6 class="card-subtitle mb-2 text-muted">作者:${item.author}</h6>
                            <div class="card-text text-justify text-truncate" >${item.content}</div>
                            <a style="margin-bottom: 10px" class="card-link" href="DetailServlet?newsId=${item.id}">查看详情 »</a>
                        </div>
                    </div><!--/.col-xs-6.col-lg-4-->
                </c:forEach>
            </div><!--/row-->
            <br>
<%--            分页--%>
            <nav aria-label="Page navigation">
                <ul class="pagination justify-content-center pagination-lg">

                    <li class="page-item">
                        <a class="page-link" id="lt" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                    <li class="page-item">
                        <a class="page-link" aria-label="show page">
                     <span>第</span>
                    <input id="page" value='<%=currentPage%>' style="width: 20px;height: 20px"/>
                     <span>页</span>
                        </a>
                    </li>
                    <li class="page-item">
                        <a class="page-link" id="gt" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                    <li class="page-item">
                        <a class="page-link" id="jumpBtn" aria-label="Go">
                        <span aria-hidden="true">跳转</span>
                    </a>
                    </li>
                    <li class="page-item disabled">
                        <a class="page-link"  aria-label="info show">
                        <span class="disabled">共${news.size()}条数据</span>
                        </a>
                    </li>
                </ul>
            </nav>
        </div><!--/.col-xs-12.col-sm-9-->
<%--边边栏--%>
        <div class="col-xs-6 col-sm-3 sidebar-offcanvas" id="sidebar">
            <div class="list-group">
                <a href="#" class="list-group-item active">${currentList[0].title}</a>
                <c:forEach items="${currentList}" var="item" begin="1">
                <a href="#" class="list-group-item">${item.title}</a>
                </c:forEach>
            </div>
        </div><!--/.sidebar-offcanvas-->
    </div><!--/row-->
    <hr>
    <footer>
        <p>© 该网站所有内容来自Ray</p>
    </footer>

</div>
<script>

    // 分页
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


    </script>
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" ></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" ></script>
</body>
</html>
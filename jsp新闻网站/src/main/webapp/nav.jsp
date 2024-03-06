<%--
  Created by IntelliJ IDEA.
  User: Ray
  Date: 2023/6/7
  Time: 14:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>top navbar</title>
</head>
<body>
<!-- 导航栏 -->
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="index.jsp">小瑞新闻</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto nav-pills">
            <li class="nav-item active">
                <a class="nav-link" >主页 <span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="#">社会</a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="#">国内</a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="#">国际</a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="#">教育</a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="#">娱乐</a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="#">金融</a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="#">体育</a>
            </li>
        </ul>
        <span class="form-inline my-2 my-lg-0">
                <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search" id="searchInput">
                <button class="btn btn-outline-success my-2 my-sm-0" id="search">Search</button>&nbsp
                <a class="btn btn-outline-info" href="login.jsp">后台管理</a>
            </span>

    </div>
</nav>
<script>
    var searchBtn=document.getElementById("search");
    var content=document.getElementById("searchInput");
    function search()
    {
        var ct=content.value;
        if(!ct)
        {
            window.location.href="index.jsp?newsType=999&keyword=*";
            return;
        }
        window.location.href="index.jsp?newsType=999&keyword="+ct;
    }
    searchBtn.onclick=function(){
        search()
    }
    content.onkeyup = function(e) {
        if (e.keyCode === 13) {
            search()
        }
    }
    var topList=document.getElementById("navbarSupportedContent").getElementsByTagName("li");
    var index=0;
    for(let i=0;i<topList.length;i++)
    {
        if(i==0)
        {
            topList[i].onclick=function()
            {
                window.location.href="index.jsp?newsType=0";
            }
        }
        else
        {
            topList[i].onclick=(function(arg){
                return function () {
                    window.location.href="ChangeServlet?type="+arg;
                }
            })(i);
        }
    }
</script>
</body>
</html>

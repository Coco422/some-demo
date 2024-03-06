<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/baseMgr.css">
<title>新闻管理页面</title>
</head>
<body>
<div class="left">
	<div class="username">
	<span style="color: white">用户名：</span>
	<span><%=session.getAttribute("user")%></span>
	</div>
	<ul class="option" id="option">
		<li>管理新闻</li>
		<li><a href="index.jsp" style="color: white">新闻主页</a></li>
	</ul>	
</div>
<script>
var topList=document.getElementById("option").getElementsByTagName("li");
topList[0].style.backgroundColor="rgb(44,49,56)";
var index=0;
for(let i=0;i<topList.length;i++)
{
	topList[i].onclick=(function(arg){
		return function () {
			        }
      })(i);
}
</script>
</body>
</html>
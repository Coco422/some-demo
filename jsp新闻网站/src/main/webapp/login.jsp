<%--
  Created by IntelliJ IDEA.
  User: Ray
  Date: 2023/6/6
  Time: 19:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录界面</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
  <style>
    .loginForm {
      /*边框高度*/
      height: 350px;
      /*边框宽度*/
      width: 500px;
      /*边框颜色*/
      border: #4d4d4d solid 1px;
      /*边框圆角*/
      border-radius: 4px;
      /*阴影 水平方向，竖直方向，模糊距离*/
      box-shadow: 5px 5px 5px #4d4d4d;
      /*上边界距离*/
      margin-top: 15%;
      /*左边界距离：自动*/
      margin-left: auto;
      /*右边界距离：自动*/
      margin-right: auto;
      /*用户名、密码间距*/
      padding: 20px 40px;
    }

    /*将用户登录置于中间*/
    .loginForm h2 {
      text-align: center;
    }

    /*修改button属性*/
    .button {
      text-align: center;
      vertical-align: middle;
    }
  </style>
</head>
<body>
<div class="loginForm">
  <h2>用户登录</h2>·
  <form action="${pageContext.request.contextPath}/loginServlet" method="post">
    <div class="form-group">
      <label for="exampleInputEmail1">用户名</label>
      <input type="text" class="form-control" id="exampleInputEmail1" placeholder="请输入用户名" name="username">
    </div>
    <div class="form-group">
      <label for="exampleInputPassword1">密码</label>
      <input type="password" class="form-control" id="exampleInputPassword1" placeholder="请输入密码" name="password">
    </div>
    <div class="button">
      <input type="submit" class="btn btn-primary" value="登 录"/>
    </div>
  </form>
</div>
<script>
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
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" ></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" ></script>
</body>
</html>

package Servlet;

import util.SqlManager;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/loginServlet")
public class loginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 设置编码格式
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
        System.out.print("login");

        String msg=null;
        String user=request.getParameter("username");
        String pwd=request.getParameter("password");
        if(pwd==null||pwd==""||user==null||user=="")
        {
            System.out.println("no null");
            request.getSession().setAttribute("msg","账号和密码不能为空");
            response.sendRedirect("login.jsp");
            return;
        }
        System.out.println("0000");
        if(SqlManager.Instance().CheckAccountExist(user))
        {
            System.out.println("1111");
            msg=SqlManager.Instance().CheckLogin(user,pwd);
            System.out.println("2222");
            if(msg!=null)
            {
                request.getSession().setAttribute("msg",msg);
                System.out.println("fail");
                response.sendRedirect("login.jsp");
                return;
            }
            else {
                request.getSession().setAttribute("user",user);
                System.out.println("success");
                response.sendRedirect("manager.jsp?keyword=");
            }
        }
        else {
            msg="账号不存在";
            System.out.println(msg);
            request.getSession().setAttribute("msg",msg);
            response.sendRedirect("login.jsp");
        }
        System.out.println("login2");
    }
}

package Servlet;

import util.SqlManager;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/DeleteServlet")
public class DeleteServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int newsId=Integer.parseInt(request.getParameter("id"));
        System.out.println("newsId"+newsId);
        if(SqlManager.Instance().DeleteNewsById(newsId))
        {
            System.out.println("删除成功");
            response.sendRedirect("manager.jsp?&page=1");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    doGet(request, response);
    }
}

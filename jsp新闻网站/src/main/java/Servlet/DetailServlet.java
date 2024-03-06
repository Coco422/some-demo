package Servlet;

import com.example.demo.JavaBean.News;
import util.SqlManager;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/DetailServlet")
public class DetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public DetailServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int newsId=Integer.parseInt(request.getParameter("newsId"));
        News news= SqlManager.Instance().GetNews(newsId);
        request.getSession().setAttribute("currentNews",news);
        response.sendRedirect("detail.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        doGet(request, response);
    }

}
package Servlet;

import com.example.demo.JavaBean.News;
import util.SomeInfoMgr;
import util.SqlManager;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/SubmitServlet")
public class SubmitServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public SubmitServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        String type=request.getParameter("type");

        String title,author,content,time;
        int newsType;
        title=request.getParameter("title");
        author=request.getParameter("author");
        content=request.getParameter("content");
        time= SomeInfoMgr.Instance().GetTime("yyyy-MM-dd HH:mm:ss");
        newsType=Integer.parseInt(request.getParameter("newsType"));

        News news=new News();
        news.setTitle(title);
        news.setAuthor(author);
        news.setContent(content);
        news.setTime(time);
        news.setType(newsType);
        if(request.getParameter("id")!=null)
            news.setId(Integer.parseInt(request.getParameter("id")));
        if(type.equals("add"))
        {
            if(news.getTitle()==""||news.getContent()==""||news.getAuthor()=="")
            {
                request.getSession().setAttribute("msg", "信息不能为空");
                response.sendRedirect("manager_change.jsp?type=add");
                return;
            }
            else {
                if(SqlManager.Instance().AddNews(news)) {
                    request.getSession().setAttribute("msg", "添加成功");
                }
                else {
                    request.getSession().setAttribute("msg", "添加失败");
                }
            }
        }
        else {
            if(SqlManager.Instance().UpdateNews(news)) {
                request.getSession().setAttribute("msg", "修改成功");
            }
            else {
                request.getSession().setAttribute("msg", "修改失败");
            }
        }
        response.sendRedirect("manager.jsp");
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

}

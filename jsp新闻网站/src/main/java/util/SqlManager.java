package util;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import com.example.demo.JavaBean.News;

import java.util.*;

public class SqlManager {
    private static SqlManager instance;
    public static SqlManager Instance()
    {
        if(instance==null)
            instance=new SqlManager();
        return instance;
    }
    public News GetNews(int id) {
        ResultSet rSet=DbUtil.Instance().Query("select * from newsdetail where id=?", id+"");
        News news=new News();
        try {
            while(rSet.next())
            {
                news.setId(rSet.getInt("id"));
                news.setTitle(rSet.getString("title"));
                news.setContent(rSet.getString("content"));
                news.setAuthor(rSet.getString("author"));
                news.setTime(TimeFormat(rSet.getString("time")));
                news.setType(rSet.getInt("type"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return news;
    }
    public List<News> GetNewsByType(int type,int searchCount)
    {
        List<News> newsList=new ArrayList<News>();
        String sql="";
        ResultSet rSet=null;
        if(type==0)
        {
            sql="select * from newsdetail";
            rSet=DbUtil.Instance().Query(sql);
        }
        else {
            sql="select * from newsdetail where type=?";
            rSet=DbUtil.Instance().Query(sql, type+"");
        }
        News news=null;
        try {
            while(rSet.next())
            {
                news=new News();
                news.setId(rSet.getInt("id"));
                news.setTitle(rSet.getString("title"));
                news.setContent(rSet.getString("content").replaceAll("<换行>","<br/>"));
                news.setAuthor(rSet.getString("author"));
                news.setTime(TimeFormat(rSet.getString("time")));
                news.setType(rSet.getInt("type"));
                newsList.add(news);
                if(searchCount!=-1&&newsList.size()>=searchCount)
                {
                    break;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return newsList;
    }
    public List<News> SearchByKeyword(String keyword)
    {
        List<News> newsList=new ArrayList<News>();
        String sql="select distinct * from newsdetail where title like '%"
                +keyword+"%' or content like '%"+keyword+"%'";
        if(keyword.equals("*"))
            sql="select * from newsdetail";

        ResultSet rSet=DbUtil.Instance().Query(sql);
        News news=null;
        try {
            while(rSet.next())
            {
                news=new News();
                news.setId(rSet.getInt("id"));
                news.setTitle(rSet.getString("title"));
                news.setContent(rSet.getString("content"));
                news.setAuthor(rSet.getString("author"));
                news.setTime(TimeFormat(rSet.getString("time")));
                news.setType(rSet.getInt("type"));
                newsList.add(news);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return newsList;
    }
    public boolean AddNews(News news)
    {
        String title,author,content,time;
        int type;
        title=news.getTitle();
        author=news.getAuthor();
        content=news.getContent();
        time=news.getTime();
        type=news.getType();
        String sql="insert into newsdetail(title,content,author,time,type) values(?,?,?,?,?)";
        return DbUtil.Instance().Update(sql,title,content,author,time,type);
    }
    public boolean UpdateNews(News news)
    {
        String title,author,content,time;
        int type;
        title=news.getTitle();
        author=news.getAuthor();
        content=news.getContent();
        time=news.getTime();
        type=news.getType();
        String sql="update newsdetail set title=?,content=?,author=?,time=?,type=? where id=?";
        return DbUtil.Instance().Update(sql,title,content,author,time,type,news.getId());
    }
    public boolean DeleteNewsById(int id)
    {
        String sql="";
        sql="delete from newsdetail where id="+id;
        return DbUtil.Instance().Update(sql);
    }
    public String TimeFormat(String time)
    {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        try {
            Date date = sdf.parse(time);
            time= sdf.format(date);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return time;
    }
    public String CheckLogin(String user,String psw) {
        String msg=null;
        try {
            ResultSet rSet=DbUtil.Instance().Query("select * from  `jspuse`.`admin` where adminname='"+user+"'");
            String realPsw="";
            //System.out.println(0);
            try {
                //System.out.println(1);
                while(rSet.next())
                {
//                    System.out.println(2);
                    realPsw=rSet.getString("adminpass");
                }
            }
            catch (Exception e) {
                e.printStackTrace();
            }
//            System.out.println("real:"+realPsw);
//            System.out.println("my:"+psw);
            if(!psw.equals(realPsw))
                msg="账号或密码错误";
        } catch (Exception e) {
            System.out.println("catch");
        }
//        System.out.println("CheckLogin");
        return msg;
    }
    public boolean CheckAccountExist(String user)
    {
        ResultSet rSet=DbUtil.Instance().Query("select * from `jspuse`.`admin` where adminname='"+user+"'");
        boolean isExist=false;
        try {
            while(rSet.next())
            {
                isExist=true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isExist;
    }
}

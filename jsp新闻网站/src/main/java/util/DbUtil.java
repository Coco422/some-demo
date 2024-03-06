package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DbUtil {
    private static DbUtil instance;
    public static DbUtil Instance()
    {
        if(instance==null)
            instance=new DbUtil();
        return instance;
    }
    private DbUtil()
    {

    }

    Connection connection=null;
    Statement statement=null;
    PreparedStatement preStatement=null;
    ResultSet resultSet=null;
    public Connection GetConnection()//获得连接
    {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection=DriverManager.getConnection("jdbc:mysql://localhost:3306/jspuse?useSSL=false&useUnicode=true&characterEncoding=utf-8","root","yhyfgcyydt422");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return connection;
    }
    public void Realease() {//释放
        try {
            if(resultSet!=null)
                resultSet.close();
            if(preStatement!=null)
                preStatement.close();
            if(statement!=null)
                statement.close();
            if(connection!=null)
                connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
    public ResultSet Query(String sql)
    {
        if(connection==null)
            connection=GetConnection();
        resultSet=null;
        try {
            statement=connection.createStatement();
            resultSet=statement.executeQuery(sql);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return resultSet;
    }
    public ResultSet Query(String sql,Object... args)
    {
        if(connection==null)
            connection=GetConnection();
        resultSet=null;
        try {
            preStatement=connection.prepareStatement(sql);
            for (int i = 1; i <= args.length; i++) {
                preStatement.setString(i, args[i-1].toString());
            }
            resultSet=preStatement.executeQuery();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return resultSet;
    }
    public boolean Update(String sql)
    {
        if(connection==null)
            connection=GetConnection();
        try {
            statement=connection.createStatement();
            statement.execute(sql);
            return true;
        } catch (SQLException e) {
            return false;
        }
    }
    public boolean Update(String sql,Object...args)
    {
        if(connection==null)
            connection=GetConnection();
        try {
            preStatement=connection.prepareStatement(sql);
            for (int i = 1; i <= args.length; i++) {
                preStatement.setString(i, args[i-1].toString());
            }
            preStatement.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
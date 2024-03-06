package util;

import java.text.SimpleDateFormat;
import java.util.*;
public class SomeInfoMgr {
    private static SomeInfoMgr instance;
    public static SomeInfoMgr Instance()
    {
        if(instance==null)
            instance=new SomeInfoMgr();
        return instance;
    }
    public String GetTime(String format)
    {
        Date date=new Date();
        if(format==null)
            format="yyyy-MM-dd";
        SimpleDateFormat simpleFormat =new SimpleDateFormat(format);
        return simpleFormat.format(date);
    }
    public String GetNewsType(int typeId)
    {
        String newsType="";
        switch(typeId)
        {
            case 0:
                newsType="综合新闻";
                break;
            case 1:
                newsType="社会新闻";
                break;
            case 2:
                newsType="国家新闻";
                break;
            case 3:
                newsType="国际新闻";
                break;
            case 4:
                newsType="教育新闻";
                break;
            case 5:
                newsType="娱乐新闻";
                break;
            case 999:
                newsType="查询结果";
                break;
        }
        return newsType;
    }
}

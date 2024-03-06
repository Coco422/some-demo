package com.example.demo.JavaBean;

import java.util.Date;

public class News {
    private int id;
    private String title,content,author,time;
    private int type;

    public News(String title, String content, String author, String time, int type) {
        this.title = title;
        this.content = content;
        this.author = author;
        this.time = time;
        this.type = type;
    }

    public News() {

    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }
}

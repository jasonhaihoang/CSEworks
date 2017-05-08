package com.example.jhoang.mysqldemo;

public class Messages {
    private String name;
    private String message;

    public Messages(String name, String message){
        this.setName(name);
        this.setMessage(message);
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}

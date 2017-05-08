package com.example.jhoang.mysqldemo;

public class MessagesStudentsList {
    private String name;
    private int FieldNum;
    private String instrument;

    public MessagesStudentsList(String name, int FieldNum, String instrument) {
        this.setName(name);
        this.setFieldNum(FieldNum);
        this.setInstrument(instrument);
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getFieldNum() {
        return FieldNum;
    }

    public void setFieldNum(int FieldNum) {
        this.FieldNum = FieldNum;
    }

    public String getInstrument() {
        return instrument;
    }

    public void setInstrument(String instrument) {
        this.instrument = instrument;
    }

}

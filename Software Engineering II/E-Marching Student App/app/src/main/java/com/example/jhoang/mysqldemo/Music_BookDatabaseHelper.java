package com.example.jhoang.mysqldemo;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

public class Music_BookDatabaseHelper extends SQLiteOpenHelper {
    public static final String DATABASE_NAME = "Music_Book.db";
    public static final String TABLE_NAME = "MUSICBOOK_TABLE";
    public static final String COL_1 = "SHOWID";
    public static final String COL_2 = "SHOWNAME";
    public static final String COL_3 = "NUMMVTS";

    public Music_BookDatabaseHelper(Context context) {
        super(context, DATABASE_NAME, null, 1);
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
        db.execSQL("create table " + TABLE_NAME + " (SHOWID TEXT PRIMARY KEY,SHOWNAME TEXT,NUMMVTS TEXT)");
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        db.execSQL("DROP TABLE IF EXISTS " + TABLE_NAME);
        onCreate(db);
    }

    public boolean insertData(String showid,String showname,String nummvts) {
        SQLiteDatabase db = this.getWritableDatabase();
        ContentValues contentValues = new ContentValues();
        contentValues.put(COL_1,showid);
        contentValues.put(COL_2,showname);
        contentValues.put(COL_3, nummvts);

        long result = db.insert(TABLE_NAME,null ,contentValues);
        if(result == -1)
            return false;
        else
            return true;
    }

    public Cursor getAllData() {
        SQLiteDatabase db = this.getWritableDatabase();
        Cursor res = db.rawQuery("select * from "+TABLE_NAME,null);
        return res;
    }

    public boolean updateData(String showid,String showname,String nummvts) {
        SQLiteDatabase db = this.getWritableDatabase();
        ContentValues contentValues = new ContentValues();
        contentValues.put(COL_1,showid);
        contentValues.put(COL_2,showname);
        contentValues.put(COL_3,nummvts);
        db.update(TABLE_NAME, contentValues, "SHOWID = ?",new String[] { showid });
        return true;
    }

    public Integer deleteData (String showid){
        SQLiteDatabase db = this.getWritableDatabase();
        return db.delete(TABLE_NAME, "SHOWID = ?",new String[] { showid });
    }
}

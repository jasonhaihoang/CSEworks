package com.example.jhoang.mysqldemo;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

public class Music_MvtDatabaseHelper extends SQLiteOpenHelper {
    public static final String DATABASE_NAME = "Music_Mvt.db";
    public static final String TABLE_NAME = "MUSICMVT_TABLE";
    public static final String COL_1 = "MVTNUM";
    public static final String COL_2 = "NAMEOFMVT";
    public static final String COL_3 = "INSTRUMENT";
    public static final String COL_4 = "SHOWID";

    public Music_MvtDatabaseHelper(Context context) {
        super(context, DATABASE_NAME, null, 1);
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
        db.execSQL("create table " + TABLE_NAME + " (MVTNUM TEXT PRIMARY KEY,NAMEOFMVT TEXT,INSTRUMENT TEXT,SHOWID TEXT)");
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        db.execSQL("DROP TABLE IF EXISTS " + TABLE_NAME);
        onCreate(db);
    }

    public boolean insertData(String mvtnum,String nameofmvt,String instrument,String showid) {
        SQLiteDatabase db = this.getWritableDatabase();
        ContentValues contentValues = new ContentValues();
        contentValues.put(COL_1,mvtnum);
        contentValues.put(COL_2,nameofmvt);
        contentValues.put(COL_3,instrument);
        contentValues.put(COL_4, showid);

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

    public boolean updateData(String mvtnum,String nameofmvt,String instrument,String showid) {
        SQLiteDatabase db = this.getWritableDatabase();
        ContentValues contentValues = new ContentValues();
        contentValues.put(COL_1,mvtnum);
        contentValues.put(COL_2,nameofmvt);
        contentValues.put(COL_3,instrument);
        contentValues.put(COL_4,showid);
        db.update(TABLE_NAME, contentValues, "MVTNUM = ?",new String[] { mvtnum });
        return true;
    }

    public Integer deleteData (String mvtnum){
        SQLiteDatabase db = this.getWritableDatabase();
        return db.delete(TABLE_NAME, "MVTNUM = ?",new String[] { mvtnum });
    }
}
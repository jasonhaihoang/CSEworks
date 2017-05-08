package com.example.jhoang.mysqldemo;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

public class Coordinate_SetDatabaseHelper extends SQLiteOpenHelper {
    public static final String DATABASE_NAME = "Coordinate_Set.db";
    public static final String TABLE_NAME = "COORDINATESET_TABLE";
    public static final String COL_1 = "SETNUM";
    public static final String COL_2 = "FRONT2BACK";
    public static final String COL_3 = "SIDE2SIDE";
    public static final String COL_4 = "NUMCOUNTS";
    public static final String COL_5 = "MEASURES";
    public static final String COL_6 = "FIELDNUM";
    public static final String COL_7 = "SHOWID";

    public Coordinate_SetDatabaseHelper(Context context) {
        super(context, DATABASE_NAME, null, 1);
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
        db.execSQL("create table " + TABLE_NAME + " (SETNUM TEXT PRIMARY KEY,FRONT2BACK TEXT, SIDE2SIDE TEXT, NUMCOUNTS TEXT, MEASURES TEXT, FIELDNUM TEXT, SHOWID)");
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        db.execSQL("DROP TABLE IF EXISTS " + TABLE_NAME);
        onCreate(db);
    }

    public boolean insertData(String setnum,String front2back, String side2side, String numcounts, String measures, String fieldnum, String showid) {
        SQLiteDatabase db = this.getWritableDatabase();
        ContentValues contentValues = new ContentValues();
        contentValues.put(COL_1,setnum);
        contentValues.put(COL_2,front2back);
        contentValues.put(COL_3,side2side);
        contentValues.put(COL_4,numcounts);
        contentValues.put(COL_5,measures);
        contentValues.put(COL_6,fieldnum);
        contentValues.put(COL_7,showid);

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

    public boolean updateData(String setnum,String front2back, String side2side, String numcounts,String measures, String fieldnum, String showid) {
        SQLiteDatabase db = this.getWritableDatabase();
        ContentValues contentValues = new ContentValues();
        contentValues.put(COL_1,setnum);
        contentValues.put(COL_2,front2back);
        contentValues.put(COL_3,side2side);
        contentValues.put(COL_4,numcounts);
        contentValues.put(COL_5,measures);
        contentValues.put(COL_6,fieldnum);
        contentValues.put(COL_7,showid);


        db.update(TABLE_NAME, contentValues, "SETNUM = ?",new String[] { setnum });
        return true;
    }

    public Integer deleteData (String setnum){
        SQLiteDatabase db = this.getWritableDatabase();
        return db.delete(TABLE_NAME, "SETNUM = ?",new String[] { setnum });
    }
}

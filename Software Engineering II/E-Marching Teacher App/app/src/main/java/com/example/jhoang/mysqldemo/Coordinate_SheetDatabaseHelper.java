package com.example.jhoang.mysqldemo;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

public class Coordinate_SheetDatabaseHelper extends SQLiteOpenHelper {
    public static final String DATABASE_NAME = "Coordinate_Sheet.db";
    public static final String TABLE_NAME = "COORDINATESHEET_TABLE";
    public static final String COL_1 = "FIELDNUM";
    public static final String COL_2 = "INSTRUMENT";
    public static final String COL_3 = "SHOWID";

    public Coordinate_SheetDatabaseHelper(Context context) {
        super(context, DATABASE_NAME, null, 1);
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
        db.execSQL("create table " + TABLE_NAME + " (FIELDNUM TEXT PRIMARY KEY,INSTRUMENT TEXT, SHOWID TEXT)");
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        db.execSQL("DROP TABLE IF EXISTS " + TABLE_NAME);
        onCreate(db);
    }

    public boolean insertData(String fieldnum,String instrument, String showid) {
        SQLiteDatabase db = this.getWritableDatabase();
        ContentValues contentValues = new ContentValues();
        contentValues.put(COL_1,fieldnum);
        contentValues.put(COL_2,instrument);
        contentValues.put(COL_3,showid);

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

    public boolean updateData(String fieldnum,String instrument,String showid) {
        SQLiteDatabase db = this.getWritableDatabase();
        ContentValues contentValues = new ContentValues();
        contentValues.put(COL_1,fieldnum);
        contentValues.put(COL_2,instrument);
        contentValues.put(COL_3,showid);


        db.update(TABLE_NAME, contentValues, "FIELDNUM = ?",new String[] { fieldnum });
        return true;
    }

    public Integer deleteData (String fieldnum){
        SQLiteDatabase db = this.getWritableDatabase();
        return db.delete(TABLE_NAME, "FIELDNUM = ?",new String[] { fieldnum });
    }
}


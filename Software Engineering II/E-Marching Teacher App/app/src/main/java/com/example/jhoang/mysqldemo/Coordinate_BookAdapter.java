package com.example.jhoang.mysqldemo;

import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteDatabase.CursorFactory;
import android.database.sqlite.SQLiteOpenHelper;

public class Coordinate_BookAdapter {

    public static final String MYDATABASE_NAME = "Coordinate_Book.db";
    public static final String MYDATABASE_TABLE = "COORDINATEBOOK_TABLE";
    public static final int MYDATABASE_VERSION = 1;
    public static final String KEY_ID = "_id";
    public static final String KEY_CONTENT1 = "SHOWID";
    public static final String KEY_CONTENT2 = "SHOWNAME";
    public static final String KEY_CONTENT3 = "NUMSETS";

    //create table MY_DATABASE (ID integer primary key, Content text not null);
    private static final String SCRIPT_CREATE_DATABASE =
            "create table " + MYDATABASE_TABLE + " ("
                    + KEY_ID + " integer primary key autoincrement, "
                    + KEY_CONTENT1 + " text not null, "
                    + KEY_CONTENT2 + " text not null, "
                    + KEY_CONTENT3 + " text not null);";

    private SQLiteHelper sqLiteHelper;
    private SQLiteDatabase sqLiteDatabase;

    private Context context;

    public Coordinate_BookAdapter(Context c){
        context = c;
    }

    public Coordinate_BookAdapter openToWrite() throws android.database.SQLException {
        sqLiteHelper = new SQLiteHelper(context, MYDATABASE_NAME, null, MYDATABASE_VERSION);
        sqLiteDatabase = sqLiteHelper.getWritableDatabase();
        return this;
    }

    public void close(){
        sqLiteHelper.close();
    }

    public Cursor queueAll(){
        String[] columns = new String[]{KEY_ID, KEY_CONTENT1, KEY_CONTENT2, KEY_CONTENT3};
        Cursor cursor = sqLiteDatabase.query(MYDATABASE_TABLE, columns,
                null, null, null, null, null);

        return cursor;
    }

    public class SQLiteHelper extends SQLiteOpenHelper {

        public SQLiteHelper(Context context, String name,
                            CursorFactory factory, int version) {
            super(context, name, factory, version);
        }

        @Override
        public void onCreate(SQLiteDatabase db) {
            // TODO Auto-generated method stub
            db.execSQL(SCRIPT_CREATE_DATABASE);
        }

        @Override
        public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
            // TODO Auto-generated method stub

        }

    }

}
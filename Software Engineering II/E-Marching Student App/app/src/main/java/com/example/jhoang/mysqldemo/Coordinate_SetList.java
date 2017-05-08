package com.example.jhoang.mysqldemo;

import android.app.Activity;
import android.content.Intent;
import android.database.Cursor;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.view.View;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.SimpleCursorAdapter;

public class Coordinate_SetList extends Activity {

    EditText inputContent1, inputContent2;
    Button buttonAdd, buttonDeleteAll;
    private static Button btneditcoordinateset;
    private Coordinate_SetAdapter mySQLiteAdapter;
    ListView listContent;

    SimpleCursorAdapter cursorAdapter;
    Cursor cursor;
    String select;
    String select1;

    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_coordinate__set_list);

        listContent = (ListView)findViewById(R.id.contentlist);

        if (savedInstanceState == null) {
            Bundle extras = getIntent().getExtras();
            if(extras == null) {
                select= null;
            } else {
                select= extras.getString("STRING_I_NEED");
            }
        } else {
            select= (String) savedInstanceState.getSerializable("STRING_I_NEED");
        }

        if (savedInstanceState == null) {
            Bundle extras = getIntent().getExtras();
            if(extras == null) {
                select1= null;
            } else {
                select1= extras.getString("STRING_I_NEED1");
            }
        } else {
            select1= (String) savedInstanceState.getSerializable("STRING_I_NEED1");
        }

        mySQLiteAdapter = new Coordinate_SetAdapter(this);
        mySQLiteAdapter.openToWrite();

        cursor = mySQLiteAdapter.getAllData(select, select1);
        String[] from = new String[]{Coordinate_SetAdapter.KEY_ID, Coordinate_SetAdapter.KEY_CONTENT1, Coordinate_SetAdapter.KEY_CONTENT2, Coordinate_SetAdapter.KEY_CONTENT3, Coordinate_SetAdapter.KEY_CONTENT4, Coordinate_SetAdapter.KEY_CONTENT5, Coordinate_SetAdapter.KEY_CONTENT6, Coordinate_SetAdapter.KEY_CONTENT7};
        int[] to = new int[]{R.id.id, R.id.text1, R.id.text2, R.id.text3, R.id.text4, R.id.text5, R.id.text6, R.id.text7};
        cursorAdapter =
                new SimpleCursorAdapter(this, R.layout.coordinate_set_item, cursor, from, to);
        listContent.setAdapter(cursorAdapter);
        listContent.setOnItemClickListener(listContentOnItemClickListener);
        OnClickButtonListener();

        FloatingActionButton fab = (FloatingActionButton) findViewById(R.id.fab);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                finish();
            }
        });

    }

    private void OnClickButtonListener() {
        btneditcoordinateset = (Button)findViewById(R.id.button_editcoordinateset);
        btneditcoordinateset.setOnClickListener(
                new View.OnClickListener(){
                    @Override
                    public void onClick(View v){
                        Intent intent = new Intent("com.example.jhoang.mysqldemo.Coordinate_SetActivity");
                        startActivity(intent);
                    }
                }
        );
    }

    private ListView.OnItemClickListener listContentOnItemClickListener
            = new ListView.OnItemClickListener() {

        @Override
        public void onItemClick(AdapterView<?> parent, View view, int position,
                                long id) {
            // TODO Auto-generated method stub

            Cursor cursor = (Cursor) parent.getItemAtPosition(position);
            final int item_id = cursor.getInt(cursor.getColumnIndex(Coordinate_SetAdapter.KEY_ID));
            String item_content1 = cursor.getString(cursor.getColumnIndex(Coordinate_SetAdapter.KEY_CONTENT1));
            String item_content2 = cursor.getString(cursor.getColumnIndex(Coordinate_SetAdapter.KEY_CONTENT2));
            String item_content3 = cursor.getString(cursor.getColumnIndex(Coordinate_SetAdapter.KEY_CONTENT3));
            String item_content4 = cursor.getString(cursor.getColumnIndex(Coordinate_SetAdapter.KEY_CONTENT4));
            String item_content5 = cursor.getString(cursor.getColumnIndex(Coordinate_SetAdapter.KEY_CONTENT5));
            String item_content6 = cursor.getString(cursor.getColumnIndex(Coordinate_SetAdapter.KEY_CONTENT6));
            String item_content7 = cursor.getString(cursor.getColumnIndex(Coordinate_SetAdapter.KEY_CONTENT7));
            Intent intent = new Intent("com.example.jhoang.mysqldemo.Coordinate_SetActivity");
            startActivity(intent);
        }
    };

    @Override
    protected void onDestroy() {
        // TODO Auto-generated method stub
        super.onDestroy();
        mySQLiteAdapter.close();
    }



    private void updateList(){
        cursor.requery();
    }

}

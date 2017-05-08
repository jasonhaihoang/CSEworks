package com.example.jhoang.mysqldemo;

import android.content.Intent;
import android.database.Cursor;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.ListView;
import android.widget.SimpleCursorAdapter;

public class Music_MvtList extends AppCompatActivity {

    private static Button btneditmusicmvt;
    private Music_MvtAdapter mySQLiteAdapter;
    ListView listContent;

    SimpleCursorAdapter cursorAdapter;
    Cursor cursor;
    String select;
    private static Button btnrefresh;
    String username;
    String password;

    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_music__mvt_list);

        FloatingActionButton fab = (FloatingActionButton) findViewById(R.id.fab);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                finish();
            }
        });

        Intent extraIntent = getIntent();
        username = extraIntent.getStringExtra("username");
        password = extraIntent.getStringExtra("password");

        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

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

        mySQLiteAdapter = new Music_MvtAdapter(this);
        mySQLiteAdapter.openToWrite();

        cursor = mySQLiteAdapter.getAllData(select);
        String[] from = new String[]{Music_MvtAdapter.KEY_ID, Music_MvtAdapter.KEY_CONTENT1, Music_MvtAdapter.KEY_CONTENT2, Music_MvtAdapter.KEY_CONTENT3, Music_MvtAdapter.KEY_CONTENT4};
        int[] to = new int[]{R.id.id, R.id.text1, R.id.text2, R.id.text3, R.id.text4};
        cursorAdapter =
                new SimpleCursorAdapter(this, R.layout.music_mvt_item, cursor, from, to);
        listContent.setAdapter(cursorAdapter);
        listContent.setOnItemClickListener(listContentOnItemClickListener);
        OnClickButtonListener();
    }

    private void OnClickButtonListener() {
        btneditmusicmvt = (Button)findViewById(R.id.button_editmusicmvt);
        btneditmusicmvt.setOnClickListener(
                new View.OnClickListener(){
                    @Override
                    public void onClick(View v){
                        Intent intent = new Intent("com.example.jhoang.mysqldemo.Music_MvtActivity");
                        intent.putExtra("username", username);
                        intent.putExtra("password", password);
                        startActivity(intent);
                    }
                }
        );

        btnrefresh = (Button)findViewById(R.id.refresh);
        btnrefresh.setOnClickListener(
                new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        Intent resume = getIntent();
                        resume.putExtra("username", username);
                        resume.putExtra("password", password);
                        finish();
                        startActivity(resume);
                    }
                }
        );
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        MenuInflater menuInflater = getMenuInflater();
        menuInflater.inflate(R.menu.menu_music, menu);

        return super.onCreateOptionsMenu(menu);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch(item.getItemId()) {
            case R.id.switchMain:
                Intent switchIntent = new Intent("com.example.jhoang.mysqldemo.Coordinate_BookList");
                switchIntent.putExtra("username", username);
                switchIntent.putExtra("password", password);
                startActivity(switchIntent);
                break;

            case R.id.notification:
                Intent notifyIntent = new Intent(Music_MvtList.this, RecyclerViewList.class);
                notifyIntent.putExtra("username", username);
                notifyIntent.putExtra("password", password);
                startActivity(notifyIntent);
                break;

            case R.id.logout:
                String type = "logout";
                BackgroundWorker backgroundWorker = new BackgroundWorker(this);
                backgroundWorker.execute(type, username, password);
                break;

            default:
                break;
        }
        return super.onOptionsItemSelected(item);
    }

    @Override
    public void onResume()
    {  // After a pause OR at startup
        super.onResume();
        //Refresh your stuff here
    }

    private ListView.OnItemClickListener listContentOnItemClickListener
            = new ListView.OnItemClickListener() {

        @Override
        public void onItemClick(AdapterView<?> parent, View view, int position,
                                long id) {
            // TODO Auto-generated method stub

            Cursor cursor = (Cursor) parent.getItemAtPosition(position);
            final int item_id = cursor.getInt(cursor.getColumnIndex(Music_MvtAdapter.KEY_ID));
            String item_content1 = cursor.getString(cursor.getColumnIndex(Music_MvtAdapter.KEY_CONTENT1));
            String item_content2 = cursor.getString(cursor.getColumnIndex(Music_MvtAdapter.KEY_CONTENT2));
            String item_content3 = cursor.getString(cursor.getColumnIndex(Music_MvtAdapter.KEY_CONTENT3));
            String item_content4 = cursor.getString(cursor.getColumnIndex(Music_MvtAdapter.KEY_CONTENT4));
            Intent intent = new Intent("com.example.jhoang.mysqldemo.MusicSelectionActivity");
            intent.putExtra("username", username);
            intent.putExtra("password", password);
            intent.putExtra("STRING_I_NEED",item_content1);
            intent.putExtra("STRING_I_NEED1",item_content4);
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

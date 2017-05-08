package com.example.jhoang.mysqldemo;

import android.content.Intent;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;

public class MainPageSelectionActivity extends AppCompatActivity {

    private static Button btnMusicBook;
    private static Button btnCoordinateBook;

    String username;
    String password;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main_page_selection);

        Intent extraIntent = getIntent();
        username = extraIntent.getStringExtra("username");
        password = extraIntent.getStringExtra("password");

        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        toolbar.setTitle("Main Page");
        setSupportActionBar(toolbar);
        OnClickButtonListener();

        FloatingActionButton fab = (FloatingActionButton) findViewById(R.id.fab);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                finish();
            }
        });
    }

    public void OnClickButtonListener() {

        btnMusicBook = (Button)findViewById(R.id.button_musicbook);
        btnCoordinateBook = (Button)findViewById(R.id.button_coordinatebook);

        btnMusicBook.setOnClickListener(
                new View.OnClickListener(){
                    @Override
                    public void onClick(View v){
                        Intent intent = new Intent("com.example.jhoang.mysqldemo.Music_BookList");
                        intent.putExtra("username", username);
                        intent.putExtra("password", password);
                        startActivity(intent);
                    }
                }
        );

        btnCoordinateBook.setOnClickListener(
                new View.OnClickListener(){
                    @Override
                    public void onClick(View v){
                        Intent intent = new Intent("com.example.jhoang.mysqldemo.Coordinate_BookList");
                        intent.putExtra("username", username);
                        intent.putExtra("password", password);
                        startActivity(intent);
                    }
                }
        );
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        MenuInflater menuInflater = getMenuInflater();
        menuInflater.inflate(R.menu.menu_main, menu);

        return super.onCreateOptionsMenu(menu);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch(item.getItemId()) {
            case R.id.notification:
                Intent notifyIntent = new Intent(MainPageSelectionActivity.this, RecyclerViewList.class);
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
}

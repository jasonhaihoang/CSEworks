package com.example.jhoang.mysqldemo;

import android.content.Intent;
import android.graphics.Color;
import android.os.Bundle;
import android.support.design.widget.CoordinatorLayout;
import android.support.design.widget.FloatingActionButton;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.GridLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.support.v7.widget.Toolbar;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;

import java.util.ArrayList;

public class MusicSelectionActivity extends AppCompatActivity {

    GalleryAdapter mAdapter;
    RecyclerView mRecyclerView;

    ArrayList<ImageModel> data = new ArrayList<>();

    public static String IMGS[] = {
            "http://novaelite4901.com/Mello2Mvt1.jpg?q=80&fm=jpg&w=1080&fit=max&s=4b703b77b42e067f949d14581f35019b",
            "http://novaelite4901.com/Mello2Mvt2.jpg?dpr=2&fit=crop&fm=jpg&h=725&q=50&w=1300",
            "http://novaelite4901.com/Mello2Mvt3.jpg?q=80&fm=jpg&w=1080&fit=max&s=80cb5dbcf01265bb81c5e8380e4f5cc1",
            "http://novaelite4901.com/Mello2Mvt4.1.jpg?dpr=2&fit=crop&fm=jpg&h=725&q=50&w=1300",
            "http://novaelite4901.com/Mello2Mvt4.2.jpg?dpr=2&fit=crop&fm=jpg&h=725&q=50&w=1300",
            "http://novaelite4901.com/Mello2Mvt5.1.jpg?dpr=2&fit=crop&fm=jpg&h=725&q=50&w=1300",
            "http://novaelite4901.com/Mello2Mvt5.2.jpg?dpr=2&fit=crop&fm=jpg&h=725&q=50&w=1300",
    };

    String username;
    String password;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_music_selection);

        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        CoordinatorLayout bgElement = (CoordinatorLayout) findViewById(R.id.music_sheet);
        bgElement.setBackgroundColor(Color.BLACK);

        Intent extraIntent = getIntent();
        username = extraIntent.getStringExtra("username");
        password = extraIntent.getStringExtra("password");

        for (int i = 0; i < IMGS.length; i++) {

            ImageModel imageModel = new ImageModel();
            imageModel.setName("Image " + i);
            imageModel.setUrl(IMGS[i]);
            data.add(imageModel);

        }

        mRecyclerView = (RecyclerView) findViewById(R.id.list);
        mRecyclerView.setLayoutManager(new GridLayoutManager(this, 3));
        mRecyclerView.setHasFixedSize(true);

        mAdapter = new GalleryAdapter(MusicSelectionActivity.this, data);
        mRecyclerView.setAdapter(mAdapter);

        mRecyclerView.addOnItemTouchListener(new RecyclerItemClickListener(this,
                new RecyclerItemClickListener.OnItemClickListener() {

                    @Override
                    public void onItemClick(View view, int position) {

                        Intent intent = new Intent(MusicSelectionActivity.this, DetailActivity.class);
                        intent.putExtra("username", username);
                        intent.putExtra("password", password);
                        intent.putParcelableArrayListExtra("data", data);
                        intent.putExtra("pos", position);
                        startActivity(intent);
                    }
                }));

        FloatingActionButton fab = (FloatingActionButton) findViewById(R.id.fab);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                finish();
            }
        });
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
                Intent notifyIntent = new Intent(MusicSelectionActivity.this, RecyclerViewList.class);
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
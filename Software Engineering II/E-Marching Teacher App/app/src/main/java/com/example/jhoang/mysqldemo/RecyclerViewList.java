package com.example.jhoang.mysqldemo;

import android.content.Intent;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.v7.app.AppCompatActivity;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;

public class RecyclerViewList extends AppCompatActivity {

    String username;
    String password;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_recycler_view_list);

        Intent extraIntent = getIntent();
        username = extraIntent.getStringExtra("username");
        password = extraIntent.getStringExtra("password");

        BackgroundRVTask backgroundRVTask = new BackgroundRVTask(this);
        backgroundRVTask.execute(username,password);

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
        menuInflater.inflate(R.menu.menu_main, menu);

        return super.onCreateOptionsMenu(menu);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case R.id.notification:
                Intent notifyIntent = new Intent(RecyclerViewList.this, RecyclerViewList.class);
                notifyIntent.putExtra("username", username);
                notifyIntent.putExtra("password", password);
                startActivity(notifyIntent);
                break;

            case R.id.notificationSend:
                Intent notifySend = new Intent("com.example.jhoang.mysqldemo.NotificationActivity");
                notifySend.putExtra("username", username);
                notifySend.putExtra("password", password);
                startActivity(notifySend);
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
}

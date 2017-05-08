package com.example.jhoang.mysqldemo;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.widget.EditText;
import android.widget.ListView;

public class NotificationActivity extends AppCompatActivity {
    EditText MessageEt;
    String username;
    String password;
    ListView lv;
    Context context;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_notification);

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

        MessageEt = (EditText)findViewById(R.id.etMessage);
    }

    public void OnNotify(View view){
        String message = MessageEt.getText().toString();
        String type = "send";
        BackgroundNotify backgroundNotify = new BackgroundNotify(this);
        backgroundNotify.execute(type, username, password, message);
    }
}

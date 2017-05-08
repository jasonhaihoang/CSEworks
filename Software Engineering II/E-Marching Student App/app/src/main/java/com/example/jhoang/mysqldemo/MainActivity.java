package com.example.jhoang.mysqldemo;

import android.os.Bundle;
import android.support.v4.app.NotificationCompat;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.widget.EditText;


public class MainActivity extends AppCompatActivity {

    EditText UsernameEt, PasswordEt;
    NotificationCompat.Builder notification;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        toolbar.setTitle("E-Marching Band Student");
        setSupportActionBar(toolbar);

        UsernameEt = (EditText)findViewById(R.id.etUsername);
        PasswordEt = (EditText)findViewById(R.id.etPassword);

        notification = new NotificationCompat.Builder(this);
        notification.setAutoCancel(true);

    }

    public void OnLogin(View view){
        String username = UsernameEt.getText().toString();
        String password = PasswordEt.getText().toString();
        String type = "login";
        BackgroundWorker backgroundWorker = new BackgroundWorker(this);
        backgroundWorker.execute(type, username, password);
    }
}

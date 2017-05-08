package com.example.jhoang.mysqldemo;

import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ListView;

public class ListNotifyActivity extends AppCompatActivity {

    ListView lv;
    String[] names = {"Jason", "Alex", "Tim"};

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_list_notify);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        FloatingActionButton fab = (FloatingActionButton) findViewById(R.id.fab);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                finish();
            }
        });

        lv = (ListView) findViewById(R.id.lvNotifications);
        lv.setAdapter(new ArrayAdapter<>(ListNotifyActivity.this, android.R.layout.simple_list_item_1, names));

        lv = (ListView) findViewById(R.id.lvStaff);
        lv.setAdapter(new ArrayAdapter<>(ListNotifyActivity.this, android.R.layout.simple_list_item_1, names));
    }

}

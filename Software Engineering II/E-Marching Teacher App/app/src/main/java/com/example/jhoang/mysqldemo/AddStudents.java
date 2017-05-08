package com.example.jhoang.mysqldemo;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.v7.app.AppCompatActivity;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.widget.EditText;

public class AddStudents extends AppCompatActivity {
    EditText NameET, UsernameET, PasswordET, InstrumentET, ClassET, FieldNumET;
    String username;
    String password;

    Context context;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_add_students);

        Intent extraIntent = getIntent();
        username = extraIntent.getStringExtra("username");
        password = extraIntent.getStringExtra("password");

        NameET = (EditText)findViewById(R.id.etName);
        UsernameET = (EditText)findViewById(R.id.etUsername);
        PasswordET = (EditText)findViewById(R.id.etPassword);
        InstrumentET = (EditText)findViewById(R.id.etInstrument);
        ClassET = (EditText)findViewById(R.id.etCLass);
        FieldNumET = (EditText)findViewById(R.id.etFieldNumber);

        FloatingActionButton fab = (FloatingActionButton) findViewById(R.id.fab);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                finish();
            }
        });
    }

    public void OnAddStudent(View view){
        String NameETstring = NameET.getText().toString();
        String UsernameETstring = UsernameET.getText().toString();
        String PasswordETstring = PasswordET.getText().toString();
        String InstrumentETstring = InstrumentET.getText().toString();
        String ClassETstring = ClassET.getText().toString();
        String FieldNumETstring = FieldNumET.getText().toString();

        String type = "add";
        AddStudentsBackground addStudentsBackground = new AddStudentsBackground(this);
        addStudentsBackground.execute(type,username,password, NameETstring, UsernameETstring, PasswordETstring, InstrumentETstring, ClassETstring, FieldNumETstring);
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
                Intent notifyIntent = new Intent(AddStudents.this, RecyclerViewList.class);
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

}

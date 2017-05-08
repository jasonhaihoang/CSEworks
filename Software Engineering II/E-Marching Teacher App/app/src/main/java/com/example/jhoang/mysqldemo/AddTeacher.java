package com.example.jhoang.mysqldemo;

import android.content.Context;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.EditText;

public class AddTeacher extends AppCompatActivity {
    EditText NameET, PasswordET;

    Context context;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_add_teacher);

        NameET = (EditText)findViewById(R.id.etNameTeacher);
        PasswordET = (EditText)findViewById(R.id.etPasswordTeacher);

        FloatingActionButton fab = (FloatingActionButton) findViewById(R.id.fab);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                finish();
            }
        });
    }

    public void OnAddTeacher(View view){
        String NameETstring = NameET.getText().toString();
        String PasswordETstring = PasswordET.getText().toString();

        String type = "add";
        AddTeacherBackground addTeacherBackground = new AddTeacherBackground(this);
        addTeacherBackground.execute(type, NameETstring, PasswordETstring);
    }

}

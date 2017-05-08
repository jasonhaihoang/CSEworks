package com.example.jhoang.mysqldemo;

import android.app.AlertDialog;
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
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

public class Coordinate_BookActivity extends AppCompatActivity {

    Coordinate_BookDatabaseHelper myDb;
    EditText  editShowId,editShowName,editNumSets;
    Button btnAddData;
    Button btnviewAll;
    Button btnDelete;

    Button btnviewUpdate;
    String username;
    String password;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_coordinate__book);

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

        myDb = new Coordinate_BookDatabaseHelper(this);

        editShowId = (EditText)findViewById(R.id.editText_ShowId);
        editShowName = (EditText)findViewById(R.id.editText_ShowName);
        editNumSets = (EditText)findViewById(R.id.editText_NumSets);
        btnAddData = (Button)findViewById(R.id.button_add);
        btnviewAll = (Button)findViewById(R.id.button_viewAll);
        btnviewUpdate= (Button)findViewById(R.id.button_update);
        btnDelete= (Button)findViewById(R.id.button_delete);
        AddData();
        viewAll();
        UpdateData();
        DeleteData();
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        MenuInflater menuInflater = getMenuInflater();
        menuInflater.inflate(R.menu.menu_coordinate, menu);

        return super.onCreateOptionsMenu(menu);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch(item.getItemId()) {
            case R.id.switchMain:
                Intent switchIntent = new Intent("com.example.jhoang.mysqldemo.Music_BookList");
                switchIntent.putExtra("username", username);
                switchIntent.putExtra("password", password);
                startActivity(switchIntent);
                break;

            case R.id.notification:
                Intent notifyIntent = new Intent(Coordinate_BookActivity.this, RecyclerViewList.class);
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

    public void DeleteData(){
        btnDelete.setOnClickListener(
                new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        Integer deletedRows = myDb.deleteData(editShowId.getText().toString());
                        if(deletedRows > 0)
                            Toast.makeText(Coordinate_BookActivity.this, "Data Deleted", Toast.LENGTH_LONG).show();
                        else
                            Toast.makeText(Coordinate_BookActivity.this, "Data not Deleted", Toast.LENGTH_LONG).show();
                    }
                }
        );
    }

    public void UpdateData() {
        btnviewUpdate.setOnClickListener(
                new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        boolean isUpdate = myDb.updateData(editShowId.getText().toString(),
                                editShowName.getText().toString(), editNumSets.getText().toString()
                        );
                        if (isUpdate == true)
                            Toast.makeText(Coordinate_BookActivity.this, "Data Update", Toast.LENGTH_LONG).show();
                        else
                            Toast.makeText(Coordinate_BookActivity.this, "Data not Updated", Toast.LENGTH_LONG).show();
                    }
                }
        );
    }
    public  void AddData() {
        btnAddData.setOnClickListener(
                new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        boolean isInserted = myDb.insertData(
                                editShowId.getText().toString(),
                                editShowName.getText().toString(),
                                editNumSets.getText().toString()
                        );
                        if (isInserted == true)
                            Toast.makeText(Coordinate_BookActivity.this, "Data Inserted", Toast.LENGTH_LONG).show();
                        else
                            Toast.makeText(Coordinate_BookActivity.this, "Data not Inserted", Toast.LENGTH_LONG).show();
                    }
                }
        );
    }

    public void viewAll() {
        btnviewAll.setOnClickListener(
                new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        Cursor res = myDb.getAllData();
                        if (res.getCount() == 0) {
                            // show message
                            showMessage("Error", "Nothing found");
                            return;
                        }

                        StringBuffer buffer = new StringBuffer();
                        while (res.moveToNext()) {
                            buffer.append("Show ID :" + res.getString(1) + "\n");
                            buffer.append("Show Name :" + res.getString(2) + "\n");
                            buffer.append("Number of Sets :" + res.getString(3) + "\n\n");
                        }

                        // Show all data
                        showMessage("Data", buffer.toString());
                    }
                }
        );
    }

    public void showMessage(String title,String Message){
        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setCancelable(true);
        builder.setTitle(title);
        builder.setMessage(Message);
        builder.show();
    }

}

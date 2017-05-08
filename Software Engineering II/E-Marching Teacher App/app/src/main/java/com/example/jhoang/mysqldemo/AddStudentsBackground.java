package com.example.jhoang.mysqldemo;

import android.content.Context;
import android.os.AsyncTask;
import android.widget.Toast;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;

public class AddStudentsBackground extends AsyncTask<String,Void,String> {

    String username;
    String password;
    String studentID;
    String name;
    String usernamenew;
    String passwordnew;
    String instrument;
    String classes;
    String fieldNum;

    Context context;
    AddStudentsBackground(Context ctx){
        context = ctx;
    }

    @Override
    protected String doInBackground(String... params) {
        String type = params[0];
        String login_url = "http://novaelite4901.com/addStudents.php";
        if(type.equals("add")){
            try {
                username = params[1];
                password = params[2];
                name = params[3];
                usernamenew = params[4];
                passwordnew = params[5];
                instrument = params[6];
                classes = params[7];
                fieldNum = params[8];

                URL url = new URL(login_url);
                HttpURLConnection httpURLConnection = (HttpURLConnection)url.openConnection();
                httpURLConnection.setRequestMethod("POST");
                httpURLConnection.setDoOutput(true);
                httpURLConnection.setDoInput(true);
                OutputStream outputStream = httpURLConnection.getOutputStream();
                BufferedWriter bufferedWriter = new BufferedWriter(new OutputStreamWriter(outputStream,"UTF-8"));
                String post_data = (
                        URLEncoder.encode("username","UTF-8")+"="+URLEncoder.encode(username,"UTF-8")+"&"+
                        URLEncoder.encode("password","UTF-8")+"="+URLEncoder.encode(password,"UTF-8")+"&"+
                        URLEncoder.encode("name","UTF-8")+"="+URLEncoder.encode(name,"UTF-8")+"&"+
                        URLEncoder.encode("usernamenew","UTF-8")+"="+URLEncoder.encode(usernamenew,"UTF-8")+"&"+
                        URLEncoder.encode("passwordnew","UTF-8")+"="+URLEncoder.encode(passwordnew,"UTF-8")+"&"+
                        URLEncoder.encode("instrument","UTF-8")+"="+URLEncoder.encode(instrument,"UTF-8")+"&"+
                        URLEncoder.encode("classes","UTF-8")+"="+URLEncoder.encode(classes,"UTF-8")+"&"+
                        URLEncoder.encode("fieldNum","UTF-8")+"="+URLEncoder.encode(fieldNum,"UTF-8"));
                bufferedWriter.write(post_data);
                bufferedWriter.flush();
                bufferedWriter.close();
                outputStream.close();
                InputStream inputStream = httpURLConnection.getInputStream();
                BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(inputStream, "iso-8859-1"));
                String result="";
                String line;
                while ((line = bufferedReader.readLine()) != null){
                    result += line;
                }
                bufferedReader.close();
                inputStream.close();
                httpURLConnection.disconnect();
                return result;
            } catch (MalformedURLException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    @Override
    protected void onPreExecute() {
        super.onPreExecute();
    }

    @Override
    protected void onPostExecute(String result) {
        Toast.makeText(context,result,Toast.LENGTH_LONG).show();
    }

    @Override
    protected void onProgressUpdate(Void... values) {
        super.onProgressUpdate(values);
    }
}

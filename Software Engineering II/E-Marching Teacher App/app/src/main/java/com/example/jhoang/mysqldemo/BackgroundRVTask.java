package com.example.jhoang.mysqldemo;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Context;
import android.os.AsyncTask;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;

public class BackgroundRVTask extends AsyncTask<String, Messages, Void> {
    Context ctx;
    Activity activity;
    String username;
    String password;
    String json_string = "http://novaelite4901.com/getMyNotes.php";

    RecyclerView recyclerView;
    RecyclerView.Adapter adapter;
    RecyclerView.LayoutManager layoutManager;
    ArrayList<Messages> arrayList = new ArrayList<>();
    ProgressDialog progressDialog;

    public BackgroundRVTask(Context ctx)
    {
        this.ctx = ctx;
        activity = (Activity)ctx;
    }

    @Override
    protected void onPreExecute() {
        recyclerView = (RecyclerView)activity.findViewById(R.id.recyclerView);
        layoutManager = new LinearLayoutManager(ctx);
        recyclerView.setLayoutManager(layoutManager);
        recyclerView.setHasFixedSize(true);
        adapter = new RecyclerAdapter(arrayList);
        recyclerView.setAdapter(adapter);
        progressDialog = new ProgressDialog(ctx);
        progressDialog.setTitle("Please Wait...");
        progressDialog.setMessage("List is Loading...");
        progressDialog.setIndeterminate(true);
        progressDialog.setCancelable(false);
        progressDialog.show();
    }

    @Override
    protected Void doInBackground(String... params) {
        try {
            username = params[0];
            password = params[1];
            URL url = new URL(json_string);
            HttpURLConnection httpURLConnection = (HttpURLConnection) url.openConnection();
            InputStream inputStream = httpURLConnection.getInputStream();
            BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(inputStream));
            StringBuilder stringBuilder = new StringBuilder();
            String line;
            while((line=bufferedReader.readLine()) != null)
            {
                stringBuilder.append(line+"\n");
            }
            httpURLConnection.disconnect();
            String json_string = stringBuilder.toString().trim();
            JSONObject jsonObject = new JSONObject(json_string);
            JSONArray jsonArray = jsonObject.getJSONArray("server_response");
            int count = 0;
            while (count < jsonArray.length())
            {
                JSONObject JO = jsonArray.getJSONObject(count);
                count++;
                Messages messages = new Messages(JO.getString("nameTeacher"), JO.getString("msg"));
                publishProgress(messages);
                Thread.sleep(50);
            }

            Log.d("JSON STRING",json_string);

        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (JSONException e) {
            e.printStackTrace();
        }catch (InterruptedException e) {
            e.printStackTrace();
        }


        return null;
    }

    @Override
    protected void onProgressUpdate(Messages... values) {
        arrayList.add(values[0]);
        adapter.notifyDataSetChanged();
    }

    @Override
    protected void onPostExecute(Void aVoid) {
        progressDialog.dismiss();
    }
}

package com.example.jhoang.mysqldemo;

import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import java.util.ArrayList;

public class RecyclerAdapterStudentsList extends RecyclerView.Adapter <RecyclerAdapterStudentsList.RecyclerViewHolder>{

    private static final int TYPE_HEAD = 0;
    private static final int TYPE_LIST = 1;
    ArrayList<MessagesStudentsList> arrayListStudent = new ArrayList<>();
    public RecyclerAdapterStudentsList(ArrayList<MessagesStudentsList> arrayList)
    {
        this.arrayListStudent = arrayList;
    }

    @Override
    public RecyclerViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {

        if(viewType == TYPE_HEAD)
        {
            View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.header_layout_student_list,parent,false);
            RecyclerViewHolder recyclerViewHolder = new RecyclerViewHolder(view,viewType);
            return recyclerViewHolder;
        }
        else if (viewType == TYPE_LIST)
        {
            View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.row_layout_student,parent,false);
            RecyclerViewHolder recyclerViewHolder = new RecyclerViewHolder(view,viewType);
            return recyclerViewHolder;
        }
        return null;
    }

    @Override
    public void onBindViewHolder(RecyclerViewHolder holder, int position) {

        if (holder.viewType == TYPE_LIST)
        {
            MessagesStudentsList messagesStudentsList = arrayListStudent.get(position-1);
            holder.Name.setText(messagesStudentsList.getName());
            holder.FieldNum.setText(Integer.toString(messagesStudentsList.getFieldNum()));
            holder.Instrument.setText(messagesStudentsList.getInstrument());
        }
    }

    @Override
    public int getItemCount() {
        return arrayListStudent.size()+1;
    }

    public static class RecyclerViewHolder extends RecyclerView.ViewHolder
    {
        TextView Name,FieldNum,Instrument;
        int viewType;
        public RecyclerViewHolder(View view, int viewType)
        {
            super(view);
            if(viewType == TYPE_LIST)
            {
                Name = (TextView)view.findViewById(R.id.name);
                FieldNum = (TextView)view.findViewById(R.id.FieldNum);
                Instrument = (TextView)view.findViewById(R.id.instrument);
                this.viewType = TYPE_LIST;
            }
            else if (viewType == TYPE_HEAD)
            {
                this.viewType = TYPE_HEAD;
            }
        }
    }

    @Override
    public int getItemViewType(int position) {
        if (position == 0)
        {
            return TYPE_HEAD;
        }
        else
        {
            return  TYPE_LIST;
        }
    }
}

package com.tkucar.dz2.ui.contact;

import androidx.lifecycle.LiveData;
import androidx.lifecycle.MutableLiveData;
import androidx.lifecycle.ViewModel;

public class ContactViewModel extends ViewModel {

    private MutableLiveData<String> mText;

    public ContactViewModel() {
        mText = new MutableLiveData<>();
        mText.setValue("Our contact.");
    }

    public LiveData<String> getText() {
        return mText;
    }
}
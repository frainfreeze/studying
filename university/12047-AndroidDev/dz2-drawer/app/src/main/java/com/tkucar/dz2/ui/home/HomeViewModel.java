package com.tkucar.dz2.ui.home;

import androidx.lifecycle.LiveData;
import androidx.lifecycle.MutableLiveData;
import androidx.lifecycle.ViewModel;

public class HomeViewModel extends ViewModel {

    private MutableLiveData<String> mText;

    public HomeViewModel() {
        mText = new MutableLiveData<>();
        mText.setValue("NavDrawer template app. To extend add fragment in layout, register it menu and navigation xml files and add appropriate fragment and viewmodel code.");
    }

    public LiveData<String> getText() {
        return mText;
    }
}
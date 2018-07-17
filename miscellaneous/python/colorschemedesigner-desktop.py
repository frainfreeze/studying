#---License---
#This is free and unencumbered software released into the public domain.

#Anyone is free to copy, modify, publish, use, compile, sell, or
#distribute this software, either in source code form or as a compiled
#binary, for any purpose, commercial or non-commercial, and by any
#means.

#---Description---
#Small browser that loads given url. In this case it loads ColorShemeDesigner
#requires min. wxpthon 2.9

#---code---
import wx
import wx.html2

class MyBrowser(wx.Dialog):
    def __init__(self, *args, **kwds):
       wx.Dialog.__init__(self, *args, **kwds)
       sizer = wx.BoxSizer(wx.VERTICAL)
       self.browser = wx.html2.WebView.New(self)
       sizer.Add(self.browser, 1, wx.EXPAND, 10)
       self.SetSizer(sizer)
       self.SetSize((1200, 700))

if __name__ == '__main__':
    app = wx.App()
    dialog = MyBrowser(None, -1)
    dialog.browser.LoadURL("http://colorschemedesigner.com/csd-3.5/")
    dialog.Show()
    app.MainLoop()

import std.stdio;

import ui;

Window win;

void main()
{
    win = new Window;
    win.show;
    win.addOnClosing(delegate(Window w) {
            App.quit;
        });
    App.run;
}

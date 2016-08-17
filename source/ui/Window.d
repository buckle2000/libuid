module ui.Window;

import ui.Control;

import std.typecons: Tuple;

class Window : Control {
private:
    void delegate(Window w)[] onPositionChangedListeners;
    void delegate(Window w)[] onContentSizeChangedListeners;
    void delegate(Window w)[] onClosingListeners;
    
    extern (C)
    static void onPositionChangedCallBack(uiWindow *, void *data) {
        auto w = cast(Window) data;
        foreach (dlg; w.onPositionChangedListeners) {
            dlg(w);
        }
    }
    
    extern (C)
    static void onContentSizeChangedCallBack(uiWindow *, void *data) {
        auto w = cast(Window) data;
        foreach (dlg; w.onContentSizeChangedListeners) {
            dlg(w);
        }
    }
    
    extern (C)
    static int onClosingCallBack(uiWindow *, void *data) {
        auto w = cast(Window) data;
        foreach (dlg; w.onClosingListeners) {
            dlg(w);
        }
        return 1;
    }

public:
    final uiWindow * convertToWindow() {
        return cast(uiWindow *) _data;
    }
    alias convertToWindow this;

    this(string title = "", int width = 400, int height = 300, bool hasMenubar = false) {
        super(uiNewWindow(title.ptr, width, height, cast(int) hasMenubar));

        uiWindowOnPositionChanged(this, &onPositionChangedCallBack, cast(void*) this);
        uiWindowOnContentSizeChanged(this, &onContentSizeChangedCallBack, cast(void*) this);
        uiWindowOnClosing(this, &onClosingCallBack, cast(void *) this);
    }

    string title() {
        auto c = uiWindowTitle(this);
        import core.stdc.string: strlen;
        auto s = c[0..strlen(c)].idup;
        import ui.Def: uiFreeText;
        uiFreeText(c);
        return s;
    }

    Window setTitle(string title) {
        uiWindowSetTitle(this, title.ptr);
        return this;
    }

    auto position() {
        auto pos = Tuple!(int, "x", int, "y")();
        uiWindowPosition(this, &pos.x, &pos.y);
        return pos;
    }

    Window setPosition(int x, int y) {
        uiWindowSetPosition(this, x, y);
        return this;
    }

    Window center() {
        uiWindowCenter(this);
        return this;
    }

    Window addOnPositionChanged(void delegate(Window w) f) {
        onPositionChangedListeners ~= f;
        return this;
    }

    auto contentSize() {
        auto size = Tuple!(int, "width", int, "height")();
        uiWindowContentSize(this, &size.width, &size.height);
        return size;
    }

    Window setContentSize(int width, int height) {
        uiWindowSetContentSize(this, width, height);
        return this;
    }

    bool fullScreen() {
        return cast(bool) uiWindowFullscreen(this);
    }

    Window setFullScreen(bool fullscreen) {
        uiWindowSetFullscreen(this, cast(int) fullscreen);
        return this;
    }
    
    Window addOnContentSizeChanged(void delegate(Window w) f) {
        onContentSizeChangedListeners ~= f;
        return this;
    }
    
    Window addOnClosing(void delegate(Window w) f) {
        onClosingListeners ~= f;
        import std.stdio: writeln;
        onClosingListeners.writeln;
        return this;
    }

    bool borderless() {
        return cast(bool) uiWindowBorderless(this);
    }

    Window setBorderless(bool borderless) {
        uiWindowSetBorderless(this, cast(int) borderless);
        return this;
    }

    Window setChild(Control child) {
        uiWindowSetChild(this, child);
        return this;
    }

    bool margined() {
        return cast(bool) uiWindowMargined(this);
    }

    Window setMargined(bool margined) {
        uiWindowSetMargined(this, cast(int) margined);
        return this;
    }
}

package:
extern(C):
struct uiWindow;
char *uiWindowTitle(uiWindow *w);
void uiWindowSetTitle(uiWindow *w, const(char) *title);
void uiWindowPosition(uiWindow *w, int *x, int *y);
void uiWindowSetPosition(uiWindow *w, int x, int y);
void uiWindowCenter(uiWindow *w);
void uiWindowOnPositionChanged(uiWindow *w, void function(uiWindow *, void *) f, void *data);
void uiWindowContentSize(uiWindow *w, int *width, int *height);
void uiWindowSetContentSize(uiWindow *w, int width, int height);
int uiWindowFullscreen(uiWindow *w);
void uiWindowSetFullscreen(uiWindow *w, int fullscreen);
void uiWindowOnContentSizeChanged(uiWindow *w, void function(uiWindow *, void *) f, void *data);
void uiWindowOnClosing(uiWindow *w, int function(uiWindow *w, void *data) f, void *data);
int uiWindowBorderless(uiWindow *w);
void uiWindowSetBorderless(uiWindow *w, int borderless);
void uiWindowSetChild(uiWindow *w, uiControl *child);
int uiWindowMargined(uiWindow *w);
void uiWindowSetMargined(uiWindow *w, int margined);
uiWindow *uiNewWindow(const(char) *title, int width, int height, int hasMenubar);
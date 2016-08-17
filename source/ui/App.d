module ui.App;

class App {
private:
    static void delegate()[] queueMainListeners;
    static void delegate()[] onShouldQuitListeners;

    extern (C)
    static void queueMainCallBack(void *data) {
        foreach (dlg; queueMainListeners) {
            dlg();
        }
    }

    extern (C)
    static int onShouldQuitCallBack(void *data) {
        foreach (dlg; onShouldQuitListeners) {
            dlg();
        }
        return 1;
    }

public:
    static this() {
        auto io = uiInitOptions();
        auto msg = uiInit(&io);
        if (msg) {
            scope(exit) uiFreeInitError(msg);
            import core.stdc.string: strlen;
            assert(false, "libui init error: " ~ msg[0..strlen(msg)]);
        }

        uiQueueMain(&queueMainCallBack, null);
        uiOnShouldQuit(&onShouldQuitCallBack, null);
    }
    
    static ~this() {
        uiUninit;
    }

    static void run() {
        uiMain;
    }

    static void quit() {
        uiQuit;
    }

    static bool step(bool wait) {
        uiMainSteps;
        return cast(bool) uiMainStep(cast(int) wait);
    }

    static void addToQueue(void delegate() f) {
        queueMainListeners ~= f;
    }
    
    static void addOnShouldQuit(void delegate() f) {
        onShouldQuitListeners ~= f;
    }
}

package:
extern(C):

struct uiInitOptions {
    size_t Size;
};

const(char) *uiInit(uiInitOptions *options);
void uiUninit();
void uiFreeInitError(const(char) *err);

void uiMain();
void uiMainSteps();
int uiMainStep(int wait);
void uiQuit();

void uiQueueMain(void function(void *data) f, void *data);

void uiOnShouldQuit(int function(void *data) f, void *data);
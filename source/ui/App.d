module ui.App;

import ui.Core;

class App {
    mixin EventListenerMixin!("QueueMain", NoneTypeTag);
    mixin EventListenerMixin!("OnShouldQuit", NoneTypeTag, int);

    static this() {
        auto io = uiInitOptions();
        auto msg = uiInit(&io);
        if (msg) {
            scope(exit) uiFreeInitError(msg);
            import core.stdc.string: strlen;
            assert(false, "libui init error: " ~ msg[0..strlen(msg)]);
        }

        uiQueueMain(&QueueMainCallback, null);
        uiOnShouldQuit(&OnShouldQuitCallback, null);
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
}

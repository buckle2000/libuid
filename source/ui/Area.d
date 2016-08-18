module ui.Area;

import ui.Core;

class Area {
    protected uiAreaHandler * _handler;
    protected uiArea * _area;

    private void delegate(Area a)[] DrawListeners;
    private extern(C) static {
        void DrawCallback(uiAreaHandler *ah, uiArea *a, uiAreaDrawParams *p) {
        }
        void MouseEventCallback(uiAreaHandler *ah, uiArea *a, uiAreaMouseEvent *e) {
        }
        void MouseCrossedCallback(uiAreaHandler *ah, uiArea *a, int left) {
        }
        void DragBrokenCallback(uiAreaHandler *ah, uiArea *a) {
        }
        int KeyEventCallback(uiAreaHandler *ah, uiArea *a, uiAreaKeyEvent *e) {
            return 1;
        }
    }

    this() {
        _handler = new uiAreaHandler();
        _handler.Draw = &DrawCallback;
        _handler.MouseEvent = &MouseEventCallback;
        _handler.MouseCrossed = &MouseCrossedCallback;
        _handler.DragBroken = &DragBrokenCallback;
        _handler.KeyEvent = &KeyEventCallback;
    }
}
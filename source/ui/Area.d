module ui.Area;

import ui.Control;

class Area : Control {
    protected uiAreaHandler * _handler;
    protected uiArea * _area;

    private {
        void initHandler() {
            _handler = new uiAreaHandler();
            _handler.Draw = &DrawCallback;
            _handler.MouseEvent = &MouseEventCallback;
            _handler.MouseCrossed = &MouseCrossedCallback;
            _handler.DragBroken = &DragBrokenCallback;
            _handler.KeyEvent = &KeyEventCallback;
        }

        static Area[uiArea*] _areaMap;
        void delegate(Area a, DrawParams params)[] DrawListeners;
        void delegate(Area a, MouseEvent event)[] MouseEventListeners;
        void delegate(Area a, int left)[] MouseCrossedListeners;
        void delegate(Area a)[] DragBrokenListeners;
        void delegate(Area a, KeyEvent event)[] KeyEventListeners;

        extern(C) static {
            void DrawCallback(uiAreaHandler *ah, uiArea *a, uiAreaDrawParams *p) {
                auto area = _areaMap[a];
                foreach (dlg; area.DrawListeners) {
                    dlg(area, DrawParams(p));
                }
            }
            void MouseEventCallback(uiAreaHandler *ah, uiArea *a, uiAreaMouseEvent *e) {
                auto area = _areaMap[a];
                foreach (dlg; area.MouseEventListeners) {
                    dlg(area, MouseEvent(e));
                }
            }
            void MouseCrossedCallback(uiAreaHandler *ah, uiArea *a, int left) {
                auto area = _areaMap[a];
                foreach (dlg; area.MouseCrossedListeners) {
                    dlg(area, left);
                }
            }
            void DragBrokenCallback(uiAreaHandler *ah, uiArea *a) {
                auto area = _areaMap[a];
                foreach (dlg; area.DragBrokenListeners) {
                    dlg(area);
                }
            }
            int KeyEventCallback(uiAreaHandler *ah, uiArea *a, uiAreaKeyEvent *e) {
                auto area = _areaMap[a];
                foreach (dlg; area.KeyEventListeners) {
                    dlg(area, KeyEvent(e));
                }
                return 1;
            }
        }
    }

    public {
        Area addDraw(void delegate(Area a, DrawParams params) f) {
            DrawListeners ~= f;
            return this;
        }
        Area addMouseEvent(void delegate(Area a, MouseEvent event) f) {
            MouseEventListeners ~= f;
            return this;
        }
        Area addMouseCrossed(void delegate(Area a, int left) f) {
            MouseCrossedListeners ~= f;
            return this;
        }
        Area addDragBroken(void delegate(Area a) f) {
            DragBrokenListeners ~= f;
            return this;
        }
        Area addKeyEvent(void delegate(Area a, KeyEvent event) f) {
            KeyEventListeners ~= f;
            return this;
        }
    }

    this(int width = 100, int height = 100, bool scrolling = false) {
        super(cast(uiControl *) _area);
        initHandler;
        if (scrolling) {
            _area = uiNewArea(_handler);
            setSize(width, height);
        } else {
            _area = uiNewScrollingArea(_handler, width, height);
        }
        _areaMap[_area] = this;
    }

    Area setSize(int width, int height) {
        uiAreaSetSize(_area, width, height);
        return this;
    }

    Area queueRedrawAll() {
        uiAreaQueueRedrawAll(_area);
        return this;
    }

    Area scrollTo(double x, double y, double width, double height) {
        uiAreaScrollTo(_area, x, y, width, height);
        return this;
    }
}

private:

struct DrawParams {
    private uiAreaDrawParams * _params;

    @property pragma(inline, true) {
        auto context() {
            import ui.Draw: Context;
            return Context(_params.Context);
        }

        double areaWidth() {
            return _params.AreaWidth;
        }
        double areaHeight() {
            return _params.AreaHeight;
        }

        double clipX() {
            return _params.ClipX;
        }
        double clipY() {
            return _params.ClipY;
        }
        double clipWidth() {
            return _params.ClipWidth;
        }
        double clipHeight() {
            return _params.ClipHeight;
        }
    }

    this(uiAreaDrawParams * params) {
        _params = params;
    }
}

struct MouseEvent {
    private uiAreaMouseEvent * _event;

    @property pragma(inline, true) {
        double x() {
            return _event.X;
        }
        double y() {
            return _event.Y;
        }

        double areaWidth() {
            return _event.AreaWidth;
        }
        double areaHeight() {
            return _event.AreaHeight;
        }

        int down() {
            return _event.Down;
        }
        int up() {
            return _event.Up;
        }

        int count() {
            return _event.Count;
        }

        ModifiersT modifiers() {
            return _event.Modifiers;
        }

        import core.stdc.stdint: uint64_t;
        uint64_t held1to64() {
            return _event.Held1To64;
        }
    }

    this(uiAreaMouseEvent * event) {
        _event = event;
    }
}

struct KeyEvent {
    private uiAreaKeyEvent * _event;

    @property pragma(inline, true) {
        char key() {
            return _event.Key;
        }
        ExtKeyT extKey() {
            return _event.ExtKey;
        }
        ModifiersT modifier() {
            return _event.Modifier;
        }

        ModifiersT modifiers() {
            return _event.Modifiers;
        }

        int up() {
            return _event.Up;
        }
    }

    this(uiAreaKeyEvent * event) {
        _event = event;
    }
}

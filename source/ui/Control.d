module ui.Control;

class Control {
    protected void * _data;
    
    final uiControl * convertToControl() {
        return cast(uiControl *) _data;
    }
    alias convertToControl this;

    protected this(void *other) {
        this._data = other;
    }

    ~this() {
        uiControlDestroy(this);
    }

    uintptr_t handle() {
        return uiControlHandle(this);
    }

    Control parent() {
        return new Control(uiControlParent(this));
    }

    Control setParent(Control other) {
        uiControlSetParent(this, other);
        return this;
    }

    bool topLevel() {
        return cast(bool) uiControlToplevel(this);
    }

    bool visible() {
        return cast(bool) uiControlVisible(this);
    }

    Control show() {
        uiControlShow(this);
        return this;
    }

    Control hide() {
        uiControlHide(this);
        return this;
    }

    bool enabled() {
        return cast(bool) uiControlEnabled(this);
    }

    Control enable() {
        uiControlEnable(this);
        return this;
    }

    Control disable() {
        uiControlDisable(this);
        return this;
    }

    Control verifySetParent(Control other) {
        uiControlVerifySetParent(this, other);
        return this;
    }

    bool enabledToUser() {
        return cast(bool) uiControlEnabledToUser(this);
    }
}

package:
extern(C):
import core.stdc.stdint;

struct uiControl;
void uiControlDestroy(uiControl *);
uintptr_t uiControlHandle(uiControl *);
uiControl *uiControlParent(uiControl *);
void uiControlSetParent(uiControl *, uiControl *);
int uiControlToplevel(uiControl *);
int uiControlVisible(uiControl *);
void uiControlShow(uiControl *);
void uiControlHide(uiControl *);
int uiControlEnabled(uiControl *);
void uiControlEnable(uiControl *);
void uiControlDisable(uiControl *);

// TODO: NO USE
uiControl *uiAllocControl(size_t n, uint32_t OSsig, uint32_t typesig, const(char)*typenamestr);
void uiFreeControl(uiControl *);

void uiControlVerifySetParent(uiControl *, uiControl *);
int uiControlEnabledToUser(uiControl *);

// TODO: NO USE
void uiUserBugCannotSetParentOnToplevel(const char *type);
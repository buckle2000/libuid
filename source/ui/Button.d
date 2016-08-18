module ui.Button;

import ui.Control;

class Button : Control {
    protected uiButton * _button;

    mixin EventListenerMixin!("OnClicked", Button);

    this(string text = "") {
        _button = uiNewButton(text.ptr);
        super(cast(uiControl *) _button);

        uiButtonOnClicked(_button, &OnClickedCallback, cast(void *) this);
    }

    string text() {
        return uiButtonText(_button).toString;
    }

    Button setText(string text) {
        uiButtonSetText(_button, text.ptr);
        return this;
    }
}

module ui.Checkbox;

import ui.Control;

class Checkbox : Control {
    protected uiCheckbox * _checkbox;

    mixin EventListenerMixin!("OnToggled", Checkbox);

    this(string text = "") {
        _checkbox = uiNewCheckbox(text.ptr);
        super(cast(uiControl *) _checkbox);

        uiCheckboxOnToggled(_checkbox, &OnToggledCallback, cast(void *) this);
    }

    string text() {
        return uiCheckboxText(_checkbox).toString;
    }

    Checkbox setText(string text) {
        uiCheckboxSetText(_checkbox, text.ptr);
        return this;
    }

    bool checked() {
        return cast(bool) uiCheckboxChecked(_checkbox);
    }

    Checkbox setChecked(bool checked) {
        uiCheckboxSetChecked(_checkbox, cast(int) checked);
        return this;
    }
}

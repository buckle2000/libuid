module ui.Label;

import ui.Control;

class Label : Control {
    protected uiLabel * _label;

    this(string text = "") {
        _label = uiNewLabel(text.ptr);
        super(cast(uiControl *) _label);
    }

    string text() {
        return uiLabelText(_label).toString;
    }
    
    Label setText(string text) {
        uiLabelSetText(_label, text.ptr);
        return this;
    }
}

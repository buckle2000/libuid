module ui.Combobox;

import ui.Control;

class Combobox : Control {
    protected uiCombobox * _combobox;

    mixin EventListenerMixin!("OnSelected", Combobox);

    this() {
        _combobox = uiNewCombobox();
        super(cast(uiControl *) _combobox);

        uiComboboxOnSelected(_combobox, &OnSelectedCallback, cast(void *) this);
    }

    Combobox append(string text) {
        uiComboboxAppend(_combobox, text.ptr);
        return this;
    }

    size_t selected() {
        return cast(size_t) uiComboboxSelected(_combobox);
    }

    Combobox setSelected(size_t index) {
        uiComboboxSetSelected(_combobox, cast(int) index);
        return this;
    }
}

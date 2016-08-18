module ui.EditableCombobox;

import ui.Control;

class EditableCombobox : Control {
    protected uiEditableCombobox * _editableCombobox;

    mixin EventListenerMixin!("OnChanged", EditableCombobox);

    this() {
        _editableCombobox = uiNewEditableCombobox();
        super(cast(uiControl *) _editableCombobox);

        uiEditableComboboxOnChanged(_editableCombobox, &OnChangedCallback, cast(void *) this);
    }

    EditableCombobox append(string text) {
        uiEditableComboboxAppend(_editableCombobox, text.ptr);
        return this;
    }

    string test() {
        return uiEditableComboboxText(_editableCombobox).toString;
    }

    EditableCombobox setText(string text) {
        uiEditableComboboxSetText(_editableCombobox, text.ptr);
        return this;
    }
}

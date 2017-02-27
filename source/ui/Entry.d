module ui.Entry;

import ui.Control;

enum EntryStyle {
    Normal,
    Password,
    Search,
}

class Entry : Control {
    protected uiEntry * _entry;

    mixin EventListenerMixin!("OnChanged", Entry);

    this(EntryStyle style = EntryStyle.Normal) {
        final switch (style) with(EntryStyle) {
            case Normal:
                _entry = uiNewEntry();
                break;
            case Password:
                _entry = uiNewPasswordEntry();
                break;
            case Search:
                _entry = uiNewSearchEntry();
                break;
        }
        super(cast(uiControl *) _entry);

        uiEntryOnChanged(_entry, &OnChangedCallback, cast(void *) this);
    }

    string text() {
        return uiEntryText(_entry).toString;
    }
    
    Entry setText(string text) {
        import std.string: toStringz;
        uiEntrySetText(_entry, text.toStringz);
        return this;
    }

    bool readOnly() {
        return cast(bool) uiEntryReadOnly(_entry);
    }

    Entry setReadOnly(bool readonly) {
        uiEntrySetReadOnly(_entry, cast(int) readonly);
        return this;
    }
}

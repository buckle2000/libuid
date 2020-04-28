module ui.Entry;

import ui.Control;

enum EntryType {
    Normal,
    Password,
    Search,
}
uiEntry* toEntry(EntryType type) {
    final switch (type) with(EntryType) {
        case Normal:
            return uiNewEntry();
        case Password:
            return uiNewPasswordEntry();
        case Search:
            return uiNewSearchEntry();
    }
}

class Entry : Control {
    protected uiEntry * _entry;

    mixin EventListenerMixin!("OnChanged", Entry);

    this(EntryType type = EntryType.Normal) {
        _entry = type.toEntry;
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

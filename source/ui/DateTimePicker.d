module ui.DateTimePicker;

import ui.Control;

enum DateTimePickerType {
    DateTime,
    Date,
    Time,
}

uiDateTimePicker* toDateTimePicker(DateTimePickerType type) {
    final switch(type) with(DateTimePickerType) {
        case DateTime:
            return uiNewDateTimePicker();
        case Date:
            return uiNewDatePicker();
        case Time:
            return uiNewTimePicker();
    }
}

class DateTimePicker : Control {
    protected uiDateTimePicker * _dateTimePicker;

    this(DateTimePickerType type = DateTimePickerType.DateTime) {
        _dateTimePicker = type.toDateTimePicker;
        super(cast(uiControl *) _dateTimePicker);
    }
}

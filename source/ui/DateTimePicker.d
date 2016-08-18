module ui.DateTimePicker;

import ui.Control;

enum DateTimePickerStype {
    DateTime,
    Date,
    Time,
}

class DateTimePicker : Control {
    protected uiDateTimePicker * _dateTimePicker;

    this(DateTimePickerStype stype = DateTimePickerStype.DateTime) {
        final switch(stype) with(DateTimePickerStype) {
            case DateTime:
                _dateTimePicker = uiNewDateTimePicker();
                break;
            case Date:
                _dateTimePicker = uiNewDatePicker();
                break;
            case Time:
                _dateTimePicker = uiNewTimePicker();
                break;
        }
        super(cast(uiControl *) _dateTimePicker);
    }
}

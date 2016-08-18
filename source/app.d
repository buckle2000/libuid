import std.stdio;

import ui;

void main()
{
    auto win = new Window();
    auto box = new Box()
        .append(new Button("Button"))
        .append(new Button().addOnClicked(delegate(Button btn){
                        win.msgBoxError("title", "discription");
                    }))
//        .append(new Tab()
//                .append("Tab 1", new Checkbox("Checkbox"))
//                .append("Tab 2", new Checkbox)
//                .insertAt("Tab 1.5", 1, new Box()
//                    .append(new Entry(EntryStyle.Normal))
//                    .append(new Entry(EntryStyle.Password))
//                    .append(new Entry(EntryStyle.Search))
//                )
//            )
//        .append(new Group("Group")
//                .setChild(new Label("Label Text"))
//            )
//        .append(new Spinbox)
//        .append(new Slider)
//        .append(new Separator(false))
//        .append(new ProgressBar()
//                .setValue(15)
//            )
//        .append(new Combobox()
//                .append("Combobox 1")
//                .append("Combobox 2")
//            )
//        .append(new EditableCombobox()
//                .append("EditableCombobox 1")
//                .append("EditableCombobox 2")
//                .setText("CurrentText")
//            )
//        .append(new RadioButtons()
//                .append("RadioButtons 1")
//                .append("RadioButtons 2")
//            )
//        .append(new DateTimePicker())
//        .append(new DateTimePicker(DateTimePickerStype.Date))
//        .append(new DateTimePicker(DateTimePickerStype.Time))
//        .append(new MultilineEntry().append("MultilineEntry 1"), true)
//        .append(new MultilineEntry(false).append("MultilineEntry 2"), true)
    ;

    win.setTitle("Window Title")
        .setChild(box)
        .addOnClosing(delegate(Window w) {
                import std.stdio;
                "addOnClosing...".writeln;
                App.quit;
            })
        .show;
    
    auto menu = new Menu("Menu1")
        .appendItem("Item 1", delegate(MenuItem i) { i.setChecked(true); })
        .appendItem("Item 2")
        .appendItem("Item 3");
    menu = new Menu("Menu2")
        .appendCheckItem("Item check")
        .appendAboutItem();
//    menu = new Menu()
//        .appendQuitItem();
//    menu = new Menu()
//        .appendPreferencesItem();
//    menu = new Menu()
//        .appendAboutItem();

    App.run;
}

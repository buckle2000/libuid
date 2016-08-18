module ui.Menu;

import ui.Core;
import ui.MenuItem;

class Menu {
    // Notice: now libui's menu implicit attached to window, it's not OO.
    // this makes Menu and MenuItem do not destroy anyhow.
    private static Object[] _menuAndItems;

    protected uiMenu * _menu;

    this(string name = "") {
        _menuAndItems ~= this;
        _menu = uiNewMenu(name.ptr);
    }

    Menu appendItem(string name, void delegate(MenuItem i) f = null) {
        auto item = new MenuItem(uiMenuAppendItem(_menu, name.ptr));
        _menuAndItems ~= item;
        if (f) {
            f(item);
        }
        return this;
    }
    
    Menu appendCheckItem(string name, void delegate(MenuItem i) f = null) {
        auto item = new MenuItem(uiMenuAppendCheckItem(_menu, name.ptr));
        _menuAndItems ~= item;
        if (f) {
            f(item);
        }
        return this;
    }
    
    Menu appendQuitItem(void delegate(MenuItem i) f = null) {
        auto item = new MenuItem(uiMenuAppendQuitItem(_menu));
        _menuAndItems ~= item;
        if (f) {
            f(item);
        }
        return this;
    }
    
    Menu appendPreferencesItem(void delegate(MenuItem i) f = null) {
        auto item = new MenuItem(uiMenuAppendPreferencesItem(_menu));
        _menuAndItems ~= item;
        if (f) {
            f(item);
        }
        return this;
    }
    
    Menu appendAboutItem(void delegate(MenuItem i) f = null) {
        auto item = new MenuItem(uiMenuAppendAboutItem(_menu));
        _menuAndItems ~= item;
        if (f) {
            f(item);
        }
        return this;
    }

    Menu appendSeparator() {
        uiMenuAppendSeparator(_menu);
        return this;
    }
}

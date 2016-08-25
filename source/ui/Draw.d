module ui.Draw;

import ui.Core;

struct Context {
    private uiDrawContext * _context;

    this(uiDrawContext * context) {
        _context = context;
    }
}
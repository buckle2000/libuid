# libuid: Complete OO interfaces of libui in D

* libuid is a binding of libui. So you have to build libui first. libui now is a submodule of libuid
to prevent compatible issues. Dynamic library is recommend as you can build your programm without
other static libraries to link.

* Build existing example1 with dub:

```bash
dub build --config=example1
```

* Minimal Example:

```d
import ui;

void main() {
    App.run(new Window("Hello").addOnClosing(_ => App.quit).show);
}
```

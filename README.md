# libuid: Complete OO interfaces of libui in D
---------

* Build existing example1 with dub:
```
dub build --config=example1
```

* Minimal Example:
```
import ui;

void main() {
    App.run(new Window("Hello").addOnClosing(_ => App.quit).show);
}
```

# libuid: Complete OO interfaces of libui in D

* libuid is a binding of libui. So you have to build libui first. libui now is a submodule of libuid
to prevent compatible issues. Dynamic library is recommend as you can build your programm without
other static libraries to link.

* Build existing examples with dub:

```bash
dub build --config=example1 --arch=x86_mscoff
```
or
```bash
dub build --config=example2 --arch=x86_64
```
You can use `--arch` to specify architecture of you platform. Note in windows, use `--arch=x86_mscoff`
to create 32bit binary.

* Minimal Example:

```d
import ui;

void main() {
    App.run(new Window("Hello").addOnClosing(_ => App.quit).show);
}
```

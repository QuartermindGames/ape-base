# ape-base

This repository provides content used as a foundation for Ape Tech derived games. Ideally, you would check this out into Ape's "projects" directory and then set it as a dependecy per your own project file.

It should also serve as an example of how you can structure a project for use with Ape.

As an example, to use this content as part of your own project, set the following in your project file.

```
node.utf8
object project
{
    ...

    ; Keep in mind the order here; your own project will come first, 
    ; then followed by the first item on this list, 
    ; and then followed by the rest
    array string dependencies
    {
        "base" ; or 'ape-base' depending on how you checked this out
    }

    ...
}
```

## Additional Credits

- [materials/editor/icons/icon_brush.png](materials/editor/icons/icon_brush.png)
- [materials/editor/icons/icon_camera.png](materials/editor/icons/icon_camera.png)
- [materials/editor/icons/icon_entity.png](materials/editor/icons/icon_entity.png)
- [materials/editor/icons/icon_light.png](materials/editor/icons/icon_light.png)
- [materials/editor/icons/icon_node.png](materials/editor/icons/icon_node.png)
- [materials/editor/icons/icon_room.png](materials/editor/icons/icon_room.png)

These were produced by [Luis Antônio](https://eunaoseibrother.newgrounds.com/) as commissioned items specifically for this engine.

----

`guis/fonts/proggy*`

These are from the [proggyfonts](https://github.com/bluescan/proggyfonts/tree/master) collection.

```
MIT License

Copyright (c) 2004, 2005 Tristan Grimmer

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

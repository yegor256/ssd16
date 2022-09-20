<img src="innopolis-logo.svg" height="48px"/>

[![latexmk](https://github.com/yegor256/ssd16/actions/workflows/latexmk.yml/badge.svg?branch=master)](https://github.com/yegor256/ssd16/actions/workflows/latexmk.yml)

There are slides for my lectures about Software Systems Design,
which were presented to 3rd year BSc students at [Innopolis University](https://innopolis.university/)
in 2021. Videos are in 
[this YouTube playlist](https://www.youtube.com/playlist?list=PLaIsQH4uc08woJKRAA7mmjs9fU0jeKjjM).
All compiled slide decks in PDF are [here](https://yegor256.github.io/ssd16/).

To compile everything just run (I use my own LaTeX packages, incl.
[ppt-slides](https://ctan.org/pkg/ppt-slides),
[crumbs](https://ctan.org/pkg/crumbs),
and
[clicks](https://ctan.org/pkg/clicks)):

```bash
$ make
```

To clean everything up, do:

```
$ make clean
```

You need to have
[LaTeX](https://en.wikipedia.org/wiki/LaTeX),
[`aspell`](http://aspell.net/),
[`texsc`](https://rubygems.org/gems/texsc),
and
[`texqc`](https://rubygems.org/gems/texqc)
installed.

**Disclaimer**: All visual and text materials presented in
this slidedeck are either originally made by the author or taken from public
Internet sources, such as website. Copyright belongs to their respected
authors.
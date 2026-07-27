# clean-app-launcher

## Overview
A simple native app launcher; centralize many executables into a single clean, customizable tiled UI

## Why?
As a musician, I had a growing library (infestation?) of software instruments with cryptic naming conventions. Their obscure shortcut icons began crowding my desktop, and organizing them into folders was not particularly fun to set up or use. I looked at my collection of _real_ instruments, displayed cleanly on organized racks/stands, and felt much more inspired. I knew that my virtual instrument collection deserved a better UX.

In short: I wanted a nice-looking, browseable UI for my native apps that inspired me to explore rather than search.

And, of course, an excuse to foray into the world of QT and native app development.

## How to Build
Build using the following command:

`python -m nuitka .\py\instrumentLibrary.py`

The application is compiled as to a single executable file in:

`dist/instrumentLibrary.onefile-build`

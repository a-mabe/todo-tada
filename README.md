[![License](https://img.shields.io/badge/License-BSD%203--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)
![Status](https://github.com/a-mabe/todo-tada/actions/workflows/tests.yml/badge.svg)
[![Version](https://badge.fury.io/gh/tterb%2FHyde.svg)](https://badge.fury.io/gh/tterb%2FHyde)

# To-do Tada

A fully open source visual to-do list [Flutter](https://flutter.dev/) application.

This app is currently **in progress and actively under developement**. Feel free to utilize GitHub issues, particularly the enhancement (feature request) tag, to suggest things as I'm developing the app.

# Table of Contents

- [To-do Tada](#to-do-tada)
- [Table of Contents](#table-of-contents)
- [Author](#author)
  - [My Other Apps](#my-other-apps)
- [License](#license)
- [Overview](#overview)
  - [Status](#status)
  - [Sitemap](#sitemap)
  - [Mockups](#mockups)
  - [Utilized Packages and Plugins](#utilized-packages-and-plugins)

# Author

* Abigail Mabe [mabe.abby.a@gmail.com](mailto:mabe.abby.a@gmail.com)

## My Other Apps

  * I created [Weatheristic](https://weatheristic.app/), a weather condition posting app, as a summer project with the help of [Dhruv Patel](https://github.com/dhruv282).

# License

See the [license file](https://github.com/a-mabe/todo-tada/blob/master/LICENSE) at the root of the project.

# Overview

This app is a drag and drop visual to-do list. Each icon is supposed to represent a to-do list item. Instead of checking a box or deleting something from the list, you drag the completed icon from the "To-do" side to the "Done" side. The intent is that the visual to-do list makes it easy to see at a glance how many things are left to do. And finishing a task so that you can drag something from one side to other should be fulfilling. The app should also make use of some reward system when you drag something over. Confetti on the screen, haptics, sound plays, etc. Of course, all of this could be turned off and on in settings.

Here's a GIF of me dragging an icon in a mockup to show what I mean:

![Example GIF](https://github.com/a-mabe/todo-tada/blob/master/docs/gifs/example.gif?raw=true)

Since the app is meant to be for visual people, I plan on making as many parts of the user interface customizable as possible. For example you can change the primary color, text color, and enable/disable dark mode.

![Themes](https://github.com/a-mabe/todo-tada/blob/master/docs/images/theme-banner.png?raw=true)

## Status

The workflow for this app utilizes [GitHub Projects](https://github.com/a-mabe/todo-tada/projects).

* [Generic To-do Lists](https://github.com/a-mabe/todo-tada/projects/2) covers the basic functionality of the to-do list app.
* [Daily Lists Screen](https://github.com/a-mabe/todo-tada/projects/1) expands on the general to-do list functionaly by allowing lists to be created for and sorted by specific dates.
* All the icons are made in [Inkscape](https://inkscape.org/). You can view the list of icons, suggest icons, or suggest changes to existing icons in [this Google Doc](https://docs.google.com/document/d/1pbwKDSxXyNEMPFTxxMaQqzwsmXEjMaDuyFj48iWG1UY/edit?usp=sharing).

## Sitemap

Initial planned sitemap.

![Sitemap](https://github.com/a-mabe/todo-tada/blob/master/docs/images/sitemap_uml.png?raw=true)

## Mockups

1. All Lists

    ![All lists mockup](https://github.com/a-mabe/todo-tada/blob/master/docs/images/all-lists.png?raw=true)

2. Daily Lists

    ![Daily lists mockup](https://github.com/a-mabe/todo-tada/blob/master/docs/images/daily-lists.png?raw=true)

3. Other Lists

    ![Other lists mockup](https://github.com/a-mabe/todo-tada/blob/master/docs/images/other-lists.png?raw=true)

## Utilized Packages and Plugins

Flutter allows the [use of packages](https://flutter.dev/docs/development/packages-and-plugins/using-packages) contributed by other developers. This app utilizes a variety of plugins. As different packages and plugins are incorporated into the app, I will list them here.

* [flutter_native_splash](https://pub.dev/packages/flutter_native_splash)
  * Generates native code for the splash screen.

* [flutter_settings_screens](https://pub.dev/packages/flutter_settings_screens)
  * Used to implement the settings screen. Utilizes shared preferences to store user settings.

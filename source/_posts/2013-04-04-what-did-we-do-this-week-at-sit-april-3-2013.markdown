---
author: andrewuf
comments: true
date: 2013-04-04 03:35:39+00:00
layout: post
slug: what-did-we-do-this-week-at-sit-april-3-2013
title: What Did We Do This Week At SIT? - April 3, 2013
wordpress_id: 645
categories:
- Meeting Re-caps
---

**ANNOUNCEMENTS!!!**

[http://prezi.com/srjbedl9lmd1/untitled-prezi/?kw=view-srjbedl9lmd1&rc=ref-35254063](http://prezi.com/srjbedl9lmd1/untitled-prezi/?kw=view-srjbedl9lmd1&rc=ref-35254063)
-please mind my poor grammerr of use of wrd "your"
**###Git the REPOsitory collaboration tool.###**
What is Git?
[http://en.wikipedia.org/wiki/Git_%28software%29](http://en.wikipedia.org/wiki/Git_%28software%29)

The beautiful part:
Its already installed on BackTrack Linux!

If you want to look at the challenges from iCTF, you will have to grab them from GitHub. To do that, clone our repo here: [https://github.com/ufsit/meeting-files.git](https://github.com/ufsit/meeting-files.git)

Gitting the files:
git clone ---- clones the repository
//This is how you get the files onto your desktop.

Updating the repo you are in:
git pull ---- "Pulls" down the latest version of the repo from GitHub or wherever
//Did someone make changes to your repo? :O

Putting a file (or files/dirs) up on a repo has three main steps:
git add [filename(s), no brackets] ---- "Indexes" the file(s). Use '.' in place of [filename] all of the files in your current working directory, and all sub-directories

git commit ---- says what do I want to push?

git push ---- pushes the file onto the repo

**###vim the text editor###**

If you aren't using this wonderful text editor... why aren't you? Except for you, Joe. Keep your emacs to yourself ;)

To get started, it is quite important to know there are two primary modes you will be interacting with: "normal"(esc) and "interactive"(i). Interactive mode lets you enter text normally but vim's real power comes from "normal" mode.

Some short cuts from interactive mode are:
yy ---- copy current line
pp ---- paste on line below
u ---- undo
crtl + r ---- redo
Some useful commands "use these in normal mode":
By the way you must enter the":" in front of the command that is important and totally not a mistake I might have made when first learning vim.

:q ---- quit (this one is important)
:w ---- write or "save"
:vsp or :vsplit ---- gives you two multiple editing screens yay!
Ctrl-W j ---- allows you to cycle through the split screens
Ctrl-W w ---- allows you to switch between two split screens

**###Basic connections TELNET###**

Basic usage is:
telnet [IP ADDRESS, NO BRACKETS] [PORT NUMBER, NO BRACKETS]

For more information:
man telnet
**###A little bit of python###**
There are lots of tutorials online!
http://docs.python.org/2/tutorial/
If you have any questions or comments please use the mailing list! You asking questions helps everyone learn!!!

If you are uncomfortable you can of course email me, or any of your officers directly.

Vincent Moscatello
President UF-SIT

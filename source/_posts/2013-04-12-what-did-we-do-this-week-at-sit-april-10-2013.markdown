---
author: andrewuf
comments: true
date: 2013-04-12 00:46:56+00:00
layout: post
slug: what-did-we-do-this-week-at-sit-april-10-2013
title: What Did We Do This Week At SIT? – April 10, 2013
wordpress_id: 653
categories:
- Meeting Re-caps
---

# **UFSIT Meeting | April 10, 2013 | Decompilers!**




### **-- Announcements! --**


Dr. Joe Wilson is teaching an Ethical Hacking course this Fall!
- Email him for more information: jnw@cise.ufl.edu
B-Sides Orlando is this weekend!
CTF Approaching!
- April 19th - April 21st (48 hours): Plain CTF hosted by the PPP
- Hackerspace on Friday/Saturday/Possibly Sunday?
Tyler Pitchford is coming to speak at UF on April 24th!
- Attorney and creator of Azureus/Vuze
- Giving TWO talks on Massive Open Online Courses (MOOCs | on April 24th) and Reverse Engineering (April 25th for SIT specifically)
Next Fall, we will be using KALI LINUX! Kali is pretty much the newest version of Backtrack and can be downloaded at www.kali-linux.org
Officer elections will be held next week!


### **-- DECOMPILERS --**


Decompiler takes byte code and turns it into a readable source
We can reverse any interpreted language which includes:
- Python and Java
Why?!
- ... to hack Minecraft of course.
- Which, on a side note, it's pretty easy to decompile Java code
How?!
- JAD (for Java) and UNPY (for Python)


### **-- JAD --**


1) Open up Backtrack
2) Backtrack -> Reverse Engineering -> JAD
- Note: It will open up in Terminal
3) Use ./jad [path/of/class/file.class]
- This will output a .jad file which you can use "cat" to display the text or open it in vim

_Challenges!_
- There are challenges on GitHub!
- If you already have the "sitgit" already setup, just navigate to [sitgit-folder]/meeting-files and use "git pull" to pull the new challenges!
- I personally recommend copying them to your desktop for easy access when using JAD!
- Remember that not all challenges are solvable..........


### **-- UNPY (aka uncompyle) --**


- The zip file for UNPY is in the meeting-files folder in [sitgit-folder]!
Installation:
1) Navigate to the unzipped uncompyle-master directory
2) Run "python2.7 setup.py build"
3) Run "python2.7 setup.py install"
1) Navigate to the uncompyle-master directory (or wherever you saved the uncompyle files)
2) Run "python2.7 uncomplyer.py [path/of/class/file.pyc]"
3) The output will be what's in the [file.pyc]!

As always, if you have a question about anything, send an email to our listserv or come chat in the IRC!

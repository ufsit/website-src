---
author: elmavericko
comments: true
date: 2013-06-13 14:27:52+00:00
layout: post
slug: prepping-for-the-defcon-ctf-qualifier
title: Prepping for the DEFCON CTF Qualifier
wordpress_id: 752
categories:
- Main
---

SIT'ers,

In order to access the internal collaboration resources this weekend, you'll need to generate a SSH key pair.

"How do I do this?" you might be thinking.
It's actually a pretty easy process.

You'll want to do this in a UNIX/Linux environment. Make sure that 'ssh-keygen' is installed. It should be, unless you're using a fresh install of some crazy minimalist distro like Arch Linux.


First, cd into your .ssh directory
[code]
[user@machine ~]$ cd /home/user/.ssh/
[user@machine .ssh]$
[/code]
If the directory doesn't exist, create it.
[code]
[user@machine ~]$ cd /home/user/.ssh/
-bash: cd: /home/user/.ssh/: No such file or directory
[user@machine ~]$ mkdir /home/user/.ssh/
[user@machine ~]$ cd /home/user/.ssh/
[user@machine .ssh]$
[/code]


Then run 'ssh-keygen -t rsa -b 4096' (this is telling ssh-keygen to create a 4096-bit key pair, of type RSA). It is not necessary to set a passphrase on this key, but you can if you want to. Please use the naming scheme 'firstlast_defcon-rsa'
[code]
[user@machine .ssh]$ ssh-keygen -t rsa -b 4096
Generating public/private rsa key pair.
Enter file in which to save the key (/home/user/.ssh/id_rsa): firstlast_defcon-rsa
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/user/.ssh/firstlast_defcon-rsa.
Your public key has been saved in /home/user/.ssh/firstlast_defcon-rsa.pub.
The key fingerprint is:
dc:10:47:23:9e:ef:e0:78:15:09:76:a3:26:fd:ed:1c user@machine
The key's randomart image is:
+--[ RSA 4096]----+
|       .oo+.o    |
|      ..+..+ o   |
|       oC.+.o    |
|       + B.+E.   |
|      . S ooo.   |
|       .    +    |
|                 |
|                 |
|                 |
+-----------------+
[/code]


Please email your public key (firstlast_defcon-rsa**.pub**) file to matt.nash@ufl.edu

After we add your pubkey to the server, you'll get an email reply with instructions on how to use the tunnel we've created. You'll also receive information about the internal resources.





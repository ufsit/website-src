---
author: barongearmu
comments: true
date: 2012-03-01 08:00:42+00:00
layout: post
slug: sql-injection
title: SQL Injection
wordpress_id: 27
categories:
- Meeting Re-caps
tags:
- cvk
- programming
- sql injection
- web hacking
---

**3/01/2012**

We were on the second floor in one of the E22X rooms.

14 attending. Here are some of them.

[![](http://ufhack.files.wordpress.com/2012/03/2012-03-01-18-21-30.jpg?w=300)](http://ufhack.files.wordpress.com/2012/03/2012-03-01-18-21-30.jpg)

We talked about the wordpress blog and it's existence.

[![](http://ufhack.files.wordpress.com/2012/10/2012-03-01-18-20-29-e1350580921406.jpg?w=225)](http://ufhack.files.wordpress.com/2012/03/2012-03-01-18-20-29.jpg)

Our fearless leader exhorting about the blogoration.

The subject of the day was SQL Injection, and the presenter was Christian (cvk).

I took some rather limited notes. I had to leave early. Maybe Matt can fill in what else there was. I also took the exact url down, cause that seems like a good idea to me.

[caption id="attachment_25" align="alignnone" width="225"][![CRAZY HANDS!](http://ufhack.files.wordpress.com/2012/03/2012-03-01-18-20-58-e1331766708421.jpg?w=225)](http://ufhack.files.wordpress.com/2012/03/2012-03-01-18-20-58.jpg) Christian standing in front of Matt's CRAZY HANDS![/caption]

PHP is super dumb by default. start at the top and go to the bottom.

MySQL shell

example.org/lolololo.php?product_id=3

MySQL comments ' -- ' not sure if space on front or back is needed, so
did both

Tautology: A statement that is true as it is a restatement of it's own definition. 1 = 1 is a tautology.

Evaluation of comparison of string to int, converts one to other
before doing comparison, so 5 ='5' works.

As we need to be able to create arbitrary sized tables, use an unqualified select.
select 1, 2, 3, 4;
this results in a table with 4 columns.

Finally, for our topic after we return from break, we should be covering some binary reversing.

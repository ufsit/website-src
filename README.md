ufsit.github.io
=================

## Setting up a Development Environment
As this site uses Jekyll, you will need an up-to-date ruby setup. Along with ruby, you will need site specific plugin dependencies. Thankfully this is easily handled by the included Gemfile. Using `bundle` you are able to install every required Gem and you will be on your way. Here are the steps for Mac OSX with homebrew:

```
$ brew install ruby    # make sure you are getting ruby 2.3 or above
$ pip install pygments # this assumes you have a python dev environment
                       # if not, check out guides online for getting pip
$ gem install bundle   # make sure you have bundle
website-src $ bundle check
The Gemfile's dependencies are satisfied
website-src $ bundle -v
Bundler version 1.13.7
website-src $ gem -v
2.5.2
website-src $ ruby -v
ruby 2.3.3p222 (2016-11-21 revision 56859) [x86_64-darwin15]
website-src $ bundle install # in the site directory, install all of the required dependencies
$ rake generate # generate the site! (or you can use jekyll serve, but you need compass for the SASS)
```

##Creating a new post:

1. `rake new_post["post title"]`
2. Edit post in `source/_posts/yyyy-mm-dd-post-title.markdown`

##Viewing Site

1. `jekyll serve`
2. Open 127.0.0.1:4000 in your browser

##Deploying to GitHub:

1. `rake deploy`
2. Follow prompts

If you are deploying for the first time, you will see an error message like
```
[grant ~/code/website-src/source >> rake deploy
(in /Users/grant/code/website-src)
## Deploying branch to Github Pages
## Pulling any updates from Github Pages
cd _deploy
rake aborted!
Errno::ENOENT: No such file or directory @ dir_chdir - _deploy
/Users/grant/code/website-src/Rakefile:255:in `block in <top (required)>'
/Users/grant/code/website-src/Rakefile:227:in `block in <top (required)>'
Tasks: TOP => deploy
(See full trace by running task with --trace)
```
Do NOT use `rake setup_github_pages` as that will start with a fresh website history. Clone the existing deployed website raw files in to deploy in stead and THEN run `rake deploy`.
```
[grant ~/code/website-src >> git clone git@github.com:ufsit/ufsit.github.io.git _deploy
Cloning into '_deploy'...
remote: Counting objects: 25162, done.
remote: Total 25162 (delta 0), reused 0 (delta 0), pack-reused 25162
Receiving objects: 100% (25162/25162), 17.59 MiB | 378.00 KiB/s, done.
Resolving deltas: 100% (9224/9224), done.
Checking connectivity... done.

[grant ~/code/website-src >> rake deploy
## Deploying branch to Github Pages
## Pulling any updates from Github Pages
<snip>

## Copying public to _deploy
cp -r public/. _deploy
cd _deploy

## Committing: Site updated at 2017-01-20 18:44:48 UTC
<snip>

## Pushing generated _deploy website
<snip>

## Github Pages deploy complete
cd -
```
git clone git@github.com:ufsit/ufsit.github.io.git _deploy


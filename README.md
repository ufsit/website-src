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

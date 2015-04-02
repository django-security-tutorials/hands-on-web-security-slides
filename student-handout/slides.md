# Student handout

### Getting comfortable with web security, PyCon 2015

Navigate these slides by clicking the right & left arrows at the bottom.

You should have received a printed-out checklist by this point. If not, talk to an instructor.

---

## How to make the most of the lab time

* You have 90 minutes -- get some hands-on practice.
* Make sure you know who your small-group lead is.
* Get on _Slack_ for your small group.
* Open up petwitter.com and open up your small group's app instance.
* Attack it, with the help of these slides.
* Be social, on your group's Slack chat room.
* Instructors -- if you're setting up a new instance of the app, scroll to the end of these slides.

---

## How to make the most of these slides

* Each slide explains a category of web app vulnerability that you can use to attack the app.
* If you want extra hints on how to attack the app, type '`s`' on your keyboard to see the _special hints_.
* When you've understood one of the attack strategies, then ask an instructor to give you a gold star for that attack! They'll quiz you, and then give you one.

Note:
* Hooray! You opened the special hints successfully.

---

## Be social

* One more thing: use your small group's Slack channel to attack your peers. They will (honestly!) enjoy clicking a link that does something completely surprising.
* Appreciating surprises is an important part of the security mindset.

---

## Cross site scripting
### Overview

Besides showing `<b>bold text</b>` and `<section>sections</section>`, HTML also includes tags that cause browsers take _actions_. If a site doesn't sanitize its inputs, but allows you to enter text that is treated as HTML when the site software renders the page, then you can run or embed whatever JavaScript you wish onto the page.

---

## Cross site scripting
### Your goal

* Add some `<b>bold text</b>` to different text inputs in the site.
* Now click around the site. If you can find the text being **bold**, then make the page run some Javascript. (Next slide has more info.)
* Once you've done that, give someone else a link to your attack page, via Slack!!!

---

## Cross-site scripting
### Sample attack code

- Sample JS: ```< script >alert(1);</ script>```
- Feel free to Google for [xss cheat sheet] for more.
- More complex attack code in the notes for this slide.

Note:
- Other fun things: ```<img src=404 onerror="alert(1);">```
- On this site, delete someone's profile with: ```< script>

---

## Default passwords

Many pieces of software are shipped with easy-to-guess default passwords, with the expectation that whoever installs and administers the software will change the password. Many **admin**s forget this step, however.

Your goal:

* Find the admin site.
* Ask someone on Slack to tell you the username they used; then, create a new pet on their behalf!
* For more hints, press '`s`'

Note:
- Take a look through the **urls.py** in the code if you can't find the admin site.
- The username is admin. Take a wild guess at the password. (-;

---

## Improper authorization checking

### Overview

As a programmer, it's easy to forget to check if a user is authorized to POST to a given URL.

You might take care to have an HTML form only appear for authorized users. Crafty users can use their browser's site inspector to change the URL a form will POST to.

---

## Improper authorization checking

### Your goal

* Ask someone on Slack for a pet ID that isn't yours, and then
* Modify it somehow.
* For more hints, press '`s`'
* To earn your gold star, you have to be able to point to the buggy view function in the source code and explain what the bug is.

Note:
- Use your browser's "Inspect element" feature to change the `form action` on a pet profile page.
- Read the (code)[https://github.com/paulproteus/petwriter/blob/master/thesite/communication_app/views.py] for the views, or just try each of the forms on the pet profile page.

---

## Cross site request forgery

### Overview

If there is a URL that changes server-side state, and it can be accessed with a `GET` request, then it's easy to make people's browsers request that URL.

One fun way is to make an `IMG` tag whose `src=` points to the URL in question.

If **Alice** makes a web page with such an `IMG` tag in it, and **Bob** loads the page, **Bob**'s browser will make the `GET` request. **Bob**'s browser will send the usual cookies for that domain, resulting in **Alice** being able to use **Bob**'s credentials.

Crazy.

---

## Cross site request forgery

### Your goal

* Create a web page that, when viewed, creates a new pet owned by whoever visits the page.

* You may want to ***read the app code*** to find a view function that that accepts GET as well as POST.

* Press '`s`' for hints.
* Once you can explain how this works, get a gold star from an instructor.

Note:
- To figure out exactly how to craft the GET URL, start by using _Inspect Element_ to modify the form so that it is `method=GET` on your own computer.
- You'll need to create an HTML file with an IMG tag inside it. We recommend using [JSFiddle](https://jsfiddle.net/) for this.
- Since you will have to embed a pet name within the attack `IMG` tag, you may need to use the app's "delete all your pet data" before attacking someone else.

---

## Cross-site request forgery: extra credit

## Overview

Did you know that `POST` requests can also happen from other sites?

See [this StackOverflow question](http://stackoverflow.com/questions/17940811/example-of-silently-submitting-a-post-form-csrf) with advice on how to make it happen.

---


## Cross-site request forgery: extra credit

## Your task

* Make a web page that, upon visiting it, causes all a user's pet info data to be deleted.

* Share a link in Slack. (This time, it's good to warn people!)

Note:
* Use JSFiddle again for hosting.
* It's fine if you skip this exercise.

---

## Generate session data for other users

### Overview

After you've logged into a website, the server sends a "cookie" to your web browser. This is a token that your browser sends with all future requests to this server, and it's typically opaque to the browser.

But what if you could understand it? What if you could modify it?

Django's `signed_cookies` session store, configured the way this app does (see `thesite/thesite/settings.py`), stores the cookies in a way that you (dear reader) can understand.

---

## Generate session data for other users

### Your task

* Use Django to parse the cookie data for your session.
* Ask your small group lead what user ID they are, and then
* Show them that you logged in as them.
* Then get a gold star!
* More details on _how_ on the next slide.

---


### Implementation notes (1/2)

* In your browser, open up the console, and type: ```document.cookie```
* You'll see something like: 
```sessionid="foo:bar"; csrftoken=Iv2HhT3i20ft5zKdWTZ6YdofnHlAqrQQ"```
* Pull out just the sessionid component - in this case ```"foo:bar"``` - we'll use this later.

---

### Implementation notes (2/2)

* To decode this, run the app locally:

```
git clone https://github.com/paulproteus/petwriter.git
cd petwriter
virtualenv env
env/bin/pip install -r requirements.txt
env/bin/python manage.py shell
```

* Then parse as follows:

```
>>> import importlib
>>> import django.conf
>>> session_module = importlib.import_module(django.conf.settings.SESSION_ENGINE)
>>> session_data = session_module.SessionStore(session_key="foo:bar")
# Use whatever was the sessionid= value from your cookie
>>> print session_data.load()
{'_auth_user_backend': 'django.contrib.auth.backends.ModelBackend', '_auth_user_id': 2}
# So let's make a new one
>>> session_data['_auth_user_id'] = 1
>>> session_store.save()
>>> print session_store.session_key
'new:thing'
```

* Now let's transfer that cookie into your browser.
* First clear your browser's cookies for this site, then:
* In your browser's Javascript console, do: ```document.cookie='sessiond=new:thing'```
* Now visit the homepage -- have you changed who you're logged in as?

---

## Generate session data for other users

### To earn your gold star, answer:

* How is the `SECRET_KEY` supposed to protect session data, for the `signed_cookies` backend?
* Why were you able to generate session data that the server trusted?
* How is pickle related to Django's `signed_cookies` system?

---

## SQL Injection

### Overview

* Many web apps, behind the scenes, access data from a database by sending SQL queries to it.
* A sample SQL query: `DELETE from users WHERE user_id=3;`
* If `user_id` were controlled by the attacker, the attacker could change the query to be:
* `DELETE FROM users WHERE user_id=user_id;`
* and you'd lose all your user data.
* SQL mappers like the Django ORM automatically escape parameters, so this might instead be:
* `DELETE from users WHERE user_id="user_id";`
* which would delete nothing.

---

## SQL Injection

### Your goal

* Find a view function that uses raw SQL queries, rather than the Django ORM.
* (**Read the source** for this!)
* Use this to post pet updates to a _pet you did not create_!
* Explain how you did it, in order to get a gold star.
* Type '`s`' to see hints.

Note:
* Once you find the vulnerable _view function_, find the form in the site that submits to it.
* If you own (e.g.) pet #5, go to its profile page, and notice that there's a form that POSTs to `/pets/update/5`
* Change it to instead POST to
/pets/update/3--
* Submit. Hooray!
* Why did this work? ([hint](http://docs.oracle.com/cd/B14117_01/server.101/b10759/sql_elements006.htm))


---



---

* Run some code locally
* Ask your group leader what their user ID is.
* 


This app uses Django's `signed_cookies` session backend, which means:

* It stores all session data in the _visitor's browser_, in a cookie, including the user ID of the visitor.
* To keep this secure, Django signs the data with the Django `SECRET_KEY` -- the server ignores all invalidly signed session data it receives.

Since the `SECRET_KEY` for the site is published ("oops"), you can generate whatever session data you want. You can use this to impersonate other users!

---

## Abuse pickle storage with session data (extra credit)

### Overview

This app uses pickle! If you didn't know that, take a look at the settings file.

Pickle is a way to take Python data, like `{'key': ['val11', 'val2']}` and turn it into a file that can be loaded into Python later.

Unfortunately, pickle is horrifyingly powerful: when loading data in from a pickle, Python will execute _code_ that the pickle file says to execute, not merely restore data.

Since Django's `signed_cookie` session store uses pickle to serialize the session data, you can cause _arbitrary code_ to run on the server.

---

## Abuse pickle storage with session data (extra credit)

### Your goal

* Take the work you did before to load custom session data, and
* instead of providing normal session data, provide normal session data _plus_ make the server execute some code.

This exploit will take about 2 hours to develop. FIXME.

References:

* http://www.balda.ch/posts/2013/Jun/23/python-web-frameworks-pickle/
* https://github.com/django/django/blob/master/django/contrib/sessions/backends/signed_cookies.py

---

TODO someone write a brief overview of how attendees can look for these -- Asheesh can write a draft of this, which Karen can smooth out maybe?


---

Note:

I plan to leave admin:admin as a valid login for /admin/
Therefore, the instructor handout needs to tell people to configure their Heroku instance with admin:admin as an admin on /admin/


# Thanks

All the following people helped with this tutorial:

* Jacky Chang
* Nicole Zuckerman
* Drew Fisher
* Asheesh Laroia
* Karen Rustad



---

## Learn more

- [RevealJS Demo/Manual](http://lab.hakim.se/reveal-js)
- [RevealJS Project/README](https://github.com/hakimel/reveal.js)
- [GitHub Flavored Markdown](https://help.github.com/articles/github-flavored-markdown)

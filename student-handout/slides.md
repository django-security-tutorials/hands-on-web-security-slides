# Student handout

### Web Application Security with Django, PyCon 2019

Navigate these slides by clicking the arrows at the bottom or use the 
right / left arrows on your keyboard.

---

## Make the most of lab time (#0)

* You have 90 minutes to get some hands-on practice.

* Visit [pettwitter.com](https://pettwitter.com) and click the link to find your group's test environment.

* Attack it, with the help of these slides.

* Some attacks are labeled **extra credit**; if you're new to security, I encourage you to skip those so you can 
  get to all the important attacks.

---

## Check your learning

* If you are the first person to finish an attack, send a PM to Jacinda with a link 
  to your work and the number from the slide heading. Once confirmed, announce in your group's channel that you've 
  successfully exploited this vulnerability. 
* Other people in your group should now turn to you for verification of vulnerability completion. 
  
---

## Social guidelines

* When you discover a peer doesn't know something, _don't_ say "Wow, I can't believe you don't know that!"
* If you offer to help someone, _truly engage_. Be next to them when doing so and answer follow-up questions.
* Respect people, and their questions, independent of their background, apparent ethnicity, gender, etc.

Reference: [The Recurse Center User's Manual](https://www.recurse.com/manual)

---

## TL;DR. Be kind.


[XKCD 1053 - Ten Thousand](https://xkcd.com/1053/)

![XKCD 1053](https://imgs.xkcd.com/comics/ten_thousand.png)

---

## Make the most of these slides

* Each slide explains a category of web app vulnerability that you can use to attack the app.
* If you have a question, check if that slide has **hints**!
* Type '`s`' on your keyboard to see the _special hints_.
* Look at the **progress bar** at the bottom to see how far along you are in the slides.

Note:
- Hooray! You opened the special hints successfully.

---

## Be social

* Use your small group's Slack channel to share your attacks with your peers. They will enjoy
 clicking a link that does something completely surprising.
* Having said that, don't be malicious. It's OK to send people links that do bad things on the Pettwitter site, but 
don't do things that would cause their computers to lock up, or other bad things that are outside the scope of Pettwitter.
* Appreciating surprises is an important part of the security mindset.


---

## Black box vs. white box

* In this tutorial, you have the source code for the app. We call this "white box testing." This simulates working as a
 security engineer at a company.
* "Black box testing," by contrast, assumes you don't have the app's source code.
* Feel free to constrain yourself by trying not to read the source if you want even more of a challenge.
* The point of this tutorial, though, is not so much to challenge you to the maximum, but instead to help you become
 familiar with a variety of security issues. Maximize your learning however works for you.

---

## Cross site scripting
### Overview (1/2)

Besides showing 

`<em>emphasized text</em>` 

and 

`<section>sections</section>`, HTML also includes tags that cause 
browsers take _actions_. If a site doesn't sanitize its inputs, but allows you to enter text that is treated as HTML 
when the site software renders the page, then you can run or embed whatever JavaScript you wish.


---

## Cross site scripting
### Overview (2/2)

When you can run JavaScript on a site that's not what the site owner expected, this is called _cross-site scripting_ 
(XSS).

---

## Cross site scripting
### Your goal (#1)

* Add some `<em>emphasized text</em>` to different text inputs in the site.
* Now click around the site. If you can see the text is _emphasized_, then make the page run some Javascript. 
  (Code example on the next slide)
* You can stop when you've found one. (For extra credit, find more than one.)
* **Check your learning**: Once you've done that, send a DM to Jacinda or someone on your team who's already 
  solved this and send them your attack link!

---

## Cross-site scripting
### Sample attack code

- Sample JS: ```< script>alert(1);< /script>```
- Feel free to Google [xss cheat sheet] for more.
- Type '`s`' for more suggestions on attack code.

Note:
- Other fun things: `< img src=x onerror="alert(1);">`
- (This works because `x` happens not to exist, so the IMG tag runs the `onerror` code.)
- TODO: Someone could write an epic site-specific weaponized script. 
- Small-group Q&A: Why can you cause JS execution in this one place, but not in all places? What sort of damage could the JavaScript have done?

---

## Default passwords
### Overview

Many pieces of software are shipped with easy-to-guess default passwords, with the expectation that whoever installs and administers the software will change the password. Many admins forget this step, however.

---

## Default passwords
## Your goal (#2)

* Find the admin site.
* Ask someone on Slack to tell you the username they used; then, create a new pet on their behalf!
* **Check your learning**: Send a DM to Jacinda or a team member with a link to the pet you created!

For more hints, press '`s`'

Note:
- Take a look through the **urls.py** in the code if you can't find the admin site.
- The username is admin. Take a wild guess at the password.
- Small group Q&A: Can you think of other things in your life that might have default passwords? Feel free to have a
 longer conversation with your group about default passwords if you have more questions!

---

## Improper authorization checking

### Overview

As a programmer, it's easy to forget to check if a user is authorized to POST to a given URL.

You might take care to have an HTML form only appear for authorized users. Crafty users can use their browser's site inspector to change the URL a form will POST to.

---

## Improper authorization checking

### Your goal (#3)

* Ask someone on Slack for a pet ID that isn't yours.
* Find a way to modify that pet.

* For more hints, press '`s`'

* **Check your learning**: Send a DM to Jacinda or a team member who's finished this step, 
  saying which function has the bug.

Note:
- Use your browser's "Inspect element" feature to change the `form action` on a pet profile page.
- Read the [code](https://github.com/django-security-tutorials/pettwitter/blob/master/thesite/communication_app/views.py) 
  for the views, or just try each of the forms on the pet profile page.
- Small group Q&A: What was special about this view that meant it had an authorization problem? How might you have written a bug like this?


---

## SQL Injection
### Overview

* Many web apps, behind the scenes, access data from a database by sending SQL queries to it.
* e.g.: `DELETE from users WHERE user_id=3;`
* If `user_id` were controlled by the attacker, the attacker could change the query to be:
```DELETE FROM users WHERE user_id=user_id;``` and you'd lose all your user data.
* SQL mappers like the Django ORM automatically escape parameters, so this might instead be:
```DELETE from users WHERE user_id="user_id";```which would delete nothing.

---

## SQL Injection
### Your goal (#4)

* Find a view function that uses raw SQL queries, rather than the Django ORM.
* (**Read the source** for this!)
* Use this to modify a _pet you did not create_!
* **Check your learning**: When you've done it, send a link to the pet page you updated to Jacinda or a team 
member. They'll ask you _why_ your attack worked.

* Type '`s`' to see hints.

Note:
- Once you find the vulnerable view function, find the form in the site that submits to it.
- If you own (e.g.) pet #5, go to its profile page, and notice that there's a form that POSTs to `/pets/update/5`
- Change it to instead POST to `/pets/update/3--` (the `--` is important!)
- Submit. Hooray!
- Think about why this worked. [Hint](http://docs.oracle.com/cd/B14117_01/server.101/b10759/sql_elements006.htm)

---

## Cross site request forgery

### Overview (1/2)

If there is a URL that changes server-side state, and it can be accessed with a `GET` request, then it's easy to make people's browsers request that URL.

One fun way is to make an `IMG` tag whose `src=` points to the URL in question.

---

## Cross site request forgery

### Overview (2/2)

* If _victim.com_ has a CSRF vulnerability, then Alice can make a page on _evil.com_ that, through Bob merely 
  visiting her _evil.com_ page, causes Bob to silently take some action on _victim.com_.
* The way cookies work is that they flow with every request Bob makes to _victim.com_.
* An IMG tag on _evil.com_ could cause Bob's browser to try to find an image on _victim.com_, or access Bob's 
  data on _victim.com_ because Bob is logged in.
* So in this way, Alice causes Bob to silently take actions on another site (i.e. "cross site").

---

## Cross site request forgery

### Your goal (#5)

* Create a web page that, when viewed, creates a new pet owned by whoever visits the page.
* You may want to ***read the app code*** to find a view function that accepts GET as well as POST.
* You can use [JSFiddle](https://jsfiddle.net/Lezp7350/) for HTML hosting.

* Press '`s`' for hints.

* **Check your learning**: Send your JSFiddle link to your instructor or team members.

Note:
- To figure out exactly how to craft the GET URL, start by using _Inspect Element_ to modify the form so that it is `method=GET` on your own computer.
- Since you will have to embed a pet name within the attack `IMG` tag, you may need to use the app's "delete all your pet data" before attacking someone else.
- Small group discussion: Ask the student, How did that work?

---

## Cross-site request forgery: extra credit (optional)

### Overview

Did you know that `POST` requests can also happen from other sites?

See [this StackOverflow question](http://stackoverflow.com/questions/17940811/example-of-silently-submitting-a-post-form-csrf) with advice on how to make it happen.

---


## Cross-site request forgery: extra credit (optional)

### Your task (#5b)

* Make a web page that, upon visiting it, causes all a user's pet info data to be deleted.

* **Check your learning**: Share a link in Slack. (This time, it's good to warn people!)

Note:
- Use JSFiddle again for hosting.
- It's fine if you skip this exercise.

---

## Generate sessions as others

### Overview (1/4)

HTTP is a "stateless" protocol, meaning each HTTP request is separate from other ones.

So let's say you log in at `/login/` and visit the home page (`/`) of a website. The homepage ought to know that you've logged in, so it can customize the homepage just for you.

Since these requests are separate, there must be some way for the `/login/` page to store some information so that `/` can look at it -- it needs to store at least your user ID.

To achieve this, HTTP grew a feature called "Cookies."


---

## Generate session data as others

### Overview (2/4)

Here's how cookies typically work:

* When you log in at `/login/`, that page stores a "cookie" in your browser.
* Then, when you make any follow-up requests, your browser sends that cookie to the server.

The `/` page needs the _user ID_ in order to customize itself. It might need other data, too; typically, it 
represents the "session data" as a Python dict, e.g.: ```{'user_id': 3}```

---

## Generate sessions as others

### Overview (3/4)

There are two common ways to use cookies to store session data.

One is to use a `session ID` cookie; the cookie contains a random number. When the server processes a request, it checks
 what _session data_ is associated with the session ID, loads that into memory, and hands it to the view function.

Another is to take the session data, e.g. `{'user_id': 3}`, turn that into text, and store the text in the cookie! This way, the server receives the raw session data. No need to look it up in a database from session ID to session _data_.

---
## Generate sessions as others

### Overview (4/4)

_However_, people's browsers can't really be trusted. So typically the session data is also _signed_ with a secret key. If the user tampers with the session data, the signature won't match.

Django calls this the `signed_cookies` session store. It uses the `SECRET_KEY` config variable to sign the data.

For this app, the _SECRET_KEY_ is just hanging out in `thesite/thesite/settings.py`. So you can change your session data... for example, changing your `user_id` to someone else's!

---

## Generate sessions as others

### Your task (#6)

* Use Django to parse the cookie data for your session.
* Pick a user that isn't you!
* Log in as them!
* **Check your learning**: Send a private message to Jacinda or a team member who's already finished this task 
 explaining why were you able to generate session data that the server trusted.
* More details on _how_ on the next slide.

---


### Implementation notes (1/5)

* In your browser, open up the console, and type: ```document.cookie```
* You'll see something like:
```sessionid="gibberish:moregibberish"; csrftoken=Iv2HhT3i20ft5zKdWTZ6YdofnHlAqrQQ"```
* Pull out just the `sessionid` component - in this case ```"gibberish:moregibberish"``` - we'll use this later.

---

### Implementation notes (2/5)

Get the app running locally:

```
git clone https://github.com/django-security-tutorials/pettwitter.git
cd pettwitter
# Below is one example of creating a virtualenv. There are others. Feel free to use those if you know how.
virtualenv -p python3 PET # This may not be necessary if python3 is your system Python
source PET/bin/activate
pip install -r requirements.txt
pip install ipython # Optional, but will give you a nicer shell experience
python thesite/manage.py shell
```

---

### Implementation notes (3/5)

Load the data as follows:

```
>>> from importlib import import_module
>>> from django.conf import settings
>>> from django.utils.crypto import salted_hmac
>>> session_module = import_module(settings.SESSION_ENGINE)
>>> session_data = session_module.SessionStore(session_key="foo:bar")
# Use whatever the sessionid= value was from your cookie
>>> print(session_data.load())
{
    '_auth_user_id': '4',
    '_auth_user_backend': 'django.contrib.auth.backends.ModelBackend',
    '_auth_user_hash': '64afb0fb3f941f61b1c7c87f6de7988a2b1261da'
}
```

---

### Implementation notes (4/5)

* _auth_user_hash is constructed from the hashed value stored in the password field in the database
* Now, where did we see that value again?

---

### Implementation notes (5/5)

Now, modify the data:

```
>>> session_data['_auth_user_id'] = THE_USER_ID_YOU_WANT_TO_BECOME
>>> key_salt = "django.contrib.auth.models.AbstractBaseUser.get_session_auth_hash"
>>> hashed_password = HASHED_PASSWORD_OF_USER_YOU_WANT_TO_BECOME
>>> new_session_auth_hash = salted_hmac(key_salt, hashed_password).hexdigest()
>>> session_data['_auth_user_hash'] = new_session_auth_hash
>>> session_data.save()
```

And extract something you can put into your browser:

```
>>> print(session_data.session_key)
'new:thing'
```

* Now let's transfer that cookie into your browser.
* Open an _Incognito Window_ or _Private Window_, and visit your group's _pettwitter_ instance.
* In the browser's Javascript console, do: ```document.cookie='sessionid=new:thing'```
* Now reload the homepage -- are you logged in? As who?

---

## Did that seem...contrived?

* You're probably thinking: "What idiot would override the UserAdmin like that?"
* And you're partly right. This exploit was a _lot_ easier to accomplish prior to 1.7 when _auth_user_hash was added
* BUT - dumps of user databases are not unheard of, and now you understand more about why SECRET_KEY needs to remain 
secret

---

## Abuse pickle storage
### Overview (extra credit)

This app uses pickle! Look at the settings file.

Pickle is a way to take Python data, like `{'key': ['val11', 'val2']}` and turn it into a file that can be loaded into Python later.

Unfortunately, pickle is powerful: when loading data in from a pickle, Python will execute _code_ that the pickle file says to execute, not merely restore data.

Since Django's `signed_cookie` session store uses pickle to serialize the session data, you can cause _arbitrary code_ to run on the server.

---

## Abuse pickle storage
### Your goal (#7 / extra credit)

* Take the work you did before to load custom session data, and
* Instead of providing normal session data, provide normal session data _plus_ make the server execute some code.

Implementation hints on the next slide.


References:

* http://www.balda.ch/posts/2013/Jun/23/python-web-frameworks-pickle/
* https://github.com/django/django/blob/master/django/contrib/sessions/backends/signed_cookies.py

---

## Abuse pickle storage
### Implementation hints

* On your computer, create a Python object that does `os.system('echo zomg')` in the `__reduce__` method
* Pickle that thing on your own system.
* Use `pickle.loads()` on your own system to verify that when you load the data, it executes the `echo zomg` shell command.
* Now, turn the session data from earlier into a `UserDict` subclass with a custom `__reduce__` method.
* Now that _should_ cause remote code execution on the server.
* This has not been tested on Python 3 / Django 2.2 and is not guaranteed to work.

---

## Fix the issues
### Your goal (#8 / extra credit)

* If you're done early, we recommend you try to _fix_ some of the security issues in the app.
* To do that, first _fork_ [the project](https://github.com/django-security-tutorials/pettwitter) on GitHub, then 
_clone_ the forked version to your computer.
* To set up a local dev environment, see next slide.

---

## Fix the issues
### Development environment (extra credit)

```
git clone YOUR_FORK_URL_HERE
cd pettwitter
virtualenv -p python3 ENV_NAME
source ENV_NAME/bin/activate
pip install -r requirements.txt
cd thesite
python manage.py migrate
python manage.py runserver
```

---

# Thanks

All the following people helped with this tutorial:

* Jacky Chang
* Drew Fisher
* William Hakizimana
* Asheesh Laroia
* Andrew Pinkham
* Karen Rustad
* Jacinda Shelly
* Nicole Zuckerman

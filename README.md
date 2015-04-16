![](https://matt-tv.herokuapp.com/assets/mtv_logo-dc062b89cca1ca3e9833c56582c97bad.png)

https://matt-tv.herokuapp.com/

Includes: JavaScript, Jquery, HTML/CSS, real-time scraping, real-time API calls, regular old ruby classes, activerecord and postgres.

The project originated as a way to 'favorite' television shows in order to keep track of their air dates/times and when they premiere. It evolved into a database of television shows with lots of real time information from APIs and scraping.

O-auth through facebook to have your liked/followed TV shows on Facebook automatically added to your personal list of favorites (if they are in the database).

The HOME page includes a short description of the site and includes a random sample of 6 of the shows from the database that link to that show's profile page. 

8 news articles are scraped from tv.com and linked at the bottom of the homepage. These 8 articles are a random sample from the 16 on the front page of tv.com. Everytime the homepage is reloaded, these articles will change.

The SHOWS page lists all the shows in the database. Each show can be favorited or unfavorited from this page. A nav bar linked to anchor links (a-z) is there to help with navigation because the page is so large.

The FAVORITES page lists only those shows that a person has chosen to follow. Each show lists the primere date, station, time and day that that specific show airs.

The PROFILE page for each show consists of data that is mostly rendered in real time. An API request is sent to themovidedatabase.com and returns the pictures, description, embedded youtube video (if there is one) and the current season information.

The SEARCH function is a postgres full-text, robust search that searches for shows by name, actors/characters, tv station and summary.

*todo*

email system to alert users when their shows are airing.

real-time airing information.

actual links to watch episodes.

top favorited shows.
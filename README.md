# README - Weather Application

This application takes an address as input and outputs to a page the current weather information.

## Running locally

* Clone this repo
* run `bundle`
* run `rails db:create`
* run `bundle exec figaro install`
* Add the below enviroment variables to application.yml

This application relies on OpenWeather API and MapQuest API.

``` yml
map_quest_key:
map_quest_secret:
open_weather_key:
```

Optionally to enable caching locally in dev run `rails dev:cache`.

## Testing

* Testing can be ran by running `rspec` to run the entire test suite.

## Future and Considerations
These are areas in no particular order that I would look to improve if I was to spend additional time.

* Look at adding type ahead on search input to help the user get to an address faster.
* Consider caching the address lat/long lookup for a longer period of time or persist in a database.
* Adding future weather forecasting and utilize paritials for html.
* Further test edge cases on service classes.

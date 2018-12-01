# README

## Basics

Ruby: 2.5.3 (rails 5.2.1)
bundle install
rails db create
rails db:migrate
rails db:migrate RAILS_ENV=test
rails spec

No external dependencies such as redis or mysql needed.

## What is this?

* This is a sorta-kinda trello like environment with boards, that have columns and each column has stories.
* There is no authentication or authorization. Maybe some other time.
* This is a pure json api, no UI!
* The api endpoints support crud operations on board, columns and stories.
* Also, there is an endpoint at /v1/columns/:column_id/stories/find_by_attributes.json that accepts a status or an array of statuses and a date or array of dates and returns stories within the target column matching the given params.



## TODO

1. Add documentation for the endpoints.

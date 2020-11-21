# Please do NOT open any pull requests to this repository!

## Welcome to Pairguru App!
Place where we examine our candidates

[For recruiters](#for-recruiters)

## For candidates
### :hammer: Setup

Before pairing:
 - Clone repo `git clone git@github.com:netguru-training/pairguru.git`
 - run `bundle install` within app directory
    - Note on Big Sur:
      ```
      Xcode 12 Beta Command Line Tools now sets -Werror=implicit-function-declaration by default
      ````
      Install FFI gem with:
      ```
      gem install ffi -v '1.9.23' --source 'https://rubygems.org/'  --  --with-cflags=-Wno-implicit-function-declaration
      ```
 - run `rake db:setup` This will create database, run migrations and fill db with seeds
 - run `rails s` :boom:

## Pre-interview tasks

- You don't have to do any tasks that you weren't asked to solve
- Do not fork the repository - clone it
- Do not forget to write tests for your solutions
- Do not remove contents of this README
- Put solutions for tasks in separate pull requests with descriptive commits, merge them to master branch after all
- Do not forget to check if all tests pass by running command `RAILS_ENV=test bundle exec rspec` from you app folder

### Task 1 - consume api
We would like to have more information about the movie in movie show and index page.
- the information should come from pairguru api (e.g. https://pairguru-api.herokuapp.com/api/v1/movies/Godfather)
- movie poster (e.g. https://pairguru-api.herokuapp.com/godfather.jpg), rating and plot overview should be displayed
- can't store this data in database

### Task 2 - build api
We would like to share our movies via api.
- allow for user to get specific movie by id
- return list of all movies (id and title)
- extend results by adding genre details (genre id, name and number of movies in this genre to be returned along with the movies) - don't break api for existing users or make them to fetch more data

### Task 3 - long running tasks
We have two tasks that run too long and users leave our page frustrated:
a) emailing details about movie (button in movie show)
b) emailing movies csv export (in navigation)
- update application so user doesn't have to wait for page load and still get emails

### Task 4 - brackets validation
Our moderators are adding parentheses and brackets to the titles.
For example `The Fellowship of the Ring [Lord of The Rings {Peter Jackson}] (2012)`.
- make sure that all brackets are closed and not empty (they can be nested as in the example above)
- uncomment tests in `spec/validators/title_brackets_validator_spec.rb`
- add validations for movie title that match all the criteria
- all tests should be passing
- hint: don't use regular expressions

### Task 5 - comments
Our users want to comment on movies.
- add feature that allows for users to do that
- under the movie description, display new comment form and all the remaining comments
- one user should be allowed to leave only one comment to the movie (can create another only if he deletes previous one)

### Task 6 - sql query - dependent on 5
We want to reward our users for commenting movies.
- create page with top commenters this week.
- display 10 users that have the most comments in last week (from 7 days ago to now)
- don't spam database with many queries in one pageview
- hint: it can be solved with ActiveRecord


## For recruiters
There is private [pairguru](https://github.com/netguru/pairguru) repository. In pull requests you can find example solutions for this tasks.

### To contribute fixes/updates
* Fork repository
* Create pull request (from forked repository, not pairguru itself)
* Ask for review one of the contributors
* After PR is merged branch will be automatically propagated to public repo for candidates

### To add new tasks (please do!)
* Add task description in this README
* Create example solution on a branch with `solution` in branch name (eg. `solution-task-7-description`) - it won't be propagated to public repo this way
* You can create specific setup for your task (eg. some prepared bug, configured tool to be used)
  * Create new branch with this setup - it will be propagated to public repo
  * Push branch to [pairguru](https://github.com/netguru/pairguru). It will be propagated to public repo
  * Specify in this task description that it should be solved on this branch
* If you change something in the repo please try to update ruby/rails/gems versions to the latest.

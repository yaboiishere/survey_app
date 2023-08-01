# README

### Simple Ruby on Rails surveys app

#### To run the app:

- Clone the repository
- Run `docker-compose up`
- In a separate terminal run `docker-compose run web rake db:seed`to generate the data needed for the app

#### To use the app:
- Go to `localhost:3000` in your browser
- You can fill out a survey
- You can create an account and log in
- Once logged in you can create a survey
- You can also view the results of the surveys you have created

### Run rake/rails tasks:
- Run `docker-compose run web rake <task_name>` to run a rake task
- Run `docker-compose run web rails <task_name>` to run a rails task

#### To reset the database:
- Run `docker-compose run web rake db:reset`

#### To run the tests:

- The tests are run when the app is started
- To run them manually use `docker-compose run web rake test`

#### Versions:

- Ruby version: 3.1.4
- Rails version: 7.0.6

# README

## Ruby version
  - ruby 2.6.8p205
  - rails 6.1.6
## Local Setup

### Install dependencies:

```bash
$ bundle install
```

### Database creation
  Run the following commands for database creation:
    `rake db:setup`
    `rake db:migrate`

### Database initialization
  - There will be scheduled job which will run daily and collect information about the exchange rate that has been added to the database on NBP. To begin the scheduler run `whenever -w`.
  - You can run the rake task of `collect_exchange_rate:monthly` and fill the database with the exchange rates of current month manually.

### Testing
 - Hit the following route with the postman to get the exchange rates -> http://localhost:3000/table_types/exchange_rates
 - Supply the date range and currency name in query params ( start_date=2022-06-22&end_date=2022-06-22&currency=USD )
 - Supply the format the get the result in specific format ( json, csv )
 - Full url you will hit will be like this -> http://localhost:3000/table_types/exchange_rates.csv?start_date=2022-06-22&currency=USD

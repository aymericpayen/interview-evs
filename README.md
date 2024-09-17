# Potato Trader API

This is a Ruby on Rails API application for tracking potato prices and calculating the best possible gain.

## Installation

1. Clone the repository:
   ```
   git clone https://github.com/aymericpayen/interview-evs.git
   ```

2. Install dependencies:
   ```
   bundle install
   ```

3. Set up the database:
   ```
   rails db:create db:migrate db:seed
   ```

## Running the Application

The API will be available at `http://localhost:3000`

## Running Tests

Execute the test suite with:
  ```
  rails test
  ```

## API Endpoints

- GET `/potatoes/prices?date=YYYY-MM-DD`: Retrieve potato prices for a specific date
- GET `/potatoes/best_possible_gain?date=YYYY-MM-DD`: Calculate the best possible gain for a specific date

## Side notes / Possible improvements

- `calculate_max_gain` method optimized from quadratic to linear perf algo. There could be further improvements most likely
- potatoes's controllers contains logic `valid_date?`, it can be extracted to related services. Same for the begin..rescue pattern. This way #show enclosed less logic and follow "Single Responsibility Principle"
- potatoes's services have some common methods, it can be mutualized in order the codebase to be DRY
- `seed.rb` could have contained more seeds
- tests are using default RoR testing framework, using Rspec would lead to better organization (describe, context...)
- potatoes's controllers related tests are covering some edge cases, more edge cases exist most likely.
- Adding factories for test
- Use a serializer so the output of the endpoints can be understood from most of the clients
- Assuming potatoe stocks are sampled in milliseconds, queries to extract prices can be heavy and degraded app performance. Maybe adding caching mechanism could help (indexing on time already present)

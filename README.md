# Event Management System

This is an Event Management System built with Ruby on Rails. It allows users to create, view, edit, and delete events, as well as assign workers to events and fetch weather information for event locations.

## Features

- User authentication with Devise
- Event CRUD operations
- Worker assignment to events
- Weather information fetching for event locations
- API endpoints for event operations
- Pagination using Pagy

## Setup

1. Clone the repository
2. Install dependencies:
   ```
   bundle install
   ```
3. Set up the database:
   ```
   rails db:create db:migrate
   ```
   ```
   rails db:seed
   ```
4. Set up environment variables:
   Create a `.env` file in the root directory and add your OpenWeather API key:
   ```
   OPENWEATHER_API_KEY=your_api_key_here
   ```

## Running the Application
5. Start the Rails server:
   ```
   rails server
   ```
6. Visit `http://localhost:3000` in your web browser to access the application.

## Testing the API

You can test the API endpoints using tools like cURL or Postman. Here are some example API calls:

1. List all events:
   ```
   GET http://localhost:3000/api/v1/events
   ```

2. Create a new event:
   ```
   POST http://localhost:3000/api/v1/events
   Content-Type: application/json

   {
     "event": {
       "title": "New Event",
       "start_time": "2023-06-01T10:00:00Z",
       "end_time": "2023-06-01T12:00:00Z",
       "user_id": 1,
       "worker_id": 2,
       "location": "New York"
     }
   }
   ```

3. Show a specific event:
   ```
   GET http://localhost:3000/api/v1/events/1
   ```

4. Delete an event:
   ```
   DELETE http://localhost:3000/api/v1/events/1
   ```

Remember to replace the IDs and data in these examples with actual values from your application.

## Additional Information

For more details on the API endpoints and their usage, refer to the `app/controllers/api/v1/events_controller.rb` file.

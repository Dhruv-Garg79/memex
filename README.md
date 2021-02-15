# XMeme
This project was build under Crio Winter of Doing Stage-2 Phase-B. This is a full-stack application. A user can create, read, update and delete memes in this app.

## Tech Stack
Frontend - Flutter web

Backend - Node.js (Express.js)

Database - Posgress

### Frontend
- Provider Pattern for state management.
- Widgets splitted in modular pieces.
- models folder : contains meme model and response model. These are data wrappers.
- MemeProvider : This is like controller and calls ApiProvider to get api response and notify view about data change.
- MemeApiProvider : This calls API and handle processing response.
- utils folder : This contains all the helper classes like logger, api_client, global variables, and helper class.
- view : It contains all the UI of the app.
- widgets folder : contains common widgets.
- app_theme : contains theming and styles of the app.
- main.dart : This starts the app. It is like index.js.
- The website is responsive on different screen sizes.

### Backend
- MemeService : This service handles all the database operations and business logic of the app
- Meme modal : This is the schema of our Meme table in postgress DB
- MemeController : this controller glues everything together, service and the routes
- config folder : this contains database, routes and server.js. Everything is setuped here.
- ES6 syntax is used and compiled by babel for deployment.

### Deployment
Frontend deployed on netlify - https://memex-dhruv.netlify.app/

Backend and database deployed on heroku - https://xmeme-backend-dhruv.herokuapp.com/

### Additional tasks attempted
1. HTTPS version for both frontend and backend
2. Delete and update meme APIs and option for same in frontend.
3. Swagger documentation available on `http://localhost:8080/swagger-ui/`
4. Dockerized solution using docker-compose.yml

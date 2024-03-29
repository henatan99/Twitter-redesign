# Twitter Re-design: Rails Capstone Project 

This is a Ruby on Rails Capstone project from the Microverse Ruby curriculum. The project is building an app which basically is a redesign of Twitter. Given the design of the website, the app serves users to share opinions about different things. 

## Description 
The app is expected to be a minimum viable product(MVP) serving the basic functionality of the presented requirements. 
### User SignUp and Login 
The app lets new users create user account and signup. Once the user account is created a user can sign up and get all the app's users services.
- A new user is valid if it has a unique username and a full name present. The user can upload photo and cover images but not required for validation.

![screenshot](docs/new_session.png)
![screenshot](docs/sign_up.png)

### Home Page 
Once a user is logged in it will be redirected to the home page which is the opinions index page. There, the user can see the list of all opinions posted by all users in descending order in created time from latest to earliest.
The home page has three sections
- the left section  has a users stat section and a navigation section
- The stat section displays the number of followings and followers of the logged_in user
- the navigation section has a home, profile, and connect links. The home link redirects to the home page, the profile to the current_user show page, and the 'connect' to the 'users' index page. 
- The middle section has the new opinion form and the opinions section which lists all the opinions posted by all users with their profile and the time created. 
- The right section has the who to follow list. It lists all users who are not already being followed by the current_user. 

![screenshot](docs/home.png)

### User show page 
The user show page has the three sections as the home page: left, middle and right sections.
- The left side is exactly the same for all the pages 
- The middle section of the show page has 
    - A cover image of the user
    - A navigation bar with the followers, following, lists, and opinion(back to user_show) links 
    - Lists of all the opinions posted by the user 
- The right section of the show page has
    - A profile section with the user photo, user full name, and username 
    - A section showing the number of opinions, followers, and followings of the user
    - A followers section listing all the followers of the user    

![screenshot](docs/user-show.png)

### Users index page 
The user index page lists all the users with their profile

![screenshot](docs/connect.png)

### Followers show page 
The followers show page has similar views as the user show page except it lists the followers of the user instead of the opinions

### Following show page
The following show page has similar views as the user show page except it lists the followed users of the user instead of the opinions

### Application layout view
The application view has a layout view with a common header bar which has the profile of the current user and links 
- The profile contains the user's photo and full name 
- For a logged_in user it has a logout link 
- For a new session and new_user it has SignIn and SignUp links

## MVC implementation 
The rails model view controller concept is implemented based on rails convention over configuration approach.

### Entity relationship diagam(ERD)
![screenshot](docs/Entity_Relationship_Diagram_(UML_Notation)_(2).png)

### Models and associations 
Based on the ERD given, the User, Opinion, and Following models are created
- The user and opinion have 'one' to 'many' relationships
- The user and following has many to many (and inverse) relationships 
- Validations are implemented for the models 

### Database schema 
The models have their respective database schema 
- 'user' : username: string, 'fullname' : string, photo: string, cover: string 
- opinion: author_id: integer, text: text
- following: follower_id: integer, followed_id: integer
- Uniqueness of a following is implemented by followed_id with the scope of followed_id

### Controllers and resources 
The controllers are efficiently utilized to address the N+1 query problems. 
The controller resources used are 
- user: index, new, create, update, destroy, show
    - with members: followers, following, follow, unfollow
- opinion: new, edit, index
- session: new, create, destroy 

### Uploaders 
Carrier-wave gem is used for photo and cover image uploading and writing to the database 

## N+1 query problems 
To avoid N+1 database queries from the web server the pre-loading of the objects variants is used before rendering views, thereby preventing unnecessarily repeated queries.  
Eg:- In the user show and index methods, we have 
- @user_opinions = @user.opinions.includes(:authors).order('created_at DESC') 
- @users = User.all_except(current_user)
The @user_opinions is an instance variable which preloads all the opinions posted by a user except the current_user. When the user_show page is viewed, all the user's opinions are stored in the @user_opinions instance variable, which avoids the need for database queries for each opinion of the user from the view page. 

## Live demo [Heroku]
https://polar-eyrie-60544.herokuapp.com/ 

## Built With

- Ruby on Rails 
- VS code
- Carrier-wave gem 
- SASS


## Getting Started
The usage of this program is simple. 

### Prerequisites

- Ruby
- Rails 

## Setup

### running with a local server 
- git clone https://github.com/henatan99/tweeter-redesign- 
- Bundle  
```bash
bundle install 
```
- Migrate database 
```bash
db:migrate 
```
- Once the project is implemented 
**Run the code demonstrations below**

```bash
rails s 
```

**For console test demonstrations below**
```bash
rails c 
```

**For routes**
```bash
rails routes 
```
## Authors

👤 **Henok Mossissa**

- GitHub: [@henatan99](https://github.com/henatan99)
- Twitter: [@henatan99](https://twitter.com/henatan99)
- LinkedIn: [Henok Mossissa](https://www.linkedin.com/in/henok-mekonnen-2a251613/)

## :handshake: Contributing

Contributions, issues, and feature requests are welcome!

## Show your support

Give a :star:️ if you like this project!

## Acknowledgment 

- behance.com for the page designs 
- Twitter for the original idea
- vectr.com for online logo development 
- Iconify for amazing icons 

## :memo: License

This project is [MIT](./LICENSE) licensed.


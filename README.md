# Dominion

#### Web app recreation of the board game Dominion using Ruby and JavaScript

#### By Bryan Lin, Ilene Gorski, David Shin, Jonathan Kang

## Rules
* Each player starts their deck with 7 coppers and 3 estates.
* Each respective player's decks are shuffled and each player draws 5 cards.
* On player turn, they start off on their action phase which allows them to play 1 action card. They can play additional action cards if they play a card that allows additional actions.
* Once player ends their action phase, they are now on their buy phase where they are allowed one "buy" (unless player previously played an action card that allows for additional buys).
* The player's turn ends when they are out of "buys" or when they click on the "end turn" button.
* The game ends when any of the three action piles are depleted or when all of the Provinces in the pile are depleted. At that point, the player with the most victory points wins. If two players tie, they are both considered winners.

## Setup
* Before starting, make sure Postgres is installed: https://www.learnhowtoprogram.com/ruby/ruby-database-basics/installing-postgres-7fb0cff7-a0f5-4b61-a0db-8a928b9f67ef
* Clone the repository: "git clone https://github.com/bryanlin39/dominion.git"
* Navigate to the project directory: "cd dominion"
* Run "bundle install" in the terminal to install all Gems and dependencies
* To set up the database:
  * Launch PostgreSQL by typing "postgres" into a terminal window
  * Create the database: "rake db:create" in a separate terminal window
  * Create the tables: "rake db:migrate"
  * Seed the database with the game cards: "rake db:seed"
* Launch the app: "ruby app.rb"
* Access the app on "localhost:4567" in the browser

## Technologies Used
* Ruby
* PostgreSQL
* Javascript
* jQuery
* HTML
* CSS

## Known Bugs
* The card amount text disappears when you hover over a card on the board.
* Money accumulated through action cards are nullified when combo'd with another action card.
* Some action cards do not get discarded from hand after played.
* Styling does not conform to the size of the div when the game ends.

## Support and contact details
Contact Bryan with any and all complaints about the project or your life in general.

### License
*Copyright (c) 2017 Epicodus

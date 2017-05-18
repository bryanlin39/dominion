# Dominion
#### By Bryan Lin, Ilene Gorski, David Shin, Jonathan Kang

## This is a working application of the board game Dominion


## Rules:
* Each player starts their deck with 7 coppers and 3 estates.
* Each respective player's decks are shuffled and each player draws 5 cards.
* On player turn, they start off on their action phase which allows you to play 1 action card. You can play additional action cards if you play a card that allows additional actions.
* Once player ends their action phase, they are now on their buy phase where they are allowed one "buy" (unless player previously played an action card that allows for additional buys).
* The player's turn ends when they are out of "buys" or when they click on the "end turn" button.
* The game ends when either three of the action piles are depleted or when all of the provinces in the pile are depleted. At that point, the player with the most victory points wins. If two players tie, they are both considered winners.


## Setup
* Before starting, make sure you have Postgres installed: https://www.learnhowtoprogram.com/ruby/ruby-database-basics/installing-postgres-7fb0cff7-a0f5-4b61-a0db-8a928b9f67ef
* Open a terminal and run $ bundle in the terminal window
* Clone this repository https://github.com/bryanlin39/dominion.git
* In the terminal, run $ psql
* In the terminal, run $ db:seed to prepopulate the game's cards into the database
* Run $ bundle in the terminal window
* Run ruby app.rb in the terminal
* Open on localhost:4567 in browser

## Technologies Used
* HTML
* Ruby
* Postgres SQL
* Javascript
* jQuery

## Known Bugs

* The card amount text disappears when you hover over a card on the board.
* Money accumulated through action cards are nullified when combo'd with another action card.
* Some action cards do not get discarded from hand after played.
* Styling does not conform to the size of the div when the game ends.

## Support and contact details

Contact Bryan with any and all complaints about the project or your life in general.

### License

*Copyright (c) 2017 **_{Epicodus}_***

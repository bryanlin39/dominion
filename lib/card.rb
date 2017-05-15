class Card < ActiveRecord::Base
  has_many :decks
  has_many :players, through: :decks
  belongs_to :supplies
end

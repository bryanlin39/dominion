class Deck < ActiveRecord::Base
  belongs_to :players
  belongs_to :cards
end

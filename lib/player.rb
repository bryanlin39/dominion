class Player < ActiveRecord::Base
  has_many :decks
  has_many :cards, through: :decks

#use shuffle method as part of converting discard to draw
  def draw_hand
    draw=Deck.where(player_id: self.id, location: "draw")
    hand=draw.shift(5)
    if hand.length < 5
      self.shuff
      draw.shift(5-hand.length).each do |card|
        hand.push(card)
      end
    end
    hand.each() do |card|
      card.update({:location => "hand"})
    end
  end
  def discard
    hand=Deck.where(player_id: self.id, location: "hand")
    hand.each { |card| card.update({:location => "discard"}) }
  end
  def shuff

  end
  # def draw
  #
  # end


end

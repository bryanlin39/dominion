class Player < ActiveRecord::Base
  has_many :decks
  has_many :cards, through: :decks

  #each player should draw_hand at the end of their turn
  def draw_hand
    draw=Deck.where(player_id: self.id, location: "draw")
    hand=draw.shift(5)
    if hand.length < 5
      self.shuffle_deck
      draw.shift(5-hand.length).each do |card|
        hand.push(card)
      end
    end
    hand.each() do |card|
      card.update({:location => "hand"})
    end
  end
  #each player should discard_hand after action and buy phase complete
  def discard_hand
    hand=Deck.where(player_id: self.id, location: "hand")
    hand.each { |card| card.update({:location => "discard"}) }
  end

  #use shuffle_deck when draw pile is empty
  def shuffle_deck
    draw = Deck.where(player_id: self.id, location: "discard")
    # draw = draw.shuffle

    draw.each do |card|
      card.update({:location => 'draw'})
    end
  end

  # def draw
  #
  # end

  def find_player(id)
    found_player = nil
    Player.all.each do |player|
      if player.id == id.to_i
        found_player = player
      end
    end
    found_player
  end

end

class Player < ActiveRecord::Base
  has_many :decks
  has_many :cards, through: :decks

  #each player should draw_hand at the end of their turn
  def draw_hand(number_to_draw)
    draw = Deck.where(player_id: self.id, location: "draw")
    draw_cards = []
    draw.each { |card| draw_cards.push(card) }
    #hand variable represents number of cards moving to hand
    hand = draw_cards.shift(number_to_draw)
    hand.each() do |card|
      card.update({:location => "hand"})
    end
    if hand.length < number_to_draw
      self.shuffle_deck
      new_draw = Deck.where(player_id: self.id, location: "draw")
      new_draw_cards = []
      new_draw.each { |card| new_draw_cards.push(card) }
      more_cards = new_draw_cards.shift(number_to_draw - hand.length)
      more_cards.each { |card| hand.push(card) }
    end
    hand.each() do |card|
      card.update({:location => "hand"})
    end
  end

  #each player should discard_hand after action and buy phase complete
  def discard_hand
    hand = Deck.where(player_id: self.id, location: "hand")
    hand.each { |card| card.update(location: "discard") }
  end

  def discard_card(card)
    Deck.where(card_id: card.id).update(location: "discard")
  end

  #use shuffle_deck when draw pile is empty
  def shuffle_deck
    draw = Deck.where(player_id: self.id, location: "discard")
    draw = draw.shuffle
    draw.each { |card| card.update(location: 'draw') }
  end

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

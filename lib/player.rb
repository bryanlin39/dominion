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

  def self.find_player(id)
    found_player = nil
    Player.all.each do |player|
      if player.player_num == id
        found_player = player
      end
    end
    found_player
  end

  def total_victory_points
    victory_cards = self.cards.where(card_type: 'victory')
    total_points = 0
    victory_cards.each do |card|
      total_points += card.victory_value
    end
    total_points
  end

  def hand
    hand_cards = Deck.where(player_id: self.id, location: 'hand')
    result = []
    hand_cards.each do |card|
      found_card = Card.find(card.card_id.to_i)
      result.push({
        'name'=>found_card.name,
        'cost'=>found_card.cost,
        'rules'=>found_card.rules,
        'card_type'=>found_card.card_type,
        'money_value'=>found_card.money_value,
        'victory_value'=>found_card.victory_value,
        'image'=>found_card.image
        })
    end
    result
  end

end

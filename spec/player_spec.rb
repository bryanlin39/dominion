require 'spec_helper'

describe Player do

  describe '#cards' do
    it 'returns cards associated with the player' do
      player = Player.create(name: 'Ilene')
      expect(player.cards).to eq([])
    end
  end

  describe '#shuffle_deck' do
    it "shuffles the deck and puts it into the draw pile" do
      player = Player.create(name: 'Ilene')
      card = Card.create(name: 'Province')
      5.times do
        Deck.create(player_id: player.id, card_id: card.id)
      end
      player.shuffle_deck
      draw = Deck.where(player_id: player.id, location: 'draw')
      expect(draw.length).to eq(5)
    end
  end

  describe '#draw_hand' do
    it "moves 5 cards from draw location into hand location" do
      player = Player.create(name: 'Ilene')
      card = Card.create(name: 'Province')
      5.times do
        Deck.create(player_id: player.id, card_id: card.id)
      end
      player.shuffle_deck
      player.draw_hand(5)
      hand = Deck.where(player_id: player.id, location: "hand")
      expect(hand.length).to eq(5)
    end
  end

  describe '#draw_hand' do
    it "moves 5 cards from draw location into hand location" do
      player = Player.create(name: 'Ilene')
      card = Card.create(name: 'Province')
      3.times do
        Deck.create(player_id: player.id, card_id: card.id)
        Deck.update(location: 'draw')
      end
      2.times do
        Deck.create(player_id: player.id, card_id: card.id)
      end
      player.draw_hand(5)
      expect(Deck.where(player_id: player.id, location: "hand").length).to eq(5)
    end
  end

  describe '#draw_hand' do
    it "moves any number of cards from draw location into hand location" do
      player = Player.create(name: 'Ilene')
      card = Card.create(name: 'Province')
      card2 = Card.create(name: 'Estate')
      5.times do
        Deck.create(player_id: player.id, card_id: card.id)
        Deck.update(location: 'hand')
      end
      deck1 = Deck.create(player_id: player.id, card_id: card.id)
      deck2 = Deck.create(player_id: player.id, card_id: card.id)
      deck1.update(location: 'draw')
      deck2.update(location: 'draw')
      2.times do
        Deck.create(player_id: player.id, card_id: card.id)
      end
      player.draw_hand(3)
      expect(Deck.where(player_id: player.id, location: "hand").length).to eq(8)
    end
  end

  describe '#discard_hand' do
    it "sends player's cards from hand to discard pile" do
      player = Player.create(name: 'Ilene')
      card = Card.create(name: 'Province')
      5.times do
        Deck.create(player_id: player.id, card_id: card.id)
        Deck.update(location: 'hand')
      end
      player.discard_hand
      expect(Deck.where(player_id: player.id, location: "hand").length).to eq(0)
    end
  end

  describe '#discard_card' do
    it "sends a specific card from the player's hand to the discard pile" do
      player = Player.create(name: 'Ilene')
      card = Card.create(name: 'Province')
      Deck.create(player_id: player.id, card_id: card.id)
      Deck.update(location: 'hand')
      player.discard_card(card)
      expect(Deck.where(card_id: card.id)[0].location).to eq('discard')
    end
  end

  describe '#total_victory_points' do
    it "calculates the total amount of victory points for a player" do
      player = Player.create(name: 'Ilene')
      duchy = Card.create(card_type: 'victory', victory_value: 3)
      province = Card.create(card_type: 'victory', victory_value: 6)
      Deck.create(player_id: player.id, card_id: duchy.id)
      Deck.create(player_id: player.id, card_id: province.id)
      expect(player.total_victory_points).to eq(9)
    end
  end
end

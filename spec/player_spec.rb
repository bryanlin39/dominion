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
  # describe '#draw_hand' do
  #   it "moves 5 cards from draw location into hand location" do
  #     player = Player.create(name: 'Ilene')
  #     5.times do
  #       card1 = Card.create(name: 'Province', player_id: player.id)
  #     end
  #
  #   end
  # end
end

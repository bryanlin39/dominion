require('spec_helper')

describe Deck do
  describe '#discard' do
    it "puts card into discard location by default" do
      deck=Deck.create(player_id: 2, card_id: 3)
      expect(deck.location).to eq('discard')
    end
  end
end

require('spec_helper')

describe Card do
  describe '#discard_card' do
    it "puts a selected card into discard location" do
      card=Card.create(name: 'Copper')
      deck=Deck.create(card_id: card.id)
      card.discard_card
      expect(deck.location).to eq('discard')
    end
  end
end

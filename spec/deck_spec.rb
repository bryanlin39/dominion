require('spec_helper')

describe Deck do
  describe '#discard' do
    it "puts card into discard location by default" do
      deck=Deck.create(player_id: 2, card_id: 3)
      expect(deck.location).to eq('discard')
    end
  end

  describe '.setup' do
    it "deals 3 estates and 7 coppers to each player" do
      estate=Card.create({:name=>'Estate'})
      copper=Card.create({:name=>'Copper'})
      player = Player.create(name: 'Bryan')
      Deck.setup
      expect(player.cards.length).to eq(10)
    end
  end
end

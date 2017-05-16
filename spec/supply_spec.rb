require('spec_helper')

describe(Supply) do
  describe('#gain_card') do
    it "moves a card from the board to a player's deck" do
      player = Player.create(name: 'Ilene')
      province = Card.create(name: 'Province')
      province_supply = Supply.create(card_id: province.id, amount: 10)
      province_supply.gain_card(player)
      expect(province_supply.amount).to eq(9)
      expect(player.cards.include?(province)).to eq(true)
    end
  end
  describe('.game_over?') do
    it('returns sets result to true if game is over') do
      act1 = Card.create({:name=>'action1', :card_type=>'action'})
      act2 = Card.create({:name=>'action2', :card_type=>'action'})
      act3 = Card.create({:name=>'action3', :card_type=>'action'})
      Supply.create({:card_id=>act1.id, :amount=>0})
      Supply.create({:card_id=>act2.id, :amount=>0})
      Supply.create({:card_id=>act3.id, :amount=>0})
      expect(Supply.game_over?).to(eq(true))
    end
  end
  # describe('.board') do
  #   it('returns nested array of cards currently on the board') do
  #     act1 = Card.create({:name=>'action1', :card_type=>'action'})
  #     act2 = Card.create({:name=>'action2', :card_type=>'action'})
  #     Supply.create({:card_id=>act1.id, :amount=>1})
  #     Supply.create({:card_id=>act2.id, :amount=>2})
  #     expect(Supply.board).to(eq([[act1, 1],[act2, 2]]))
  #   end
  # end
end

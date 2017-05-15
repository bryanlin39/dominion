require('spec_helper')

describe(Supply) do
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
end

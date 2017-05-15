class Supply < ActiveRecord::Base
  has_many :cards

  def gain_card(player)
    self.amount -= 1
    player.cards.push(self)
  end

  def self.game_over?
    result = false
    if Supply.where('card_id=3')[0]!=nil
      province_amount = Supply.where('card_id=3')[0].amount
    else
      province_amount = 50
    end
    counter = 0
    Supply.all.each do |card|
      found_card = Card.find(card.card_id.to_i)
      if found_card.card_type =='action'&&card.amount==0
        counter+=1;
      end
    end
    
    if counter>=3||province_amount<=0
      result = true;
    end
    result
  end

  def self.board
    result = []
    Supply.all.each do |card|
      found_card = Card.find(card.card_id.to_i)
      result.push([found_card,card.amount])
    end
    result
  end

end

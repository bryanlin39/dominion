class Supply < ActiveRecord::Base
  has_many :cards

  def gain_card(player)
    self.amount -= 1
    card = Card.where(id: self.card_id())
    player.cards.push(card)
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
      result.push({
        'id'=>found_card.id,
        'name'=>found_card.name,
        'cost'=>found_card.cost,
        'rules'=>found_card.rules,
        'amount'=>card.amount,
        'card_type'=>found_card.card_type,
        'money_value'=>found_card.money_value,
        'victory_value'=>found_card.victory_value,
        'image'=>found_card.image
        })
    end
    result
  end

end

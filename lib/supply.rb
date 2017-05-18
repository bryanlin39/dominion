class Supply < ActiveRecord::Base
  has_many :cards

  def gain_card(player)
    new_amount = self.amount.to_i-1
    self.update({:amount=> new_amount})
    card = Card.where(id: self.card_id())
    player.cards.push(card[0])
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

  def self.reset_game
    estate=Card.create({:name=>'Estate', :cost=>2, :rules=>'', :money_value=>0, :victory_value=>1, :card_type=>'victory', :image =>'/img/estate.jpg' })
    duchy=Card.create({:name=>'Duchy', :cost=>5, :rules=>'', :money_value=>0, :victory_value=>3, :card_type=>'victory', :image =>'/img/duchy.jpg' })
    province=Card.create({:name=>'Province', :cost=>8, :rules=>'', :money_value=>0, :victory_value=>6, :card_type=>'victory', :image =>'/img/province.jpg' })
    copper=Card.create({:name=>'Copper', :cost=>0, :rules=>'', :money_value=>1, :victory_value=>0, :card_type=>'treasure', :image =>'/img/copper.jpg' })
    silver=Card.create({:name=>'Silver', :cost=>3, :rules=>'', :money_value=>2, :victory_value=>0, :card_type=>'treasure', :image =>'/img/silver.jpg' })
    gold=Card.create({:name=>'Gold', :cost=>6, :rules=>'', :money_value=>3, :victory_value=>0, :card_type=>'treasure', :image =>'/img/gold.jpg' })
    smithy=Card.create({:name=>'Smithy', :cost=>4, :rules=>'00030', :money_value=>0, :victory_value=>0, :card_type=>'action', :image =>'/img/smithy.jpg' })
    village=Card.create({:name=>'Village', :cost=>3, :rules=>'02010', :money_value=>0, :victory_value=>0, :card_type=>'action', :image =>'/img/village.jpg' })
    chapel=Card.create({:name=>'Chapel', :cost=>2, :rules=>'00004', :money_value=>0, :victory_value=>0, :card_type=>'action', :image =>'/img/chapel.jpg' })
    market=Card.create({:name=>'Market', :cost=>5, :rules=>'11110', :money_value=>0, :victory_value=>0, :card_type=>'action', :image =>'/img/market.jpg' })
    woodcutter=Card.create({:name=>'Woodcutter', :cost=>3, :rules=>'20100', :money_value=>0, :victory_value=>0, :card_type=>'action', :image =>'/img/woodcutter.jpg' })
    
    Supply.create({:card_id=>estate.id, :amount=>24})
    Supply.create({:card_id=>duchy.id, :amount=>12})
    Supply.create({:card_id=>province.id, :amount=>12})
    Supply.create({:card_id=>copper.id, :amount=>60})
    Supply.create({:card_id=>silver.id, :amount=>40})
    Supply.create({:card_id=>gold.id, :amount=>30})
    Supply.create({:card_id=>smithy.id, :amount=>10})
    Supply.create({:card_id=>village.id, :amount=>10})
    Supply.create({:card_id=>chapel.id, :amount=>10})
    Supply.create({:card_id=>market.id, :amount=>10})
    Supply.create({:card_id=>woodcutter.id, :amount=>10})
  end

end

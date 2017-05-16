class Card<ActiveRecord::Base
  has_many :decks
  has_many :players, through: :decks
  belongs_to :supplies
end

Card.create({:name=>'Estate', :cost=>2, :rules=>'', :money_value=>0, :victory_value=>1, :card_type=>'victory', :image =>'/img/estate.jpg' })
Card.create({:name=>'Duchy', :cost=>5, :rules=>'', :money_value=>0, :victory_value=>3, :card_type=>'victory', :image =>'/img/duchy.jpg' })
Card.create({:name=>'Province', :cost=>8, :rules=>'', :money_value=>0, :victory_value=>6, :card_type=>'victory', :image =>'/img/province.jpg' })
Card.create({:name=>'Copper', :cost=>0, :rules=>'', :money_value=>1, :victory_value=>0, :card_type=>'treasure', :image =>'/img/copper.jpg' })
Card.create({:name=>'Silver', :cost=>3, :rules=>'', :money_value=>2, :victory_value=>0, :card_type=>'treasure', :image =>'/img/silver.jpg' })
Card.create({:name=>'Gold', :cost=>6, :rules=>'', :money_value=>3, :victory_value=>0, :card_type=>'treasure', :image =>'/img/gold.jpg' })
Card.create({:name=>'Smithy', :cost=>4, :rules=>'', :money_value=>0, :victory_value=>0, :card_type=>'action', :image =>'/img/smithy.jpg' })
Card.create({:name=>'Village', :cost=>3, :rules=>'', :money_value=>0, :victory_value=>0, :card_type=>'action', :image =>'/img/village.jpg' })
Card.create({:name=>'Chapel', :cost=>2, :rules=>'', :money_value=>0, :victory_value=>0, :card_type=>'action', :image =>'/img/chapel.jpg' })
Card.create({:name=>'Market', :cost=>5, :rules=>'', :money_value=>1, :victory_value=>0, :card_type=>'action', :image =>'/img/market.jpg' })
Card.create({:name=>'Woodcutter', :cost=>3, :rules=>'', :money_value=>2, :victory_value=>0, :card_type=>'action', :image =>'/img/woodcutter.jpg' })

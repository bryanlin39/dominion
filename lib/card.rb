class Card < ActiveRecord::Base
  has_many :decks
  has_many :players, through: :decks
  belongs_to :supplies

  def rules_arr
    rules = []
    rules_array = self.rules.split('')
    rules_array.each { |rule| rules.push(rule.to_i) }
    rules
  end

  def discard_card
    Deck.where(card_id: self.id).update(location: "discard")
  end

end

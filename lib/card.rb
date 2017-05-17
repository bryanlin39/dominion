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

end

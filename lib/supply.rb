class Supply < ActiveRecord::Base
  has_many :cards

  def gain_card(player)
    self.amount -= 1
    player.cards.push(self)
  end
end

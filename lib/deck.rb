class Deck < ActiveRecord::Base
  belongs_to :player
  belongs_to :card

  before_create(:discard)

  def self.setup
    estate = Card.where(name: 'Estate')
    copper = Card.where(name: 'Copper')
    Player.all.each do |player|
      3.times do
        player.cards.push(estate)
      end
      7.times do
        player.cards.push(copper)
      end
    end
  end

  private
  def discard
    self.location = 'discard'
  end

end

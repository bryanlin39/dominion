class Deck < ActiveRecord::Base
  belongs_to :player
  belongs_to :card

  before_create(:discard)

  def self.setup
    estate = Card.where(name: 'Estate')
    copper = Card.where(name: 'Copper')
    smithy = Card.where(name: 'Smithy')
    Player.all.each do |player|
      if player.name=='David'
        player.cards.push(smithy)
      end
      3.times do
        player.cards.push(estate)
      end
      7.times do
        player.cards.push(copper)
      end
      player.cards = player.cards.shuffle
    end

  end

  private
  def discard
    self.location = 'discard'
  end

end

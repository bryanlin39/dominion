class Card < ActiveRecord::Base
  has_many :decks
  has_many :players, through: :decks
  belongs_to :supplies

  def discard_card
    Deck.where(card_id: self.id).update(location: "discard")
  end

end

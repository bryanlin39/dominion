class Deck < ActiveRecord::Base
  belongs_to :player
  belongs_to :card

  before_save(:discard)

  private
  def discard
    self.location = 'discard'
  end
end

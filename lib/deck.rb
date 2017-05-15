class Deck < ActiveRecord::Base
  belongs_to :player
  belongs_to :card

  before_create(:discard)

  private
  def discard
    self.location = 'discard'
  end
end

class Deck < ActiveRecord::Base
  belongs_to :players
  belongs_to :cards

  before_save(:discard)

  private
  def discard
    self.location = 'discard'
  end
end

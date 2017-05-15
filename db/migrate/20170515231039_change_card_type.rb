class ChangeCardType < ActiveRecord::Migration[5.1]
  def change
    remove_column(:cards, :type, :string)
    add_column(:cards, :card_type, :string)    
  end
end

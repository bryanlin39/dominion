class AddPlayerNumbers < ActiveRecord::Migration[5.1]
  def change
    add_column(:players, :player_num, :integer)
  end
end

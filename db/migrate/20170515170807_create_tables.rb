class CreateTables < ActiveRecord::Migration[5.1]
  def change
    create_table(:supplies) do |t|
      t.column(:amount, :integer)
      t.column(:card_id, :integer)
    end

    create_table(:cards) do |t|
      t.column(:name, :string)
      t.column(:type, :string)
      t.column(:cost, :integer)
      t.column(:rules, :string)
      t.column(:money_value, :integer)
      t.column(:victory_value, :integer)
    end

    create_table(:decks) do |t|
      t.column(:player_id, :integer)
      t.column(:card_id, :integer)
      t.column(:location, :string)
    end

    create_table(:players) do |t|
      t.column(:name, :string)
      t.column(:victory_points, :integer)
    end
  end
end

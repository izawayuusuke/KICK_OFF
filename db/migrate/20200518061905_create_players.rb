class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.string :name
      t.date :birthday
      t.integer :age
      t.integer :height
      t.integer :weight
      t.integer :dominant_foot
      t.integer :position

      t.timestamps
    end
  end
end

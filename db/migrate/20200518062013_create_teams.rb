class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.references :league, foreign_key: true
      t.string :name
      t.string :emblem

      t.timestamps
    end
  end
end

class CreateBelongs < ActiveRecord::Migration[5.2]
  def change
    create_table :belongs do |t|
      t.references :player, foreign_key: true
      t.references :team, foreign_key: true

      t.timestamps
      t.index [:player_id, :team_id], unique: true
    end
  end
end

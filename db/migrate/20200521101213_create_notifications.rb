class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.references :visitor, foreign_key: { to_table: :users }
      t.references :visited, foreign_key: { to_table: :users }
      t.references :post, foreign_key: true
      t.references :comment, foreign_key: true
      t.string :action, default: '', null: false
      t.boolean :checked, default: false, null: false

      t.timestamps
    end
  end
end

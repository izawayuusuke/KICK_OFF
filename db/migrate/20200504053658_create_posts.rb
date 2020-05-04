class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.text :content
      t.string :image_id
      t.string :youtube_url

      t.timestamps
    end
  end
end

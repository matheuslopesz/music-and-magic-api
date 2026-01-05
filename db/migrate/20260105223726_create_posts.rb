class CreatePosts < ActiveRecord::Migration[7.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :summary
      t.text :content
      t.datetime :published_at
      t.string :slug

      t.timestamps
    end
    add_index :posts, :slug
  end
end

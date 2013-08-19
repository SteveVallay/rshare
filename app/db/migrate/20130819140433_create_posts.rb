class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :text
      t.string :origin_name
      t.string :real_name

      t.timestamps
    end
  end
end

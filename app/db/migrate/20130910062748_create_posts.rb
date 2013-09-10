class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :text
      t.string :origin_name
      t.string :real_name
      t.string :md5

      t.timestamps
    end
  end
end

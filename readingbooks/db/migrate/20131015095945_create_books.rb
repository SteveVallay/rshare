class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :name
      t.text :desc
      t.string :image
      t.string :uploader
      t.string :filesize
      t.integer :downloads

      t.timestamps
    end
  end
end

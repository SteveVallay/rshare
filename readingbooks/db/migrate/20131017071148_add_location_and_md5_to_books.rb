class AddLocationAndMd5ToBooks < ActiveRecord::Migration
  def change
    add_column :books, :location, :string
    add_column :books, :md5, :string
  end
end

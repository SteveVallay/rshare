class AddColumnsToBooks < ActiveRecord::Migration
  def change
     add_column :books, :publisher, :string
     add_column :books, :author, :string
     add_column :books, :isbn, :string
     add_column :books, :year, :string
     add_column :books, :page, :string
     add_column :books, :language, :string
     add_column :books, :format, :string
     add_column :books, :douban, :string
  end
end

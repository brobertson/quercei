class ChangePagesTextToLongstring < ActiveRecord::Migration
  def self.up
change_column :pages, :content, :longtext
  end

  def self.down
   change_column :pages, :content, :string
  end
end

class AddField1ToSubdoc < ActiveRecord::Migration
  def self.up
    add_column :subdocs, :field1, :string
  end

  def self.down
    remove_column :subdocs, :field1
  end
end

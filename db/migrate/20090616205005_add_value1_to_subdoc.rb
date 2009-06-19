class AddValue1ToSubdoc < ActiveRecord::Migration
  def self.up
    add_column :subdocs, :value1, :string
  end

  def self.down
    remove_column :subdocs, :value1
  end
end

class AddValue2ToSubdoc < ActiveRecord::Migration
  def self.up
    add_column :subdocs, :value2, :string
  end

  def self.down
    remove_column :subdocs, :value2
  end
end

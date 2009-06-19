class AddField2ToSubdoc < ActiveRecord::Migration
  def self.up
    add_column :subdocs, :field2, :string
  end

  def self.down
    remove_column :subdocs, :field2
  end
end

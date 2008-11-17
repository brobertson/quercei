class AddSpanToWords < ActiveRecord::Migration
  def self.up
    add_column :words, :span, :string
  end

  def self.down
    remove_column :words, :span
  end
end

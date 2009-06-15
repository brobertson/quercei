class AddPerseusIdToWords < ActiveRecord::Migration
  def self.up
    add_column :words, :perseusId, :integer
  end

  def self.down
    remove_column :words, :perseusId
  end
end

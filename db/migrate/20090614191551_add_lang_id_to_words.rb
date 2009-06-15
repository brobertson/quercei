class AddLangIdToWords < ActiveRecord::Migration
  def self.up
    add_column :words, :lang_id, :integer
  end

  def self.down
    remove_column :words, :lang_id
  end
end

class RenameIdAsNumber < ActiveRecord::Migration
  def self.up
   rename_column :words, :id, :number
   Word.reset_column_information()
  end

  def self.down
   rename_column :words, :number, :id
   Word.reset_column_information()
  end
end

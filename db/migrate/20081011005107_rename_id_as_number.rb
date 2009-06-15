class RenameIdAsNumber < ActiveRecord::Migration
  def self.up
   add_column :words,  :number, :integer
   Word.reset_column_information()
  end

  def self.down
   remove_column :words, :number
   Word.reset_column_information()
  end
end

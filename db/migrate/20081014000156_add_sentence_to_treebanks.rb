class AddSentenceToTreebanks < ActiveRecord::Migration
  def self.up
      add_column :treebanks, :sentence, :integer
  end

  def self.down
      remove_column :treebanks, :sentence
  end
end

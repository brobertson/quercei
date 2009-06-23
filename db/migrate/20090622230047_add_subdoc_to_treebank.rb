class AddSubdocToTreebank < ActiveRecord::Migration
  def self.up
    add_column :treebanks, :subdoc, :string
  end

  def self.down
    remove_column :treebanks, :subdoc
  end
end

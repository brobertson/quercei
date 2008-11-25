class AddDocumentUrnToTreebanks < ActiveRecord::Migration
  def self.up
      add_column :treebanks, :document_urn, :string
  end

  def self.down
     remove_column :treebanks, :document_urn
  end
end

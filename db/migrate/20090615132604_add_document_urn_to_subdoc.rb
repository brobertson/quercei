class AddDocumentUrnToSubdoc < ActiveRecord::Migration
  def self.up
    add_column :subdocs, :document_urn, :string
    add_index :subdocs, :document_urn
  end
   
  def self.down
    remove_column :subdocs, :document_urn
  end
end

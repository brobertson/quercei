class CreateDocuments < ActiveRecord::Migration
  def self.up
    create_table :documents do |t|
      t.string :urn
      t.string :title
      t.string :author

      t.timestamps
    end
  end

  def self.down
    drop_table :documents
  end
end

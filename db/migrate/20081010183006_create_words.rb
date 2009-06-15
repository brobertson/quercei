class CreateWords < ActiveRecord::Migration
  def self.up
    create_table :words do |t|
      t.string :form
      t.integer :sentence
      t.string :document_urn
      t.string :document_span

      t.timestamps
    end
  end

  def self.down
    drop_table :words
  end
end

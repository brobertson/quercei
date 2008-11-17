class CreateTreebanks < ActiveRecord::Migration
  def self.up
    create_table :treebanks do |t|
      t.integer :word_id
      t.string :word_form
      t.integer :head_id
      t.string :relation
      t.string :postag
      t.string :lemma
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :treebanks
  end
end

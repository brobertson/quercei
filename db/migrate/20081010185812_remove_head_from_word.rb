class RemoveHeadFromWord < ActiveRecord::Migration
  def self.up
    remove_column :words, :head, :lemma, :postag, :relation
  end

  def self.down
    add_column :words, :head, :lemma, :postag, :relation
  end
end

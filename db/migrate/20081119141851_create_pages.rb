class CreatePages < ActiveRecord::Migration
  def self.up
      create_table :pages do |t|
        t.string :name
        t.string :permalink
        t.string :content
        t.timestamps
     end
  end

  def self.down
  end
end

class Treebank < ActiveRecord::Base
  belongs_to :word,
    :class_name => "Word",
    :foreign_key => "word_id"
  belongs_to :user
  belongs_to :head_word,
    :class_name => "Word",
    :foreign_key => "head_id"
end

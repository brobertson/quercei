class Word < ActiveRecord::Base
  has_many :treebanks
  has_one :document
end

class Collection < ActiveRecord::Base
  attr_accessible :name, :primary, :description

  has_many :references
  has_many :documents, :through => :references, :order => '"order" ASC'
end

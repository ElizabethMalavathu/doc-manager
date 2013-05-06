class Collection < ActiveRecord::Base
  attr_accessible :name, :primary, :description, :citation

  has_many :references
  has_many :documents, :through => :references, :order => "position ASC"
end

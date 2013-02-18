class Author < ActiveRecord::Base
  attr_accessible :biography, :born, :died, :first_name, :last_name

  has_many :primary_documents
end

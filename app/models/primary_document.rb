class PrimaryDocument < ActiveRecord::Base
  attr_accessible :title, :publication_date, :content, :location, :background

  belongs_to :author

  has_and_belongs_to_many :collections

end

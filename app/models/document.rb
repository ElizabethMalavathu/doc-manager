class Document < ActiveRecord::Base
  attr_accessible :title, :publication_date, :content, :location, :background, :primary

  scope :primary, {:conditions => {:primary => true}}

  belongs_to :author

  has_and_belongs_to_many :collections

end

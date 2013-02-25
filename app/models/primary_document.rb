class PrimaryDocument < ActiveRecord::Base
  attr_accessible :title, :publication_date, :content, :location, :background

  belongs_to :author

end

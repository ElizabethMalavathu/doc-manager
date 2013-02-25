class PrimaryDocument < ActiveRecord::Base
  attr_accessible :title, :publication_date, :content

  belongs_to :author

end

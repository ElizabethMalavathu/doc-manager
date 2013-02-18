class PrimaryDocument < ActiveRecord::Base
  attr_accessible :title, :publication_date, :text

  belongs_to :author

end

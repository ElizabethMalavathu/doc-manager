class Author < ActiveRecord::Base
  has_many :documents

  def full_name
    "#{first_name} #{last_name}"
  end

  def born_died
    "born and died" # do furreal later
  end
end

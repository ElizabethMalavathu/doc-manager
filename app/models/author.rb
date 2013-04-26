class Author < ActiveRecord::Base
  attr_accessible :biography, :born, :died, :first_name, :last_name

  has_many :documents

  def full_name
    "#{first_name} #{last_name}"
  end

  def born_died
    "born and died" # do furreal later
  end
end

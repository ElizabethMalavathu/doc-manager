class Document < ActiveRecord::Base

  scope :primary, {:conditions => {:primary => true}}

  belongs_to :author

  has_many :references
  has_many :collections, :through => :references
  has_and_belongs_to_many :tags

  def primary_collection
    collections.where(:primary => true).first
  end

  def full_citation
    if primary_collection
      "#{primary_collection.citation} p#{citation}."
    else
      ""
    end
  end

end

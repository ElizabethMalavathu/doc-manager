class Collection < ActiveRecord::Base

  has_many :references
  has_many :documents, :through => :references

  def to_s
    docs = documents.all
    puts citation
    puts "\n"
    docs.each do |doc|
      puts "#{doc.citation}. #{doc.title.downcase.titleize}"
      puts doc.location || "unknown"
      puts doc.publication_date.to_s.blank? ? "unknown" : doc.publication_date
      puts doc.content
      puts "background: #{doc.background}" if doc.background
      puts "\n"
    end
    nil
  end
end

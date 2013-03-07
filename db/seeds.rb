Dir.glob("#{Rails.root}/db/seeds/*.txt").each do |file_path|
  file = File.open(file_path)
  file_contents = file.read
  file.close

  documents = file_contents.split("\n\n")
  file_title = file_path.split("/").last.gsub(".txt", "").titleize
  collection = Collection.create! :name => file_title, :primary => true, :description => documents.shift

  documents.each do |document|
    begin
      lines        = document.strip.split("\n")
      title        = lines.shift.strip.sub(/[0-9]{1,}\.\ /, "")
      location     = lines.shift.strip
      date         = Date.parse(lines.shift) rescue nil
      background   = if lines.first.include?("background: ")
        lines.shift.gsub("background: ", "").strip
      end

      collection.primary_documents.create! :title => title,
                              :location => location,
                              :publication_date => date,
                              :content => lines.map(&:strip).join('\n'),
                              :background => background
    rescue NoMethodError => e
      puts "==============================================="
      puts "There was an error with the following document"
      puts document
      puts e.backtrace
    end
  end
end

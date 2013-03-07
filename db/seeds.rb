file_contents = File.open("#{Rails.root}/db/seeds/the_fugger_news_letters_1.txt").read
documents = file_contents.split("\n\n")
bibliography = documents.shift

documents.each do |document|
  begin
    lines        = document.strip.split("\n")
    title        = lines.shift.strip.sub(/[0-9]{1,}\.\ /, "")
    location     = lines.shift.strip.
    date         = Date.parse(lines.shift) rescue nil
    background   = if lines.first.include?("background: ")
      lines.shift.gsub("background: ", "").strip
    end

    PrimaryDocument.create! :title => title,
                            :location => location,
                            :publication_date => date,
                            :content => lines.map(&:strip).join('\n'),
                            :background => background
  rescue Exception => e
    puts "==============================================="
    puts "There was an error with the following document"
    puts document
    puts e.backtrace
  end
end



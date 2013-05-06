class DocumentLoader
  def self.run!
    @created = 0
    @errors = 0

    error_log = File.open("#{Rails.root}/log/seeds.log", "w")

    Dir.glob("#{Rails.root}/db/seeds/*.txt").each do |file_path|
      file = File.open(file_path)
      file_contents = file.read
      file.close

      documents = file_contents.split("\n\n")
      file_title = file_path.split("/").last.gsub(".txt", "").titleize
      collection = Collection.create! :name => file_title, :primary => true, :citation => documents.shift

      documents.each do |document|
        begin
          lines        = document.strip.split("\n")
          title_line   = lines.shift.strip
          citation     = title_line.match(/[0-9]{1,}\-[0-9]{1,}|[0-9]{1,}/)
          title        = title_line.sub(/#{citation}\.\ /, "").strip
          location     = lines.shift.strip
          date         = Date.parse(lines.shift) rescue nil
          background   = if lines.first.include?("background: ")
            lines.shift.gsub("background: ", "").strip
          end

          collection.documents.create! :title => title,
                                  :location => location,
                                  :publication_date => date,
                                  :content => lines.map(&:strip).join("\n"),
                                  :background => background,
                                  :citation => citation.to_s,
                                  :primary => true

          @created += 1
        rescue Exception => e
          @errors += 1
          error_log.puts "======================================="
          error_log.puts "There was an Error with #{file_title}"
          error_log.puts document
          error_log.puts e.backtrace
          error_log.puts "======================================="
        end
      end
    end

    error_log.close

    smaller_collection = Collection.create! :name => "Smaller collection", :primary => true, :description => "A smaller collection of 50 documents"
    smaller_collection.documents << Document.last(50)

    puts "#{@created} Documents created, #{@errors} Documents with errors. Consult seeds.log for details."
  end
end

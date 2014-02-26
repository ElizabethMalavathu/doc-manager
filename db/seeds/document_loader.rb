class DocumentLoader

  def self.sanitize_file_name(file)
    file.gsub(" ", "\\ ").
        gsub("'", "\\\\'").
        gsub("(", "\\(").
        gsub(")", "\\)").
        gsub("&", "\\\\&").
        gsub("$", "\\\\$")
  end

  def self.run_new!
    error_log = File.open("#{Rails.root}/log/seeds.log", "w")
    word_docs = `find ~/projects/dr_mitchell -name "*.doc"`.split("\n")

    word_docs.each_with_index do |word_file_path, i|
      file_name = word_file_path.split("/").last.gsub(".doc", "").titleize
      file_text = `antiword -f -w 0 #{sanitize_file_name(word_file_path)}`
      if $?.exitstatus != 0
        error_log.puts sanitize_file_name(word_file_path)
        next
      end
      puts "Saving: #{i}/#{word_docs.count} #{word_file_path} as #{file_name}"
      
      tags = word_file_path.match(/dr_mitchell\/(.*)/)[1].split("/") rescue [""]
      tags = tags.map do |t|
        if !t.blank?
          Tag.find_by_name(t) || Tag.create!(name: t)
        end
      end

      doc = Document.create!(
        title: file_name,
        content: file_text
      )
      doc.tags = tags
    end
    error_log.close
  end

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

          lines = lines.map(&:strip)
          footnote_index = lines.index(lines.detect{|l| l.include?("footnote: ")})
          if footnote_index
            content = lines[0...footnote_index].join("\n")
            footnote = lines[footnote_index..lines.length].join("\n")
            footnote.gsub!("footnote: ", "")
          else
            content = lines.join("\n")
          end

          collection.documents.create! :title => title,
                                  :location => location,
                                  :publication_date => date,
                                  :content => content,
                                  :background => background,
                                  :citation => citation.to_s,
                                  :footnote => footnote,
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

    # smaller_collection = Collection.create! :name => "Smaller collection", :description => "A smaller collection of 50 documents"
    # smaller_collection.documents << Document.last(50)

    puts "#{@created} Documents created, #{@errors} Documents with errors. Consult seeds.log for details."
  end
end

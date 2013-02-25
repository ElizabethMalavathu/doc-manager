file_contents = File.open("#{Rails.root}/db/seeds/the_fugger_news_letters_1.txt").read
documents = file_contents.split("\n\n")
documents.each do |documents|
  PrimaryDocument.create! :content => document
end
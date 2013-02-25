documents = File.open("#{Rails.root}/db/seeds/the_fugger_news_letters_1.txt").read
documents.each do |document|
  document.new "PrimaryDoc"
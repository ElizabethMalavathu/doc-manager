module ApplicationHelper
  def ls(string)
    string.gsub!("\\", "\\textbackslash{}")
    %w[# $ % ^ & _ { } ~].each do |c|
      string.gsub!(c, "\\\#{c}")
    end
    string.html_safe
  end
end

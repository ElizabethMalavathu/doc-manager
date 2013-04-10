class CollectionsController < ApplicationController

  def index
    @collections = Collection.all
  end
  
  def show
    @collection = Collection.find(params[:id])
  end

  private
  def sanitize_for_latex(string)
    %w[# $ % ^ & _ { } ~ \\].each do |c|
      string.gsub!(c, "\\#{c}")
    end
    string
  end
end

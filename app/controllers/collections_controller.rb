class CollectionsController < ApplicationController

  def index
    respond_to do |format|
      format.html
      format.json {render json: CollectionsDatatable.new(view_context) }
    end
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
